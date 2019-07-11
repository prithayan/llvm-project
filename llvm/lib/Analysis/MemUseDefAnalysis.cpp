//===- MemUseDefAnalysis.cpp - Mem Use-Def Analysis based on MemorySSA---===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
//===----------------------------------------------------------------------===//

#include "llvm/Analysis/MemUseDefAnalysis.h"

using namespace llvm;

#define DEBUG_TYPE "mem-usedef-analysis"

void DebugLocation::printDebugLocation() {
  for (auto Iter : FileLinesMap) {
    LLVM_DEBUG(dbgs() << "\n file:" << Iter.first);
    // errs()<<"\n file:"<<iter.first;
    for (auto Lines : Iter.second) {
      LLVM_DEBUG(dbgs() << ":" << Lines << ",");
      // errs()<<":"<<lines<<",";
    }
  }
}

void DebugLocation::recordDebugLoc(const LocationStringType &LocStrBegin,
                                   const LocationStringType &LocStrEnd,
                                   LocationSequenceNumType &BeginSeq,
                                   LocationSequenceNumType &EndSeq) {
  FileNameType FileNameBegin, FileNameEnd;
  LineNumberType LineBegin = 0, LineEnd = 0;
  LineNumberType BaseLineNumBegin = -1, BaseLineNumEnd = -1;
  getFile_Line_fromStr(LocStrBegin, FileNameBegin, LineBegin);
  getFile_Line_fromStr(LocStrEnd, FileNameEnd, LineEnd);
  auto IterBegin = FileLinesMap.find(FileNameBegin);
  if (IterBegin == FileLinesMap.end()) {
    errs() << "\n ERROR OMP file :" << FileNameBegin
           << "\n Not compiled with non omp";
  }
  auto SetLines = IterBegin->second;
  auto IterGreaterEqual = SetLines.upper_bound(LineBegin);
  if (IterGreaterEqual != SetLines.end()) {
    BaseLineNumBegin = *IterGreaterEqual;
  }
  LLVM_DEBUG(dbgs() << "\n searching for :" << LineBegin
                    << " and Found:" << BaseLineNumBegin);
  LocationStringType baseStrBegin =
      FileNameBegin + ":" + std::to_string(BaseLineNumBegin);
  BeginSeq = DebugLoc2SeqNumMap[baseStrBegin];
  while (IterGreaterEqual != SetLines.end()) {
    if (*IterGreaterEqual >= LineEnd)
      break;
    LLVM_DEBUG(dbgs() << "," << *IterGreaterEqual);
    IterGreaterEqual++;
  }
  if (IterGreaterEqual-- != SetLines.end()) {
    BaseLineNumEnd = *IterGreaterEqual;
  }
  LLVM_DEBUG(dbgs() << "\n searching for :" << LineEnd
                    << " and Found:" << BaseLineNumEnd);
  LocationStringType baseStrEnd =
      FileNameEnd + ":" + std::to_string(BaseLineNumEnd);
  EndSeq = DebugLoc2SeqNumMap[baseStrEnd] + 1;
  // return
}

LocationSequenceNumType
DebugLocation::recordDebugLoc(LocationStringType &locStr) {
  FileNameType fileName;
  LineNumberType line = 0;
  LineNumberType baseLineNum = -1;
  getFile_Line_fromStr(locStr, fileName, line);
  auto iter = FileLinesMap.find(fileName);
  if (iter == FileLinesMap.end()) {
    errs() << "\n ERROR OMP file :" << fileName
           << "\n Not compiled with non omp";
  }
  auto setLines = iter->second;
  auto iterGreaterEqual = setLines.upper_bound(line);
  if (iterGreaterEqual != setLines.end()) {
    baseLineNum = *iterGreaterEqual;
  }
  LLVM_DEBUG(dbgs() << "\n searching for :" << line
                    << " and Found:" << baseLineNum);
  LocationStringType baseStr = fileName + ":" + std::to_string(baseLineNum);
  return DebugLoc2SeqNumMap[baseStr];
}
void DebugLocation::recordDebugLoc(const Instruction &inst) {
  if (!inst.getDebugLoc())
    return;
  static LocationStringType lastLocationStr = "";
  unsigned seperatorPosition;
  LocationStringType locStr =
      getDebugLocStr(&inst.getDebugLoc(), seperatorPosition);
  if (DebugLoc2SeqNumMap.find(locStr) != DebugLoc2SeqNumMap.end())
    return; // already added this location to map
  LLVM_DEBUG(dbgs() << "\n position:" << locStr
                    << "\n seq:" << DebugLoc2SeqNumMap.size());
  FileNameType fileName;
  LineNumberType line = 0;
  getFile_Line_fromStr(locStr, fileName, line, seperatorPosition);
  DebugLoc2SeqNumMap[locStr] = DebugLoc2SeqNumMap.size();
  FileLinesMap[fileName].insert(line);
  lastLocationStr = locStr;
  printDebugLocation();
}
void DebugLocation::getFile_Line_fromStr(const LocationStringType &location,
                                         FileNameType &fileName,
                                         LineNumberType &lineNum,
                                         const unsigned seperatorPosition) {
  auto sepAt = seperatorPosition;
  fileName = location.substr(0, sepAt);
  // errs()<<"\n 1. filename:"<<fileName;
  // errs()<<"\n 2. linenum:"<<location.substr(sepAt+1, location.size() -
  // sepAt);
  lineNum = std::stoul(location.substr(sepAt + 1, location.size() - sepAt));
}
void DebugLocation::getFile_Line_fromStr(const LocationStringType &location,
                                         FileNameType &fileName,
                                         LineNumberType &lineNum) {
  const std::string seperator = ":";
  auto sepAt = location.find(seperator);
  fileName = location.substr(0, sepAt);
  // errs()<<"\n filename:"<<fileName;
  // errs()<<"\n linenum:"<<location.substr(sepAt+1, location.size() - sepAt);
  lineNum = std::stoul(location.substr(sepAt + 1, location.size() - sepAt));
}
bool DebugLocation::hasDebugLoc(const Instruction *instr) {
  if (instr->getDebugLoc())
    return true;
  return false;
}
LocationSequenceNumType DebugLocation::getDebugLocSeq(const Instruction *inst) {
  LocationSequenceNumType invalidRet = (LocationSequenceNumType)(-1);
  if (!inst->getDebugLoc())
    return invalidRet;
  // const DebugLoc *locStr = &inst->getDebugLoc();
  unsigned dummySep;
  auto locStr = getDebugLocStr(&inst->getDebugLoc(), dummySep);
  auto iter = DebugLoc2SeqNumMap.find(locStr);
  if (iter == DebugLoc2SeqNumMap.end()) {
    // if doesnot exist, then new instruction, insert in map
    recordDebugLoc(*inst);
    iter = DebugLoc2SeqNumMap.find(locStr);
    // return invalidRet ;
  }
  return iter->second;
}
const std::string DebugLocation::getDebugLocStr(const Instruction &inst) {
  const std::string invalidRet = ""; //(unsigned)(-1);
  if (!inst.getDebugLoc())
    return invalidRet;
  const DebugLoc &loc = inst.getDebugLoc();
  unsigned dummySep;
  return getDebugLocStr(&loc, dummySep);
}
const std::string DebugLocation::getDebugLocStr(const DebugLoc *loc,
                                                unsigned &seperatorPosition) {
  const std::string invalidRet = ""; //(unsigned)(-1);
  if (auto *scope = dyn_cast<DIScope>(loc->getScope())) {
    auto filename = scope->getFilename();
    seperatorPosition = filename.size();
    return filename.str() + ":" + std::to_string(loc->getLine());
  }
  return invalidRet;
}
const std::string DebugLocation::getDebugLocStr(const unsigned seq) {
  const std::string invalidRet = ""; //(unsigned)(-1);
  for (auto iter : DebugLoc2SeqNumMap) {
    if (iter.second == seq)
      return (iter.first);
  }
  return invalidRet;
}
bool DebugLocation::isPosX_greater_PosY(const unsigned seqX,
                                        const unsigned seqY) {
  if (seqX > seqY)
    return true;
  auto locX = getDebugLocStr(seqX);
  auto locY = getDebugLocStr(seqY);
  LineNumberType lineX, lineY;
  FileNameType fileX, fileY;
  getFile_Line_fromStr(locX, fileX, lineX);
  getFile_Line_fromStr(locY, fileY, lineY);
  LLVM_DEBUG(dbgs() << "\n is :" << lineX << " > " << lineY);
  if (lineX > lineY)
    return true;
  return false;
}

