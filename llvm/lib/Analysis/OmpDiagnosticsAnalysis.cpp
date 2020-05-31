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

  Value *OmpDiagnosticsLocalAnalysis::getAliasingCallArg(CallInst &CIDef, Value &PointerOp){
    Value *AliasingArg = nullptr;
    for (Value *CallArg : CIDef.args()){
      if ( AA.isNoAlias(CallArg, &PointerOp ))
        continue;
      AliasingArg = CallArg;
    }
    return AliasingArg;
  }


llvm::Optional<unsigned> OmpDiagnosticsLocalAnalysis::getAliasingArg(const Value &Mem, const Function &F){
  auto FuncArgs = F.args();
  unsigned ArgI = 0;
  for (const Value &Arg : FuncArgs ){
    AliasResult  AR = AA.alias(&Mem, &Arg)   ;
    if (AR != NoAlias)
      return ArgI;
    ArgI++;
  }
  // This means none of the arguments alias, could be global.
  return ArgI;
}

void OmpDiagnosticsLocalAnalysis::recordFuncGens(const MemoryDef &MemDef){
  LLVM_DEBUG(dbgs()<<"\n MemDef:"; MemDef.dump());
  if (MSSA.isLiveOnEntryDef(&MemDef))
    return;
  Instruction *DefInstr = MemDef.getMemoryInst();
  if (DefInstr == nullptr) 
    assert("Cannot handle MemoryDef: not liveonentry or instruction");
  const Function &ParentF = *DefInstr->getFunction();
  if (auto CI = dyn_cast<CallInst>(DefInstr)){
    for (unsigned CallArgI = 0 ; CallArgI < CI->getNumArgOperands() ; CallArgI++){
      Value * Arg = CI->getArgOperand(CallArgI);
      auto FArgI = getAliasingArg(*Arg, ParentF);
      // Does not alias with any function argument.
      if (FArgI == None)
        continue;
      CallToFuncArgsAliasMap[CI][CallArgI] = *FArgI;
      //FuncToGenDefs[&ThisFunc][*FArgI] = CI;
      //AA.alias(Arg,
    }
  }
  if (auto St = dyn_cast<StoreInst>(DefInstr)){
    auto  Mem = MemoryLocation::getOrNone(St);
    if (Mem == None)
      return ;
    auto ArgI = getAliasingArg(*Mem->Ptr, ParentF);
    if (ArgI == None)
      return;
    LLVM_DEBUG(dbgs()<<"\n arg:"<<*ArgI<<"\n Def::"<<MemDef);
    FuncToGenDefs[&ThisFunc][*ArgI] = DefInstr;

    //LLVM_DEBUG(dbgs()<<" \n Mem Loc::"<<*MemoryLocation::get(St).Ptr);
  }
}

