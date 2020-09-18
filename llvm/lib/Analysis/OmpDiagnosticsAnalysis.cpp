//===- OmpDiagnosticsAnalysis.cpp - Analyze omp target clauses and infer data
//-------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
//===----------------------------------------------------------------------===//

#include "llvm/Analysis/OmpDiagnosticsAnalysis.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/ScalarEvolutionExpressions.h"
//#include "llvm/IR/CallSite.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

#define DEBUG_TYPE "omp-diagnostics"

const Value* getAlloca(const Value* Inst){

  if (auto Gep = dyn_cast<GetElementPtrInst>(Inst))
    return getAlloca(Gep->getPointerOperand());
  if (auto Bitcast = dyn_cast<BitCastInst>(Inst))
    return getAlloca(Bitcast->getOperand(0));
  
  return Inst;
}
bool checkAlias(const Value* &A, const Value* &B){
  if (A == nullptr || B == nullptr) 
    return false;
  auto MemA = getAlloca(A);
  auto MemB = getAlloca(B);

  A = MemA;
  B = MemB;
  bool AisAlloca = isa<AllocaInst>(MemA);
  bool BisAlloca = isa<AllocaInst>(MemB);
  bool AisCall = isa<CallInst> (MemA)&& dyn_cast<CallInst>(MemA)->getCalledFunction()->getName().contains("_Zn");
  bool BisCall = isa<CallInst> (MemB) && isa<CallInst> (MemB) && dyn_cast<CallInst>(MemB)->getCalledFunction()->getName().contains("_Zn");
  if (AisCall)
    LLVM_DEBUG(dbgs()<<"\n Call ::"<<*MemA);
  if (AisAlloca && BisAlloca  && MemA != MemB )
    return false;
  if ((AisAlloca && isa<GlobalVariable>(MemB) ) || (isa<GlobalVariable>(MemA) && BisAlloca) )
    return false;
  if ((AisAlloca && BisCall) || (AisCall && BisAlloca)|| (AisCall  && BisCall && dyn_cast<CallInst>(MemA) != dyn_cast<CallInst>(MemB)))
    return false;
  return true;
}
Value *OmpDiagnosticsLocalAnalysis::getAliasingCallArg(CallInst &CIDef,
                                                       Value &PointerOp) {
  Value *AliasingArg = nullptr;
  for (Value *CallArg : CIDef.args()) {
    if (AA.isNoAlias(CallArg, &PointerOp))
      continue;
    AliasingArg = CallArg;
  }
  return AliasingArg;
}

llvm::Optional<unsigned>
OmpDiagnosticsLocalAnalysis::getAliasingArg(const Value &Mem,
                                            const Function &F) {
  // Iterate over all function arguments, and check which argument aliases with
  // Mem.
  auto FuncArgs = F.args();
  unsigned ArgI = 0;
  for (const Value &Arg : FuncArgs) {
    AliasResult AR = AA.alias(&Mem, &Arg);
    if (AR != NoAlias)
      return ArgI;
    ArgI++;
  }
  // This means none of the arguments alias, could be global.
  return ArgI;
}

void OmpDiagnosticsLocalAnalysis::recordFuncGenDefs(const MemoryDef &MemDef) {
  LLVM_DEBUG(dbgs() << "\n MemDef:"; MemDef.dump());
  if (MSSA.isLiveOnEntryDef(&MemDef))
    return;
  Instruction *DefInstr = MemDef.getMemoryInst();
  if (DefInstr == nullptr)
    assert("Cannot handle MemoryDef: not liveonentry or instruction");
  const Function &ParentF = *DefInstr->getFunction();
  // if this is a call instruction, then check if we are passing a function argument to this call instruction. This is required to handle use defs across multiple function calls.
  if (auto CI = dyn_cast<CallInst>(DefInstr)) {
    for (unsigned CallArgI = 0; CallArgI < CI->getNumArgOperands();
         CallArgI++) {
      Value *Arg = CI->getArgOperand(CallArgI);
      auto FArgI = getAliasingArg(*Arg, ParentF);
      // Does not alias with any function argument.
      if (FArgI == None)
        continue;
      // Call instruction argument refers to which parent function argument.
      CallToFuncArgsAliasMap[CI][CallArgI] = *FArgI;
      // FuncToGenDefs[&ThisFunc][*FArgI] = CI;
      // AA.alias(Arg,
    }
  }
  // Next check if this store instruction updates one of the function arguments.
  if (auto St = dyn_cast<StoreInst>(DefInstr)) {
    auto Mem = MemoryLocation::getOrNone(St);
    if (Mem == None)
      return;
    auto ArgI = getAliasingArg(*Mem->Ptr, ParentF);
    if (ArgI == None)
      return;
    LLVM_DEBUG(dbgs() << "\n arg:" << *ArgI << "\n Def::" << MemDef);
    FuncToGenDefs[&ThisFunc][*ArgI] = DefInstr;

    // LLVM_DEBUG(dbgs()<<" \n Mem Loc::"<<*MemoryLocation::get(St).Ptr);
  }
}

bool OmpDiagnosticsLocalAnalysis::recordIfLiveOnEntry(
    const MemoryAccess &MA, const Instruction &Ld, const unsigned AliasingArg) {
  for (auto DefIter = MA.defs_begin(); DefIter != MA.defs_end(); DefIter++) {
    const MemoryAccess *DefMA = *DefIter;
    if (MSSA.isLiveOnEntryDef(DefMA)) {
      addFuncToGenUse(Ld, AliasingArg);
      return true;
    }
    if (recordIfLiveOnEntry(*DefMA, Ld, AliasingArg))
      return true;
  }
  return false;
}