const std::string DebugLocation::getOrigVarName(const Value *irVal) {
  // DIFlagArtificial need to be ignored
  // TODO if global variable !0 = !DIGlobalVariableExpression(var: !1, expr:
  // !DIExpression()) distinct !DIGlobalVariable(name: "p", linkageName: "_ZL1p",
  // scope:
  if (auto Ld = dyn_cast<LoadInst>(irVal)) {
    return getOrigVarName(Ld->getPointerOperand());
  }
  if (auto St = dyn_cast<StoreInst>(irVal)) {
    return getOrigVarName(St->getPointerOperand());
  }
  if (IrToSrcLocMap.find(irVal) != IrToSrcLocMap.end()) {
    return IrToSrcLocMap[irVal];
  }
  if (irVal->hasName()) {
    auto strName = irVal->getName();
    if (strName.find(".casted") != std::string::npos) {
      strName = strName.substr(0, strName.find(".casted"));
    }
    return strName;
  }
  if (const Instruction *vI = dyn_cast<Instruction>(irVal)) {
    if (hasDebugLoc(vI) &&
        (LineNum2VarName.find(getDebugLocSeq(vI)) != LineNum2VarName.end())) {
      LLVM_DEBUG(dbgs() << "\n location name found:"
                        << LineNum2VarName[getDebugLocSeq(vI)]);
      return LineNum2VarName[getDebugLocSeq(vI)];
    }
  }
  const Instruction *storedI = dyn_cast<Instruction>(irVal);
  if (storedI == NULL) {
    return "";
  }
  for (unsigned i = 0; i < storedI->getNumOperands(); i++) {
    Value *op = storedI->getOperand(i);
    LLVM_DEBUG(dbgs() << "\n get name for :" << *op);
    auto Vname = getOrigVarName(op);
    if (Vname != "") {
      LLVM_DEBUG(dbgs() << "\n name is  :" << Vname);
      return Vname;
    }
  }
  if (storedI->getNumOperands() != 1)
    return "";
  return storedI->getOperand(0)->getName();
}
void DebugLocation::handleLLVMir2Srcdebug(const BitCastInst *&dbgI) {
  // call void @llvm.dbg.declare(metadata i32* %vla, metadata !16, metadata
  // !DIExpression()), !dbg !25 errs()<<"\n mapping :"<<*dbgI->getValue();
  // errs()<<"\n with exp:"<<*dbgI->getExpression();
  const Value *v = dbgI->getOperand(0);
  if (!v->hasName())
    return;
  IrToSrcLocMap[dbgI] = v->getName();
  if (hasDebugLoc(dbgI) &&
      (LineNum2VarName.find(getDebugLocSeq(dbgI)) == LineNum2VarName.end())) {
    LLVM_DEBUG(dbgs() << "\n LIne:" << dbgI->getDebugLoc().getLine()
                      << "has name :" << v->getName());
    LineNum2VarName[getDebugLocSeq(dbgI)] = v->getName();
  }
}
void DebugLocation::handleLLVMir2Srcdebug(const DbgValueInst *&dbgI) {
  // call void @llvm.dbg.declare(metadata i32* %vla, metadata !16, metadata
  // !DIExpression()), !dbg !25 errs()<<"\n mapping :"<<*dbgI->getValue();
  // errs()<<"\n with exp:"<<*dbgI->getExpression();
  LLVM_DEBUG(dbgs() << "\n LIne:"
                    << (*dbgI)
                    // dbgI->getDebugLoc().getLine()
                    << "has name :" << dbgI->getVariable()->getName());
  if (dbgI->getValue() != nullptr) {
    IrToSrcLocMap[dbgI->getValue()] = dbgI->getVariable()->getName();
  }
  IrToSrcLocMap[dbgI->getVariableLocation()] = dbgI->getVariable()->getName();
  LineNum2VarName[getDebugLocSeq(dbgI)] = dbgI->getVariable()->getName();
}
void DebugLocation::handleLLVMir2Srcdebug(const GetElementPtrInst *&Gep) {
  auto Ptr = Gep->getPointerOperand();
  if (IrToSrcLocMap.find(Ptr) != IrToSrcLocMap.end())
    IrToSrcLocMap[Gep] = IrToSrcLocMap[Ptr];
}
void DebugLocation::handleLLVMir2Srcdebug(const DbgDeclareInst *&dbgI) {
  // call void @llvm.dbg.declare(metadata i32* %vla, metadata !16, metadata
  // !DIExpression()), !dbg !25
  LLVM_DEBUG(dbgs() << "\n Location:" << *dbgI
                    << " \n Name:" << dbgI->getVariable()->getName());
  IrToSrcLocMap[dbgI->getVariableLocation()] = dbgI->getVariable()->getName();
}
void DebugLocation::initFunc(Function &F) {
  for (inst_iterator I = inst_begin(&F), E = inst_end(&F); I != E; ++I) {
    const Instruction &Inst = *I;
    recordDebugLoc(Inst);
    if (const BitCastInst *BitI = dyn_cast<BitCastInst>(&Inst)) {
      handleLLVMir2Srcdebug(
          BitI); // hack to record name of orignial source variable
    } else if (const DbgDeclareInst *dbgI = dyn_cast<DbgDeclareInst>(&Inst)) {
      handleLLVMir2Srcdebug(dbgI);
    } else if (const DbgValueInst *dbgI = dyn_cast<DbgValueInst>(&Inst)) {
      handleLLVMir2Srcdebug(dbgI);
    } else if (const GetElementPtrInst *Gep =
                   dyn_cast<GetElementPtrInst>(&Inst)) {
      handleLLVMir2Srcdebug(Gep);
    }
  }
}

