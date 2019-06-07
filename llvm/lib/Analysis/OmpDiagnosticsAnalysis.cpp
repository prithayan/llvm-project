//===- OmpDiagnosticsAnalysis.cpp - Stack memory safety analysis -------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
//===----------------------------------------------------------------------===//


//int omp_get_num_devices(void);
//int omp_get_initial_device(void);
//void *omp_target_alloc(size_t size, int device_num);
//void omp_target_free(void *device_ptr, int device_num);
//int omp_target_is_present(void *ptr, int device_num);
//int omp_target_memcpy(void *dst, void *src, size_t length, size_t dst_offset,
//    size_t src_offset, int dst_device, int src_device);
//int omp_target_memcpy_rect(void *dst, void *src, size_t element_size,
//    int num_dims, const size_t *volume, const size_t *dst_offsets,
//    const size_t *src_offsets, const size_t *dst_dimensions,
//    const size_t *src_dimensions, int dst_device, int src_device);
//int omp_target_associate_ptr(void *host_ptr, void *device_ptr, size_t size,
//    size_t device_offset, int device_num);
//int omp_target_disassociate_ptr(void *host_ptr, int device_num);
//
///// adds a target shared library to the target execution image
//void __tgt_register_lib(__tgt_bin_desc *desc);
//
///// removes a target shared library from the target execution image
//void __tgt_unregister_lib(__tgt_bin_desc *desc);
//
//// creates the host to target data mapping, stores it in the
//// libomptarget.so internal structure (an entry in a stack of data maps) and
//// passes the data to the device;
//void __tgt_target_data_begin(int64_t device_id, int32_t arg_num,
//                             void **args_base, void **args, int64_t *arg_sizes,
//                             int64_t *arg_types);
//void __tgt_target_data_begin_nowait(int64_t device_id, int32_t arg_num,
//                                    void **args_base, void **args,
//                                    int64_t *arg_sizes, int64_t *arg_types,
//                                    int32_t depNum, void *depList,
//                                    int32_t noAliasDepNum,
//                                    void *noAliasDepList);
//
//// passes data from the target, release target memory and destroys the
//// host-target mapping (top entry from the stack of data maps) created by
//// the last __tgt_target_data_begin
//void __tgt_target_data_end(int64_t device_id, int32_t arg_num, void **args_base,
//                           void **args, int64_t *arg_sizes, int64_t *arg_types);
//void __tgt_target_data_end_nowait(int64_t device_id, int32_t arg_num,
//                                  void **args_base, void **args,
//                                  int64_t *arg_sizes, int64_t *arg_types,
//                                  int32_t depNum, void *depList,
//                                  int32_t noAliasDepNum, void *noAliasDepList);
//
///// passes data to/from the target
//void __tgt_target_data_update(int64_t device_id, int32_t arg_num,
//                              void **args_base, void **args, int64_t *arg_sizes,
//                              int64_t *arg_types);
//void __tgt_target_data_update_nowait(int64_t device_id, int32_t arg_num,
//                                     void **args_base, void **args,
//                                     int64_t *arg_sizes, int64_t *arg_types,
//                                     int32_t depNum, void *depList,
//                                     int32_t noAliasDepNum,
//                                     void *noAliasDepList);
//
//// Performs the same actions as data_begin in case arg_num is non-zero
//// and initiates run of offloaded region on target platform; if arg_num
//// is non-zero after the region execution is done it also performs the
//// same action as data_end above. The following types are used; this
//// function returns 0 if it was able to transfer the execution to a
//// target and an int different from zero otherwise.
//int __tgt_target(int64_t device_id, void *host_ptr, int32_t arg_num,
//                 void **args_base, void **args, int64_t *arg_sizes,
//                 int64_t *arg_types);
//int __tgt_target_nowait(int64_t device_id, void *host_ptr, int32_t arg_num,
//                        void **args_base, void **args, int64_t *arg_sizes,
//                        int64_t *arg_types, int32_t depNum, void *depList,
//                        int32_t noAliasDepNum, void *noAliasDepList);
//
//int __tgt_target_teams(int64_t device_id, void *host_ptr, int32_t arg_num,
//                       void **args_base, void **args, int64_t *arg_sizes,
//                       int64_t *arg_types, int32_t num_teams,
//                       int32_t thread_limit);
//int __tgt_target_teams_nowait(int64_t device_id, void *host_ptr,
//                              int32_t arg_num, void **args_base, void **args,
//                              int64_t *arg_sizes, int64_t *arg_types,
//                              int32_t num_teams, int32_t thread_limit,
//                              int32_t depNum, void *depList,
//                              int32_t noAliasDepNum, void *noAliasDepList);
#include "llvm/Analysis/OmpDiagnosticsAnalysis.h"
#include "llvm/Analysis/ScalarEvolutionExpressions.h"
#include "llvm/IR/CallSite.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/Support/raw_ostream.h" 

