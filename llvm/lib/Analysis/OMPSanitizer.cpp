//===- OMPSanitizer.cpp - Stack memory safety analysis
//-------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
//===----------------------------------------------------------------------===//


#include "llvm/Analysis/OMPSanitizer.h"
using namespace llvm;

#define DEBUG_TYPE "omp-diagnostics"

void ValidateOmpReachingDefs::analyzeBasicBlock(const BasicBlock &BB){
  for (auto &I : BB) {
    if (const CallInst *Call = dyn_cast<CallInst>(&I)) {
      auto CalledFunc = Call->getCalledFunction();
      if (CalledFunc == nullptr || !CalledFunc->hasName())
        continue;
      // Ignore recursive calls
      if (CalledFunc == BB.getParent())
        continue;
    if (!CalledFunc->hasName() || CalledFunc->isIntrinsic() || CalledFunc->isDeclaration())
      continue;
        analyzeFunction(*CalledFunc);
    }
  }
}

void ValidateOmpReachingDefs::analyzeFunction(Function &F) {
  if (EXISTSinMap(FuncEnvMap, &F)) return;
  bool TargetRegBeginCall = false;
  if (F.getName().find("__omp_offloading") != std::string::npos && !InsideTargetEnv) {
    TargetRegBeginCall = true;
    InsideTargetEnv = true;
  }
  FuncEnvMap[&F] = InsideTargetEnv;
  // SmallVector<const BasicBlock*, 10> BBVisitQ;
  std::queue<const BasicBlock *> BBVisitQ;
  std::set<const BasicBlock *> BBVisitedSet;
  BBVisitQ.push(&F.getEntryBlock());
  LLVM_DEBUG(dbgs() << "\n AnalyzeFunction : " << F.getName());
  // Traverse the CFG in BFS
  while (!BBVisitQ.empty()) {
    auto VisitBB = BBVisitQ.front();
    BBVisitQ.pop();
    if (EXISTSinMap(BBVisitedSet, VisitBB))
      continue;
    BBVisitedSet.insert(VisitBB);
    for (auto SuccBB = succ_begin(VisitBB); SuccBB != succ_end(VisitBB);
         SuccBB++) {
      BBVisitQ.push(*SuccBB);
    }
    analyzeBasicBlock(*VisitBB);
  }
  // Once we return from the function that was the target region begin, we are out of the Target environment and back to host environment.
  if (TargetRegBeginCall)
    InsideTargetEnv = false;
}

void ValidateOmpReachingDefs::analyzeModule(Module &M){
  const StringRef MainFuncName = "main";
  LLVM_DEBUG(dbgs() << "\n Analysis module:");
  // Find the "main" function, and start analysis from that.
  for (Function &Func : M) {
    if (!Func.hasName() || Func.isIntrinsic() || Func.isDeclaration())
      continue;
    if (Func.getName() == MainFuncName){
      analyzeFunction(Func);
      break;
    }
  }
}

OmpSanitizerGlobalAnalysis::Result OmpSanitizerGlobalAnalysis::run(Module &M, ModuleAnalysisManager &AM) {
  // OmpDiagnosticsGlobalInfo result;
  ThisModule = &M;
  LLVM_DEBUG(dbgs() << "\n Analysis module:");
  AnalysisManager = &AM;
  OmpDiagnosticsInfo OmpInfo = AM.getResult<OmpDiagnosticsGlobalAnalysis>(M);
  auto MemInfo = AM.getResult<MemUseDefGlobalAnalysis>(M);
  //MemInfo.
  InstructionToMemCopyMapType AllocatedDevice, HostToDeviceCopy, DeviceToHostCopy, DevicePersistent;
  OmpInfo.getAllocatedItems(AllocatedDevice); 
  OmpInfo.getHostDeviceCopy(HostToDeviceCopy); 
  OmpInfo.getDeviceHostCopy(DeviceToHostCopy);
  OmpInfo.getDevicePersistentIn(DevicePersistent);
  ValidateOmpReachingDefs ValidateObj(AllocatedDevice, HostToDeviceCopy, DeviceToHostCopy, DevicePersistent);
  ValidateObj.analyzeModule(M);
  return 0;

}

PreservedAnalyses
OmpSanitizerGlobalPrinterPass::run(Module &M, ModuleAnalysisManager &AM) {
  OS << "'omp diagnostics Analysis' for module '" << M.getName() << "'\n";
  AM.getResult<OmpSanitizerGlobalAnalysis>(M);
  //Res.print(OS);
  return PreservedAnalyses::all();
}


static const char LocalPassArg[] = "omp-diagnostics-local";
static const char LocalPassName[] = "omp diagnostics Local Analysis";
static const char GlobalPassName[] = "omp diagnostics Analysis";