void OmpDiagnosticsLocalAnalysis::recordFuncGenUses(const MemoryUse &MemUse) {
  // This function records if the instruction uses one of the function arguments.
  LLVM_DEBUG(dbgs() << "\n MemUse:" << MemUse);
  if (!isa<LoadInst>(MemUse.getMemoryInst())) {
    MemUse.getMemoryInst()->dump();
    assert("Instruction MemUse Not handled:");
  }
  LoadInst *Ld = dyn_cast<LoadInst>(MemUse.getMemoryInst());
  // Get the memory location corresponding to the load instruction.
  auto LdMem = MemoryLocation::get(Ld);
  // Check if the load address accesses one of the function arguments.
  auto AliasingArg = getAliasingArg(*LdMem.Ptr, *Ld->getFunction());
  LLVM_DEBUG(dbgs() << " \n Mem Loc::" << *LdMem.Ptr
                    << " AliasingArg=" << AliasingArg);
  if (AliasingArg == None)
    return;
  const MemoryAccess *MA = &MemUse;
  recordIfLiveOnEntry(*MA, *Ld, *AliasingArg);
  return ;
}

void OmpDiagnosticsLocalAnalysis::recordFuncGens() {
  LLVM_DEBUG(dbgs() << "\n Analysis Local:"<<ThisFunc.getName());
  for (const BasicBlock &BB : ThisFunc) {
    auto MAList = MSSA.getBlockAccesses(&BB);
    if (MAList == nullptr)
      continue;
    for (const MemoryAccess &MA : *MAList) {
      if (auto MemUse = dyn_cast<MemoryUse>(&MA))
        recordFuncGenUses(*MemUse);
      if (auto MemDef = dyn_cast<MemoryDef>(&MA))
        recordFuncGenDefs(*MemDef);
    }
  }
  /* Moved this to a print function.
  */
}

void OmpDiagnosticsLocalAnalysis::run() {
  // This analysis records the following 3 items,
  // 1. Which instruction uses one of the function arguments.
  // 2. Which instruction defines one of the function arguments.
  // 3. Which call instruction passes one of the function arguments.

  LLVM_DEBUG(dbgs() << "\n Analysis Local:");
  recordFuncGens();

  return;
}

void OmpDiagnosticsLocalAnalysis::print() {
  for (auto Iter : FuncToGenDefs[&ThisFunc]) {
    LLVM_DEBUG(dbgs() << "\n Arg:" << Iter.first << "\n Def::";
               Iter.second->dump());
  }
  for (auto Iter : CallToFuncArgsAliasMap) {
    LLVM_DEBUG(dbgs() << "\n Call:" << *Iter.first);
    for (auto ArgIter : Iter.second) {
      LLVM_DEBUG(dbgs() << ", Call Arg:" << ArgIter.first
                        << " Func Arg:" << ArgIter.second);
    }
  }
}
Function * InterproceduralAnalysis::getCalledFuncUses(CallInst &CI, ArgToUseMapTy &ArgToUseMap) {
  Function *F = CI.getCalledFunction();
  unsigned NumArgs = CI.getNumArgOperands();
  bool ACS = false;
  if (CallInstToACSmap.find(&CI) != CallInstToACSmap.end()){
    LLVM_DEBUG(dbgs()<<"\n acs::"<< *CallInstToACSmap[&CI]->getCalledOperand() );
    F = CallInstToACSmap[&CI]->getCalledFunction();
    NumArgs = F->arg_size();// CallInstToACSmap[&CI]->getCallArgOperandNo 
    ACS = true;
    LLVM_DEBUG(dbgs()<<" \n CI:"<<CI << "F:"<<F->getName()<<" num=" << NumArgs);
  }
  auto GenUsesIter = FuncToGenUses.find(F);
  if (GenUsesIter == FuncToGenUses.end())
    return F;
  for (unsigned ArgI = 0; ArgI < NumArgs ; ArgI++) {
    auto UsesIter = FuncToGenUses[F].find(ArgI);
    if (UsesIter == FuncToGenUses[F].end())
      continue;
    unsigned CallArgNum = ArgI;
    if (ACS){
      CallArgNum = CallInstToACSmap[&CI]->getCallArgOperandNo(ArgI);
      if (CallArgNum == (unsigned)-1)
        continue;
      LLVM_DEBUG(dbgs()<<"\n CallArgNum="<<CallArgNum<<";;ArgI="<<ArgI);
    }
    ArgToUseMap[CallArgNum] = UsesIter->second;
  }
  return F;
}