using namespace llvm;

#define DEBUG_TYPE "omp-diagnostics"


const RTLinfoType *getRTLinfo(const CallInst &CI){
  if (auto CalledFunc = CI.getCalledFunction() ) {
    auto CName = CalledFunc->getName();
    auto Iter = TargetRTLMap.find(CName);
    if ( Iter != TargetRTLMap.end()){
      const RTLinfoType *Ret = &Iter->second; 
      return Ret;
    }
  }
  return nullptr;
}
OmpDiagnosticsInfo::OmpDiagnosticsInfo() { 
  DeviceEnvironments.push_back( ItemsRefCountType());
}
//OmpDiagnosticsInfo::OmpDiagnosticsInfo(OmpDiagnosticsInfo &&) = default;
//OmpDiagnosticsInfo &OmpDiagnosticsInfo::operator=(OmpDiagnosticsInfo &&) = default;


OmpDiagnosticsInfo::~OmpDiagnosticsInfo() = default;

void OmpDiagnosticsInfo::print(raw_ostream &O) const {

  if (HostDeviceCopy.size()) {
    O <<"\n =============== ";
    O << "\n Host to Device Copy:";
    for (auto Iter : HostDeviceCopy) {
      O << "\n " << *Iter.first ;
      for (auto Id : Iter.second ){
        O << "\t Copy:: " << *Id;
      }
    }
  }
  if (DeviceHostCopy.size()){
    O << "\n Device to Host Copy:";
    for (auto Iter : DeviceHostCopy) {
      O << "\n " << *Iter.first ;
      for (auto Id : Iter.second ){
        O << "\t Copy:: " << *Id;
      }
    }
  }
}