DebugLocation OmpDiagnosticsLocationInfo;
const std::string DebugLocation::getVarNameLocStr(const Instruction *Inst) {
  const unsigned seq = getDebugLocSeq(Inst);
  std::string NameLocationStr;
  NameLocationStr = getSymbolName(Inst);
  // getOrigVarName(Inst);//
  NameLocationStr += " At location:" + getDebugLocStr(seq);
  return NameLocationStr;
}
void MemoryLdStMapClass::insertEntry(ConstInstrPtr LdSt, ConstValuePtr Mem) {
  if (LdSt == nullptr || Mem == nullptr)
    return;
  LdStPointsToMap[LdSt] = Mem;
}

bool MemoryLdStMapClass::isMemory(ConstValuePtr Val) {
  if (isa<GlobalVariable>(Val)) {
    return true;
  }
  if (isa<AllocaInst>(Val)) {
    return true;
  }
  return false;
}

bool MemoryLdStMapClass::backtrackFindMemoryInstr(ConstValuePtr Instr,
                                                  ConstValuePtr &Mem) {
  LLVM_DEBUG(dbgs() << "\n get memory for :" << *Instr);
  if (isMemory(Instr)) {
    Mem = Instr;
    return true;
  }
  if (const GetElementPtrInst *Gep = dyn_cast<GetElementPtrInst>(Instr)) {
    auto Ptr = Gep->getPointerOperand();
    return backtrackFindMemoryInstr(Ptr, Mem);
  }
  if (const LoadInst *Ld = dyn_cast<LoadInst>(Instr)) {
    auto Ptr = Ld->getPointerOperand();
    return backtrackFindMemoryInstr(Ptr, Mem);
  }
  if (const StoreInst *St = dyn_cast<StoreInst>(Instr)) {
    auto Ptr = St->getPointerOperand();
    return backtrackFindMemoryInstr(Ptr, Mem);
  }
  // if (auto indirectPtr = dyn_cast<Instruction>(instr)){
  //  return backtrackFindMemoryInstr(indirectPtr->getOperand(0) , mem);
  //}
  LLVM_DEBUG(dbgs() << "\n Warning: Memory op for instruction not found"
                    << *Instr);
  // errs()<<"\n Warning: Memory op for instruction not found"<<*Instr;
  Mem = nullptr;
  return false;
}

bool MemoryLdStMapClass::isMalloc(ConstInstrPtr LdSt) const {
  static std::set<LocationSequenceNumType> MallocLines;
  if (auto C = dyn_cast<CallInst>(LdSt)) {
    auto CalledF = C->getCalledFunction();
    if (CalledF != nullptr &&
        CalledF->getName().find("malloc") != std::string::npos) {
      auto Loc = OmpDiagnosticsLocationInfo.getDebugLocSeq(LdSt);
      LLVM_DEBUG(dbgs() << "\n malloc:" << *LdSt << "at:" << Loc);
      MallocLines.insert(Loc);
      return true;
    }
  } else if (MallocLines.find(OmpDiagnosticsLocationInfo.getDebugLocSeq(
                 LdSt)) != MallocLines.end()) {
    auto Loc = OmpDiagnosticsLocationInfo.getDebugLocSeq(LdSt);
    LLVM_DEBUG(dbgs() << "\n malloc:" << *LdSt << "at:" << Loc);
    return true;
  }
  return false;
}

MemoryLdStMapClass::ConstValuePtr
MemoryLdStMapClass::getMemoryForLdSt(ConstInstrPtr LdSt) const {
  LLVM_DEBUG(dbgs() << "\n mem instr:" << *LdSt);
  isMalloc(LdSt);
  auto EntryIter = LdStPointsToMap.find(LdSt);
  if (EntryIter == LdStPointsToMap.end())
    return nullptr;
  return EntryIter->second;
}