Function * InterproceduralAnalysis::getCalledFuncDefs(CallInst &CI,
    ArgToDefMapTy &ArgToDefMap) {
  Function *F = CI.getCalledFunction();
  unsigned NumArgs = CI.getNumArgOperands();
  bool ACS = false;
  if (CallInstToACSmap.find(&CI) != CallInstToACSmap.end()){
    F = CallInstToACSmap[&CI]->getCalledFunction();
    NumArgs = F->arg_size();// CallInstToACSmap[&CI]->getCallArgOperandNo 
    ACS = true;
    LLVM_DEBUG(dbgs()<<" \n CI:"<<CI << "F:"<<F->getName()<<" num=" << NumArgs);
  }
  auto GenDefsIter = FuncToGenDefs.find(F);
  if (GenDefsIter == FuncToGenDefs.end())
    return nullptr;
  for (unsigned ArgI = 0; ArgI < NumArgs; ArgI++) {
    auto DefsIter = FuncToGenDefs[F].find(ArgI);
    if (DefsIter == FuncToGenDefs[F].end())
      continue;
    unsigned CallArgNum = ArgI;
    if (ACS){
      CallArgNum = CallInstToACSmap[&CI]->getCallArgOperandNo(ArgI);
      if (CallArgNum == (unsigned)-1)
        continue;
      LLVM_DEBUG(dbgs()<<"\n CallArgNum="<<CallArgNum<<";;ArgI="<<ArgI ; DefsIter->second->dump());
    }
    ArgToDefMap[CallArgNum] = DefsIter->second;
  }
  return F;
}
void InterproceduralAnalysis::getCallGens(CallToGenDefsTy &CallToGenDefs, CallToGenUsesTy &CallToGenUses){
  for (auto &F : ThisModule){
    for (inst_iterator I = inst_begin(F), E = inst_end(F); I != E; ++I) {
      if (!isa<CallInst>(&*I))
        continue;
      CallInst *CI = dyn_cast<CallInst>(&*I);
      if (CI->getIntrinsicID() != Intrinsic::not_intrinsic)
        continue;
      LLVM_DEBUG(dbgs()<<"\n CI:"<<*CI);
      Function *CalledF = CI->getCalledFunction();
      bool ACS = false;
      if (CallInstToACSmap.find(CI) != CallInstToACSmap.end()){
        LLVM_DEBUG(dbgs()<<"\n 1. acs::"<< *CallInstToACSmap[CI]->getCalledOperand() );
        CalledF = CallInstToACSmap[CI]->getCalledFunction();
        ACS = true;
        LLVM_DEBUG(dbgs()<<" \n CI:"<<*CI << "F:"<<CalledF->getName());
      }
      //unsigned NumArgs = CalledF->arg_size();// CallInstToACSmap[&CI]->getCallArgOperandNo 
      {
        auto DefI = FuncToGenDefs.find(CalledF);
        if (DefI != FuncToGenDefs.end()){
          for (auto DIter : DefI->second){
            unsigned CalledArg = DIter.first;
            LLVM_DEBUG(dbgs()<<"\n Calledarg::"<<CalledArg);
            if (ACS)
              CalledArg = CallInstToACSmap[CI]->getCallArgOperandNo(CalledArg);
            LLVM_DEBUG(dbgs()<<";; 2.Calledarg::"<<CalledArg<<" Def at"; DIter.second->getDebugLoc().dump());
            if (CalledArg != (unsigned)-1)
              CallToGenDefs[CI][CalledArg] = DIter.second;
          }
        }
      }
      auto UseI = FuncToGenUses.find(CalledF);
      if (UseI != FuncToGenUses.end()){
        for (auto UIter : UseI->second){
          unsigned CalledArg = UIter.first;
            LLVM_DEBUG(dbgs()<<"\n Calledarg::"<<CalledArg);
            if (ACS)
              CalledArg = CallInstToACSmap[CI]->getCallArgOperandNo(CalledArg);
            LLVM_DEBUG(dbgs()<<";; 2.Calledarg::"<<CalledArg);
          if (CalledArg != (unsigned)-1)
            CallToGenUses[CI][CalledArg] = UIter.second;
        }
      }
    }
  }
}

void InterproceduralAnalysis::insertDef(Function &F, unsigned FuncArgNum,
                                        const Instruction *Def) {
  if (FuncToGenDefs.find(&F) != FuncToGenDefs.end() &&
      FuncToGenDefs[&F].find(FuncArgNum) != FuncToGenDefs[&F].end())
    return;
  FuncToGenDefs[&F][FuncArgNum] = Def;
  Converged = false;
}

void InterproceduralAnalysis::insertUse(Function &F, unsigned FuncArgNum,
                                        const Instruction *Use) {
  if (FuncToGenUses.find(&F) != FuncToGenUses.end() &&
      FuncToGenUses[&F].find(FuncArgNum) != FuncToGenUses[&F].end())
    return;
  FuncToGenUses[&F][FuncArgNum] = Use;
  Converged = false;
}

void InterproceduralAnalysis::analyzeFunc(Function &F) {
  if (F.arg_size() == 0)
    return;
  for (inst_iterator I = inst_begin(F), E = inst_end(F); I != E; ++I) {
    if (!isa<CallInst>(&*I))
      continue;
    CallInst *CI = dyn_cast<CallInst>(&*I);
    ArgToDefMapTy ArgToDefMap;
    Function *CalledF = getCalledFuncDefs(*CI, ArgToDefMap);
    for (auto ArgIter : ArgToDefMap) {
      unsigned CalledFArgNum = ArgIter.first;
      if (CallToFuncArgsAliasMap[CI].find(CalledFArgNum) ==
          CallToFuncArgsAliasMap[CI].end())
        continue;
      unsigned FuncArgNum = CallToFuncArgsAliasMap[CI][CalledFArgNum];
      LLVM_DEBUG(dbgs()<<"\n F::"<<F << " \n CalledF" << CalledF->getName());
      LLVM_DEBUG(dbgs() << "\n FuncArg=" << FuncArgNum << " ArgNum:" << CalledFArgNum);
      insertDef(F, FuncArgNum, ArgIter.second);
      // FuncToGenDefs[&F][FuncArgNum] = FuncToGenDefs[CalledF][ArgNum];
    }
    ArgToUseMapTy ArgToUseMap;
    CalledF = getCalledFuncUses(*CI,  ArgToUseMap);
    for (auto ArgIter : ArgToUseMap) {
      unsigned ArgNum = ArgIter.first;
      if (CallToFuncArgsAliasMap[CI].find(ArgNum) ==
          CallToFuncArgsAliasMap[CI].end())
        continue;
      unsigned FuncArgNum = CallToFuncArgsAliasMap[CI][ArgNum];
      // LLVM_DEBUG(dbgs()<<"\n F::"<<F << " \n CalledF" << *CalledF);
      LLVM_DEBUG(dbgs() << "\n FuncArg=" << FuncArgNum << " ArgNum:" << ArgNum);
      insertUse(F, FuncArgNum, ArgIter.second);
      // FuncToGenDefs[&F][FuncArgNum] = FuncToGenDefs[CalledF][ArgNum];
    }
  }
}

