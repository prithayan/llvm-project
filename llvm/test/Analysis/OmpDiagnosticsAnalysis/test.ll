; RUN: opt < %s -passes='print<omp-diagnostics-local>' -disable-output 2>&1 | FileCheck %s --check-prefixes=NUF,CHECK

; CHECK:  Store   store i32 %0, i32* %arrayidx, align 4, !dbg !26, !tbaa !27 
; CHECK-NEXT: at :: 4
; CHECK-NEXT: Index :   %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
; CHECK-NEXT:  SCEV ::{0,+,1}<nuw><nsw><%for.body>
; CHECK-NEXT:   Max


;int A[100];
;void fun(){
;  for (int i =0 ; i < 100 ; i++){
;    A[i] = i;
;  }
;}

; ModuleID = 'test2.c'
source_filename = "test.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@A = common dso_local local_unnamed_addr global [100 x i32] zeroinitializer, align 16, !dbg !0

; Function Attrs: norecurse nounwind uwtable writeonly
define dso_local void @fun() local_unnamed_addr #0 !dbg !14 {
entry:
  call void @llvm.dbg.value(metadata i32 0, metadata !18, metadata !DIExpression()), !dbg !20
  br label %for.body, !dbg !21

for.cond.cleanup:                                 ; preds = %for.body
  ret void, !dbg !22

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  call void @llvm.dbg.value(metadata i64 %indvars.iv, metadata !18, metadata !DIExpression()), !dbg !20
  %arrayidx = getelementptr inbounds [100 x i32], [100 x i32]* @A, i64 0, i64 %indvars.iv, !dbg !23
  %0 = trunc i64 %indvars.iv to i32, !dbg !26
  store i32 %0, i32* %arrayidx, align 4, !dbg !26, !tbaa !27
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !31
  call void @llvm.dbg.value(metadata i32 undef, metadata !18, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !20
  %exitcond = icmp eq i64 %indvars.iv.next, 100, !dbg !32
  br i1 %exitcond, label %for.cond.cleanup, label %for.body, !dbg !21, !llvm.loop !33
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { norecurse nounwind uwtable writeonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!10, !11, !12}
!llvm.ident = !{!13}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "A", scope: !2, file: !3, line: 1, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 9.0.0 (git@github.com:prithayan/llvm-project.git 9683f06d0ed55984d96f430331d28b1437b7dd07)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, nameTableKind: None)
!3 = !DIFile(filename: "test2.c", directory: "/home/prithayan/openmp/llvm-mainline/llvm-project/llvm/test/Analysis/OmpDiagnosticsAnalysis")
!4 = !{}
!5 = !{!0}
!6 = !DICompositeType(tag: DW_TAG_array_type, baseType: !7, size: 3200, elements: !8)
!7 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!8 = !{!9}
!9 = !DISubrange(count: 100)
!10 = !{i32 2, !"Dwarf Version", i32 4}
!11 = !{i32 2, !"Debug Info Version", i32 3}
!12 = !{i32 1, !"wchar_size", i32 4}
!13 = !{!"clang version 9.0.0 (git@github.com:prithayan/llvm-project.git 9683f06d0ed55984d96f430331d28b1437b7dd07)"}
!14 = distinct !DISubprogram(name: "fun", scope: !3, file: !3, line: 2, type: !15, scopeLine: 2, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !17)
!15 = !DISubroutineType(types: !16)
!16 = !{null}
!17 = !{!18}
!18 = !DILocalVariable(name: "i", scope: !19, file: !3, line: 3, type: !7)
!19 = distinct !DILexicalBlock(scope: !14, file: !3, line: 3, column: 3)
!20 = !DILocation(line: 0, scope: !19)
!21 = !DILocation(line: 3, column: 3, scope: !19)
!22 = !DILocation(line: 6, column: 1, scope: !14)
!23 = !DILocation(line: 4, column: 5, scope: !24)
!24 = distinct !DILexicalBlock(scope: !25, file: !3, line: 3, column: 33)
!25 = distinct !DILexicalBlock(scope: !19, file: !3, line: 3, column: 3)
!26 = !DILocation(line: 4, column: 10, scope: !24)
!27 = !{!28, !28, i64 0}
!28 = !{!"int", !29, i64 0}
!29 = !{!"omnipotent char", !30, i64 0}
!30 = !{!"Simple C/C++ TBAA"}
!31 = !DILocation(line: 3, column: 30, scope: !25)
!32 = !DILocation(line: 3, column: 21, scope: !25)
!33 = distinct !{!33, !21, !34}
!34 = !DILocation(line: 5, column: 3, scope: !19)