void OmpDiagnosticsLocalAnalysis::analyzeMemUse(const MemoryUse &MemUse){
  return;
  LLVM_DEBUG(dbgs()<<"\n MemUse:"<<MemUse);
  if (!isa<LoadInst>(MemUse.getMemoryInst())) {
    MemUse.getMemoryInst()->dump();
    assert("Instruction MemUse Not handled:") ;
  }
  LoadInst *Ld = dyn_cast<LoadInst>(MemUse.getMemoryInst());
  LLVM_DEBUG(dbgs()<<" \n Mem Loc::"<<*MemoryLocation::get(Ld).Ptr);

  if (MSSA.isLiveOnEntryDef(MemUse.getDefiningAccess()) ) {
    Function *F = Ld->getFunction();
    LLVM_DEBUG(dbgs()<<"\n Liveonentry: Use:");
    for (Value &arg : F->args()){
      LLVM_DEBUG(dbgs()<<"\n alias with :"<<arg<<" ==="<<  AA.alias(MemoryLocation::get(Ld).Ptr, &arg));

    }
    return ;
  }
  return;
  LLVM_DEBUG(dbgs()<<"\n Load:"<<*Ld;if (Ld->getDebugLoc())Ld->getDebugLoc()->dump());
  MemoryAccess* MemDef = MemUse.getDefiningAccess();
  if (MSSA.isLiveOnEntryDef(MemDef) ) {
    LLVM_DEBUG(dbgs()<<"\n Liveonentry: Use:");
    return ;
  }
  if (isa<MemoryPhi>(MemDef))
    return;
  if (!isa<MemoryDef>(MemDef)) {
    MemDef->dump();
    assert("Don't know how to handle MemDef");
  }
  MemoryDef *MD = dyn_cast<MemoryDef>(MemDef);
  Instruction *MemDefInstr = MD->getMemoryInst();
  if (MemDefInstr == nullptr)  {
    MD->dump();
    assert("Not a valid memory def instruction") ;
  }
  // If a call, then all Funcgens and also all block reaches.
  if (CallInst *CIDef = dyn_cast<CallInst>(MemDefInstr)) {
    Value *DefV = getAliasingCallArg(*CIDef, *Ld->getPointerOperand());
    if (DefV != nullptr) {
      LLVM_DEBUG(dbgs()<<"\n Def :"<<*DefV;
          auto DefI = dyn_cast<Instruction>(DefV);
          if (DefI->getDebugLoc())DefI->getDebugLoc()->dump());
    }
    return;
  }

  if ( !isa<StoreInst>(MemDefInstr)) {
    MD->dump();
    assert("Not Handled the memory def instruction") ;
  }

  StoreInst *St = dyn_cast<StoreInst>(MemDefInstr);
  //Value * LoadAddr = Ld->getPointerOperand();
  //Value *StoreAddr = St->getPointerOperand();
  AliasResult AR =  AA.alias(MemoryLocation::get(Ld), MemoryLocation::get(St));
  LLVM_DEBUG(dbgs()<<"\n Def:"<< *MD);
  LLVM_DEBUG(dbgs()<<"\n Alias ::"<< AR 
      <<"\n Store: "<<*St);
  if (St->getDebugLoc())
    LLVM_DEBUG(dbgs()<<"\n Stor:";St->getDebugLoc()->dump());
}

void OmpDiagnosticsLocalAnalysis::analyzeBB(const BasicBlock &BB){
  auto MAList = MSSA.getBlockAccesses(&BB);
  if (MAList == nullptr)
    return;
  for (const MemoryAccess & MA : *MAList){
    if (auto MemDef = dyn_cast<MemoryDef>(&MA)) 
      recordFuncGens(*MemDef);
    else if (auto MemUse = dyn_cast<MemoryUse>(&MA)) 
      analyzeMemUse(*MemUse);
  }
}

void OmpDiagnosticsLocalAnalysis::recordFuncGens(){
  for (const BasicBlock &BB : ThisFunc){
    auto MAList = MSSA.getBlockDefs(&BB);
    if (MAList == nullptr)
      continue;
    for (const MemoryAccess & MA : *MAList)
      if (auto MemDef = dyn_cast<MemoryDef>(&MA)) 
        recordFuncGens(*MemDef);
  }
  for (auto Iter : FuncToGenDefs[&ThisFunc]){
    LLVM_DEBUG(dbgs()<<"\n Arg:"<<Iter.first <<"\n Def::";Iter.second->dump());
  }
  for (auto Iter : CallToFuncArgsAliasMap){
    LLVM_DEBUG(dbgs()<<"\n Call:"<<*Iter.first      );
    for (auto ArgIter : Iter.second){
      LLVM_DEBUG(dbgs() << ", Call Arg:"<<ArgIter.first <<" Func Arg:"<<ArgIter.second);
    }
  }
}

void OmpDiagnosticsLocalAnalysis::run() {

  LLVM_DEBUG(dbgs() << "\n Analysis Local:");
  recordFuncGens();

  return ;
}

void OmpDiagnosticsLocalAnalysis::print() {}

AnalysisKey OmpDiagnosticsGlobalAnalysis::Key;

void OmpDiagnosticsGlobalAnalysis::recordFuncGens(){
  for (Function &F : *ThisModule){
    if (!F.hasName() || F.isIntrinsic() || F.isDeclaration())
      continue;
    LLVM_DEBUG(dbgs()<<"\n Func:"<<F.getName());
    AAResults &AA = GetAAForFunc(F);
    MemorySSA &MSSA = GetMemSSAForFunc(F);
    LLVM_DEBUG(MSSA.dump());
    OmpDiagnosticsLocalAnalysis LocalA(F,MSSA,AA, FuncToGenDefs, CallToFuncArgsAliasMap);
    LocalA.recordFuncGens();
  }
}