void OmpDiagnosticsInfo::enterDataEnv(const Instruction &OmpCall, IdType ItemId, unsigned MapTypeInt, unsigned ItemSize, unsigned DeviceId){
  // 1. If a corresponding list item of the original list item is not present in the device data environment,then:
  //    a) A new list item with language-specific attributes is derived from the original list item and23created in the device data environment; 
  //    b) The new list item becomes the corresponding list item of the original list item in the device25data environment;
  //    c) The corresponding list item has a reference count that is initialized to zero; and
  //    d) The value of the corresponding list item is undefined;
  //  2. If the corresponding list item’s reference count was not already incremented because of the effect of amapclause on the construct then:
  //    a) The corresponding list item’s reference count is incremented by one; 
  //  3. If the corresponding list item’s reference count is one or thealwaysmap-type-modifier is present, and if themap-typeistoortofrom, then
  //    a) For each part of the list item that is an attached pointer, that part of the corresponding list3item will have the value that it had immediately prior to the effect of themapclause; a
  ItemsRefCountType &DEnvMap = DeviceEnvironments[DeviceId];
  // If the item not present in device environment
  if (!EXISTSinMap(DEnvMap, ItemId))  {
    // Initialize reference count to zero
    DEnvMap[ItemId] = 0;
  }
  DEnvMap[ItemId]++;
  if  ( (DEnvMap[ItemId] == 1 || (MapTypeInt & OMP_TGT_MAPTYPE_ALWAYS)) && 
      (MapTypeInt & OMP_TGT_MAPTYPE_TO) ){
    LLVM_DEBUG(dbgs()<<" Copy Host to Device");
    HostDeviceCopy[&OmpCall].insert(ItemId);
  }
  LLVM_DEBUG(dbgs()<<"\n Enter ItemID:"<<ItemId<<" Count :"<<DEnvMap[ItemId]);
}
void OmpDiagnosticsInfo::exitDataEnv(const Instruction &OmpCall, IdType ItemId, unsigned MapTypeInt, unsigned ItemSize, unsigned DeviceId){
  // 1. If themap-type is notdeleteand the corresponding list item’s reference count is finite and was not already decremented because of the effect of amapclause on the construct then:
  //  a) The corresponding list item’s reference count is decremented by one;. 
  // 2. If themap-type is delete and the corresponding list item’s reference count is finite then:
  //    a) The corresponding list item’s reference count is set to zero;
  // 3. If themap-typeisfromortofromand if the corresponding list item’s reference count is zero or the alwaysmap-type-modifieris present then:
  //    a) For each part of the list item that is an attached pointer, that part of the original list item will1have the value that it had immediately prior to the effect of themapclause;
  // 4. If the corresponding list item’s reference count is zero then the corresponding list item is8removed from the device data environment  
  LLVM_DEBUG(dbgs()<<"\n IN Exit Data env for "<<ItemId
      <<" Maptype::"<<MapTypeInt 
      <<" Maptype:: "<<OMP_TGT_MAPTYPE_FROM  
      <<" ismap from::"<<(MapTypeInt & OMP_TGT_MAPTYPE_FROM) );
  ItemsRefCountType &DEnvMap = DeviceEnvironments[DeviceId];
  // If the item not present in device environment
  if (!EXISTSinMap(DEnvMap, ItemId))  {
    // Initialize reference count to zero
    LLVM_DEBUG(dbgs()<<"\n Doesnot Exist in Map:"<<ItemId);
    return;
  }
  DEnvMap[ItemId]--;
  LLVM_DEBUG(dbgs()<<"\nExit Env Map Count:"<<DEnvMap[ItemId]);
  if  ( MapTypeInt & OMP_TGT_MAPTYPE_DELETE )  {
    DEnvMap[ItemId] = 0;
    LLVM_DEBUG(dbgs()<<"\n Delete :"<<DEnvMap[ItemId]);
  }
  if (( DEnvMap[ItemId] == 0 || (MapTypeInt & OMP_TGT_MAPTYPE_ALWAYS) ) && 
      (MapTypeInt & OMP_TGT_MAPTYPE_FROM) ) {
    LLVM_DEBUG(dbgs()<<" Copy Device to Host");
    DeviceHostCopy[&OmpCall].insert(ItemId);
  }
  if (DEnvMap[ItemId] == 0) 
    DeviceEnvironments[DeviceId].erase(ItemId );
}
bool ValueFlowAtInstruction::getIdForValue(IdType &Id, const Value *V, const unsigned Index){
  if (!EXISTSinMap(Value2IdMap, V))
    return false;
  Id = Value2IdMap[V].at(Index);
  return true;
}
ValueFlowAtInstruction::IdType ValueFlowAtInstruction::getIdForValue(const Value *V, const unsigned Index ){
  static unsigned IdCounter = 0;
  if (EXISTSinMap(Value2IdMap, V) )
      if (Value2IdMap[V].size() > Index)
  return Value2IdMap[V][Index];
  // Now, create an id for all the entries till Index
  // The following loop is required, so that we can 
  // create an entry for Value2IdMap[V][2] even before the entry for Value2IdMap[V][0] exists
  // If the Size is less than Index+1, then create an entry for all the elements, 
  // Till Index, and assign a new Id to them
  while ( Value2IdMap[V].size() < (Index+1)) {
    // Last element at [index]
    Value2IdMap[V].push_back(IdCounter++);
    Id2ValueMap.push_back(V);
  } 
  // Now size = Index+1
  return Value2IdMap[V][Index];
}
/// Lhs has the same contents as Rhs
/// Depending on their types, it may either point to the same object or 
/// Have the same Value
void ValueFlowAtInstruction::addAlias(const Value* Lhs, const Value* Rhs, unsigned Index ){
  IdType LhsId = getIdForValue(Lhs, Index);
  IdType RhsId = getIdForValue(Rhs);
  ValueFlowMap[LhsId] = RhsId;
}
void ValueFlowAtInstruction::run(){
  for (auto I = &ValuesAtInstruction ; I != nullptr ; I = I->getPrevNonDebugInstruction()  ){
    if (auto GEP = dyn_cast<GetElementPtrInst>(I)){
      auto PtrOp = GEP->getPointerOperand();
      // Since we are only concerned about the omp rtl function arguments, 
      // We know that they will have constant indices
      // So, we only handle this case
      if (GEP->hasAllConstantIndices()){
        auto IndexOpIt = (GEP->idx_end()-1);
        const Value *IndexOp = *IndexOpIt;
        const unsigned ConstVal = dyn_cast<Constant>(IndexOp)->getUniqueInteger().getZExtValue();
        LLVM_DEBUG(dbgs()<<"\n PtrOp:"<<*PtrOp
            <<"\n IndexOp: "<<*IndexOp
            <<"\n Const Index:"<<ConstVal
            );
        // This means that, 
        // after this instruction, contents of PtrOp same as I
        // PtrOp[ConstVal] = I 
        addAlias(PtrOp, I, ConstVal);
      }
    }else if (auto LoadedValue = dyn_cast<LoadInst>(I)){
      auto LoadAddress = LoadedValue->getPointerOperand();
      // LoadedValue = LoadAddress[0]; 
      addAlias(LoadedValue, LoadAddress);
    }else if (auto Store = dyn_cast<StoreInst>(I)){
      auto Address = (Store->getPointerOperand());
      auto StoredVal = (Store->getValueOperand());
      // Address[0] = StoredVal 
      addAlias(Address, StoredVal);
      //AddresContent[Address] = StoredVal;
    }else if (I->isCast()){
      // Only one operand
      auto Src = I->getOperand(0);
      // After this instruction, contents of Src same as I
      // Src = I
      addAlias(Src, I);
    }
  }
}
void ValueFlowAtInstruction::print(){
  LLVM_DEBUG(dbgs()<<"\n ==== PRINTING ======");
  for (auto Iter : Value2IdMap) {
    LLVM_DEBUG(dbgs()<<"\n Value::"<<*Iter.first);
    for (auto Id : Iter.second)
      LLVM_DEBUG(dbgs()<<"\t Id::"<<Id);
  }
  LLVM_DEBUG(dbgs()<<"\n ==========");
  for (auto Iter : ValueFlowMap) {
    LLVM_DEBUG(dbgs()<<" \n  "<< Iter.first
        <<"=>" << Iter.second);
    LLVM_DEBUG(dbgs()<<" \n  "<< *Id2ValueMap[Iter.first] 
        <<"=>" << *Id2ValueMap[Iter.second]);
  }
  LLVM_DEBUG(dbgs()<<"\n ==========");
}
void ValueFlowAtInstruction::parseArguments(const CallInst &OmpCall, const unsigned NumVars, 
      const Value *BaseAddrArg, const Value *SizeAddrArg, 
      const Value *MaptTypeArg){
  // %21 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_baseptrs, i32 0, i32 0, !dbg !69
  // %22 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_ptrs, i32 0, i32 0, !dbg !69
  // %23 = call i32 @__tgt_target_teams(i64 0, i8* @.__omp_offloading_801_15a4795_Mult_l30.region_id, i32 3, i8** %21, i8** %22, i64* getelementptr inbounds ([3 x i64], [3 x i64]* @.offload_sizes, i32 0, i32 0), i64* getelementptr inbounds ([3 x i64], [3 x i64]* @.offload_maptypes, i32 0, i32 0), i32 0, i32 0), 
  SmallVector<IdType, 5 > ArrayVarsMapped; 
  ArrayVarsMapped.resize(NumVars);
  auto BaseAddr = dyn_cast<GetElementPtrInst>(BaseAddrArg);
  LLVM_DEBUG(dbgs()<<"\n Map type: "<<*MaptTypeArg);
  // Assumption, the Maptype is always a global constant array
  if (!isa<GEPOperator>(MaptTypeArg)) return;
  auto MapTypeAddr = dyn_cast<GlobalVariable>(dyn_cast<GEPOperator>(MaptTypeArg)->getPointerOperand() )->getInitializer();
  auto SizeAddrGep = dyn_cast<GEPOperator>(SizeAddrArg);
  const GlobalVariable *ConstSizeAddr = nullptr; 
  if (SizeAddrGep!= nullptr) ConstSizeAddr = dyn_cast<GlobalVariable>(SizeAddrGep->getPointerOperand()); 

  // The Arguments sent to the RTL is always a pointer
  // and we assume the pointer will be obtained from a GEP
  if (BaseAddr == nullptr ) return;
  // Now we need to look at the contents of the address of this GEP
  // Assumption: the index is zero, so just look for the id of the pointer
  // Now check the contents of the array at this address
  for (unsigned MappedVarNum = 0 ; MappedVarNum < NumVars ; MappedVarNum++) {
    // If the pointer does not have an ID, then our analysis did not see it, 
    // Cannot Handle, return
    IdType BaseAddrId;
    if (! getIdForValue(BaseAddrId, BaseAddr->getPointerOperand(), MappedVarNum)) return;
    LLVM_DEBUG(dbgs()<<"\n Baseaddr: "<<BaseAddrId);
    for ( ; EXISTSinMap(ValueFlowMap, BaseAddrId) ; ){
      LLVM_DEBUG(dbgs()<<"\n Get alias for Baseaddr: "<<BaseAddrId);
      BaseAddrId = ValueFlowMap[BaseAddrId];
      LLVM_DEBUG(dbgs()<<" == > Baseaddr: "<<BaseAddrId);
      LLVM_DEBUG(dbgs()<<"\n Alias::"<<*(Id2ValueMap[BaseAddrId]));
    }
    ArrayVarsMapped[MappedVarNum] = BaseAddrId;
    const unsigned MapTypeInt = MapTypeAddr->getAggregateElement(MappedVarNum)->getUniqueInteger().getSExtValue();
    unsigned MappedSectionSize  = 0;
    if (ConstSizeAddr != nullptr ) {
      MappedSectionSize = ConstSizeAddr->getInitializer()->getAggregateElement(MappedVarNum)->getUniqueInteger().getSExtValue();
    } // TODO: Handle when the section size is not a constant
    LLVM_DEBUG(dbgs()<<"\n Variable:"<<*(Id2ValueMap[BaseAddrId])
        <<"["<< MappedSectionSize << "]"
        <<" Mapped wtih :: "<<MapTypeInt );
    auto RTLInfo  = getRTLinfo(OmpCall);
    assert(RTLInfo != nullptr && "Not a data mapping RTL call ");
    LLVM_DEBUG(dbgs()<<"\n EnterEnv:: "<< RTLInfo->IsEnterEnv 
        <<" Exit:: "<<RTLInfo->IsExitEnv);
    if (RTLInfo->IsEnterEnv)
      OmpEnvInfo.enterDataEnv(OmpCall, Id2ValueMap[BaseAddrId], MapTypeInt, MappedSectionSize);
    if (RTLInfo->IsExitEnv)
      OmpEnvInfo.exitDataEnv(OmpCall, Id2ValueMap[BaseAddrId], MapTypeInt, MappedSectionSize);
  }
}