void DebugLocation::setSymbolName(const Instruction *Instr, const Value *Val) {
  LLVM_DEBUG(dbgs() << "\n set name : " << *Instr
                    << " \n from ::" << getSymbolName(Val));
  IrToSrcLocMap[Instr] = getSymbolName(Val);
  // LineNum2VarName[getDebugLocSeq(Instr)] = getSymbolName(Val);
  return;
}
/// Get the source level name for this Value.
std::string DebugLocation::getSymbolName(const Value *Val) {
  if (OmpDiagnosticsLocationInfo.IrToSrcLocMap.find(Val) != IrToSrcLocMap.end())
    return IrToSrcLocMap[Val];
  if (Val->hasName()) {
    return Val->getName();
  }
  // if (auto I = dyn_cast<Instruction>(Val)){
  //  //auto Seq = OmpDiagnosticsLocationInfo.getDebugLocSeq(I);
  //  //if (LineNum2VarName.find(Seq) != LineNum2VarName.end()) {
  //  //  LLVM_DEBUG(dbgs()<<"\n line num var name:" <<  LineNum2VarName[Seq]);
  //  //  return LineNum2VarName[Seq];
  //  //}
  //}
  return "";
}

std::string DebugLocation::getSymbolName(const Instruction *LdSt) {
  if (OmpDiagnosticsLocationInfo.IrToSrcLocMap.find(LdSt) !=
      IrToSrcLocMap.end())
    return IrToSrcLocMap[LdSt];
  if (auto StoreI = dyn_cast<StoreInst>(LdSt)) {
    auto Ptr = StoreI->getPointerOperand();
    if (IrToSrcLocMap.find(Ptr) != IrToSrcLocMap.end())
      return IrToSrcLocMap[Ptr];
  }
  if (auto LoadI = dyn_cast<LoadInst>(LdSt)) {
    auto Ptr = LoadI->getPointerOperand();
    if (IrToSrcLocMap.find(Ptr) != IrToSrcLocMap.end())
      return IrToSrcLocMap[Ptr];
  }
  // auto seq = OmpDiagnosticsLocationInfo.getDebugLocSeq(ldst);
  // if (LineNum2VarName.find(seq) != LineNum2VarName.end()){
  //  errs()<<"\n Line:"<<OmpDiagnosticsLocationInfo.getDebugLocStr(seq)
  //    <<" Name:"<<LineNum2VarName[seq];
  //  return LineNum2VarName[seq];
  //}
  return "";
}

void MemoryLdStMapClass::setSymbolName(ConstInstrPtr LdSt) {
  auto SymName = OmpDiagnosticsLocationInfo.getSymbolName(LdSt);
  if (SymName != "")
    return;
  if (LdStPointsToMap.find(LdSt) != LdStPointsToMap.end()) {
    return OmpDiagnosticsLocationInfo.setSymbolName(LdSt,
                                                    LdStPointsToMap[LdSt]);
  }
  return;
}

/// Find the memory that this instruction accesses, then record it in the map
/// and also return the memory.
MemoryLdStMapClass::ConstValuePtr
MemoryLdStMapClass::insertLoadStore(ConstInstrPtr LdSt) {
  ConstValuePtr Mem = getMemoryForLdSt(LdSt);
  if (Mem == nullptr) {
    if (backtrackFindMemoryInstr(LdSt, Mem)) {
      insertEntry(LdSt, Mem);
      setSymbolName(LdSt);
    }
  }
  return getMemoryForLdSt(LdSt);
}

void MemoryLdStMapClass::insertReachingDef(ConstInstrPtr MemUse,
                                           ConstInstrPtr MemDef,
                                           bool SingleReachingDef) {
  if (SingleReachingDef)
    MemUseToReachingDefsMap[MemUse] = {MemDef};
  else
    MemUseToReachingDefsMap[MemUse].insert(MemDef);
}

void MemoryLdStMapClass::insertReachingDef(const BasicBlock *BB,
                                           ConstInstrPtr MemDef) {
  BBtoReachingDefsMap[BB].insert(MemDef);
}

bool MemoryLdStMapClass::isDoublePointer(ConstInstrPtr Instr) {
  if (!isa<LoadInst>(Instr))
    assert(1);
  auto *Ld = dyn_cast<LoadInst>(Instr);
  auto LoadedVal = Ld->getPointerOperand();
  auto PtrType = LoadedVal->getType();
  if (PtrType->isPointerTy()) {
    if (dyn_cast<PointerType>(PtrType)->getElementType()->isPointerTy())
      return true;
  }
  return false;
}

void MemoryLdStMapClass::print(raw_ostream &O) {
  for (auto Iter : MemUseToReachingDefsMap) {
    auto MemUseInstr = Iter.first;
    auto PointsToMem = LdStPointsToMap[MemUseInstr];
    O << "\n Use::" << OmpDiagnosticsLocationInfo.getOrigVarName(PointsToMem)
      << " At:: " << OmpDiagnosticsLocationInfo.getDebugLocStr(*MemUseInstr)
      << " Defined at: ";
    for (auto MemDefInstr : Iter.second) {
      O << OmpDiagnosticsLocationInfo.getDebugLocStr(*MemDefInstr) << ", ";
      //<<"At :"<<OmpDiagnosticsLocationInfo.getVarNameLocStr(MemDefInstr);
    }
  }
}

