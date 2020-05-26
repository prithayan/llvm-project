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
#include <queue>
#include <set>

namespace llvm {

using namespace llvm;

class IntResult {
  int R;
  public:
  IntResult(): R(0){}
  int get() {return R;}
};
/// Iterate over every Omp RTL call instruction, and parse its arguments, to
/// deduce the data mapping pragma used by the programmer. Then record all the
/// variables mapped and its mapping properties for every Omp RTL call.
class OmpDiagnosticsLocalAnalysis {
  const Function &Func2Analyze;
  const MemorySSA & MSSA;
  AAResults &AA;

  void analyzeBB(const BasicBlock &BB);
  public:
  /// Updates the \p OInfo, with the mapping informa
  OmpDiagnosticsLocalAnalysis(const Function &F, const MemorySSA & MSSA, AAResults &AA)
    : Func2Analyze(F), MSSA(MSSA), AA(AA) {}
  // TODO : make sure the order of traversal of Basicblocks is correct, preorder
  // traversal only
  void run();
  void print();
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

  void analyzeModule();

  std::map<std::string, Function *> FuncNameMap;

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
