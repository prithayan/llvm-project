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

#define DEBUG_TYPE "omp-sanitizer"

void ValidateOmpReachingDefs::analyzeBasicBlock(const BasicBlock &BB){
  for (auto &I : BB) {
    if (const CallInst *Call = dyn_cast<CallInst>(&I)) {
      const Function *CalledFunc = Call->getCalledFunction();
      for (auto &A : Call->args()){
        if (auto F = dyn_cast<Function>(A->stripPointerCastsAndInvariantGroups())){
          LLVM_DEBUG(dbgs()<<" Arg ::"<<A<<":"<<*(A->stripPointerCastsAndInvariantGroups()));
          CalledFunc = F;
        }
      }
      if (CalledFunc == nullptr || !CalledFunc->hasName())
        continue;
      // Ignore recursive calls
      if (CalledFunc == BB.getParent())
        continue;
      if (CalledFunc->isIntrinsic() || CalledFunc->isDeclaration())
        continue;
      CalledFuncLocationMap[CalledFunc] = MemInfo.OmpDiagnosticsLocationInfo.getDebugLocSeq(Call);
      analyzeFunction(*CalledFunc);
    }
  }
}

void ValidateOmpReachingDefs::analyzeFunction(const Function &F) {
  if (EXISTSinMap(FuncEnvMap, &F)) return;
  bool TargetRegBeginCall = false;
  if (F.getName().find("__omp_offloading") != std::string::npos && InsideOMPCall == nullptr) {
    TargetRegBeginCall = true;
    InsideOMPCall = &F;
  }
  if (InsideOMPCall != nullptr) {
      LLVM_DEBUG(dbgs()<<"\n Target Called at Line:"<<MemInfo.OmpDiagnosticsLocationInfo.getDebugLocStr(CalledFuncLocationMap[InsideOMPCall]));
  }
  FuncEnvMap[&F] = InsideOMPCall;
  // SmallVector<const BasicBlock*, 10> BBVisitQ;
  std::queue<const BasicBlock *> BBVisitQ;
  std::set<const BasicBlock *> BBVisitedSet;
  BBVisitQ.push(&F.getEntryBlock());
  LLVM_DEBUG(dbgs() << "\n AnalyzeFunction : " << F.getName()<< " is Target region?"<<InsideOMPCall <<"\n");
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
    InsideOMPCall = nullptr;
}

