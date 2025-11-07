/* SimpleLICM.cpp
 *
 * This pass hoists loop-invariant code before the loop when it is safe to do so.
 *
 * Compatible with New Pass Manage
*/

#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/CFG.h"

#include "llvm/Pass.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"

#include "llvm/Analysis/LoopAnalysisManager.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/Analysis/ValueTracking.h"

#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Transforms/Utils/LoopUtils.h"
#include "llvm/Transforms/Utils/ValueMapper.h"

using namespace llvm;

struct SimpleLICM : public PassInfoMixin<SimpleLICM> {
  PreservedAnalyses run(Loop &L, LoopAnalysisManager &AM,
                        LoopStandardAnalysisResults &AR,
                        LPMUpdater &) {
    DominatorTree &DT = AR.DT;

    BasicBlock *Preheader = L.getLoopPreheader();
    if (!Preheader) {
      errs() << "No preheader, skipping loop\n";
      return PreservedAnalyses::all();
    }

    SmallPtrSet<Instruction *, 8> InvariantSet;
    bool Change = true;

    // Worklist algorithm to identify loop invariant instructions
    /*************************************/
    /* Your code goes here */
    /*************************************/ 

    while (Change) {

      Change = false; // Preemptively set convergence flag

      for (BasicBlock *BB : L.blocks()) {

        for (Instruction &Inst : *BB) {

          if (InvariantSet.contains(&Inst)) // Skip previously marked
            continue;
          if (isa<PHINode>(&Inst)) // Skip PHI instrs
            continue;
          if (Inst.mayReadOrWriteMemory()) // Skip memory instrs
            continue;
          if (Inst.mayHaveSideEffects()) // Skip side effect instrs
            continue;
          if (Inst.isTerminator()) // Skip terminators 
            continue;

          // Check that all operands of the instr are invariant
          // Ex: Contants, defined outside loop, or already marked invariant

          bool allInvariant = true;

	  for (Value *Op : Inst.operands()) {
  		if (!isLoopInvariant(Op, &L, InvariantSet)) { 
  			allInvariant = false; break; 
  		}
	  }

          if (!allInvariant)
            continue;

          InvariantSet.insert(&Inst); // Add the new instr to the set
          Change = true; // Update convergence flag
        }
      }
    }

    // Actually hoist the instructions
    for (Instruction *I : InvariantSet) {
      if (isSafeToSpeculativelyExecute(I) || dominatesAllLoopExits(I, &L, DT)) {
        errs() << "Hoisting: " << *I << "\n";
        I->moveBefore(Preheader->getTerminator());
      }
    }

    return PreservedAnalyses::none();
  }

  bool isLoopInvariant(Value *V, Loop *L, const SmallPtrSetImpl<Instruction*> &Inv) {
  	if (isa<Constant>(V) || isa<Argument>(V) || isa<GlobalValue>(V)) 
  		return true;
  	if (auto *I = dyn_cast<Instruction>(V))
    		return !L->contains(I) || Inv.contains(I);
  	return true;
}


  bool dominatesAllLoopExits(Instruction *I, Loop *L, DominatorTree &DT) {
    SmallVector<BasicBlock *, 8> ExitBlocks;
    L->getExitBlocks(ExitBlocks);
    for (BasicBlock *EB : ExitBlocks) {
      if (!DT.dominates(I, EB))
        return false;
    }
    return true;
  }
};

llvm::PassPluginLibraryInfo getSimpleLICMPluginInfo() {
  errs() << "SimpleLICM plugin: getSimpleLICMPluginInfo() called\n";
  return {LLVM_PLUGIN_API_VERSION, "simple-licm", LLVM_VERSION_STRING,
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, LoopPassManager &LPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "simple-licm") {
                    LPM.addPass(SimpleLICM());
                    return true;
                  }                  
                  return false;
                });
          }};
}

extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  errs() << "SimpleLICM plugin: llvmGetPassPluginInfo() called\n";
  return getSimpleLICMPluginInfo();
}