OmpDiagnosticsInfo OmpDiagnosticsLocalAnalysis::OmpEnvInfo;
bool OmpDiagnosticsLocalAnalysis::getRTLArgsPos(const CallInst &CI, 
    unsigned &NumVarsPos, unsigned &BaseAddrPos, unsigned &SizePos, unsigned &MapTypePos){
  auto Info = getRTLinfo(CI);
  if (Info != nullptr) {
      NumVarsPos = Info->NumVariablesPosition; 
      BaseAddrPos = Info->VariableBaseAddressPosition;
      SizePos = Info->VariableSizePosition;
      MapTypePos = Info->MapTypePosition;
      return true;
  }
  //if (auto CalledFunc = CI.getCalledFunction() ) {
  //  auto CName = CalledFunc->getName();
  //  auto Iter = TargetRTLMap.find(CName);
  //  if ( Iter != TargetRTLMap.end()){
  //    NumVarsPos = Iter->second.NumVariablesPosition; 
  //    BaseAddrPos = Iter->second.VariableBaseAddressPosition;
  //    SizePos = Iter->second.VariableSizePosition;
  //    MapTypePos = Iter->second.MapTypePosition;
  //    return true;
  //  }
  //}
  return false;
}
void OmpDiagnosticsLocalAnalysis::analyzeRTLArguments(const CallInst &CI, 
      const unsigned NumVarsPos, const unsigned BaseAddrPos, 
      const unsigned SizePos, const unsigned MapTypePos ){
  auto NumVarsArg = CI.getArgOperand(NumVarsPos);
  auto BaseAddrArg = CI.getArgOperand(BaseAddrPos);
  auto SizeArg = CI.getArgOperand(SizePos);
  auto MaptTypeArg = CI.getArgOperand(MapTypePos);
  auto NumVars =  dyn_cast<ConstantInt>(NumVarsArg);
  if (NumVars == nullptr) {
    LLVM_DEBUG(dbgs()<<" \n Number of Vars not a Constant"<<*NumVarsArg);
    return ;
  }
  //NumVars->getUniqueInteger();
  LLVM_DEBUG(dbgs()<<"\n Num Var: "<<NumVars->getSExtValue()
      <<"\n Baseaddr:: "<<*BaseAddrArg
      <<"\n SizeArg::"<<*SizeArg
      <<"\n Maptype::"<<*MaptTypeArg);
  ValueFlowAtInstruction VFA(CI, OmpEnvInfo);
  VFA.run();
  VFA.print();
  VFA.parseArguments(CI, NumVars->getSExtValue(), BaseAddrArg, SizeArg, MaptTypeArg ); 
}
OmpDiagnosticsInfo &OmpDiagnosticsLocalAnalysis::run(){
  for (auto &I : instructions(Func2Analyze)){
    if (const CallInst *OmpCall = dyn_cast<CallInst>(&I)){
      unsigned NumVarsPos, BaseAddrPos, SizePos, MapTypePos;
      if (getRTLArgsPos(*OmpCall, 
            NumVarsPos, BaseAddrPos, SizePos, MapTypePos)){
        LLVM_DEBUG(dbgs()<<"\n OMP RTL :"<< *OmpCall<<"\n");
        analyzeRTLArguments(*OmpCall, 
            NumVarsPos, BaseAddrPos, SizePos, MapTypePos);
      }
    }
  }
  return OmpEnvInfo;
}