void MemorySSAUseDefWalker::insertDefs(
    MemoryToDefAccessMapType &S,
    const MemoryToDefAccessMapType::iterator &begin,
    const MemoryToDefAccessMapType::iterator &end) {
  auto beforeInsertSize = S.size();
  S.insert(begin, end);
  if (beforeInsertSize != S.size())
    HasConvergedFlagged = false;
}
void MemorySSAUseDefWalker::insertDefs(
    SetOfMemoryDefsType &S, const SetOfMemoryDefsType::iterator &begin,
    const SetOfMemoryDefsType::iterator &end) {
  auto beforeInsertSize = S.size();
  S.insert(begin, end);
  if (beforeInsertSize != S.size())
    HasConvergedFlagged = false;
}
void MemorySSAUseDefWalker::addToGeneratingDefs(
    DefiningMemoryAccessType memDef) {
  auto instr = memDef->getMemoryInst();
  assert(instr != nullptr);
  auto memVal = LdStToMem.insertLoadStore(instr);
  if (memVal == nullptr)
    return;
  assert(memVal != nullptr);
  const BasicBlock *parentBB = instr->getParent();
  assert(parentBB != nullptr);
  // bb_defAccess_memory_map[parentBB][memDef] = memVal;//TODO remove this ?
  BBGeneratingDefs[parentBB][memVal] =
      memDef; // only one entry for every memval, later accesses clobber/kill
              // previous defs
  LLVM_DEBUG(dbgs() << "\n BasicBlock:" << parentBB << "\n Writes to:"
                    << *memVal << "\n by memdef:" << *memDef);
}
void MemorySSAUseDefWalker::print() {
  LLVM_DEBUG(dbgs() << "\n===============================");
  for (auto iter1 : BBGeneratingDefs) {
    auto bb = iter1.first;
    LLVM_DEBUG(dbgs() << "\n BB:" << bb);
    auto mem2access = iter1.second;
    for (auto iter2 : mem2access) {
      LLVM_DEBUG(dbgs() << "\n Memdef:" << *iter2.second
                        << "\n Writes to :" << *iter2.first);
    }
  }
  for (auto iter1 : BBReachingDefs) {
    auto memPhi = iter1.first; // MSSA->getMemoryAccess(bb);
    if (memPhi == nullptr)
      continue;
    LLVM_DEBUG(dbgs() << "\n Mem Phi:" << *memPhi);
    auto reachingDefs = BBReachingDefs[memPhi];
    for (auto iter3 : reachingDefs) {
      auto writtenToVal = iter3.first;
      LLVM_DEBUG(dbgs() << "\n Write to :" << *writtenToVal);
      auto setOfDefs = iter3.second;
      for (auto memDef : setOfDefs) {
        LLVM_DEBUG(dbgs() << "\n Memdef:" << *memDef);
      }
    }
  }
  LLVM_DEBUG(dbgs() << "\n===============================\n");
}

/// PredBB is the predecessor block of BB, this function updates the reaching
/// defs of the BB, based on the following equation,
//  ReachingDef[BB] = (ReachingDef[PredBB] - Kill[PredBB]) + Gen[BB]
void MemorySSAUseDefWalker::updateReachingDefsOfBB(const BasicBlock *PredBB,
                                                   const BasicBlock *BB) {
  assert(PredBB != nullptr && BB != nullptr);
  std::set<MemoryWrittenToType> KilledDefs;
  LLVM_DEBUG(dbgs() << " \n phi :"
                    << "\n incoming bb:" << *PredBB);
  // If this PredBB generates any defs, then
  // then add all the genrated defs from predecessor to the reaching defs of the
  // BB. Also, record all the defs killed by the predecessor.
  if (BBGeneratingDefs.find(PredBB) != BBGeneratingDefs.end())
    for (auto MapIter : BBGeneratingDefs[PredBB]) {
      // Forall the defs generated in this PredBB.
      auto MemWritten = MapIter.first;
      auto DefAccss = MapIter.second;
      auto NewElemInserted = BBReachingDefs[BB][MemWritten].insert(DefAccss);
      LdStToMem.insertReachingDef(BB, DefAccss->getMemoryInst());
      // If new element inserted, then the analysis has not converged.
      if (NewElemInserted.second)
        HasConvergedFlagged = false;
      // Keep track of all the defs killed in this BB.
      KilledDefs.insert(MemWritten);
      LLVM_DEBUG(dbgs() << "\n phi BB:"
                        << " \n REaching def:" << *MemWritten
                        << "\n def acces:" << *DefAccss);
    }

  // All the reaching defs of the predecessor, also reach the BB, unless they
  // are killed. This implements the union operator at a phi node
  if (BBReachingDefs.find(PredBB) != BBReachingDefs.end())
    for (auto PredPhiIter : BBReachingDefs[PredBB]) {
      // forall defs transitively passed by the phis of the incoming block
      auto MemWritten = PredPhiIter.first;
      if (KilledDefs.find(MemWritten) != KilledDefs.end())
        continue; // if this bb kills the mem, then ignore
      auto MemDefSet = PredPhiIter.second;
      insertDefs(BBReachingDefs[BB][MemWritten], MemDefSet.begin(),
                 MemDefSet.end());
      for (auto MDef : MemDefSet) {
        LdStToMem.insertReachingDef(BB, MDef->getMemoryInst());
      }
    }
}
/// The join operator for the reaching defs at BB. Udpates the reaching defs of
/// BB, based on its predecessors.
void MemorySSAUseDefWalker::reachingDefJoinOp(const BasicBlock *BB) {
  if (BB == nullptr)
    return;
  MemoryPhi *BBPhi = MSSA->getMemoryAccess(BB);
  if (BBPhi == nullptr) {
    // BBPhi is null means basic block has a single predecessor. Since there is
    // no phi here, we need to make sure to propagate all the reaching defs from
    // its predecessor.
    auto Pred = BB->getSinglePredecessor();
    if (Pred == nullptr)
      return;
    updateReachingDefsOfBB(Pred, BB);
    return;
  }
  // Forall predecessor blocks for the Phi Node, perform the join operator for
  // the reaching defs data flow analysis.
  for (unsigned IncomingIndex = 0;
       IncomingIndex < BBPhi->getNumIncomingValues(); IncomingIndex++) {
    auto IncomingValue = BBPhi->getIncomingValue(IncomingIndex);
    auto IncomingBB = IncomingValue->getBlock();
    updateReachingDefsOfBB(IncomingBB, BB);
  }
  // auto afterUpdateSize = sizeof(BBReachingDefs);
  // LLVM_DEBUG(dbgs()<<"\n Size of :"<<afterUpdateSize);
  // if (afterUpdateSize != beforeUpdateSize) {
  //  HasConvergedFlagged = false;
  //}
}