void ValidateOmpReachingDefs::recordOmpMaps(){
  for (auto Iter : OmpInfo.getAllocatedItems()){
    auto LocSeq = MemInfo.OmpDiagnosticsLocationInfo.getDebugLocSeq(Iter.first); 
    for (auto MapTypeIter : Iter.second ){
      const std::string VN = MemInfo.OmpDiagnosticsLocationInfo.getSymbolName(MapTypeIter.MappedValue);
      AllocatedOnDeviceMap[LocSeq].insert(VN);
      LLVM_DEBUG(dbgs()<<"\n Allocated on line:"<<MemInfo.OmpDiagnosticsLocationInfo.getDebugLocStr(LocSeq) <<" val:"<<MapTypeIter.MappedValue << "= "<<*MapTypeIter.MappedValue);
    }
  }
  for (auto Iter : OmpInfo.getHostDeviceCopy()){
    auto LocSeq = MemInfo.OmpDiagnosticsLocationInfo.getDebugLocSeq(Iter.first); 
    for (auto MapTypeIter : Iter.second ){
      const std::string VN = MemInfo.OmpDiagnosticsLocationInfo.getSymbolName(MapTypeIter.MappedValue);
      HostToDeviceMap[LocSeq].insert(VN);
      LLVM_DEBUG(dbgs()<<"\n Host to Device copy on line:"<<MemInfo.OmpDiagnosticsLocationInfo.getDebugLocStr(LocSeq) <<" val:"<<MapTypeIter.MappedValue<< "= "<<*MapTypeIter.MappedValue
          <<" \n Val Name: "<<VN);
    }
  }
  for (auto Iter : OmpInfo.getDeviceHostCopy()){
    auto LocSeq = MemInfo.OmpDiagnosticsLocationInfo.getDebugLocSeq(Iter.first); 
    for (auto MapTypeIter : Iter.second ){
      const std::string VN = MemInfo.OmpDiagnosticsLocationInfo.getSymbolName(MapTypeIter.MappedValue);
      DeviceToHostMap[LocSeq].insert(VN);
      LLVM_DEBUG(dbgs()<<"\n Device to Host copy on line:"<<MemInfo.OmpDiagnosticsLocationInfo.getDebugLocStr(LocSeq) <<" val:"<<MemInfo.OmpDiagnosticsLocationInfo.getSymbolName(MapTypeIter.MappedValue)<< "= "<<*MapTypeIter.MappedValue
         <<" \n Val Name: "<<VN );
    }
  }
  //for (auto Iter : OmpInfo.getDevicePersistentIn()){
  //  auto LocSeq = MemInfo.OmpDiagnosticsLocationInfo.getDebugLocSeq(Iter.first); 
  //  for (auto MapTypeIter : Iter.second ){
  //    PersistentInMap[LocSeq].insert(MemInfo.OmpDiagnosticsLocationInfo.getSymbolName(MapTypeIter.MappedValue));
  //    LLVM_DEBUG(dbgs()<<"\n Persistent in on line:"<<MemInfo.OmpDiagnosticsLocationInfo.getDebugLocStr(LocSeq) <<" val:"<<MapTypeIter.MappedValue<< "= "<<*MapTypeIter.MappedValue);
  //  }
  //}
  //for (auto Iter : OmpInfo.getDevicePersistentOut()){
  //  auto LocSeq = MemInfo.OmpDiagnosticsLocationInfo.getDebugLocSeq(Iter.first); 
  //  for (auto MapTypeIter : Iter.second ){
  //    PersistentOutMap[LocSeq].insert(MemInfo.OmpDiagnosticsLocationInfo.getSymbolName(MapTypeIter.MappedValue));
  //    LLVM_DEBUG(dbgs()<<"\n Persistent out on line:"<<MemInfo.OmpDiagnosticsLocationInfo.getDebugLocStr(LocSeq) <<" val:"<<MapTypeIter.MappedValue<< "= "<<*MapTypeIter.MappedValue);
  //  }
  //}
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

  MemUseToReachingDefsMapType MemUseToReachingDefsMap;
  MemInfo.getMemUseToReachingDefsMap(MemUseToReachingDefsMap);
  for (auto Iter : MemUseToReachingDefsMap) {
    bool UseOnDevice = false;
    auto MemUseInstr = Iter.first;
    auto UseArray = MemInfo.OmpDiagnosticsLocationInfo.getSymbolName(MemInfo.getMemoryForLdSt(MemUseInstr));
    if (UseArray == "") continue;
    if (!isa<LoadInst>(MemUseInstr)) continue;
    auto Ld = dyn_cast<LoadInst>(MemUseInstr);
    if (Ld->getType()->isPointerTy()) continue;
    auto UseFunc = MemUseInstr->getFunction();
    if (EXISTSinMap(FuncEnvMap, UseFunc)) {
      //LLVM_DEBUG(dbgs()<<"\n ENV ::"<<FuncEnvMap[Func]);
      if (FuncEnvMap[UseFunc] != nullptr && EXISTSinMap(CalledFuncLocationMap, UseFunc)){
        LLVM_DEBUG(dbgs()<<"Use Target env Use Func Called at line :"<<MemInfo.OmpDiagnosticsLocationInfo.getDebugLocStr(CalledFuncLocationMap[FuncEnvMap[UseFunc]]) << " and seq :"<<CalledFuncLocationMap[FuncEnvMap[UseFunc]] );
        UseOnDevice = true;
        } else {
          LLVM_DEBUG(dbgs()<<"Use outside target");
        }
    } else 
      continue;
    LLVM_DEBUG(dbgs()<<"\n ==== Use:"<<*MemUseInstr << " At: "<<MemInfo.OmpDiagnosticsLocationInfo.getDebugLocStr(*MemUseInstr)<<" of : "<<UseArray<<" ==========");
    //auto BB = MemUseInstr->getParent();
    //for (auto RDefs : MemInfo.BBReachingCalls[BB]){
    //  LLVM_DEBUG(dbgs()<<"\n Reaching Def: "<<*RDefs);
    //}

    if (Iter.second.empty())  continue;
    for (auto MemDefInstr : Iter.second) {
    bool DefOnDevice = false;
      if ( MemUseInstr == MemDefInstr ) continue;
      if (!isa<StoreInst>(MemDefInstr)) continue;
      auto St = dyn_cast<StoreInst>(MemDefInstr);
      if (St->getType()->isPointerTy()) continue;
    auto DefArray = MemInfo.OmpDiagnosticsLocationInfo.getSymbolName(MemInfo.getMemoryForLdSt(MemDefInstr));

      LLVM_DEBUG(dbgs()<<"\n Def :"<<*MemDefInstr<< " At: "<<MemInfo.OmpDiagnosticsLocationInfo.getDebugLocStr(*MemDefInstr));
      LLVM_DEBUG(dbgs()<<"\n DEf Array::"<<DefArray);
      //if (isa<CallInst>(MemDefInstr)) continue;
      auto DefFunc = MemDefInstr->getFunction();
      if (EXISTSinMap(FuncEnvMap, DefFunc)) {
        //LLVM_DEBUG(dbgs()<<"\n ENV ::"<<FuncEnvMap[DefFunc]);
        if (FuncEnvMap[DefFunc] && EXISTSinMap(CalledFuncLocationMap, DefFunc)){
          LLVM_DEBUG(dbgs()<<"Def Target env DeFunc Called at line :"<<MemInfo.OmpDiagnosticsLocationInfo.getDebugLocStr(CalledFuncLocationMap[FuncEnvMap[DefFunc]])<<" and seq: "<<CalledFuncLocationMap[FuncEnvMap[DefFunc]]);
          DefOnDevice = true;
        } else {
          LLVM_DEBUG(dbgs()<<"Def outside target");
        }
        if (UseOnDevice && DefOnDevice){
          // If not within same target region, then persistent out and in. 
        }else if (DefOnDevice && !UseOnDevice){
          // Must be copy out or persistent out from target.
          if (EXISTSinMap(DeviceToHostMap[CalledFuncLocationMap[FuncEnvMap[DefFunc]]], DefArray ) || EXISTSinMap(DeviceToHostMap[CalledFuncLocationMap[FuncEnvMap[DefFunc]]], UseArray ) ){
            LLVM_DEBUG(dbgs()<<"\n exists in device to host copy:"<<UseArray);
          } else {
            LLVM_DEBUG(dbgs()<<"\n Error not copied out"<<UseArray);
          }
        }else if (!DefOnDevice && UseOnDevice){
          // Must be Copy in or persistent in to the target.
          if (EXISTSinMap(HostToDeviceMap[CalledFuncLocationMap[UseFunc]], DefArray ) || EXISTSinMap(HostToDeviceMap[CalledFuncLocationMap[UseFunc]], UseArray ) ){
            LLVM_DEBUG(dbgs()<<"\n exists in device to host copy:"<<UseArray);
          } else {
            LLVM_DEBUG(dbgs()<<"\n Error not copied out"<<UseArray);
          }
        }

      } else 
      continue;
      //<<"At :"<<OmpDiagnosticsLocationInfo.getVarNameLocStr(MemDefInstr);
    }
  }

  for (auto Iter : HostToDeviceMap){
    LLVM_DEBUG(dbgs()<<"\n Host to Device at line:"<< Iter.first << 
        " str: "<< MemInfo.OmpDiagnosticsLocationInfo.getDebugLocStr(Iter.first));
    for (auto V : Iter.second){
      LLVM_DEBUG(dbgs()<<"\n Val:"<<V );
    }
  }
  for (auto Iter : DeviceToHostMap){
    LLVM_DEBUG(dbgs()<<"\n Device to host at line:"<< Iter.first<< 
        " str: "<< MemInfo.OmpDiagnosticsLocationInfo.getDebugLocStr(Iter.first));
    for (auto V : Iter.second){
      LLVM_DEBUG(dbgs()<<"\n Val:"<<V );
    }
  }
}

AnalysisKey OmpSanitizerGlobalAnalysis::Key;
OmpSanitizerGlobalAnalysis::Result OmpSanitizerGlobalAnalysis::run(Module &M, ModuleAnalysisManager &AM) {
  // OmpDiagnosticsGlobalInfo result;
  ThisModule = &M;
  LLVM_DEBUG(dbgs() << "\n Analysis module:");
  AnalysisManager = &AM;
  OmpDiagnosticsInfo OmpInfo = AM.getResult<OmpDiagnosticsGlobalAnalysis>(M);
  auto MemInfo = AM.getResult<MemUseDefGlobalAnalysis>(M);
  MemUseToReachingDefsMapType MemUseToReachingDefsMap;
  MemInfo.getMemUseToReachingDefsMap(MemUseToReachingDefsMap);
  ValidateOmpReachingDefs ValidateObj( MemInfo, OmpInfo);//, MemUseToReachingDefsMap);
  ValidateObj.analyzeModule(M);
  return ValidateObj;
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

