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

int OmpDiagnosticsAnalysis::getSCEV_Max_value(std::vector<const SCEV *> &simplifySCEV, std::string &maxSCEV_string, const bool getMax){
  if (simplifySCEV.empty()) return 0;
  const SCEV * inst_scev = simplifySCEV.back();
  simplifySCEV.pop_back();
  static bool foundUnkown = false;
  LLVM_DEBUG(dbgs()<<"\n simplify scev:"<<*inst_scev);
  //<<"\n scev vec size:"<<simplifySCEV.size()
  //<<"\n "<<maxSCEV_string);
  switch (static_cast<SCEVTypes>(inst_scev->getSCEVType())) {
    case scUMinExpr: assert(false && "scUMinExpr Not Handled");
    case scSMinExpr: assert(false && "scSMinExpr Not Handled");
    case scConstant: {
                       const ConstantInt *constInt = dyn_cast<SCEVConstant>(inst_scev)->getValue();
                       LLVM_DEBUG(dbgs()<<"\n Constant scev:"<<*constInt);
                       maxSCEV_string += constInt->getValue().toString(10, true) ;
                       simplifySCEV.push_back(inst_scev);
                       /*if constant then itself is the max value,*/
                       return 1;
                     }
    case scTruncate: {
                       LLVM_DEBUG(dbgs()<<"\n Truncate scev:");
                       const SCEVTruncateExpr *Trunc = cast<SCEVTruncateExpr>(inst_scev);
                       const SCEV *Op = Trunc->getOperand();
                       simplifySCEV.push_back(Op);
                       getSCEV_Max_value(simplifySCEV,maxSCEV_string);
                       return -1;
                     }
    case scZeroExtend: {
                         LLVM_DEBUG(dbgs()<<"\n ZeroExnt scev:");
                         const SCEVZeroExtendExpr *ZExt = cast<SCEVZeroExtendExpr>(inst_scev);
                         const SCEV *Op = ZExt->getOperand();
                         simplifySCEV.push_back(Op);
                         getSCEV_Max_value(simplifySCEV, maxSCEV_string);
                         return -1;
                       }
    case scSignExtend: {
                         LLVM_DEBUG(dbgs()<<"\n ZeroExnt scev:");
                         const SCEVSignExtendExpr *SExt = cast<SCEVSignExtendExpr>(inst_scev);
                         const SCEV *Op = SExt->getOperand();
                         simplifySCEV.push_back(Op);
                         getSCEV_Max_value(simplifySCEV,  maxSCEV_string);
                         return -1;
                       }
    case scAddRecExpr: {
                         LLVM_DEBUG(dbgs()<<"\n add rec expr  scev:");
                         const SCEVAddRecExpr *AR = cast<SCEVAddRecExpr>(inst_scev);
                         const Loop *fLoop = AR->getLoop();
                         auto beCountScev = SE->getBackedgeTakenCount(fLoop);
                         LLVM_DEBUG(dbgs()<< "\n TRIP COUNT ::"<<SE->getSmallConstantMaxTripCount(fLoop)
                             <<" \n be count::"<<*beCountScev
                             <<"bescev count: "<<beCountScev->getSCEVType());
                         if (beCountScev->getSCEVType() !=  scUnknown 
                             && beCountScev->getSCEVType() != scCouldNotCompute
                            ) {
                           const SCEV *maxVal = AR->evaluateAtIteration(beCountScev, *SE);
                           simplifySCEV.push_back(maxVal);
                           getSCEV_Max_value(simplifySCEV, maxSCEV_string);
                         } else 
                           foundUnkown = true;
                         /*for add rec, simply get the maximum possible 
                          * value for the last iteration of the for loop*/
                         return -1;
                       }
    case scAddExpr: {
                      LLVM_DEBUG(dbgs()<<"\n Add  scev:");
                      const SCEVAddExpr *Sadd = cast<SCEVAddExpr>(inst_scev);
                      const SCEV *Op= Sadd->getOperand(0);
                      simplifySCEV.push_back(Op);//simplify first op
                      maxSCEV_string += "(";
                      getSCEV_Max_value(simplifySCEV, maxSCEV_string);
                      if (foundUnkown) {
                        maxSCEV_string += ")";
                        return -1;
                      }
                      maxSCEV_string += "+";
                      const SCEV *lhs = simplifySCEV.back();
                      simplifySCEV.pop_back();
                      Op= Sadd->getOperand(1);
                      simplifySCEV.push_back(Op);//simplify second op
                      getSCEV_Max_value(simplifySCEV, maxSCEV_string);
                      maxSCEV_string += ")";
                      if (!foundUnkown) {
                        const SCEV *rhs = simplifySCEV.back();
                        simplifySCEV.pop_back();
                        auto addSCEV  = SE->getAddExpr(lhs, rhs);
                        simplifySCEV.push_back(addSCEV);
                      }
                      //          getSCEV_Max_value(simplifySCEV, SE, LI);
                      return -1;
                    }
    case scMulExpr: {
                      LLVM_DEBUG(dbgs()<<"\n mul scev:");
                      const SCEVMulExpr *Smul = cast<SCEVMulExpr>(inst_scev);
                      const SCEV *Op= Smul->getOperand(0);
                      simplifySCEV.push_back(Op);//simplify first op
                      maxSCEV_string += "(";
                      getSCEV_Max_value(simplifySCEV, maxSCEV_string);
                      if (foundUnkown) {
                        maxSCEV_string += ")";
                        return -1;
                      }
                      LLVM_DEBUG(dbgs()<<"\n size:"<<simplifySCEV.size()<<"\n");
                      const SCEV *lhs = simplifySCEV.back();
                      simplifySCEV.pop_back();
                      Op= Smul->getOperand(1);
                      simplifySCEV.push_back(Op);//simplify second op
                      maxSCEV_string += "*";
                      getSCEV_Max_value(simplifySCEV, maxSCEV_string);
                      LLVM_DEBUG(dbgs()<<"\n size:"<<simplifySCEV.size()<<"\n");
                      maxSCEV_string += ")";
                      if (!foundUnkown) {
                        const SCEV *rhs = simplifySCEV.back();
                        simplifySCEV.pop_back();
                        auto mulSCEV  = SE->getMulExpr(lhs, rhs);
                        simplifySCEV.push_back(mulSCEV);
                      }
                      //            getSCEV_Max_value(simplifySCEV, SE, LI);
                      return -1;
                    }
    case scUMaxExpr:
    case scSMaxExpr: {
                       LLVM_DEBUG(dbgs()<<"\n max scev:");
                       const SCEVNAryExpr *SExt = cast<SCEVNAryExpr>(inst_scev);
                       //const SCEVSMaxExpr *SExt = cast<SCEVSMaxExpr>(inst_scev);
                       //ignore the first operator in maxexpr, example:(0 smax %p) 
                       //TODO Generalize it
                       LLVM_DEBUG(dbgs()<<"\n Ignoring SMax first op:"<<*SExt);
                       const SCEV *Op = SExt->getOperand(1);
                       simplifySCEV.push_back(Op);
                       getSCEV_Max_value(simplifySCEV, maxSCEV_string);
                       return -1;
                     }
    case scUDivExpr: {
                       LLVM_DEBUG(dbgs()<<"\n div scev:");
                       const SCEVUDivExpr *UDiv = cast<SCEVUDivExpr>(inst_scev);
                       const SCEV *Op= UDiv->getLHS() ;
                       simplifySCEV.push_back(Op);//simplify first op
                       maxSCEV_string += "(";
                       getSCEV_Max_value(simplifySCEV, maxSCEV_string);
                       if (foundUnkown) {
                         maxSCEV_string += ")";
                         return -1;
                       }
                       const SCEV *lhs = simplifySCEV.back();
                       simplifySCEV.pop_back();
                       Op= UDiv->getRHS();
                       simplifySCEV.push_back(Op);//simplify second op
                       maxSCEV_string += "/";
                       getSCEV_Max_value(simplifySCEV, maxSCEV_string);
                       maxSCEV_string += ")";
                       if (!foundUnkown) {
                         const SCEV *rhs = simplifySCEV.back();
                         simplifySCEV.pop_back();
                         auto divSCEV  = SE->getUDivExpr(lhs, rhs);
                         simplifySCEV.push_back(divSCEV);
                       }
                       //              getSCEV_Max_value(simplifySCEV, SE, LI);
                       return -1;
                     }
    case scUnknown: {
                      LLVM_DEBUG(dbgs()<<"\n unknown scev:");
                      const SCEVUnknown *U = cast<SCEVUnknown>(inst_scev);
                      simplifySCEV.push_back(inst_scev);
                      const Value *v = U->getValue();
                      maxSCEV_string +=   v->getName().str();
                      foundUnkown = true;
                      //Type *AllocTy;
                      //if (U->isSizeOf(AllocTy)) {
                      //  OS << "sizeof(" << *AllocTy << ")";
                      //  return;
                      //}
                      //if (U->isAlignOf(AllocTy)) {
                      //  OS << "alignof(" << *AllocTy << ")";
                      //  return;
                      //}

                      //Type *CTy;
                      //Constant *FieldNo;
                      //if (U->isOffsetOf(CTy, FieldNo)) {
                      //  OS << "offsetof(" << *CTy << ", ";
                      //  FieldNo->printAsOperand(OS, false);
                      //  OS << ")";
                      //  return;
                      //}

                      // Otherwise just print it normally.

                      return 1;
                    }
    case scCouldNotCompute:
                    return -1;
  }
  llvm_unreachable("Unknown SCEV kind!");
}
AnalysisKey OmpDiagnosticsAnalysis::Key;

