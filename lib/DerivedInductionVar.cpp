/* DerivedInductionVar.cpp 
 *
 * This pass detects derived induction variables using ScalarEvolution.
 *
 * Compatible with New Pass Manager
 */

#include "llvm/IR/PassManager.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Value.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/ScalarEvolutionExpressions.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Transforms/Utils/ScalarEvolutionExpander.h"
#include "llvm/IR/DataLayout.h"

using namespace llvm;

namespace {

  void collectInnerLoops(Loop * Root, SmallVectorImpl < Loop * > & Out) { // Finds innermost loops of a root loop (loops w/o subloops)
    SmallVector < Loop * , 8 > stack {
      Root
    };
    while (!stack.empty()) {
      Loop * L = stack.pop_back_val();
      if (L -> getSubLoops().empty()) { // Inner loop -> store it
        Out.push_back(L);
      } else {
        for (Loop * SL: L -> getSubLoops()) { // Push subloops to check later
          stack.push_back(SL);
        }
      }
    }
  }

  class DerivedInductionVar
    : public PassInfoMixin < DerivedInductionVar > {
      public: PreservedAnalyses run(Function & F, FunctionAnalysisManager & AM) {
        auto & LI = AM.getResult < LoopAnalysis > (F);
        auto & SE = AM.getResult < ScalarEvolutionAnalysis > (F);
        const DataLayout & DL = F.getParent() -> getDataLayout();

        bool Changed = false; // Convergence flag

        for (Loop * L: LI) {
          errs() << "Analyzing loop in function " << F.getName() << ":\n";

          SmallVector < Loop * , 8 > Inners;
          collectInnerLoops(L, Inners); // Collect inner loops for this loop

          for (Loop * SL: Inners) {
            BasicBlock * Header = SL -> getHeader();

            if (!Header)
              continue;

            errs() << "[derived-iv] Function " << F.getName() << " — inner loop header: " << Header -> getName() << "\n";

            // Get main loop counter 
            PHINode * CIV = SL -> getCanonicalInductionVariable();
            BasicBlock * Preheader = SL -> getLoopPreheader();
            if (!Preheader) continue;

            // Collect PHI nodes (loop vars defined in header block)
            SmallVector < PHINode * , 16 > PhiList;
            for (PHINode & PNRef: Header -> phis())
              PhiList.push_back( & PNRef);

            // Look for derived ivs
            for (PHINode * PN: PhiList) {
              if (!PN) continue;

              if (PN == CIV) continue; // Skip main loop var
              if (!PN -> getType() -> isIntegerTy())
                continue;

              const SCEV * S = SE.getSCEV(PN); // SCEV for the phi node

              // Detect affine AddRec expressions
              if (auto * AR = dyn_cast < SCEVAddRecExpr > (S)) {
                if (AR -> getLoop() != SL) continue;
                if (!AR -> isAffine()) continue;

                const SCEV * Step = AR -> getStepRecurrence(SE);
                const SCEV * Start = AR -> getStart();

                errs() << "  Derived induction variable: " << PN -> getName() <<
                  " = {" << * Start << ",+," << * Step << "}<" <<
                  SL -> getHeader() -> getName() << ">\n";

                if (!CIV) continue;

                // Now remove/replace instrs -- transformation pass
                SCEVExpander Rewriter(SE, DL, "iv-elim");

                // Get Start and step vals once before loop
                Value * StartV = Rewriter.expandCodeFor(Start, PN -> getType(),
                  Preheader -> getTerminator());
                Value * StepV = Rewriter.expandCodeFor(Step, PN -> getType(),
                  Preheader -> getTerminator());

                // Replace each use with StartV + StepV * CIV
                SmallVector < Use * , 16 > Uses;
                Uses.reserve(PN -> getNumUses());
                for (Use & U: PN -> uses()) Uses.push_back( & U);

                for (Use * U: Uses) {
                  if (auto * UserPhi = dyn_cast < PHINode > (U -> getUser())) {
                    // For incoming edge where PN is used, replace
                    for (unsigned i = 0; i < UserPhi -> getNumIncomingValues(); ++i) {
                      if (UserPhi -> getIncomingValue(i) != PN) continue;

                      BasicBlock * Incoming = UserPhi -> getIncomingBlock(i);
                      IRBuilder < > EB(Incoming -> getTerminator()); // insert in the predecessor

                      // Cast CIV if needed
                      Value * CIVV = CIV;
                      if (CIVV -> getType() != PN -> getType())
                        CIVV = EB.CreateSExtOrTrunc(CIVV, PN -> getType(), "iv.cast");

                      Value * EdgeVal = nullptr;
                      if (Incoming == Preheader) {
                        // On the preheader edge the value is Start
                        EdgeVal = StartV; // already expanded in preheader
                      } else {
                        // On the latch edge the value equals Start + Step*(CIV+1)
                        Value * One = ConstantInt::get(PN -> getType(), 1);
                        Value * CIVNext = EB.CreateAdd(CIVV, One, "iv.next");
                        Value * Mul = EB.CreateMul(StepV, CIVNext, "iv.mul.latch");
                        EdgeVal = EB.CreateAdd(StartV, Mul, "iv.lin.latch");
                      }

                      UserPhi -> setIncomingValue(i, EdgeVal);
                      Changed = true;
                    }
                  } else if (auto * UserI = dyn_cast<Instruction>(U -> getUser())) {
                    // original non-PHI replacement
                    IRBuilder < > B(UserI);
                    Value * CIVV = CIV;
                    if (CIVV -> getType() != PN -> getType())
                      CIVV = B.CreateSExtOrTrunc(CIVV, PN -> getType(), "iv.cast");
                    Value * Mul = B.CreateMul(StepV, CIVV, "iv.mul");
                    Value * Lin = B.CreateAdd(StartV, Mul, "iv.lin");
                    U -> set(Lin);
                    Changed = true;
                  }
                }
              }
            }
          }

          return Changed ? PreservedAnalyses::none() : PreservedAnalyses::all();
        }
      }

	};
} // namespace

  // Register the pass
  llvm::PassPluginLibraryInfo getDerivedInductionVarPluginInfo() {
    return {
      LLVM_PLUGIN_API_VERSION,
      "DerivedInductionVar",
      LLVM_VERSION_STRING,
      [](PassBuilder & PB) {
        PB.registerPipelineParsingCallback(
          [](StringRef Name, FunctionPassManager & FPM,
            ArrayRef < PassBuilder::PipelineElement > ) {
            if (Name == "derived-iv") {
              FPM.addPass(DerivedInductionVar());
              return true;
            }
            return false;
          });
      }
    };
  }

  extern "C"
  LLVM_ATTRIBUTE_WEAK::llvm::PassPluginLibraryInfo
  llvmGetPassPluginInfo() {
    return getDerivedInductionVarPluginInfo();
  }
