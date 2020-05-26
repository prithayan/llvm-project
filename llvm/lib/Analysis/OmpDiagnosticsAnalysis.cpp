//===- OmpDiagnosticsAnalysis.cpp - Stack memory safety analysis
//-------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
//===----------------------------------------------------------------------===//

#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/OmpDiagnosticsAnalysis.h"
#include "llvm/Analysis/ScalarEvolutionExpressions.h"
//#include "llvm/IR/CallSite.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

#define DEBUG_TYPE "omp-diagnostics"


void OmpDiagnosticsLocalAnalysis::analyzeBB(const BasicBlock &BB){
  auto MAList = MSSA.getBlockAccesses(&BB);
  if (MAList == nullptr)
    return;
  for (const MemoryAccess & MA : *MAList){
    if (auto MemDef = dyn_cast<MemoryDef>(&MA)) { 

    } else if (auto MemUse = dyn_cast<MemoryUse>(&MA)) { 
      LLVM_DEBUG(dbgs()<<"\n MemUse:"<<*MemUse);
      if (!isa<LoadInst>(MemUse->getMemoryInst()))
        continue;
      LoadInst *Ld = dyn_cast<LoadInst>(MemUse->getMemoryInst());
      LLVM_DEBUG(dbgs()<<"\n Load:"<<*Ld;if (Ld->getDebugLoc())Ld->getDebugLoc()->dump());
      if (!isa<MemoryDef>(MemUse->getDefiningAccess())) 
        continue;
      MemoryDef *MD = dyn_cast<MemoryDef>(MemUse->getDefiningAccess());
      if (MSSA.isLiveOnEntryDef(MD) ) {
        LLVM_DEBUG(dbgs()<<"\n Liveonentry: Use:");
        continue;
      }

      if (MSSA.isLiveOnEntryDef(MD) || !isa<StoreInst>(MD->getMemoryInst()))
        continue;

      StoreInst *St = dyn_cast<StoreInst>(MD->getMemoryInst());
      //Value * LoadAddr = Ld->getPointerOperand();
      //Value *StoreAddr = St->getPointerOperand();
      AliasResult AR =  AA.alias(MemoryLocation::get(Ld), MemoryLocation::get(St));
      LLVM_DEBUG(dbgs()<<"\n Def:"<< *MD);
      LLVM_DEBUG(dbgs()<<"\n Alias ::"<< AR 
          <<"\n Load :"<<* Ld 
          <<"\n Store: "<<*St);
      if (Ld->getDebugLoc())
        LLVM_DEBUG(dbgs()<<"\n Load:";Ld->getDebugLoc()->dump());
      if (St->getDebugLoc())
        LLVM_DEBUG(dbgs()<<"\n Stor:";St->getDebugLoc()->dump());
    }
  }
}

void OmpDiagnosticsLocalAnalysis::run() {

  LLVM_DEBUG(dbgs() << "\n Analysis Local:");
  for (const BasicBlock &BB : Func2Analyze){
    analyzeBB(BB);
  }

  return ;
}

void OmpDiagnosticsLocalAnalysis::print() {}

AnalysisKey OmpDiagnosticsGlobalAnalysis::Key;

void OmpDiagnosticsGlobalAnalysis::analyzeModule() {
  LLVM_DEBUG(dbgs() << "\n Analysis module:");

  for (Function &F : *ThisModule){
    if (!F.hasName() || F.isIntrinsic() || F.isDeclaration())
      continue;
    LLVM_DEBUG(dbgs()<<"\n Func:"<<F.getName());
    AAResults &AA = GetAAForFunc(F);
    MemorySSA &MSSA = GetMemSSAForFunc(F);
    //LLVM_DEBUG(MSSA.dump());
    OmpDiagnosticsLocalAnalysis LocalA(F,MSSA,AA);
    LocalA.run();
  }
}

OmpDiagnosticsGlobalAnalysis::Result
OmpDiagnosticsGlobalAnalysis::run(Module &M, ModuleAnalysisManager &AM) {
  // OmpDiagnosticsGlobalInfo result;
  ThisModule = &M;
  AnalysisManager = &AM;
  LLVM_DEBUG(dbgs() << "\n Analysis module:");
  FunctionAnalysisManager &FAM =
    AM.getResult<FunctionAnalysisManagerModuleProxy>(M).getManager();

   GetAAForFunc = [&](Function &F) -> AAResults & {
    return FAM.getResult<AAManager>(F);
  };
  GetMemSSAForFunc = [&](Function &F) -> MemorySSA & {
    return FAM.getResult<MemorySSAAnalysis>(F).getMSSA();
  };

  analyzeModule();
  return IntResult();
}

PreservedAnalyses
OmpDiagnosticsGlobalPrinterPass::run(Module &M, ModuleAnalysisManager &AM) {
  OS << "'omp diagnostics Analysis' for module '" << M.getName() << "'\n";
  IntResult Res = AM.getResult<OmpDiagnosticsGlobalAnalysis>(M);
  LLVM_DEBUG(dbgs()<<"\n Ret="<<Res.get());

  return PreservedAnalyses::all();
}


static const char LocalPassArg[] = "omp-diagnostics-local";
static const char LocalPassName[] = "omp diagnostics Local Analysis";
static const char GlobalPassName[] = "omp diagnostics Analysis";