OmpDiagnosticsInfo OmpDiagnosticsAnalysis::run(Function &F,
                                         FunctionAnalysisManager &AM) {
  SE = &AM.getResult<ScalarEvolutionAnalysis>(F);
  std::map<const Value*, const SCEV*> Instr2ScevMap;
  //OmpDiagnosticsLocalAnalysis SSLA(F, AM.getResult<ScalarEvolutionAnalysis>(F));
  //return SSLA.run();
  for (auto I = inst_begin(F) , E = inst_end(F); I != E ; I++){
    Instruction &Instr = *I;
    if (SE->isSCEVable(Instr.getType())) {
      LLVM_DEBUG(dbgs()<<"\n Instruction::"<<*I);
      auto Scev = SE->getSCEV(&Instr);
      if (isa<SCEVNAryExpr>(Scev)) {
        Instr2ScevMap[&Instr] = Scev;
        LLVM_DEBUG(dbgs()<<"\n SCEV::"<<*SE->getSCEV(&Instr));
      }
    }
    if (auto St = dyn_cast<StoreInst>(&Instr)){
      auto Address = St->getPointerOperand();
      if (auto Gep = dyn_cast<GetElementPtrInst>(Address)){
        for (unsigned OpNum = 0 ; OpNum < Gep->getNumOperands() ; OpNum++){
          if (OpNum == Gep->getPointerOperandIndex()) continue;
          auto Index = Gep->getOperand(OpNum);
          // Keep on going to the def instruction, till we reach a non instruction or we get the proper scev for the index
          while (Instr2ScevMap.find(Index) == Instr2ScevMap.end()){
            if (auto IndexInstr = dyn_cast<Instruction>(Index)){
              // Need to handle different instruction kinds here
              Index = IndexInstr->getOperand(0);
            }else 
              break;
          }
          if (Instr2ScevMap.find(Index) != Instr2ScevMap.end()) {
            LLVM_DEBUG(dbgs()<<"\n Store "<<*I 
                <<" \n at :: "<<I->getDebugLoc().getLine());
            LLVM_DEBUG(dbgs()<<"\n Index : "<<*Index << "\n SCEV ::"<<*Instr2ScevMap[Index]);
            std::vector<const SCEV*> simplifySCEV = {Instr2ScevMap[Index] };
            std::string maxSCEV_str = "";
            getSCEV_Max_value(simplifySCEV, maxSCEV_str );
            LLVM_DEBUG(dbgs()<<"\n Max::"<<maxSCEV_str);
            errs()<<"\n Store "<<*I 
                <<" \n at :: "<<I->getDebugLoc().getLine();
            errs()<<"\n Index : "<<*Index << "\n SCEV ::"<<*Instr2ScevMap[Index];
            errs()<<"\n Max::"<<maxSCEV_str;
          }
        }
      }
    }
  }
  return OmpDiagnosticsInfo();
}

PreservedAnalyses OmpDiagnosticsPrinterPass::run(Function &F,
                                              FunctionAnalysisManager &AM) {
  OS << "'omp diagnostics Local Analysis' for function '" << F.getName() << "'\n";
  AM.getResult<OmpDiagnosticsAnalysis>(F).print(OS);
  return PreservedAnalyses::all();
}