void InterproceduralAnalysis::run() {
  // TODO: delete this in destructor.
  for (Function &F : ThisModule) {
      if (!F.hasName() || F.isIntrinsic() || F.isDeclaration())
        continue;
      LLVM_DEBUG(dbgs()<<"\n Trying ACS for:"<<F.getName());
    for (Use &U : F.uses()) {
      AbstractCallSite *ACS = new AbstractCallSite(&U);
      LLVM_DEBUG(dbgs()<<"\n Use:"<<*U.getUser()<<" acs=" << ACS);
      if (ACS == nullptr || !*ACS )
        for (auto &X : U.getUser()->uses()){
          LLVM_DEBUG(dbgs()<<"\n trying another acs: "<<*X.getUser());
          AbstractCallSite *XACS = new AbstractCallSite(&X);
          LLVM_DEBUG(dbgs()<<"\n Use:"<<*U.getUser()<<" acs=" << ACS);
          if( XACS != nullptr && *XACS) {
            ACS = XACS;
            break;
          }

        }
      if (ACS != nullptr && *ACS ) {
        CallInstToACSmap[ACS->getInstruction()] = ACS;
        LLVM_DEBUG(dbgs()<<"\n Construct ACS:"<< *ACS->getInstruction() << "and called = "<< ACS->getCalledFunction()->getName() );
      }
    }
  }
  unsigned Iteration = 0;
  Converged = false;
  while (!Converged) {
    Iteration++;
    LLVM_DEBUG(dbgs() << "\n Iteration:" << Iteration);
    Converged = true;
    for (Function &F : ThisModule) {
      if (!F.hasName() || F.isIntrinsic() || F.isDeclaration())
        continue;
      LLVM_DEBUG(dbgs() << "\n Interproc Func:" << F.getName());
      analyzeFunc(F);
    }
  }
}

bool  InterproceduralMSSAWalker::isInstrOnDevice(const Instruction &I){
  const BasicBlock *BB = I.getParent();
  auto Pred = BB->getSinglePredecessor();
    if (Pred == nullptr) 
      return false;
    for (const Instruction &PredI : *Pred){
      if (!isa<CallInst>(&PredI))
        continue;
      auto CI = dyn_cast<CallInst>(&PredI);
      if (CI->getCalledFunction()->getName().contains("tgt_target")) {
        if (const CallInst* CpuCI = dyn_cast<CallInst>(&I) ){
          if (CallToGenDefs.find(CpuCI) != CallToGenDefs.end() || CallToGenUses.find(CpuCI) != CallToGenUses.end())
          TargetCIMap[CI] = CpuCI;
        }
        //LLVM_DEBUG(dbgs()<<"\n IS DEVICE");
        return true;
      }
    }
    return false;
}

void InterproceduralMSSAWalker::checkCallArgAlias(
    const CallInst &CIparam, const Value *UseMem, AAResults &AR, std::set<unsigned> &AliasingArgs) {
  // Forall args, return the arg number which aliases.
  unsigned ArgNum = 0;
  const CallInst *CI = &CIparam;
  if (CI->getCalledFunction()->getName().contains("tgt_target")) {
    CI = TargetCIMap[CI];
  }
  for (auto &Arg : CI->args()) {
    const Value *ArgV = Arg.get();
    if (checkAlias(ArgV, UseMem) && !AR.isNoAlias(ArgV, UseMem)) {
      LLVM_DEBUG(dbgs()<<"\n Call Arg Alias:"<<ArgNum; CI->dump());
      AliasingArgs.insert(ArgNum);
    }
    ArgNum++;
  }
  return ;
}

bool InterproceduralMSSAWalker::checkIfAlias(const Instruction *Def,
                                             const Value *UseMem,
                                             AAResults &AR) {
  return (AR.alias(Def, UseMem) != NoAlias);
}

const Instruction *InterproceduralMSSAWalker::getFuncArgDef(const CallInst &CI,
                                                            unsigned ArgNum) {
  auto IterF = CallToGenDefs.find(&CI);
  if (IterF == CallToGenDefs.end()){
    IterF = CallToGenDefs.find(TargetCIMap[&CI]);
    if (IterF == CallToGenDefs.end())
      return nullptr;
  }
  auto IterDefI = IterF->second.find(ArgNum);
  if (IterDefI == IterF->second.end())
    return nullptr;
  return IterDefI->second;
}

void InterproceduralMSSAWalker::handleDefOnDevice(const MemoryUseOrDef &MemUse, const MemoryUseOrDef &MemDef){
  LLVM_DEBUG(dbgs()<<"\n Def:";MemDef.dump());
  std::stack<const MemoryUseOrDef*> MemDefChain;
  std::set<const MemoryUseOrDef *> VisitedSet;
  MemDefChain.push(&MemUse);
  while (!MemDefChain.empty()){
    const MemoryUseOrDef *VisitMA = MemDefChain.top(); MemDefChain.pop();
    if (VisitedSet.find(VisitMA) == VisitedSet.end())
      continue;
    VisitedSet.insert(VisitMA);
    if (VisitMA == &MemUse) 
      continue;
    for (const Use &UseOfDef : VisitMA->uses()){
    if (auto VisitPhi = dyn_cast<MemoryPhi>(&UseOfDef) ){
      unsigned PhiIndex = VisitPhi->getBasicBlockIndex(VisitMA->getBlock());
      MemPhiToDeviceDefMap[VisitPhi][PhiIndex] = true;
    }
      if (!isa<MemoryUseOrDef>(UseOfDef))
        continue;
      const MemoryUseOrDef *UseMA =dyn_cast<MemoryUseOrDef>(UseOfDef) ;
      LLVM_DEBUG(dbgs()<<"\n Useod:"<<*UseMA);
      MemDefChain.push(UseMA);
    }
  }
}