/// Keep traversing the reaching definition to this \p MemAccss, until we reach
/// a Phi Node. This is a recursive function, traversing up reaching defs, till
/// we find a MemPhi, or the LiveOnEntry Node.
const MemoryPhi *
MemorySSAUseDefWalker::getParentPhi(const MemoryAccess *MemAccss) {
  if (auto MemPhi = dyn_cast<MemoryPhi>(MemAccss))
    return MemPhi;
  if (MSSA->isLiveOnEntryDef(MemAccss))
    return nullptr;
  return (
      getParentPhi(dyn_cast<MemoryUseOrDef>(MemAccss)->getDefiningAccess()));
}

/// Update the reaching definitions for this \p MemUse. Update the record in
/// "MemUseToReachingDefsMap", which maps every mem use to a set of mem defs.
void MemorySSAUseDefWalker::updateClobberingAccess(const MemoryUse *MemUse) {
  if (MemUse == nullptr)
    return;
  auto DefAccss = MemUse->getDefiningAccess();
  auto BB = DefAccss->getBlock();
  assert(BB != nullptr);
  auto MemDefsInBB = BBGeneratingDefs[BB];
  auto Instr = MemUse->getMemoryInst();
  // Returns the Memory Written to by this instruction.
  auto WrittenMem = LdStToMem.insertLoadStore(Instr);
  // If this memory was defined in BB, then get the last instruction in the BB,
  // that defines this memory, by looking up the Defs generated in the BB.
  // Otherwise, it could be a reaching def, from some previous block, use the
  // phi node to track that. Last case, we give up since we could not find any
  // reaching def for this "WrittenMem".
  if (MemDefsInBB.find(WrittenMem) != MemDefsInBB.end()) {
    // found a write
    auto MemDef = MemDefsInBB[WrittenMem];
    auto DefinedInstr = MemDef->getMemoryInst();
    LdStToMem.insertReachingDef(Instr, DefinedInstr, true);
    // OmpInfo.insertReachingDef(Instr, DefinedInstr, WrittenMem, true);
    // MemUseToReachingDefsMap[MemUse]={MemDef};//single reaching def
    LLVM_DEBUG(dbgs() << "\n Same BB Def Instr :" << *DefinedInstr
                      << "\n Use Instr:" << *Instr);
  } else if (auto MemPhi = getParentPhi(DefAccss)) {
    // Get all the reaching defs at the Phi node, then find out all the
    // instructions that write to the memory "WrittenMem". These are all the
    // definitions that reach this MemUse.
    auto ReachingDefsAtPhi = BBReachingDefs[MemPhi->getBlock()];
    if (ReachingDefsAtPhi.find(WrittenMem) != ReachingDefsAtPhi.end()) {
      auto MemDefSet = ReachingDefsAtPhi[WrittenMem];
      for (auto MemDef : MemDefSet) {
        auto DefinedInstr = MemDef->getMemoryInst();
        LdStToMem.insertReachingDef(Instr, DefinedInstr);
        // MemUseToReachingDefsMap[MemUse].insert(MemDef);
        LLVM_DEBUG(dbgs() << "\n Through PHI Def Instr :" << *DefinedInstr
                          << "\n Use Instr:" << *Instr);
      }
    } else {
      // Our analysis failed to find any reaching def for this Instr.
      LLVM_DEBUG(dbgs() << "\n NO DEF FOUND for :" << *Instr);
      // errs()<<"\n WARNING: No reaching defs found for this use::"<< *Instr;
    }
  }
}

