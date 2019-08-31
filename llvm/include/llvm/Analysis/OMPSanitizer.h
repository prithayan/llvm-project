//===- OMPSanitizer.h - Analyze omp target clauses and infer data
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

#ifndef LLVM_ANALYSIS_OMPSanitizer_H
#define LLVM_ANALYSIS_OMPSanitizer_H

#include "llvm/IR/DebugInfoMetadata.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Pass.h"
#include <queue>
#include <set>
#include "llvm/Analysis/ScalarEvolutionExpressions.h"
#include "llvm/IR/CallSite.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Analysis/OmpDiagnosticsAnalysis.h"
#include "llvm/Analysis/MemUseDefAnalysis.h"

namespace llvm {

using namespace llvm;
class ValidateOmpReachingDefs {

  //const InstructionToMemCopyMapType &AllocatedDevice, &HostToDeviceCopy, &DeviceToHostCopy, &DevicePersistent;

  //const MemUseToReachingDefsMapType &MemUseToReachingDefsMap;

  MemoryLdStMapClass &MemInfo;
  OmpDiagnosticsInfo &OmpInfo;
  std::map<const Function *, const Function *> FuncEnvMap;
  std::map<const Function *, unsigned> CalledFuncLocationMap;
  //std::map<unsigned , std::set<const Function *>> LocationToCalledFuncMap;
  //DebugLocation OmpDiagnosticsLocationInfo;
  std::map<unsigned, SetOfValues> AllocatedOnDeviceMap;
  std::map<unsigned, SetOfValues> HostToDeviceMap;
  std::map<unsigned, SetOfValues> DeviceToHostMap;
  std::map<unsigned, SetOfValues> PersistentInMap;
  std::map<unsigned, SetOfValues> PersistentOutMap;
  const Function *InsideOMPCall;
  //bool InsideTargetEnv;

  void recordOmpMaps();
  public:
  ValidateOmpReachingDefs(MemoryLdStMapClass &M, OmpDiagnosticsInfo &O): MemInfo(M), OmpInfo(O), InsideOMPCall(nullptr){
    recordOmpMaps();
  }

  //ValidateOmpReachingDefs(InstructionToMemCopyMapType &A, InstructionToMemCopyMapType &B, InstructionToMemCopyMapType &C, InstructionToMemCopyMapType &D, MemUseToReachingDefsMapType &E, DebugLocation &F): AllocatedDevice(A), HostToDeviceCopy(B), DeviceToHostCopy(C), DevicePersistent(D), MemUseToReachingDefsMap(E), OmpDiagnosticsLocationInfo(F), InsideTargetEnv(false) {}
  void analyzeModule(Module &M);
  void analyzeFunction(const Function &F);
  void analyzeBasicBlock(const BasicBlock &BB);

};

/// This pass performs the global (interprocedural) Omp Data Mapping Analysis.
/// (New pass manager).
class OmpSanitizerGlobalAnalysis
    : public AnalysisInfoMixin<OmpSanitizerGlobalAnalysis> {
  friend AnalysisInfoMixin<OmpSanitizerGlobalAnalysis>;
  static AnalysisKey Key;
  Module *ThisModule;
  ModuleAnalysisManager *AnalysisManager;

public:
  using Result = ValidateOmpReachingDefs;
  Result run(Module &M, ModuleAnalysisManager &AM);
};

/// Printer pass for the \c OmpDiagnosticsGlobalAnalysis results.
class OmpSanitizerGlobalPrinterPass
    : public PassInfoMixin<OmpSanitizerGlobalPrinterPass> {
  raw_ostream &OS;

public:
  explicit OmpSanitizerGlobalPrinterPass(raw_ostream &OS) : OS(OS) {}
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);
};


} // end namespace llvm

#endif // LLVM_ANALYSIS_OMPSanitizer_H