AnalysisKey OmpDiagnosticsAnalysis::Key;

OmpDiagnosticsInfo& OmpDiagnosticsAnalysis::run(Function &F,
                                         FunctionAnalysisManager &AM) {
  OmpDiagnosticsLocalAnalysis OMPD(F);//.getResult<ScalarEvolutionAnalysis>(F));
  return OMPD.run(); 
  //OmpDiagnosticsLocalAnalysis SSLA(F, AM.getResult<ScalarEvolutionAnalysis>(F));
  //return SSLA.run();
}

PreservedAnalyses OmpDiagnosticsPrinterPass::run(Function &F,
                                              FunctionAnalysisManager &AM) {
  OS << "'omp diagnostics Local Analysis' for function '" << F.getName() << "'\n";
  AM.getResult<OmpDiagnosticsAnalysis>(F).print(OS);
  return PreservedAnalyses::all();
}

char OmpDiagnosticsInfoWrapperPass::ID = 0;

OmpDiagnosticsInfoWrapperPass::OmpDiagnosticsInfoWrapperPass() : FunctionPass(ID), 
  OmpEnvInfo(nullptr){
    initializeOmpDiagnosticsInfoWrapperPassPass(*PassRegistry::getPassRegistry());
  }

void OmpDiagnosticsInfoWrapperPass::getAnalysisUsage(AnalysisUsage &AU) const {
  AU.addRequired<ScalarEvolutionWrapperPass>();
  AU.setPreservesAll();
}

