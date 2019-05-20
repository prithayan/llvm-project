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

/// OmpDiagnosticsInfo wrapper for the legacy pass manager
class OmpDiagnosticsInfoWrapperPass : public FunctionPass {
  OmpDiagnosticsInfo SSI;

public:
  static char ID;
  OmpDiagnosticsInfoWrapperPass();

  const OmpDiagnosticsInfo &getResult() const { return SSI; }

  void print(raw_ostream &O, const Module *M) const override;
  void getAnalysisUsage(AnalysisUsage &AU) const override;

  bool runOnFunction(Function &F) override;
};

using OmpDiagnosticsGlobalInfo = std::map<const GlobalValue *, OmpDiagnosticsInfo>;

/// This pass performs the global (interprocedural) stack safety analysis (new
/// pass manager).
class OmpDiagnosticsGlobalAnalysis
    : public AnalysisInfoMixin<OmpDiagnosticsGlobalAnalysis> {
  friend AnalysisInfoMixin<OmpDiagnosticsGlobalAnalysis>;
  static AnalysisKey Key;

public:
  using Result = OmpDiagnosticsGlobalInfo;
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

/// This pass performs the global (interprocedural) stack safety analysis
/// (legacy pass manager).
class OmpDiagnosticsGlobalInfoWrapperPass : public ModulePass {
  OmpDiagnosticsGlobalInfo SSI;

public:
  static char ID;

  OmpDiagnosticsGlobalInfoWrapperPass();

  const OmpDiagnosticsGlobalInfo &getResult() const { return SSI; }

  void print(raw_ostream &O, const Module *M) const override;
  void getAnalysisUsage(AnalysisUsage &AU) const override;

  bool runOnModule(Module &M) override;
};

} // end namespace llvm

#endif // LLVM_ANALYSIS_OmpDiagnosticsANALYSIS_H