/// Traverse all the memory accesses within the basic block, then add the defs
/// to the Gen set of the block, and record the corresponding the reaching defs
/// for every Mem Use.
void MemorySSAUseDefWalker::updateBasicBlock(const BasicBlock *BB) {
  // auto bb_defs_list = MSSA->getBlockDefs(bb);
  auto MAList = MSSA->getBlockAccesses(BB);
  if (MAList == nullptr)
    return; // no Memory access in this BB;
  for (auto &MA : *MAList) {
    if (auto MemDef = dyn_cast<MemoryDef>(&MA)) {
      LLVM_DEBUG(dbgs() << "\n Memdef:" << *MemDef);
      // TODO: Confirm if this needs to be done on every iteration till
      // convergence, or only once is enough.
      addToGeneratingDefs(MemDef);
    } else if (auto MemUse = dyn_cast<MemoryUse>(&MA)) {
      LLVM_DEBUG(dbgs() << "\n Memuse:" << *MemUse);
      // TODO: optimize by not updating the clobber every iteration, but only
      // after the defs have converged.
      updateClobberingAccess(MemUse);
    }
  }
}
// Entry Point for Reaching definitions data flow analysis. After this function,
// we have a record of all the reaching definitions for every memory use. Do BFS
// traversal of the Basic Blocks starting from the LiveOnEntry Access basic
// block. At the entry of every basic block, perform the following update,
// ReachingDef[BB] = \Union_{P \in Pred(BB)} ((ReachingDef[P] - Kill[P])+Gen[P])
// Then iterate over all the memory uses in the BB, and find all the reaching
// defs that may clobber the memory being read by the memory use. Following 3
// cases can occuer,
// 1. There is a single MemDef for the memory, that occurs in the same basic
// block as the use.
// 2. Among all the reaching defs at the MemPhi, that dominates this MemUse, add
// all MemDefs that clobber the coresponding memory.
// 3. Cannot find any reaching defs, analysis failed.
void MemorySSAUseDefWalker::reachingDefAnalysis() {
  // Get the first memory def of the function
  MemoryAccess *LiveOnEntry = MSSA->getLiveOnEntryDef();
  assert(LiveOnEntry != nullptr &&
         "Memory SSA does Must have LiveOnEntry Definition ");
  const BasicBlock *EntryBlock = LiveOnEntry->getBlock();
  assert(EntryBlock != nullptr && "The entry block cannot be Null ");
  unsigned IterationCount = 0;
  // This do while loop, runs until the analysis converges, that is no new
  // reaching defs are added.
  do {
    LLVM_DEBUG(dbgs() << "\n Analysis Iteration " << ++IterationCount);
    HasConvergedFlagged = true;
    std::set<const BasicBlock *> VisitedBBSet;
    std::queue<const BasicBlock *> BBQueue;
    // Analysis starts from the NetryBlock.
    BBQueue.push(EntryBlock);
    // BFS traversal.
    while (!BBQueue.empty()) {
      auto BB = BBQueue.front();
      BBQueue.pop();
      // Ignore if already visited.
      if (VisitedBBSet.find(BB) != VisitedBBSet.end())
        continue;
      VisitedBBSet.insert(BB);
      LLVM_DEBUG(dbgs() << "\n Basic Block:" << BB);
      // Perform the join operator at the entry of this basicblock.
      reachingDefJoinOp(BB);
      // Now update all the reaching definitions for every memory use in this
      // basic block.
      updateBasicBlock(BB);
      // print();
      for (auto Succ = succ_begin(BB), End = succ_end(BB); Succ != End;
           Succ++) {
        // LLVM_DEBUG(dbgs()<<"\n Enqueue block:"<<*succ);
        BBQueue.push(*Succ);
      }
    }
    LLVM_DEBUG(dbgs() << "\n Printing Def Use Chains after 1 round:\n");
    // for (auto Iter : MemUseToReachingDefsMap){
    //  auto MemUse = Iter.first;
    //  auto MemUseInstr = MemUse->getMemoryInst();
    //  LLVM_DEBUG(dbgs()<<"\n Use :"<<*MemUseInstr
    //      <<"At :"<<OmpDiagnosticsLocationInfo.getDebugLocStr(*MemUseInstr));
    //  for (auto MemDef : Iter.second) {
    //    auto MemDefInstr = MemDef->getMemoryInst();
    //    LLVM_DEBUG(dbgs()<<"\n Def :"<<*MemDefInstr
    //        <<"At
    //        :"<<OmpDiagnosticsLocationInfo.getDebugLocStr(*MemDefInstr));
    //  }
    //}
  } while (!HasConvergedFlagged && IterationCount < 100);
  LLVM_DEBUG(dbgs() << "\n Printing Def Use Chains:\n");
  // for (auto Iter : MemUseToReachingDefsMap){
  //  auto MemUse = Iter.first;
  //  auto UseInstr = MemUse->getMemoryInst();
  //  auto LoadedValue = LdStToMem.getMemoryForLdSt(UseInstr);
  //  if (LdStToMem.isDoublePointer(UseInstr))
  //    continue;
  //  LLVM_DEBUG(dbgs()<<"\n Use :"<<*UseInstr
  //      <<"At :"<<OmpDiagnosticsLocationInfo.getDebugLocStr(*UseInstr)
  //      <<" Loaded Val:"<<*LoadedValue);
  //  for (auto MemDef : Iter.second) {
  //    auto instr = MemDef->getMemoryInst();
  //    LLVM_DEBUG(dbgs()<<"\n Def :"<<*instr
  //        <<"At :"<<OmpDiagnosticsLocationInfo.getDebugLocStr(*instr));
  //  }
  //}
}

void OmpDiagnosticsInfo::insertReachingDef(ConstInstrPtr MemUse,
                                           ConstInstrPtr MemDef,
                                           ConstValuePtr WrittenMem,
                                           bool SingleReachingDef) {
  if (SingleReachingDef)
    MemUseToReachingDefsMap[MemUse] = {MemDef};
  else
    MemUseToReachingDefsMap[MemUse].insert(MemDef);
  MemUseToMemValMap[MemUse] = WrittenMem;
}
void OmpDiagnosticsInfo::print() {
  for (auto Iter : MemUseToReachingDefsMap) {
    auto MemUseInstr = Iter.first;
    LLVM_DEBUG(
        dbgs() << "\n Use :" << *MemUseInstr << "At :"
               << OmpDiagnosticsLocationInfo.getDebugLocStr(*MemUseInstr));
    for (auto MemDefInstr : Iter.second) {
      LLVM_DEBUG(
          dbgs() << "\n Def :" << *MemDefInstr << "At :"
                 << OmpDiagnosticsLocationInfo.getDebugLocStr(*MemDefInstr));
    }
  }
}

void OmpDiagnosticsInfo::print(raw_ostream &O) {
  for (auto Iter : MemUseToReachingDefsMap) {
    auto MemUseInstr = Iter.first;
    O << "\n Use::" << OmpDiagnosticsLocationInfo.getVarNameLocStr(MemUseInstr);
    for (auto MemDefInstr : Iter.second) {
      O << "\n Def :"
        << "At :" << OmpDiagnosticsLocationInfo.getVarNameLocStr(MemDefInstr);
    }
  }
  // for (auto Iter : MemUseToReachingDefsMap){
  //  auto MemUseInstr = Iter.first;
  //  O << "\n Use :"<<*MemUseInstr
  //    <<"At :"<<OmpDiagnosticsLocationInfo.getDebugLocStr(*MemUseInstr);
  //  for (auto MemDefInstr : Iter.second) {
  //    O <<"\n Def :"<<*MemDefInstr
  //      <<"At :"<<OmpDiagnosticsLocationInfo.getDebugLocStr(*MemDefInstr);
  //  }
  //}
}
AnalysisKey MemUseDefLocalAnalysis::Key;

MemUseDefLocalAnalysis::Result
MemUseDefLocalAnalysis::run(Function &F, FunctionAnalysisManager &AM) {
  MemorySSA &MSSA = AM.getResult<MemorySSAAnalysis>(F).getMSSA();
  LLVM_DEBUG(MSSA.dump());
  OmpDiagnosticsLocationInfo.initFunc(F);
  MemoryLdStMapClass LdStToMem;
  MemorySSAUseDefWalker useDefWalker(MSSA, LdStToMem);
  useDefWalker.reachingDefAnalysis();
  return LdStToMem;
}