void OmpDiagnosticsInfoWrapperPass::print(raw_ostream &O, const Module *M) const {
  OmpEnvInfo->print(O);
  //SSI.print(O);
}

bool OmpDiagnosticsInfoWrapperPass::runOnFunction(Function &F) {
  OmpDiagnosticsLocalAnalysis OMPD(F);//.getResult<ScalarEvolutionAnalysis>(F));
  OmpEnvInfo = &OMPD.run(); 
  //OmpDiagnosticsLocalAnalysis SSLA(
  //    F, getAnalysis<ScalarEvolutionWrapperPass>().getSE());
  //SSI = OmpDiagnosticsInfo(SSLA.run());
  return false;
}

AnalysisKey OmpDiagnosticsGlobalAnalysis::Key;

OmpDiagnosticsGlobalInfo
OmpDiagnosticsGlobalAnalysis::run(Module &M, ModuleAnalysisManager &AM) {
  OmpDiagnosticsGlobalInfo result; 
  return result;
  //FunctionAnalysisManager &FAM =
  //    AM.getResult<FunctionAnalysisManagerModuleProxy>(M).getManager();

  //OmpDiagnosticsDataFlowAnalysis SSDFA(
  //    M, [&FAM](Function &F) -> const OmpDiagnosticsInfo & {
  //      return FAM.getResult<OmpDiagnosticsAnalysis>(F);
  //    });
  //return SSDFA.run();
}

