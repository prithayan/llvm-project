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

#include "llvm/IR/DebugInfoMetadata.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Pass.h"
#include "llvm/Analysis/MemorySSA.h" 
#include "llvm/Analysis/PostDominators.h"
#include <queue>
#include <set>
#include <map>

namespace llvm {

using namespace llvm;

class IntResult {
  int R;
  public:
  IntResult(): R(0){}
  int get() {return R;}
};
//using UseInstr2DefInstrMapTy = std::map<Instruction*,Instruction*>;
using ArgumentDefsTy = std::map<unsigned, const Instruction*>;
using FuncToGenDefsTy = std::map<const Function*, ArgumentDefsTy>;
using CallToFuncArgsAliasMapTy = std::map<const CallInst*, std::map<unsigned, unsigned>>;
/// Iterate over every Omp RTL call instruction, and parse its arguments, to
/// deduce the data mapping pragma used by the programmer. Then record all the
/// variables mapped and its mapping properties for every Omp RTL call.
class OmpDiagnosticsLocalAnalysis {
  const Function &ThisFunc;
  const MemorySSA & MSSA;
  AAResults &AA;
  FuncToGenDefsTy &FuncToGenDefs;
  CallToFuncArgsAliasMapTy &CallToFuncArgsAliasMap;

  void analyzeBB(const BasicBlock &BB);
  void analyzeMemUse(const MemoryUse &MemUse);
  void recordFuncGens(const MemoryDef &MemDef);
  Value *getAliasingCallArg(CallInst &CIDef, Value &PointerOp);

  llvm::Optional<unsigned> getAliasingArg(const Value &Mem, const Function &F);
  public:
  /// Updates the \p OInfo, with the mapping informa
  OmpDiagnosticsLocalAnalysis(const Function &F, const MemorySSA & MSSA, AAResults &AA, FuncToGenDefsTy &FuncToGenDefs, CallToFuncArgsAliasMapTy &CallToFuncArgsAliasMap) 
    : ThisFunc(F), MSSA(MSSA), AA(AA), FuncToGenDefs(FuncToGenDefs),CallToFuncArgsAliasMap(CallToFuncArgsAliasMap){}
  // TODO : make sure the order of traversal of Basicblocks is correct, preorder
  // traversal only
  void run();
  void recordFuncGens();
  void print();
};

using ArgToDefMapTy = std::map<unsigned, const Instruction*>;
class InterproceduralAnalysis {
  Module &ThisModule;
  FuncToGenDefsTy &FuncToGenDefs;
  CallToFuncArgsAliasMapTy &CallToFuncArgsAliasMap;

  bool Converged;
  void getCalledFuncDefs(CallInst &CI, Function &F, ArgToDefMapTy &ArgToDefMap);
  void insertDef(Function &F, unsigned FuncArg, Function &CalledFunc, unsigned CalledFuncArg);
  void analyzeFunc(Function &F);
  void run();
  public:
  InterproceduralAnalysis(Module &ThisModule,FuncToGenDefsTy &FuncToGenDefs, CallToFuncArgsAliasMapTy &CallToFuncArgsAliasMap):ThisModule(ThisModule),FuncToGenDefs(FuncToGenDefs), CallToFuncArgsAliasMap(CallToFuncArgsAliasMap), Converged(false){run(); }
};
/// This pass performs the global (interprocedural) Omp Data Mapping Analysis.
/// (New pass manager).
class OmpDiagnosticsGlobalAnalysis
: public AnalysisInfoMixin<OmpDiagnosticsGlobalAnalysis> {
  friend AnalysisInfoMixin<OmpDiagnosticsGlobalAnalysis>;
  static AnalysisKey Key;
  Module *ThisModule;
  ModuleAnalysisManager *AnalysisManager;
  std::function<AAResults& (Function&) > GetAAForFunc;
  std::function<MemorySSA & (Function &F) > GetMemSSAForFunc;
  std::function<PostDominatorTree & (Function &F) > GetPDMForFunc;
  FuncToGenDefsTy FuncToGenDefs;
  CallToFuncArgsAliasMapTy CallToFuncArgsAliasMap;

  void analyzeModule();
  void recordFuncGens();
  void  interProcRecordFuncGens();
  void interProcMSSA();

  public:
  using Result = IntResult;
  Result run(Module &M, ModuleAnalysisManager &AM);
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
