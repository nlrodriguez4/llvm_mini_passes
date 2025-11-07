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


  void collectInnerLoops(Loop* Root, SmallVectorImpl<Loop*> &Out) {
    SmallVector<Loop*, 8> stack{Root};
    while (!stack.empty()) {
      Loop *L = stack.pop_back_val();
      if (L->getSubLoops().empty()) {
        Out.push_back(L);
      }
      else {
        for (Loop *SL: L->getSubLoops()) {
          stack.push_back(SL);
        }
      }
    }
  }

class DerivedInductionVar
    : public PassInfoMixin<DerivedInductionVar> {
public:
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM) {
    auto &LI = AM.getResult<LoopAnalysis>(F);
    auto &SE = AM.getResult<ScalarEvolutionAnalysis>(F);
    const DataLayout &DL = F.getParent()->getDataLayout();

    bool Changed = false;

    for (Loop *L : LI) {
      errs() << "Analyzing loop in function " << F.getName() << ":\n";

      SmallVector<Loop*, 8> Inners;
      collectInnerLoops(L, Inners);

      for (Loop* SL : Inners) {
        BasicBlock *Header = SL->getHeader();
        
        if (!Header)
            continue;

        errs() << "[derived-iv] Function " << F.getName() << " — inner loop header: " << Header->getName() << "\n";
        
        PHINode *CIV = SL->getCanonicalInductionVariable();
        BasicBlock *Preheader = SL->getLoopPreheader();
        if (!Preheader) continue;

        // Collect PHIs first to avoid iterator invalidation when erasing.
        SmallVector<PHINode*, 16> PhiList;
        for (PHINode &PNRef : Header->phis())
          PhiList.push_back(&PNRef);
      
        for (PHINode *PN : PhiList) {
            if (!PN) continue;

            if (PN == CIV) continue; 
            if (!PN->getType()->isIntegerTy())
              continue;
            
            const SCEV *S = SE.getSCEV(PN);

            // Detect affine AddRec expressions
            if (auto *AR = dyn_cast<SCEVAddRecExpr>(S)) {
              if (AR->getLoop() != SL) continue;
              if (!AR->isAffine()) continue;

              const SCEV *Step = AR->getStepRecurrence(SE);
              const SCEV *Start = AR->getStart();

              errs() << "  Derived induction variable: " << PN->getName()
                << " = {" << *Start << ",+," << *Step << "}<"
                << SL->getHeader()->getName() << ">\n";
              
              if (!CIV) continue; 

              // ===== transformation start (revised & safe) =====
              SCEVExpander Rewriter(SE, DL, "iv-elim");

              // Materialize Start/Step once in the preheader (loop-invariant w.r.t. SL)
              Value *StartV = Rewriter.expandCodeFor(Start, PN->getType(),
                                                     Preheader->getTerminator());
              Value *StepV  = Rewriter.expandCodeFor(Step,  PN->getType(),
                                                     Preheader->getTerminator());

              // Replace each use with StartV + StepV * CIV (cast CIV to PN type if needed)
              SmallVector<Use*, 16> Uses;
              Uses.reserve(PN->getNumUses());
              for (Use &U : PN->uses()) Uses.push_back(&U);

              for (Use *U : Uses) {
                if (auto *UserI = dyn_cast<Instruction>(U->getUser())) {
                  IRBuilder<> B(UserI);

                  Value *CIVV = CIV;
                  if (CIVV->getType() != PN->getType()) {
                    // Sign-extend/trunc as a conservative default for IVs
                    CIVV = B.CreateSExtOrTrunc(CIVV, PN->getType(), "iv.cast");
                  }

                  Value *Mul = B.CreateMul(StepV, CIVV, "iv.mul");
                  Value *Lin = B.CreateAdd(StartV, Mul, "iv.lin");
                  U->set(Lin);
                  Changed = true;
                }
              }

              if (PN->use_empty()) {
                errs() << "  [iv-elim] removed PHI " << PN->getName() << "\n";
                PN->eraseFromParent();
                // Do not touch PN after this point.
                Changed = true;
              }
              // ===== transformation end =====
            }
        }
      }
    }

    return Changed ? PreservedAnalyses::none() : PreservedAnalyses::all();
  }
};

} // namespace

// Register the pass
llvm::PassPluginLibraryInfo getDerivedInductionVarPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "DerivedInductionVar", LLVM_VERSION_STRING,
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "derived-iv") {
                    FPM.addPass(DerivedInductionVar());
                    return true;
                  }
                  return false;
                });
          }};
}

extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getDerivedInductionVarPluginInfo();
}