PreservedAnalyses OmpDiagnosticsGlobalPrinterPass::run(Module &M,
                                                    ModuleAnalysisManager &AM) {
  OS << "'omp diagnostics Analysis' for module '" << M.getName() << "'\n";
  //print(AM.getResult<OmpDiagnosticsGlobalAnalysis>(M), OS, M);
  return PreservedAnalyses::all();
}

char OmpDiagnosticsGlobalInfoWrapperPass::ID = 0;

OmpDiagnosticsGlobalInfoWrapperPass::OmpDiagnosticsGlobalInfoWrapperPass()
    : ModulePass(ID) {
  initializeOmpDiagnosticsGlobalInfoWrapperPassPass(
      *PassRegistry::getPassRegistry());
}

void OmpDiagnosticsGlobalInfoWrapperPass::print(raw_ostream &O,
                                             const Module *M) const {
  //::print(SSI, O, *M);
}

void OmpDiagnosticsGlobalInfoWrapperPass::getAnalysisUsage(
    AnalysisUsage &AU) const {
  AU.addRequired<OmpDiagnosticsInfoWrapperPass>();
}

bool OmpDiagnosticsGlobalInfoWrapperPass::runOnModule(Module &M) {
  //OmpDiagnosticsDataFlowAnalysis SSDFA(
  //    M, [this](Function &F) -> const OmpDiagnosticsInfo & {
  //      return getAnalysis<OmpDiagnosticsInfoWrapperPass>(F).getResult();
  //    });
  //SSI = SSDFA.run();
  return false;
}

static const char LocalPassArg[] = "omp-diagnostics-local";
static const char LocalPassName[] = "omp diagnostics Local Analysis";
INITIALIZE_PASS_BEGIN(OmpDiagnosticsInfoWrapperPass, LocalPassArg, LocalPassName,
                      false, true)
INITIALIZE_PASS_DEPENDENCY(ScalarEvolutionWrapperPass)
INITIALIZE_PASS_END(OmpDiagnosticsInfoWrapperPass, LocalPassArg, LocalPassName,
                    false, true)

static const char GlobalPassName[] = "omp diagnostics Analysis";
INITIALIZE_PASS_BEGIN(OmpDiagnosticsGlobalInfoWrapperPass, DEBUG_TYPE,
                      GlobalPassName, false, false)
INITIALIZE_PASS_DEPENDENCY(OmpDiagnosticsInfoWrapperPass)
INITIALIZE_PASS_END(OmpDiagnosticsGlobalInfoWrapperPass, DEBUG_TYPE,
                    GlobalPassName, false, false)