bool InterproceduralMSSAWalker::getDefAccesses(const MemoryUseOrDef &UseMA,const MemoryAccess &DefMA, const Value *UseMem,const MemorySSA &MSSA, AAResults &AR){
  std::set<const MemoryAccess *> VisitedSet;
  SetOfInstructionsTy SetOfInstructions ;
  SetOfMemoryAccessesTy SetOfMemoryAccesses;
  const Instruction *UseI = UseMA.getMemoryInst();
  getDefAccesses(DefMA, UseMem, MSSA, AR, VisitedSet, SetOfInstructions, SetOfMemoryAccesses, UseMA);
  LLVM_DEBUG(dbgs()<<"\n$$User:"<<*UseI<< "  UsedOn::"<<isInstrOnDevice(*UseI)<<" At:::"; UseI->getDebugLoc().dump());
  for (auto I : SetOfInstructions){
    LLVM_DEBUG(dbgs()<<"\n$$ Def:"<<*I<<" At:::" ; I->getDebugLoc().dump());
  }
  for (auto UorD : SetOfMemoryAccesses){
    if (isInstrOnDevice(*UorD->getMemoryInst())){
      handleDefOnDevice(UseMA, *UorD);
    }
  }
  return !SetOfInstructions.empty() ; 
}
InterproceduralMSSAWalker::DefLocation
InterproceduralMSSAWalker::getDefAccesses(const MemoryAccess &MA,
                                        const Value *UseMem,
                                        const MemorySSA &MSSA, AAResults &AR, std::set<const MemoryAccess *> &VisitedSet, SetOfInstructionsTy &SetOfInstructions, SetOfMemoryAccessesTy &SetOfMemoryAccesses, const MemoryUseOrDef &UseMA ) {
  if (MSSA.isLiveOnEntryDef(&MA) || VisitedSet.find(&MA) != VisitedSet.end()      ) 
    return NoDef;
  VisitedSet.insert(&MA);
  if (auto UorD = dyn_cast<MemoryUseOrDef>(&MA)) {
    if (const Instruction *DefInstr = UorD->getMemoryInst()) {
      auto Ret = HostDef;
      LLVM_DEBUG(dbgs()<<"\n Checking Alias :";MA.dump(); DefInstr->dump());
      auto Mem = MemoryLocation::getOrNone(DefInstr);
      const Value *MemVal = nullptr;
      if (Mem != None) {
        MemVal = (*Mem).Ptr;
        //MemVal = getAlloca(MemVal);
      }

      //if (MemVal != nullptr && ((isa<AllocaInst>(MemVal) && isa<AllocaInst>(UseMem) && MemVal != UseMem )  ||  (isa<AllocaInst>(MemVal) && isa<GlobalVariable>(UseMem) ) || (isa<GlobalVariable>(MemVal) && isa<AllocaInst>(UseMem) ) )){
      //  MemVal = nullptr;
      //}
      if (checkAlias(MemVal, UseMem) && !AR.isNoAlias(MemVal, UseMem)) {
        LLVM_DEBUG(dbgs() << "\n Aliasing mem"<<*MemVal <<" Def::" << *DefInstr
            <<"\n Usemem:"<<*UseMem);
        SetOfInstructions.push_back(DefInstr);
        SetOfMemoryAccesses.insert(UorD);
        if (isInstrOnDevice(*DefInstr))
          Ret = DeviceDef;
        return Ret;
      }
      // If the call instruction is a potential def, since an argument aliases,
      // then check the called function gen defs,and return the definition
      // instruction if it exists else continue walking up the def chain.
      if (auto CI = dyn_cast<CallInst>(DefInstr)) {
        std::set<unsigned> AliasingArgs;
        checkCallArgAlias(*CI, UseMem, AR, AliasingArgs);
        for (auto ArgAliasNum : AliasingArgs) {
          if (auto DefI = getFuncArgDef(*CI, ArgAliasNum)) {
            SetOfInstructions.push_back(DefI);
            if (isInstrOnDevice(*DefInstr) || CI->getCalledFunction()->getName().contains("tgt_target"))
              Ret = DeviceDef;
            return Ret;
            SetOfMemoryAccesses.insert(UorD);
          }
        }
      }
    }
  }
  auto Ret = NoDef;
  std::vector<DefLocation> ReachingDefLocations;
  unsigned Arg = 1;
  // This Memory Access does not alias, so start walking the chain up.
  for (auto DefIter = MA.defs_begin(); DefIter != MA.defs_end(); DefIter++, Arg++) {
    const MemoryAccess *DefMA = *DefIter;
    if (MSSA.isLiveOnEntryDef(DefMA)) {
      ReachingDefLocations.push_back(HostDef);
      continue;
    }

    auto DefOn = getDefAccesses(*DefMA, UseMem, MSSA, AR, VisitedSet, SetOfInstructions, SetOfMemoryAccesses, UseMA);
    if (Arg > 2) {
      LLVM_DEBUG(dbgs()<<" \n MA::"<<MA);
      assert("Not handled >2 Phi arguments");
    }

      if (Arg == 2)
        LLVM_DEBUG(dbgs()<<"\n DEFON phi::"<<MA <<"="<<Ret<<","<<DefOn);
    if (Arg == 2 && Ret != DefOn ){
      bool UseOnDevice = isInstrOnDevice(*UseMA.getMemoryInst());
      std::string CopyStr = "";
      if (UseOnDevice && Ret == HostDef)
        CopyStr = " Host to Device Copy 2nd ";
      if (UseOnDevice && DefOn == HostDef)
        CopyStr = " Host to Device Copy 1st ";

      if (!UseOnDevice && Ret == DeviceDef)
        CopyStr = " Device to Host Copy 2nd ";
      if (!UseOnDevice && DefOn == DeviceDef)
        CopyStr = " Device to Host Copy 1st ";

      if (Arg == 2){
        LLVM_DEBUG(dbgs()<<"\n DEFON phi::"<<MA <<"="<<Ret<<","<<DefOn);
        printCopy(SetOfInstructions, *UseMA.getMemoryInst(), *MA.getBlock()->getFirstNonPHIOrDbg(), CopyStr, UseOnDevice);
      }
      if (UseOnDevice)
        Ret = HostDef;
      else
        Ret = DeviceDef;

    }
    ReachingDefLocations.push_back(DefOn);
    if (DefOn != NoDef && Arg == 1) 
      Ret = DefOn;

  }
  return Ret;

}

