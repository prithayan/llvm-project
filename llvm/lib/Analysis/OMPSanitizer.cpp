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
      LLVM_DEBUG(dbgs()<<"\n Host to Device copy on line:"<<MemInfo.OmpDiagnosticsLocationInfo.getDebugLocStr(LocSeq)
          << ", Seq:"<< LocSeq
          <<",val:"<<MapTypeIter.MappedValue<< "= "<<*MapTypeIter.MappedValue
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
  for (auto Iter : OmpInfo.getDevicePersistentIn()){
    auto LocSeq = MemInfo.OmpDiagnosticsLocationInfo.getDebugLocSeq(Iter.first); 
    for (auto MapTypeIter : Iter.second ){
      const std::string VN = MemInfo.OmpDiagnosticsLocationInfo.getSymbolName(MapTypeIter.MappedValue);
      PersistentInMap[LocSeq].insert(VN);
      LLVM_DEBUG(dbgs()<<"\n Persistent in on line:"<<MemInfo.OmpDiagnosticsLocationInfo.getDebugLocStr(LocSeq) <<" val:"<<VN << "= "<<*MapTypeIter.MappedValue);
    }
  }
  for (auto Iter : OmpInfo.getDevicePersistentOut()){
    auto LocSeq = MemInfo.OmpDiagnosticsLocationInfo.getDebugLocSeq(Iter.first); 
    for (auto MapTypeIter : Iter.second ){
      const std::string VN = MemInfo.OmpDiagnosticsLocationInfo.getSymbolName(MapTypeIter.MappedValue);
      PersistentOutMap[LocSeq].insert(VN);
      LLVM_DEBUG(dbgs()<<"\n Persistent out on line:"<<MemInfo.OmpDiagnosticsLocationInfo.getDebugLocStr(LocSeq) <<" val:"<<VN << "= "<<*MapTypeIter.MappedValue);
    }
  }
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
  // MemUseDefAnalysis, provides all the reaching definitions information, the OMP pragmas must respect these use def relations. So, iterate over the reaching defs information.
  for (auto Iter : MemUseToReachingDefsMap) {
    bool UseOnDevice = false;
    if (Iter.second.empty())  continue;
    auto MemUseInstr = Iter.first;
    auto UseArrayName = MemInfo.OmpDiagnosticsLocationInfo.getSymbolName(MemInfo.getMemoryForLdSt(MemUseInstr));
    if (UseArrayName == "") continue;
    if (!isa<LoadInst>(MemUseInstr)) continue;
    auto Ld = dyn_cast<LoadInst>(MemUseInstr);
    if (Ld->getType()->isPointerTy()) continue;
    auto UseFunc = MemUseInstr->getFunction();
    unsigned UsePragmaOmpSeq = 0;
    // Depending on which function the Use instruction belongs to, we can classify if its executed on device or host.
    if (EXISTSinMap(FuncEnvMap, UseFunc)) {
      if (FuncEnvMap[UseFunc] != nullptr && EXISTSinMap(CalledFuncLocationMap, UseFunc)){
        // Get the line number of the original parent RTL call, that is the pragma omp line number.
        UsePragmaOmpSeq = CalledFuncLocationMap[FuncEnvMap[UseFunc]];
        LLVM_DEBUG(dbgs()<<"\n Use Target env Use Func Called at line :"<<MemInfo.OmpDiagnosticsLocationInfo.getDebugLocStr(UsePragmaOmpSeq) << " and seq :"<< UsePragmaOmpSeq );
        UseOnDevice = true;
      } else {
          LLVM_DEBUG(dbgs()<<"Use outside target");
        }
    } else 
      continue;
    LLVM_DEBUG(dbgs()<<"\n ==== Use:"<<*MemUseInstr << " At: "<<MemInfo.OmpDiagnosticsLocationInfo.getDebugLocStr(*MemUseInstr)<<" of : "<<UseArrayName << ", ontarget ?:"<< UseOnDevice   <<" ==========");
    bool PersistentIn = false, CopyIn = false;
    if (UseOnDevice){
      if (EXISTSinMap(HostToDeviceMap[UsePragmaOmpSeq], UseArrayName ))
        CopyIn = true;
      else if (EXISTSinMap(PersistentInMap[UsePragmaOmpSeq], UseArrayName ))
        PersistentIn = true;
    }

    for (auto MemDefInstr : Iter.second) {
    bool DefOnDevice = false;
      if ( MemUseInstr == MemDefInstr ) continue;
      if (!isa<StoreInst>(MemDefInstr)) continue;
      auto St = dyn_cast<StoreInst>(MemDefInstr);
      if (St->getType()->isPointerTy()) continue;
    auto DefArrayName = MemInfo.OmpDiagnosticsLocationInfo.getSymbolName(MemInfo.getMemoryForLdSt(MemDefInstr));

      LLVM_DEBUG(dbgs()<<"\n Def :"<<*MemDefInstr<< " At: "<<MemInfo.OmpDiagnosticsLocationInfo.getDebugLocStr(*MemDefInstr));
      LLVM_DEBUG(dbgs()<<"\n DEf Array::"<<DefArrayName);
      //if (isa<CallInst>(MemDefInstr)) continue;
      auto DefFunc = MemDefInstr->getFunction();
      unsigned DefPragmaOmpSeq = 0;

      if (EXISTSinMap(FuncEnvMap, DefFunc)) {
        //LLVM_DEBUG(dbgs()<<"\n ENV ::"<<FuncEnvMap[DefFunc]);
        if (FuncEnvMap[DefFunc] && EXISTSinMap(CalledFuncLocationMap, DefFunc)){
          DefPragmaOmpSeq = CalledFuncLocationMap[FuncEnvMap[DefFunc]];
          LLVM_DEBUG(dbgs()<<"Def Target env DeFunc Called at line :"<<MemInfo.OmpDiagnosticsLocationInfo.getDebugLocStr(DefPragmaOmpSeq)<<" and seq: "<<DefPragmaOmpSeq);
          DefOnDevice = true;
        } else {
          LLVM_DEBUG(dbgs()<<"Def outside target");
        }
        // If both use and def on host or both in the samge target region, then nothing to check.
        if ( (!UseOnDevice && !DefOnDevice ) || (DefPragmaOmpSeq == UsePragmaOmpSeq ))
          continue;
    bool PersistentOut = false, CopyOut = false;
    if (DefOnDevice){
      if (EXISTSinMap(DeviceToHostMap[DefPragmaOmpSeq], DefArrayName ))
        CopyOut = true;
      else if (EXISTSinMap(PersistentOutMap[DefPragmaOmpSeq], DefArrayName ))
        PersistentOut = true;
    }
    auto DefPragmaLocation = MemInfo.OmpDiagnosticsLocationInfo.getDebugLocStr(DefPragmaOmpSeq);
    auto UsePragmaLocation = MemInfo.OmpDiagnosticsLocationInfo.getDebugLocStr(UsePragmaOmpSeq);
    std::string ErrorMessage = "";
    auto DefLocation = MemInfo.OmpDiagnosticsLocationInfo.getDebugLocStr(*MemDefInstr);
    auto UseLocation = MemInfo.OmpDiagnosticsLocationInfo.getDebugLocStr(*MemUseInstr);
    if (UseOnDevice && ( !PersistentIn && !CopyIn)) {
      ErrorMessage = " 'to:"+UseArrayName+"' At Line:" + UsePragmaLocation;
    }
    if (DefOnDevice && (!PersistentOut && !CopyOut)){
      ErrorMessage = " 'from:"+DefArrayName+"' At Line:" + UsePragmaLocation;
    }
    if (!ErrorMessage.empty()){
      errs() << "\n === Error detected in usage of omp map clauses === ";
      errs() << "\n Definition of variable:'"<< DefArrayName << "' on Line: " << DefLocation << " does not reach the use of variable:'" << UseArrayName <<"' on Line: " << UseLocation;
      errs() << "\n Possible Fix, Add omp map clause :"<< ErrorMessage << "\n\n";
    }
        if (UseOnDevice && DefOnDevice){
          // TODO: Check if within same region.
          // If not within same target region, then persistent out and in. 
          if (UsePragmaOmpSeq == DefPragmaOmpSeq)
            continue;
          // copy out or persistent out
          if (EXISTSinMap(DeviceToHostMap[DefPragmaOmpSeq], DefArrayName ) || EXISTSinMap(DeviceToHostMap[DefPragmaOmpSeq], UseArrayName ) ){
            LLVM_DEBUG(dbgs()<<"\n exists in device to host copy:"<<UseArrayName);
          }else 
            LLVM_DEBUG(dbgs()<<"\n Error not copied out"<<UseArrayName);
          
          if (EXISTSinMap(HostToDeviceMap[UsePragmaOmpSeq], DefArrayName ) || EXISTSinMap(HostToDeviceMap[UsePragmaOmpSeq], UseArrayName ) ){
            LLVM_DEBUG(dbgs()<<"\n exists in device to host copy:"<<UseArrayName<<"\n");
          } else {
            LLVM_DEBUG(dbgs()<<"\n Error not copied in:"<<UseArrayName<<"\n");
          }
        }else if (DefOnDevice && !UseOnDevice){
          // If defined in target but used on host, then
          // Must be copy out or persistent out from target.
          if (EXISTSinMap(DeviceToHostMap[DefPragmaOmpSeq], DefArrayName ) || EXISTSinMap(DeviceToHostMap[DefPragmaOmpSeq], UseArrayName ) ){
            LLVM_DEBUG(dbgs()<<"\n exists in device to host copy:"<<UseArrayName);
          } else {
            LLVM_DEBUG(dbgs()<<"\n Error not copied out"<<UseArrayName);
          }
        }else if (!DefOnDevice && UseOnDevice){
          // Must be Copy in or persistent in to the target.
          if (EXISTSinMap(HostToDeviceMap[UsePragmaOmpSeq], DefArrayName ) || EXISTSinMap(HostToDeviceMap[UsePragmaOmpSeq], UseArrayName ) ){
            LLVM_DEBUG(dbgs()<<"\n exists in device to host copy:"<<UseArrayName<<"\n");
          } else {
            LLVM_DEBUG(dbgs()<<"\n Error not copied in:"<<UseArrayName<<"\n");
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

