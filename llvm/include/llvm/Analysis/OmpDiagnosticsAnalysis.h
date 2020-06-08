//===- OmpDiagnosticsAnalysis.h - Analyze omp target clauses and infer data
// mapping -----*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// OpenMp target data mapping Analysis,
// A Diagnostics Pass to help understand usage of data mapping clauses.
// Looks at all the omp target RTL calls, and interprets their semantics,
// to conclude which variable is residing on Device or Host memory,
// outside and inside target regions.
// RTL is an acronym for "Run Time Library"
//===----------------------------------------------------------------------===//

#ifndef LLVM_ANALYSIS_OmpDiagnosticsANALYSIS_H
#define LLVM_ANALYSIS_OmpDiagnosticsANALYSIS_H

#include "llvm/Analysis/MemorySSA.h"
#include "llvm/Analysis/PostDominators.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include "llvm/IR/PassManager.h"
#include "llvm/IR/AbstractCallSite.h"
#include "llvm/Pass.h"
#include <map>
#include <queue>
#include <set>

namespace llvm {

using namespace llvm;

class IntResult {
  int R;

public:
  IntResult() : R(0) {}
  int get() { return R; }
};
// using UseInstr2DefInstrMapTy = std::map<Instruction*,Instruction*>;
using ArgumentDefsTy = std::map<unsigned, const Instruction *>;
using CallToFuncArgsAliasMapTy =
    std::map<const CallInst *, std::map<unsigned, unsigned>>;
using ArgumentUsesTy = std::map<unsigned, const Instruction *>;
using FuncToGenDefsTy = std::map<const Function *, ArgumentDefsTy>;
using FuncToGenUsesTy = std::map<const Function *, ArgumentUsesTy>;
using CallToGenDefsTy = std::map<const CallInst *, ArgumentDefsTy>;
using CallToGenUsesTy = std::map<const CallInst *, ArgumentUsesTy>;
using CallToUpwardExposedArgsTy =
    std::map<const CallInst *, std::set<unsigned>>;
/// Iterate over every Omp RTL call instruction, and parse its arguments, to
/// deduce the data mapping pragma used by the programmer. Then record all the
/// variables mapped and its mapping properties for every Omp RTL call.
class OmpDiagnosticsLocalAnalysis {
  const Function &ThisFunc;
  const MemorySSA &MSSA;
  AAResults &AA;
  FuncToGenDefsTy &FuncToGenDefs;
  FuncToGenUsesTy &FuncToGenUses;
  CallToFuncArgsAliasMapTy &CallToFuncArgsAliasMap;

  void analyzeBB(const BasicBlock &BB);
  void recordFuncGens(const MemoryUse &MemUse);
  void recordFuncGens(const MemoryDef &MemDef);
  Value *getAliasingCallArg(CallInst &CIDef, Value &PointerOp);
  void addFuncToGenUse(const Instruction &MemUse, unsigned FuncArgNum) {
    FuncToGenUses[MemUse.getFunction()][FuncArgNum] = &MemUse;
  }
  bool checkIfLiveOnEntry(const MemoryAccess &MA, const Instruction &Ld,
                          const unsigned AliasingArg);

  // Iterate over all function arguments, and check which argument aliases with
  // Mem
  llvm::Optional<unsigned> getAliasingArg(const Value &Mem, const Function &F);

public:
  /// Updates the \p OInfo, with the mapping informa
  OmpDiagnosticsLocalAnalysis(const Function &F, const MemorySSA &MSSA,
                              AAResults &AA, FuncToGenDefsTy &FuncToGenDefs,
                              FuncToGenUsesTy &FuncToGenUses,
                              CallToFuncArgsAliasMapTy &CallToFuncArgsAliasMap)
      : ThisFunc(F), MSSA(MSSA), AA(AA), FuncToGenDefs(FuncToGenDefs),
        FuncToGenUses(FuncToGenUses),
        CallToFuncArgsAliasMap(CallToFuncArgsAliasMap) {}
  // TODO : make sure the order of traversal of Basicblocks is correct, preorder
  // traversal only
  void run();
  void recordFuncGens();
  void print();
};

using ArgToDefMapTy = std::map<unsigned, const Instruction *>;
using ArgToUseMapTy = std::map<unsigned, const Instruction *>;
class InterproceduralAnalysis {
  Module &ThisModule;
  FuncToGenDefsTy &FuncToGenDefs;
  FuncToGenUsesTy &FuncToGenUses;
  CallToFuncArgsAliasMapTy &CallToFuncArgsAliasMap;

  std::map<CallBase*, AbstractCallSite *> CallInstToACSmap;