void InterproceduralMSSAWalker::printCopy(const SetOfInstructionsTy &Def, const Instruction &Use, const Instruction &CopyAt, const std::string &CopyStr, bool UseOnDevice){
  auto Size = Def.size();
  if (Size >1) {
  const Instruction *Def1 = Def.at(Size-1);
  LLVM_DEBUG(dbgs()<<"\n Def1 ::"<< *Def1 << " At ::";  Def1->getDebugLoc().dump());
  }
  if (Size >2) {
  const Instruction *Def2 = Def.at(Size-2);
  LLVM_DEBUG(dbgs()<<"\n Def2 ::"<< *Def2 << " At ::";  Def2->getDebugLoc().dump());
  }
  LLVM_DEBUG(dbgs()<<"\n Use ::"<< Use << " At ::";  Use.getDebugLoc().dump());
  LLVM_DEBUG(dbgs()<<"\n"<<CopyStr << " At ::";  CopyAt.getDebugLoc().dump()); 
  LLVM_DEBUG(dbgs()<<"\n PHI ::"<< CopyAt);
  LLVM_DEBUG(dbgs()<<"\n Mem:"<< *getAlloca(&Use));

}

void InterproceduralMSSAWalker::handleMemUse(const MemoryUse &MemUse,
                                             const MemorySSA &MSSA,
                                             AAResults &AR) {
  LLVM_DEBUG(dbgs() << "\n MemUse:" << MemUse);
  if (!isa<LoadInst>(MemUse.getMemoryInst())) {
    MemUse.getMemoryInst()->dump();
    assert("Instruction MemUse Not handled:");
  }
  LoadInst *Ld = dyn_cast<LoadInst>(MemUse.getMemoryInst());
  LLVM_DEBUG(dbgs() << " \n Mem Loc::" << *MemoryLocation::get(Ld).Ptr);
  MemoryAccess *MemDef = MemUse.getDefiningAccess();
  auto Mem = MemoryLocation::getOrNone(Ld);
  if (Mem == None)
    return;
  const Value *MemAddr = getAlloca(Mem->Ptr);
  if (getDefAccesses(MemUse, *MemDef, MemAddr , MSSA, AR))
    LLVM_DEBUG(dbgs() << "\n Load:" << *Ld;
        if (Ld->getDebugLoc()) Ld->getDebugLoc()->dump());
}

void InterproceduralMSSAWalker::handleMemDef(const MemoryDef &MemDef,
                                             const MemorySSA &MSSA,
                                             AAResults &AR) {
  // This is just used to identify potential use by a call instruction.

  auto DefI = MemDef.getMemoryInst();
  if (DefI == nullptr) return;
  auto CI = dyn_cast<CallInst>(DefI) ;
  if (CI == nullptr) return;
  auto UsesIter =  CallToGenUses.find(CI);
  if (UsesIter == CallToGenUses.end()){
    UsesIter = CallToGenUses.find(TargetCIMap[CI]);
    if (UsesIter == CallToGenUses.end())
      return;
  }
  LLVM_DEBUG(dbgs()<<"\nCI::"<<*CI);
  for (auto AI : UsesIter->second){
    LLVM_DEBUG(dbgs()<<"\n arg::"<<AI.first<<" instr:"<<*AI.second);
  }
  int ArgNum = -1;
  for (auto &Arg : CI->args()){
    ArgNum++;
    if (UsesIter->second.find(ArgNum) == UsesIter->second.end())
      continue;
    LLVM_DEBUG(dbgs()<<"\n Func Use::"<<*Arg.get(); UsesIter->second[ArgNum]->getDebugLoc().dump()
        );
    
    getDefAccesses(MemDef, *MemDef.getDefiningAccess(), Arg.get(), MSSA, AR);
  }
}

void InterproceduralMSSAWalker::analyzeFunc(const MemorySSA &MSSA,
                                            AAResults &AR, const Function &F, std::vector<const Function*> &CalledFunctionsList) {

  LLVM_DEBUG(dbgs()<<"\n Function ::"<<F.getName());
  for (const BasicBlock &BB : F) {
    for (auto &I : BB)
      if (auto CI = dyn_cast<CallInst>(&I)) {
        CalledFunctionsList.push_back(CI->getCalledFunction());
        isInstrOnDevice(*CI);
      }
      
    
    auto MAList = MSSA.getBlockAccesses(&BB);
    if (MAList == nullptr)
      continue;
    for (const MemoryAccess &MA : *MAList) {
      if (auto MemUse = dyn_cast<MemoryUse>(&MA))
        handleMemUse(*MemUse, MSSA, AR);
      if (auto MemDef = dyn_cast<MemoryDef>(&MA))
        handleMemDef(*MemDef, MSSA, AR);
    }
  }
}

void InterproceduralMSSAWalker::run() {
  std::string EntryFuncStr = "main";
  const Function *EntryFunc = nullptr;
  for (const Function &F : ThisModule) {
    if (!F.hasName() || F.isIntrinsic() || F.isDeclaration() || F.getName() != EntryFuncStr)
      continue;
    EntryFunc = &F;
    break;
  }
  if (EntryFunc == nullptr) 
    return;
  std::vector<const Function*> WorkList;
  std::set<const Function*> VisitedSet;
  WorkList.push_back(EntryFunc);
  while (!WorkList.empty()) {
    auto F = WorkList.back(); 
    WorkList.pop_back();
    if (F == nullptr || VisitedSet.find(F) != VisitedSet.end())
      continue;
    VisitedSet.insert(F);
    auto FSSA = FuncToMSSAMap.find(F);
    if (FSSA == FuncToMSSAMap.end())
      continue;
    auto AAIter = FuncToAAResultsMap.find(F);
    if (AAIter == FuncToAAResultsMap.end())
      assert("Invalid Alias Analysis Results");
    AAResults *AR = AAIter->second;
    analyzeFunc(*FSSA->second, *AR, *F, WorkList);
  }

}