PreservedAnalyses
MemUseDefLocalAnalysisPrinterPass::run(Function &F,
                                       FunctionAnalysisManager &AM) {
  OS << "\n 'omp diagnostics Local Analysis' for function '" << F.getName()
     << "'\n";
  AM.getResult<MemUseDefLocalAnalysis>(F).print(OS);
  return PreservedAnalyses::all();
}

AnalysisKey MemUseDefGlobalAnalysis::Key;
void MemUseDefGlobalAnalysis::analyzeModule(OmpDiagnosticsInfo &OmpEnvInfo) {
  LLVM_DEBUG(dbgs() << "\n Analysis module:");
  // FunctionAnalysisManager &FAM =
  //    AM.getResult<FunctionAnalysisManagerModuleProxy>(M).getManager();
  for (Function &Func : *ThisModule) {
    if (!Func.hasName() || Func.isIntrinsic() || Func.isDeclaration())
      continue;
    // MemUseDefLocalAnalysis FuncAnalysis(Func, OmpEnvInfo);
    // FuncAnalysis.run();
    LLVM_DEBUG(dbgs() << "\n Function Map::" << Func.getName());
    FuncNameMap[Func.getName()] = &Func;
  }
  OmpEnvInfo.print();
  const std::string MainFuncName = "main";
  if (EXISTSinMap(FuncNameMap, MainFuncName)) {
    // analyzeFunction(*FuncNameMap[MainFuncName], OmpEnvInfo);
  }
}

void MemUseDefGlobalAnalysis::analyzeBasicBlock(
    const BasicBlock &BB, OmpDiagnosticsInfo &OmpEnvInfo) {
  // for (auto &I : BB) {
  //  if (const CallInst *Call = dyn_cast<CallInst>(&I)) {
  //    auto CalledFunc = Call->getCalledFunction();
  //    if (!CalledFunc->hasName())
  //      continue;
  //    // Ignore recursive calls
  //    if (CalledFunc == BB.getParent())
  //      continue;
  //    if (EXISTSinMap(FuncNameMap, CalledFunc->getName()))
  //      analyzeFunction(*CalledFunc, OmpEnvInfo);
  //    OmpEnvInfo.processOmpRTLCall(*Call);
  //  }
  //}
}
void MemUseDefGlobalAnalysis::analyzeFunction(Function &F,
                                              OmpDiagnosticsInfo &OmpEnvInfo) {
  MemorySSA &MSSA = FunctionAM->getResult<MemorySSAAnalysis>(F).getMSSA();
  //&getAnalysis<MemorySSAWrapperPass>(func).getMSSA();
  LLVM_DEBUG(MSSA.dump());
  // MemorySSAUseDefWalker useDefWalker(MSSA);
  // useDefWalker.reachingDefAnalysis();
  // useDefWalker.validateMapClauses(mapClauseHandler, func, ORE);
  // SmallVector<const BasicBlock*, 10> BBVisitQ;
  // std::queue<const BasicBlock *> BBVisitQ;
  // std::set<const BasicBlock *> BBVisitedBBSet;
  // BBVisitQ.push(&F.getEntryBlock());
  // LLVM_DEBUG(dbgs() << "\n AnalyzeFunction : " << F.getName());
  //// Traverse the CFG in BFS
  // while (!BBVisitQ.empty()) {
  //  auto VisitBB = BBVisitQ.front();
  //  BBVisitQ.pop();
  //  if (EXISTSinMap(BBVisitedBBSet, VisitBB))
  //    continue;
  //  BBVisitedBBSet.insert(VisitBB);
  //  for (auto SuccBB = succ_begin(VisitBB); SuccBB != succ_end(VisitBB);
  //       SuccBB++) {
  //    BBVisitQ.push(*SuccBB);
  //  }
  //  analyzeBasicBlock(*VisitBB, OmpEnvInfo);
  //}
}

MemUseDefGlobalAnalysis::Result
MemUseDefGlobalAnalysis::run(Module &M, ModuleAnalysisManager &AM) {
  // OmpDiagnosticsGlobalInfo result;
  ThisModule = &M;
  // FunctionAM =
  // &AnalysisManager->getResult<FunctionAnalysisManagerModuleProxy>(M).getManager();
  AnalysisManager = &AM;
  OmpDiagnosticsInfo OmpEnvInfo; // new OmpDiagnosticsInfo;
  LLVM_DEBUG(dbgs() << "\n Analysis module:");
  analyzeModule(OmpEnvInfo);

  return OmpEnvInfo;
}

PreservedAnalyses
MemUseDefGlobalAnalysisPrinterPass::run(Module &M, ModuleAnalysisManager &AM) {
  OS << "'omp diagnostics Analysis' for module '" << M.getName() << "'\n";
  OmpDiagnosticsInfo Res = AM.getResult<MemUseDefGlobalAnalysis>(M);
  Res.print(OS);
  return PreservedAnalyses::all();
}

// bool OmpDiagnosticsGlobalInfoWrapperPass::runOnModule(Module &M) {
//  //OmpDiagnosticsDataFlowAnalysis SSDFA(
//  //    M, [this](Function &F) -> const OmpDiagnosticsInfo & {
//  //      return getAnalysis<OmpDiagnosticsInfoWrapperPass>(F).getResult();
//  //    });
//  //SSI = SSDFA.run();
////bool OmpDiagnosticsInfoWrapperPass::runOnFunction(Function &F) {
////  MemUseDefLocalAnalysis
/// OMPD(F);//.getResult<ScalarEvolutionAnalysis>(F)); /  OmpEnvInfo =
///&OMPD.run();
//  std::map<std::string, Function *> FuncNameMap;
//  for (Function &Func : M) {
//    if (!Func.hasName() ||
//        Func.isIntrinsic() ||
//        Func.isDeclaration()) continue;
//    FuncNameMap[Func.getName()] = &Func;
//  }
//  if (EXISTSinMap(FuncNameMap, "main")){
//  }
//  return false;
//}

static const char LocalPassArg[] = "omp-diagnostics-local";
static const char LocalPassName[] = "omp diagnostics Local Analysis";
static const char GlobalPassName[] = "omp diagnostics Analysis";