void InterproceduralAnalysis::getCalledFuncDefs(CallInst &CI, Function &F, ArgToDefMapTy &ArgToDefMap){
  auto GenDefsIter = FuncToGenDefs.find(&F);
  if ( GenDefsIter == FuncToGenDefs.end())
    return;
  for (unsigned ArgI = 0 ; ArgI < CI.getNumArgOperands(); ArgI++){
    auto DefsIter = FuncToGenDefs[&F].find(ArgI);
    if ( DefsIter != FuncToGenDefs[&F].end())
      ArgToDefMap[ArgI] = DefsIter->second;
  }
}

  void InterproceduralAnalysis::insertDef(Function &F, unsigned FuncArgNum, Function &CalledFunc, unsigned CalledFuncArgNum){
    if (FuncToGenDefs.find(&F) != FuncToGenDefs.end() && FuncToGenDefs[&F].find(FuncArgNum) != FuncToGenDefs[&F].end())
      return ;
      FuncToGenDefs[&F][FuncArgNum] = FuncToGenDefs[&CalledFunc][CalledFuncArgNum];
      Converged = false;
  }

void InterproceduralAnalysis::analyzeFunc(Function &F){
  for (inst_iterator I = inst_begin(F), E = inst_end(F); I != E; ++I){
    if (!isa<CallInst>(&*I))
      continue;
    CallInst *CI = dyn_cast<CallInst>(&*I);
    Function *CalledF = CI->getCalledFunction();
    if (CalledF == nullptr )
      continue;
    ArgToDefMapTy ArgToDefMap;
    getCalledFuncDefs(*CI, *CalledF, ArgToDefMap);
    for (auto ArgIter : ArgToDefMap){
      unsigned ArgNum = ArgIter.first;
      if (CallToFuncArgsAliasMap[CI].find(ArgNum) == CallToFuncArgsAliasMap[CI].end())
        continue;
      unsigned FuncArgNum = CallToFuncArgsAliasMap[CI][ArgNum];
      //LLVM_DEBUG(dbgs()<<"\n F::"<<F << " \n CalledF" << *CalledF);
      LLVM_DEBUG(dbgs()<<"\n FuncArg="<<FuncArgNum<<" ArgNum:"<<ArgNum);
      insertDef(F, FuncArgNum, *CalledF, ArgNum);
      //FuncToGenDefs[&F][FuncArgNum] = FuncToGenDefs[CalledF][ArgNum];
    }
  }
}

void InterproceduralAnalysis::run(){
  unsigned Iteration =0;
  Converged = false;
  while (!Converged) {
    Iteration++;
    LLVM_DEBUG(dbgs()<<"\n Iteration:"<<Iteration);
    Converged = true;
    for (Function &F : ThisModule){
      if (!F.hasName() || F.isIntrinsic() || F.isDeclaration())
        continue;
      LLVM_DEBUG(dbgs()<<"\n Interproc Func:"<<F.getName());
      analyzeFunc(F);
    }
  }
}

void  OmpDiagnosticsGlobalAnalysis::interProcRecordFuncGens(){
  InterproceduralAnalysis IA(*ThisModule, FuncToGenDefs, CallToFuncArgsAliasMap);
}

void OmpDiagnosticsGlobalAnalysis::interProcMSSA(){
  std::string EntryFuncStr = "fun";
  Function *EntryFunc = nullptr;
  for (Function &F : *ThisModule){
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
  interProcMSSA();

  for (auto ItF : FuncToGenDefs ){
    auto F = ItF.first;
    LLVM_DEBUG(dbgs()<<" F:"<<F->getName());
    for (auto Iter : FuncToGenDefs[F]){
      LLVM_DEBUG(dbgs()<<"\n Arg:"<<Iter.first <<"\n Def::";Iter.second->dump());
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
  GetPDMForFunc = [&](Function &F) -> PostDominatorTree & {
    return FAM.getResult<PostDominatorTreeAnalysis>(F);
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