AnalysisKey OmpDiagnosticsGlobalAnalysis::Key;

void OmpDiagnosticsGlobalAnalysis::handleIndirectCalls(Function &F){
for (Use &U : F.uses()) {
    AbstractCallSite ACS(&U);
    if (!ACS)
      continue;
    LLVM_DEBUG(dbgs() << "\n ACS is indirect:: " << ACS.isIndirectCall()
                      << " is callback: " << ACS.isCallbackCall()
                      << " ACS called::  " << ACS.getCalledFunction()->getName()
                      << " Call inst: " << *ACS.getInstruction()
                      << " num ops: " << ACS.getNumArgOperands() << "\n ACS: ");
    //User *UR = U.getUser();
    //for (auto &UseofUser : UR->uses()) {
    //  if (auto IndirectCall = dyn_cast<CallInst>(UseofUser.getUser())) {
    //    LLVM_DEBUG(dbgs() << "u of u ::" << *IndirectCall
    //                      << "\n op number: " << UseofUser.getOperandNo()
    //                      << "\n parent op number: " << U.getOperandNo());

    //    SmallVector<Argument *, 5> FParams;
    //    for (auto &A : F.args()) {
    //      FParams.push_back(&A);
    //    }
    //    for (unsigned ArgNum = IndirectCall->getNumArgOperands() - 1,
    //                  ParamNum = FParams.size() - 1;
    //         ArgNum > UseofUser.getOperandNo(); ArgNum--, ParamNum--) {
    //      auto Arg = IndirectCall->getArgOperand(ArgNum);
    //      auto Param = FParams[ParamNum];
    //      LLVM_DEBUG(dbgs() << "\n Arg::" << *Arg << "\n Param:: " << *Param);
    //      //IndirectCallsMap[IndirectCall][Arg] = Param;
    //      if (ParamNum == 0)
    //        break;
    //    }
    //  }
    //}
    // LLVM_DEBUG(dbgs() << "\n user:" << *UR << "\n use::" << *U.get());
    // Ignore blockaddress uses.
    // if (isa<BlockAddress>(UR)) continue;
    // If no abstract call site was created we did not understand the use, bail.
  }
}

void OmpDiagnosticsGlobalAnalysis::recordFuncGens() {
  for (Function &F : *ThisModule) {
    if (!F.hasName() || F.isIntrinsic() || F.isDeclaration())
      continue;
    LLVM_DEBUG(dbgs() << "\n Func:" << F.getName());
    AAResults &AA = GetAAForFunc(F);
    MemorySSA &MSSA = GetMemSSAForFunc(F);
    FuncToAAResultsMap[&F] = &AA;
    FuncToMSSAMap[&F] = &MSSA;
    LLVM_DEBUG(MSSA.dump());
    //The function local analysis updates 3 maps,
    // 1. Func gen Defs, 2. Func gen Uses, 3. Call instruction to function arguments.
    OmpDiagnosticsLocalAnalysis LocalA(F, MSSA, AA, FuncToGenDefs,
                                       FuncToGenUses, CallToFuncArgsAliasMap);
    LocalA.recordFuncGens();
    LocalA.print();
    //handleIndirectCalls(F);
  }
}

void print(std::map<const CallInst* , std::map<unsigned, const Instruction*>> CtoI){
  for (auto CIter : CtoI){
    const CallInst *CI= CIter.first;
    LLVM_DEBUG(dbgs()<<"\n Call:"<<*CI<<" AT::";CI->getDebugLoc().dump());
    for (auto UIter : CIter.second){
      LLVM_DEBUG(dbgs()<<"\n Arg:"<<UIter.first<<" ::Instr:: "<<*UIter.second; UIter.second->getDebugLoc().dump());
    }
  }
}

void OmpDiagnosticsGlobalAnalysis::interProcRecordFuncGens() {
  InterproceduralAnalysis IA(*ThisModule, FuncToGenDefs, FuncToGenUses,
      CallToFuncArgsAliasMap);
  CallToGenDefsTy CallToGenDefs;
  CallToGenUsesTy CallToGenUses;
  IA.getCallGens(CallToGenDefs, CallToGenUses);
  IA.print();
  LLVM_DEBUG(dbgs()<<"\n  ==========================Call Def::");
  print(CallToGenDefs);
  LLVM_DEBUG(dbgs()<<"\n ==========================Call Use::");
  print(CallToGenUses);

  InterproceduralMSSAWalker IPA(*ThisModule, FuncToAAResultsMap,FuncToMSSAMap,  CallToGenDefs, CallToGenUses);

  //LLVM_DEBUG(dbgs()<<"\n================DEFUSE=================\n");
  //for (Function &ThisFunc : *ThisModule) {
  //  LLVM_DEBUG(dbgs()<<"\n Func::"<<ThisFunc.getName());
  //  for (auto Iter : FuncToGenDefs[&ThisFunc]) {
  //    LLVM_DEBUG(dbgs() << "\n Arg:" << Iter.first << "\n Def::";
  //        Iter.second->dump(); Iter.second->getDebugLoc().dump());
  //  }
  //  for (auto Iter : FuncToGenUses[&ThisFunc]) {
  //    LLVM_DEBUG(dbgs() << "\n Arg:" << Iter.first << "\n Use::";
  //        Iter.second->dump(); Iter.second->getDebugLoc().dump());
  //  }
  //}
  //LLVM_DEBUG(dbgs()<<"\n================DEFUSE=================\n");
}