  bool Converged;
  Function *getCalledFunc(CallInst &CI);
  Function *getCalledFuncDefs(CallInst &CI, ArgToDefMapTy &ArgToDefMap);
  Function *getCalledFuncUses(CallInst &CI, ArgToUseMapTy &ArgToDefMap);
  void insertDef(Function &F, unsigned FuncArg, const Instruction *);
  void insertUse(Function &F, unsigned FuncArg, const Instruction *);
  void analyzeFunc(Function &F);
  void run();

public:
  InterproceduralAnalysis(Module &ThisModule, FuncToGenDefsTy &FuncToGenDefs,
                          FuncToGenUsesTy &FuncToGenUses,
                          CallToFuncArgsAliasMapTy &CallToFuncArgsAliasMap)
      : ThisModule(ThisModule), FuncToGenDefs(FuncToGenDefs),
        FuncToGenUses(FuncToGenUses),
        CallToFuncArgsAliasMap(CallToFuncArgsAliasMap), Converged(false) {
    run();
  }
  void getCallGens(CallToGenDefsTy &CallToGenDefs, CallToGenUsesTy &CallToGenUses);
  void print();
};

using FuncToAAResultsMapTy = std::map<const Function *, AAResults *>;
using FuncToMSSAMapTy = std::map<const Function *, const MemorySSA *>;
using SetOfInstructionsTy = std::vector<const Instruction*> ;
using SetOfMemoryAccessesTy = std::set<const MemoryUseOrDef*>;
class InterproceduralMSSAWalker {
  const Module &ThisModule;
  FuncToAAResultsMapTy &FuncToAAResultsMap;
  FuncToMSSAMapTy &FuncToMSSAMap;
  CallToGenDefsTy &CallToGenDefs;
  CallToGenUsesTy &CallToGenUses;
  std::map<const MemoryPhi *, std::vector<bool>> MemPhiToDeviceDefMap;
  std::map<const CallInst*, const CallInst*> TargetCIMap;
  enum DefLocation{NoDef, DeviceDef, HostDef} ;

  //  llvm::optional<const Instruction*>
  void recordReachingDefsAtPhi();
  void printCopy(const SetOfInstructionsTy &Src, const Instruction &Dst, const Instruction &CopyAt, const std::string &copyStr, bool UseOnDevice);
  const Instruction *getFuncArgDef(const CallInst &CI,unsigned ArgNum);
  bool checkIfAlias(const Instruction *Def, const Value *UseMem, AAResults &AR);
  // Iterate over all the arguments to the call instruction \p DefInstr, and check if any argument aliases with Usemem, return the argument which aliases.
  void checkCallArgAlias(const CallInst &DefInstr,
      const Value *UseMem,
      AAResults &AR, std::set<unsigned> &AliasingArgs);
  DefLocation getDefAccesses(const MemoryAccess &MA, const Value *UseMem,
      const MemorySSA &MSSA, AAResults &AR, std::set<const MemoryAccess *> &VisitedSet, SetOfInstructionsTy &DefInstrs, SetOfMemoryAccessesTy &SetOfMemoryAccesses, const MemoryUseOrDef &MemUse);

  bool getDefAccesses(const MemoryUseOrDef &UseMA, const MemoryAccess &DefMA, const Value *UseMem,const MemorySSA &MSSA, AAResults &AR);
  void handleMemUse(const MemoryUse &MemUse, const MemorySSA &MSSA,
      AAResults &AR);
  void handleMemDef(const MemoryDef &MemDef, const MemorySSA &MSSA,
      AAResults &AR);
  void analyzeFunc(const MemorySSA &MSSA, AAResults &AR, const Function &F, std::vector<const Function*> &CalledFunctionsList);
  void run();
  bool isInstrOnDevice(const Instruction &I);
  void handleDefOnDevice(const MemoryUseOrDef &MemUse, const MemoryUseOrDef &MemDef);

  public:
  /// Updates the \p OInfo, with the mapping informa
  InterproceduralMSSAWalker(const Module &ThisModule,
      FuncToAAResultsMapTy &FuncToAAResultsMap,
      FuncToMSSAMapTy &FuncToMSSAMap,
      CallToGenDefsTy &CallToGenDefs,
      CallToGenUsesTy &CallToGenUses)
    : ThisModule(ThisModule), FuncToAAResultsMap(FuncToAAResultsMap),
    FuncToMSSAMap(FuncToMSSAMap), CallToGenDefs(CallToGenDefs),
    CallToGenUses(CallToGenUses) {run();}
};

/// This pass performs the global (interprocedural) Omp Data Mapping Analysis.
/// (New pass manager).
class OmpDiagnosticsGlobalAnalysis
    : public AnalysisInfoMixin<OmpDiagnosticsGlobalAnalysis> {
  friend AnalysisInfoMixin<OmpDiagnosticsGlobalAnalysis>;
  static AnalysisKey Key;
  Module *ThisModule;
  ModuleAnalysisManager *AnalysisManager;
  std::function<AAResults &(Function &)> GetAAForFunc;
  std::function<MemorySSA &(Function &F)> GetMemSSAForFunc;
  FuncToAAResultsMapTy FuncToAAResultsMap;
  FuncToMSSAMapTy FuncToMSSAMap;
  FuncToGenDefsTy FuncToGenDefs;
  FuncToGenUsesTy FuncToGenUses;
  CallToFuncArgsAliasMapTy CallToFuncArgsAliasMap;

  void analyzeModule();
  void recordFuncGens();
  void interProcRecordFuncGens();
  void interProcMSSA();

public:
  using Result = IntResult;
  Result run(Module &M, ModuleAnalysisManager &AM);
  void handleIndirectCalls(Function &F);
};

/// Printer pass for the \c OmpDiagnosticsGlobalAnalysis results.
class OmpDiagnosticsGlobalPrinterPass
    : public PassInfoMixin<OmpDiagnosticsGlobalPrinterPass> {
  raw_ostream &OS;

public:
  explicit OmpDiagnosticsGlobalPrinterPass(raw_ostream &OS) : OS(OS) {}
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);
};

} // end namespace llvm

#endif // LLVM_ANALYSIS_OmpDiagnosticsANALYSIS_H
