//===- OmpDiagnosticsAnalysis.cpp - Stack memory safety analysis -------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
//===----------------------------------------------------------------------===//

#include "llvm/Analysis/OmpDiagnosticsAnalysis.h"
#include "llvm/Analysis/ScalarEvolutionExpressions.h"
#include "llvm/IR/CallSite.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

#define DEBUG_TYPE "omp-diagnostics"

OmpDiagnosticsInfo::OmpDiagnosticsInfo() = default;
OmpDiagnosticsInfo::OmpDiagnosticsInfo(OmpDiagnosticsInfo &&) = default;
OmpDiagnosticsInfo &OmpDiagnosticsInfo::operator=(OmpDiagnosticsInfo &&) = default;

OmpDiagnosticsInfo::OmpDiagnosticsInfo(FunctionInfo &&Info)
//    : Info(new FunctionInfo(std::move(Info))) 
  {}

OmpDiagnosticsInfo::~OmpDiagnosticsInfo() = default;

void OmpDiagnosticsInfo::print(raw_ostream &O) const { }//Info->print(O); }

AnalysisKey OmpDiagnosticsAnalysis::Key;

OmpDiagnosticsInfo OmpDiagnosticsAnalysis::run(Function &F,
                                         FunctionAnalysisManager &AM) {
  return OmpDiagnosticsInfo();
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

OmpDiagnosticsInfoWrapperPass::OmpDiagnosticsInfoWrapperPass() : FunctionPass(ID) {
  initializeOmpDiagnosticsInfoWrapperPassPass(*PassRegistry::getPassRegistry());
}

void OmpDiagnosticsInfoWrapperPass::getAnalysisUsage(AnalysisUsage &AU) const {
  AU.addRequired<ScalarEvolutionWrapperPass>();
  AU.setPreservesAll();
}

void OmpDiagnosticsInfoWrapperPass::print(raw_ostream &O, const Module *M) const {
  //SSI.print(O);
}

bool OmpDiagnosticsInfoWrapperPass::runOnFunction(Function &F) {
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