void OmpDiagnosticsGlobalAnalysis::interProcMSSA() {

  std::string EntryFuncStr = "fun";
  Function *EntryFunc = nullptr;
  for (Function &F : *ThisModule) {
    if (!F.hasName() || F.isIntrinsic() || F.isDeclaration())
      continue;
    if (F.getName() != EntryFuncStr)
      continue;
    EntryFunc = &F;
    break;
  }
}

void OmpDiagnosticsGlobalAnalysis::analyzeModule() {
  LLVM_DEBUG(dbgs() << "\n Analysis module:");
  recordFuncGens();
  interProcRecordFuncGens();
  //interProcMSSA();

  LLVM_DEBUG(dbgs() << "\n ============================\n");
  for (auto ItF : FuncToGenDefs) {
    auto F = ItF.first;
    LLVM_DEBUG(dbgs() << "\n Function:" << F->getName());
    for (auto Iter : FuncToGenDefs[F]) {
      LLVM_DEBUG(dbgs() << "\n Arg:" << Iter.first << "\n Def::";
                 Iter.second->dump());
      if (Iter.second->getDebugLoc())
        LLVM_DEBUG(dbgs() << "At:" << *Iter.second->getDebugLoc().get());
    }
  }
  LLVM_DEBUG(dbgs() << "\n Uses::\n");
  for (auto ItF : FuncToGenUses) {
    auto F = ItF.first;
    LLVM_DEBUG(dbgs() << "\n Function:" << F->getName());
    for (auto Iter : FuncToGenUses[F]) {
      LLVM_DEBUG(dbgs() << "\n Arg:" << Iter.first << "\n Use::";
                 Iter.second->dump());
      if (Iter.second->getDebugLoc())
        LLVM_DEBUG(dbgs() << "At:" << *Iter.second->getDebugLoc().get());
    }
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
  LLVM_DEBUG(dbgs() << "\n Ret=" << Res.get());

  return PreservedAnalyses::all();
}

static const char LocalPassArg[] = "omp-diagnostics-local";
static const char LocalPassName[] = "omp diagnostics Local Analysis";
static const char GlobalPassName[] = "omp diagnostics Analysis";

// void OmpDiagnosticsLocalAnalysis::analyzeMemUse(const MemoryUse &MemUse){
//  return;
//  LLVM_DEBUG(dbgs()<<"\n MemUse:"<<MemUse);
//  if (!isa<LoadInst>(MemUse.getMemoryInst())) {
//    MemUse.getMemoryInst()->dump();
//    assert("Instruction MemUse Not handled:") ;
//  }
//  LoadInst *Ld = dyn_cast<LoadInst>(MemUse.getMemoryInst());
//  LLVM_DEBUG(dbgs()<<" \n Mem Loc::"<<*MemoryLocation::get(Ld).Ptr);
//
//  if (MSSA.isLiveOnEntryDef(MemUse.getDefiningAccess()) ) {
//    Function *F = Ld->getFunction();
//    LLVM_DEBUG(dbgs()<<"\n Liveonentry: Use:");
//    for (Value &arg : F->args()){
//      LLVM_DEBUG(dbgs()<<"\n alias with :"<<arg<<" ==="<<
//      AA.alias(MemoryLocation::get(Ld).Ptr, &arg));
//
//    }
//    return ;
//  }
//  return;
//  LLVM_DEBUG(dbgs()<<"\n Load:"<<*Ld;if
//  (Ld->getDebugLoc())Ld->getDebugLoc()->dump()); MemoryAccess* MemDef =
//  MemUse.getDefiningAccess(); if (MSSA.isLiveOnEntryDef(MemDef) ) {
//    LLVM_DEBUG(dbgs()<<"\n Liveonentry: Use:");
//    return ;
//  }
//  if (isa<MemoryPhi>(MemDef))
//    return;
//  if (!isa<MemoryDef>(MemDef)) {
//    MemDef->dump();
//    assert("Don't know how to handle MemDef");
//  }
//  MemoryDef *MD = dyn_cast<MemoryDef>(MemDef);
//  Instruction *MemDefInstr = MD->getMemoryInst();
//  if (MemDefInstr == nullptr)  {
//    MD->dump();
//    assert("Not a valid memory def instruction") ;
//  }
//  // If a call, then all Funcgens and also all block reaches.
//  if (CallInst *CIDef = dyn_cast<CallInst>(MemDefInstr)) {
//    Value *DefV = getAliasingCallArg(*CIDef, *Ld->getPointerOperand());
//    if (DefV != nullptr) {
//      LLVM_DEBUG(dbgs()<<"\n Def :"<<*DefV;
//          auto DefI = dyn_cast<Instruction>(DefV);
//          if (DefI->getDebugLoc())DefI->getDebugLoc()->dump());
//    }
//    return;
//  }
//
//  if ( !isa<StoreInst>(MemDefInstr)) {
//    MD->dump();
//    assert("Not Handled the memory def instruction") ;
//  }
//
//  StoreInst *St = dyn_cast<StoreInst>(MemDefInstr);
//  //Value * LoadAddr = Ld->getPointerOperand();
//  //Value *StoreAddr = St->getPointerOperand();
//  AliasResult AR =  AA.alias(MemoryLocation::get(Ld),
//  MemoryLocation::get(St)); LLVM_DEBUG(dbgs()<<"\n Def:"<< *MD);
//  LLVM_DEBUG(dbgs()<<"\n Alias ::"<< AR
//      <<"\n Store: "<<*St);
//  if (St->getDebugLoc())
//    LLVM_DEBUG(dbgs()<<"\n Stor:";St->getDebugLoc()->dump());
//}
