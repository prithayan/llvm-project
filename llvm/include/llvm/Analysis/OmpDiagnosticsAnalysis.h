//===- OmpDiagnosticsAnalysis.h - Stack memory safety analysis -----*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Stack Safety Analysis detects allocas and arguments with safe access.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_ANALYSIS_OmpDiagnosticsANALYSIS_H
#define LLVM_ANALYSIS_OmpDiagnosticsANALYSIS_H

#include "llvm/IR/PassManager.h"
#include "llvm/Pass.h"
#include "llvm/Analysis/ScalarEvolutionExpressions.h"
#include "llvm/IR/CallSite.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/Support/raw_ostream.h"
#include <vector>

namespace llvm {

/// Interface to access stack safety analysis results for single function.
class OmpDiagnosticsInfo {
public:
  struct FunctionInfo;

private:
  //std::unique_ptr<FunctionInfo> Info;

public:
  OmpDiagnosticsInfo();
  OmpDiagnosticsInfo(FunctionInfo &&Info);
  OmpDiagnosticsInfo(OmpDiagnosticsInfo &&);
  OmpDiagnosticsInfo &operator=(OmpDiagnosticsInfo &&);
  ~OmpDiagnosticsInfo();

  // TODO: Add useful for client methods.
  void print(raw_ostream &O) const;
};

/// OmpDiagnosticsInfo wrapper for the new pass manager.
class OmpDiagnosticsAnalysis : public AnalysisInfoMixin<OmpDiagnosticsAnalysis> {
  friend AnalysisInfoMixin<OmpDiagnosticsAnalysis>;
  static AnalysisKey Key;

  int getSCEV_Max_value(std::vector<const SCEV *> &simplifySCEV, std::string &maxSCEV_string, const bool getMax=true);
  ScalarEvolution *SE;
  public:
  using Result = OmpDiagnosticsInfo;
  OmpDiagnosticsInfo run(Function &F, FunctionAnalysisManager &AM);
};

/// Printer pass for the \c OmpDiagnosticsAnalysis results.
class OmpDiagnosticsPrinterPass : public PassInfoMixin<OmpDiagnosticsPrinterPass> {
  raw_ostream &OS;

public:
  explicit OmpDiagnosticsPrinterPass(raw_ostream &OS) : OS(OS) {}
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM);
};


} // end namespace llvm

#endif // LLVM_ANALYSIS_OmpDiagnosticsANALYSIS_H
