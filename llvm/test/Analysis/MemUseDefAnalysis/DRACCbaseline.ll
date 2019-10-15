; RUN: opt < %s -passes="print-mem-usedef-analysis"  -disable-output 2>&1 | FileCheck %s 
; CHECK-DAG: Use::b At:: DRACC022_OMP_MxV_Missing_Data_yes.c:35 Defined at: DRACC022_OMP_MxV_Missing_Data_yes.c:18, DRACC022_OMP_MxV_Missing_Data_yes.c:59, 
; CHECK-DAG: Use::a At:: DRACC022_OMP_MxV_Missing_Data_yes.c:35 Defined at: DRACC022_OMP_MxV_Missing_Data_yes.c:20, DRACC022_OMP_MxV_Missing_Data_yes.c:58, 
; CHECK-DAG: Use::c At:: DRACC022_OMP_MxV_Missing_Data_yes.c:35 Defined at: DRACC022_OMP_MxV_Missing_Data_yes.c:21, DRACC022_OMP_MxV_Missing_Data_yes.c:35, DRACC022_OMP_MxV_Missing_Data_yes.c:60, 
; CHECK-DAG: Use::c At:: DRACC022_OMP_MxV_Missing_Data_yes.c:46 Defined at: DRACC022_OMP_MxV_Missing_Data_yes.c:21, DRACC022_OMP_MxV_Missing_Data_yes.c:35, DRACC022_OMP_MxV_Missing_Data_yes.c:60, 

; ModuleID = 'baseline.ll'
source_filename = "DRACC022_OMP_MxV_Missing_Data_yes.c"
target datalayout = "e-m:e-i64:64-n32:64"
target triple = "powerpc64le-unknown-linux-gnu"

@b = common dso_local global i32* null, align 8, !dbg !0
@a = common dso_local global i32* null, align 8, !dbg !6
@c = common dso_local global i32* null, align 8, !dbg !10
@.str = private unnamed_addr constant [23 x i8] c"Data Race occured: %s\0A\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"true\00", align 1
@.str.2 = private unnamed_addr constant [6 x i8] c"false\00", align 1

; Function Attrs: nounwind
define dso_local signext i32 @init() #0 !dbg !16 {
entry:
  call void @llvm.dbg.value(metadata i32 0, metadata !20, metadata !DIExpression()), !dbg !26
  br label %for.cond, !dbg !27

for.cond:                                         ; preds = %for.inc9, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc10, %for.inc9 ], !dbg !26
  call void @llvm.dbg.value(metadata i32 %i.0, metadata !20, metadata !DIExpression()), !dbg !26
  %cmp = icmp slt i32 %i.0, 5000, !dbg !28
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !dbg !29

for.cond.cleanup:                                 ; preds = %for.cond
  br label %for.end11

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.value(metadata i32 0, metadata !22, metadata !DIExpression()), !dbg !30
  br label %for.cond1, !dbg !31

for.cond1:                                        ; preds = %for.inc, %for.body
  %j.0 = phi i32 [ 0, %for.body ], [ %inc, %for.inc ], !dbg !30
  call void @llvm.dbg.value(metadata i32 %j.0, metadata !22, metadata !DIExpression()), !dbg !30
  %cmp2 = icmp slt i32 %j.0, 5000, !dbg !32
  br i1 %cmp2, label %for.body4, label %for.cond.cleanup3, !dbg !34

for.cond.cleanup3:                                ; preds = %for.cond1
  br label %for.end

for.body4:                                        ; preds = %for.cond1
  %0 = load i32*, i32** @b, align 8, !dbg !35, !tbaa !37
  %mul = mul nsw i32 %i.0, 5000, !dbg !41
  %add = add nsw i32 %j.0, %mul, !dbg !42
  %idxprom = sext i32 %add to i64, !dbg !35
  %arrayidx = getelementptr inbounds i32, i32* %0, i64 %idxprom, !dbg !35
  store i32 1, i32* %arrayidx, align 4, !dbg !43, !tbaa !44
  br label %for.inc, !dbg !46

for.inc:                                          ; preds = %for.body4
  %inc = add nsw i32 %j.0, 1, !dbg !47
  call void @llvm.dbg.value(metadata i32 %inc, metadata !22, metadata !DIExpression()), !dbg !30
  br label %for.cond1, !dbg !48, !llvm.loop !49

for.end:                                          ; preds = %for.cond.cleanup3
  %1 = load i32*, i32** @a, align 8, !dbg !51, !tbaa !37
  %idxprom5 = sext i32 %i.0 to i64, !dbg !51
  %arrayidx6 = getelementptr inbounds i32, i32* %1, i64 %idxprom5, !dbg !51
  store i32 1, i32* %arrayidx6, align 4, !dbg !52, !tbaa !44
  %2 = load i32*, i32** @c, align 8, !dbg !53, !tbaa !37
  %idxprom7 = sext i32 %i.0 to i64, !dbg !53
  %arrayidx8 = getelementptr inbounds i32, i32* %2, i64 %idxprom7, !dbg !53
  store i32 0, i32* %arrayidx8, align 4, !dbg !54, !tbaa !44
  br label %for.inc9, !dbg !55

for.inc9:                                         ; preds = %for.end
  %inc10 = add nsw i32 %i.0, 1, !dbg !56
  call void @llvm.dbg.value(metadata i32 %inc10, metadata !20, metadata !DIExpression()), !dbg !26
  br label %for.cond, !dbg !57, !llvm.loop !58

for.end11:                                        ; preds = %for.cond.cleanup
  ret i32 0, !dbg !60
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind
define dso_local signext i32 @Mult() #0 !dbg !61 {
entry:
  call void @llvm.dbg.declare(metadata !4, metadata !63, metadata !DIExpression()), !dbg !74
  call void @llvm.dbg.value(metadata i32 0, metadata !67, metadata !DIExpression()), !dbg !75
  br label %for.cond, !dbg !76

for.cond:                                         ; preds = %for.inc11, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc12, %for.inc11 ], !dbg !75
  call void @llvm.dbg.value(metadata i32 %i.0, metadata !67, metadata !DIExpression()), !dbg !75
  %cmp = icmp slt i32 %i.0, 5000, !dbg !77
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !dbg !78

for.cond.cleanup:                                 ; preds = %for.cond
  br label %for.end13

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.value(metadata i32 0, metadata !70, metadata !DIExpression()), !dbg !79
  br label %for.cond1, !dbg !80

for.cond1:                                        ; preds = %for.inc, %for.body
  %j.0 = phi i32 [ 0, %for.body ], [ %inc, %for.inc ], !dbg !79
  call void @llvm.dbg.value(metadata i32 %j.0, metadata !70, metadata !DIExpression()), !dbg !79
  %cmp2 = icmp slt i32 %j.0, 5000, !dbg !81
  br i1 %cmp2, label %for.body4, label %for.cond.cleanup3, !dbg !83

for.cond.cleanup3:                                ; preds = %for.cond1
  br label %for.end

for.body4:                                        ; preds = %for.cond1
  %0 = load i32*, i32** @b, align 8, !dbg !84, !tbaa !37
  %mul = mul nsw i32 %i.0, 5000, !dbg !86
  %add = add nsw i32 %j.0, %mul, !dbg !87
  %idxprom = sext i32 %add to i64, !dbg !84
  %arrayidx = getelementptr inbounds i32, i32* %0, i64 %idxprom, !dbg !84
  %1 = load i32, i32* %arrayidx, align 4, !dbg !84, !tbaa !44
  %2 = load i32*, i32** @a, align 8, !dbg !88, !tbaa !37
  %idxprom5 = sext i32 %j.0 to i64, !dbg !88
  %arrayidx6 = getelementptr inbounds i32, i32* %2, i64 %idxprom5, !dbg !88
  %3 = load i32, i32* %arrayidx6, align 4, !dbg !88, !tbaa !44
  %mul7 = mul nsw i32 %1, %3, !dbg !89
  %4 = load i32*, i32** @c, align 8, !dbg !90, !tbaa !37
  %idxprom8 = sext i32 %i.0 to i64, !dbg !90
  %arrayidx9 = getelementptr inbounds i32, i32* %4, i64 %idxprom8, !dbg !90
  %5 = load i32, i32* %arrayidx9, align 4, !dbg !91, !tbaa !44
  %add10 = add nsw i32 %5, %mul7, !dbg !91
  store i32 %add10, i32* %arrayidx9, align 4, !dbg !91, !tbaa !44
  br label %for.inc, !dbg !92

for.inc:                                          ; preds = %for.body4
  %inc = add nsw i32 %j.0, 1, !dbg !93
  call void @llvm.dbg.value(metadata i32 %inc, metadata !70, metadata !DIExpression()), !dbg !79
  br label %for.cond1, !dbg !94, !llvm.loop !95

for.end:                                          ; preds = %for.cond.cleanup3
  br label %for.inc11, !dbg !97

for.inc11:                                        ; preds = %for.end
  %inc12 = add nsw i32 %i.0, 1, !dbg !98
  call void @llvm.dbg.value(metadata i32 %inc12, metadata !67, metadata !DIExpression()), !dbg !75
  br label %for.cond, !dbg !99, !llvm.loop !100

for.end13:                                        ; preds = %for.cond.cleanup
  ret i32 0, !dbg !102
}

; Function Attrs: nounwind
define dso_local signext i32 @check() #0 !dbg !103 {
entry:
  call void @llvm.dbg.value(metadata i8 0, metadata !105, metadata !DIExpression()), !dbg !109
  call void @llvm.dbg.value(metadata i32 0, metadata !107, metadata !DIExpression()), !dbg !110
  br label %for.cond, !dbg !111

for.cond:                                         ; preds = %for.inc, %entry
  %test.0 = phi i8 [ 0, %entry ], [ %test.1, %for.inc ], !dbg !109
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ], !dbg !110
  call void @llvm.dbg.value(metadata i32 %i.0, metadata !107, metadata !DIExpression()), !dbg !110
  call void @llvm.dbg.value(metadata i8 %test.0, metadata !105, metadata !DIExpression()), !dbg !109
  %cmp = icmp slt i32 %i.0, 5000, !dbg !112
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !dbg !114

for.cond.cleanup:                                 ; preds = %for.cond
  br label %for.end

for.body:                                         ; preds = %for.cond
  %0 = load i32*, i32** @c, align 8, !dbg !115, !tbaa !37
  %idxprom = sext i32 %i.0 to i64, !dbg !115
  %arrayidx = getelementptr inbounds i32, i32* %0, i64 %idxprom, !dbg !115
  %1 = load i32, i32* %arrayidx, align 4, !dbg !115, !tbaa !44
  %cmp1 = icmp ne i32 %1, 5000, !dbg !118
  br i1 %cmp1, label %if.then, label %if.end, !dbg !119

if.then:                                          ; preds = %for.body
  call void @llvm.dbg.value(metadata i8 1, metadata !105, metadata !DIExpression()), !dbg !109
  br label %if.end, !dbg !120

if.end:                                           ; preds = %if.then, %for.body
  %test.1 = phi i8 [ 1, %if.then ], [ %test.0, %for.body ], !dbg !109
  call void @llvm.dbg.value(metadata i8 %test.1, metadata !105, metadata !DIExpression()), !dbg !109
  br label %for.inc, !dbg !122

for.inc:                                          ; preds = %if.end
  %inc = add nsw i32 %i.0, 1, !dbg !123
  call void @llvm.dbg.value(metadata i32 %inc, metadata !107, metadata !DIExpression()), !dbg !110
  br label %for.cond, !dbg !124, !llvm.loop !125

for.end:                                          ; preds = %for.cond.cleanup
  %tobool = trunc i8 %test.0 to i1, !dbg !127
  %2 = zext i1 %tobool to i64, !dbg !127
  %cond = select i1 %tobool, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), !dbg !127
  %call = call signext i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i64 0, i64 0), i8* %cond), !dbg !128
  ret i32 0, !dbg !129
}

declare signext i32 @printf(i8*, ...) #3

; Function Attrs: nounwind
define dso_local signext i32 @main() #0 !dbg !130 {
entry:
  %call = call noalias i8* @malloc(i64 20000) #5, !dbg !131
  %0 = bitcast i8* %call to i32*, !dbg !131
  store i32* %0, i32** @a, align 8, !dbg !132, !tbaa !37
  %call1 = call noalias i8* @malloc(i64 100000000) #5, !dbg !133
  %1 = bitcast i8* %call1 to i32*, !dbg !133
  store i32* %1, i32** @b, align 8, !dbg !134, !tbaa !37
  %call2 = call noalias i8* @malloc(i64 20000) #5, !dbg !135
  %2 = bitcast i8* %call2 to i32*, !dbg !135
  store i32* %2, i32** @c, align 8, !dbg !136, !tbaa !37
  %call3 = call signext i32 @init(), !dbg !137
  %call4 = call signext i32 @Mult(), !dbg !138
  %call5 = call signext i32 @check(), !dbg !139
  %3 = load i32*, i32** @a, align 8, !dbg !140, !tbaa !37
  %4 = bitcast i32* %3 to i8*, !dbg !140
  call void @free(i8* %4) #5, !dbg !141
  %5 = load i32*, i32** @b, align 8, !dbg !142, !tbaa !37
  %6 = bitcast i32* %5 to i8*, !dbg !142
  call void @free(i8* %6) #5, !dbg !143
  %7 = load i32*, i32** @c, align 8, !dbg !144, !tbaa !37
  %8 = bitcast i32* %7 to i8*, !dbg !144
  call void @free(i8* %8) #5, !dbg !145
  ret i32 0, !dbg !146
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #4

; Function Attrs: nounwind
declare void @free(i8*) #4

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="ppc64le" "target-features"="+altivec,+bpermd,+crypto,+direct-move,+extdiv,+htm,+power8-vector,+vsx,-power9-vector,-qpx" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind readnone speculatable }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="ppc64le" "target-features"="+altivec,+bpermd,+crypto,+direct-move,+extdiv,+htm,+power8-vector,+vsx,-power9-vector,-qpx" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="ppc64le" "target-features"="+altivec,+bpermd,+crypto,+direct-move,+extdiv,+htm,+power8-vector,+vsx,-power9-vector,-qpx" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!12, !13, !14}
!llvm.ident = !{!15}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "b", scope: !2, file: !3, line: 11, type: !8, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 9.0.0 (/nethome/pbarua3/work/openmp/llvm-project/clang 37ba1fa5c93b8ac2742c9a93afcf67c7b894b2db)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, nameTableKind: None)
!3 = !DIFile(filename: "DRACC022_OMP_MxV_Missing_Data_yes.c", directory: "/nethome/pbarua3/work/openmp/llvm-project/llvm/test/Analysis/MemUseDefAnalysis")
!4 = !{}
!5 = !{!6, !0, !10}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "a", scope: !2, file: !3, line: 10, type: !8, isLocal: false, isDefinition: true)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DIGlobalVariableExpression(var: !11, expr: !DIExpression())
!11 = distinct !DIGlobalVariable(name: "c", scope: !2, file: !3, line: 12, type: !8, isLocal: false, isDefinition: true)
!12 = !{i32 2, !"Dwarf Version", i32 4}
!13 = !{i32 2, !"Debug Info Version", i32 3}
!14 = !{i32 1, !"wchar_size", i32 4}
!15 = !{!"clang version 9.0.0 (/nethome/pbarua3/work/openmp/llvm-project/clang 37ba1fa5c93b8ac2742c9a93afcf67c7b894b2db)"}
!16 = distinct !DISubprogram(name: "init", scope: !3, file: !3, line: 15, type: !17, scopeLine: 15, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !19)
!17 = !DISubroutineType(types: !18)
!18 = !{!9}
!19 = !{!20, !22}
!20 = !DILocalVariable(name: "i", scope: !21, file: !3, line: 16, type: !9)
!21 = distinct !DILexicalBlock(scope: !16, file: !3, line: 16, column: 5)
!22 = !DILocalVariable(name: "j", scope: !23, file: !3, line: 17, type: !9)
!23 = distinct !DILexicalBlock(scope: !24, file: !3, line: 17, column: 9)
!24 = distinct !DILexicalBlock(scope: !25, file: !3, line: 16, column: 27)
!25 = distinct !DILexicalBlock(scope: !21, file: !3, line: 16, column: 5)
!26 = !DILocation(line: 0, scope: !21)
!27 = !DILocation(line: 16, column: 9, scope: !21)
!28 = !DILocation(line: 16, column: 19, scope: !25)
!29 = !DILocation(line: 16, column: 5, scope: !21)
!30 = !DILocation(line: 0, scope: !23)
!31 = !DILocation(line: 17, column: 13, scope: !23)
!32 = !DILocation(line: 17, column: 23, scope: !33)
!33 = distinct !DILexicalBlock(scope: !23, file: !3, line: 17, column: 9)
!34 = !DILocation(line: 17, column: 9, scope: !23)
!35 = !DILocation(line: 18, column: 13, scope: !36)
!36 = distinct !DILexicalBlock(scope: !33, file: !3, line: 17, column: 31)
!37 = !{!38, !38, i64 0}
!38 = !{!"any pointer", !39, i64 0}
!39 = !{!"omnipotent char", !40, i64 0}
!40 = !{!"Simple C/C++ TBAA"}
!41 = !DILocation(line: 18, column: 18, scope: !36)
!42 = !DILocation(line: 18, column: 16, scope: !36)
!43 = !DILocation(line: 18, column: 21, scope: !36)
!44 = !{!45, !45, i64 0}
!45 = !{!"int", !39, i64 0}
!46 = !DILocation(line: 19, column: 9, scope: !36)
!47 = !DILocation(line: 17, column: 28, scope: !33)
!48 = !DILocation(line: 17, column: 9, scope: !33)
!49 = distinct !{!49, !34, !50}
!50 = !DILocation(line: 19, column: 9, scope: !23)
!51 = !DILocation(line: 20, column: 9, scope: !24)
!52 = !DILocation(line: 20, column: 13, scope: !24)
!53 = !DILocation(line: 21, column: 9, scope: !24)
!54 = !DILocation(line: 21, column: 13, scope: !24)
!55 = !DILocation(line: 22, column: 5, scope: !24)
!56 = !DILocation(line: 16, column: 24, scope: !25)
!57 = !DILocation(line: 16, column: 5, scope: !25)
!58 = distinct !{!58, !29, !59}
!59 = !DILocation(line: 22, column: 5, scope: !21)
!60 = !DILocation(line: 23, column: 9, scope: !16)
!61 = distinct !DISubprogram(name: "Mult", scope: !3, file: !3, line: 27, type: !17, scopeLine: 27, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !62)
!62 = !{!63, !67, !70}
!63 = !DILocalVariable(name: "z", scope: !61, file: !3, line: 28, type: !64)
!64 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 32000, elements: !65)
!65 = !{!66, !66, !66}
!66 = !DISubrange(count: 10)
!67 = !DILocalVariable(name: "i", scope: !68, file: !3, line: 33, type: !9)
!68 = distinct !DILexicalBlock(scope: !69, file: !3, line: 33, column: 9)
!69 = distinct !DILexicalBlock(scope: !61, file: !3, line: 31, column: 5)
!70 = !DILocalVariable(name: "j", scope: !71, file: !3, line: 34, type: !9)
!71 = distinct !DILexicalBlock(scope: !72, file: !3, line: 34, column: 13)
!72 = distinct !DILexicalBlock(scope: !73, file: !3, line: 33, column: 31)
!73 = distinct !DILexicalBlock(scope: !68, file: !3, line: 33, column: 9)
!74 = !DILocation(line: 28, column: 7, scope: !61)
!75 = !DILocation(line: 0, scope: !68)
!76 = !DILocation(line: 33, column: 13, scope: !68)
!77 = !DILocation(line: 33, column: 23, scope: !73)
!78 = !DILocation(line: 33, column: 9, scope: !68)
!79 = !DILocation(line: 0, scope: !71)
!80 = !DILocation(line: 34, column: 17, scope: !71)
!81 = !DILocation(line: 34, column: 27, scope: !82)
!82 = distinct !DILexicalBlock(scope: !71, file: !3, line: 34, column: 13)
!83 = !DILocation(line: 34, column: 13, scope: !71)
!84 = !DILocation(line: 35, column: 23, scope: !85)
!85 = distinct !DILexicalBlock(scope: !82, file: !3, line: 34, column: 35)
!86 = !DILocation(line: 35, column: 28, scope: !85)
!87 = !DILocation(line: 35, column: 26, scope: !85)
!88 = !DILocation(line: 35, column: 32, scope: !85)
!89 = !DILocation(line: 35, column: 31, scope: !85)
!90 = !DILocation(line: 35, column: 17, scope: !85)
!91 = !DILocation(line: 35, column: 21, scope: !85)
!92 = !DILocation(line: 36, column: 13, scope: !85)
!93 = !DILocation(line: 34, column: 32, scope: !82)
!94 = !DILocation(line: 34, column: 13, scope: !82)
!95 = distinct !{!95, !83, !96}
!96 = !DILocation(line: 36, column: 13, scope: !71)
!97 = !DILocation(line: 37, column: 9, scope: !72)
!98 = !DILocation(line: 33, column: 28, scope: !73)
!99 = !DILocation(line: 33, column: 9, scope: !73)
!100 = distinct !{!100, !78, !101}
!101 = !DILocation(line: 37, column: 9, scope: !68)
!102 = !DILocation(line: 40, column: 5, scope: !61)
!103 = distinct !DISubprogram(name: "check", scope: !3, file: !3, line: 43, type: !17, scopeLine: 43, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !104)
!104 = !{!105, !107}
!105 = !DILocalVariable(name: "test", scope: !103, file: !3, line: 44, type: !106)
!106 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!107 = !DILocalVariable(name: "i", scope: !108, file: !3, line: 45, type: !9)
!108 = distinct !DILexicalBlock(scope: !103, file: !3, line: 45, column: 5)
!109 = !DILocation(line: 0, scope: !103)
!110 = !DILocation(line: 0, scope: !108)
!111 = !DILocation(line: 45, column: 9, scope: !108)
!112 = !DILocation(line: 45, column: 19, scope: !113)
!113 = distinct !DILexicalBlock(scope: !108, file: !3, line: 45, column: 5)
!114 = !DILocation(line: 45, column: 5, scope: !108)
!115 = !DILocation(line: 46, column: 12, scope: !116)
!116 = distinct !DILexicalBlock(scope: !117, file: !3, line: 46, column: 12)
!117 = distinct !DILexicalBlock(scope: !113, file: !3, line: 45, column: 27)
!118 = !DILocation(line: 46, column: 16, scope: !116)
!119 = !DILocation(line: 46, column: 12, scope: !117)
!120 = !DILocation(line: 48, column: 9, scope: !121)
!121 = distinct !DILexicalBlock(scope: !116, file: !3, line: 46, column: 20)
!122 = !DILocation(line: 49, column: 5, scope: !117)
!123 = !DILocation(line: 45, column: 24, scope: !113)
!124 = !DILocation(line: 45, column: 5, scope: !113)
!125 = distinct !{!125, !114, !126}
!126 = !DILocation(line: 49, column: 5, scope: !108)
!127 = !DILocation(line: 50, column: 38, scope: !103)
!128 = !DILocation(line: 50, column: 5, scope: !103)
!129 = !DILocation(line: 51, column: 5, scope: !103)
!130 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 57, type: !17, scopeLine: 57, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !4)
!131 = !DILocation(line: 58, column: 9, scope: !130)
!132 = !DILocation(line: 58, column: 7, scope: !130)
!133 = !DILocation(line: 59, column: 9, scope: !130)
!134 = !DILocation(line: 59, column: 7, scope: !130)
!135 = !DILocation(line: 60, column: 9, scope: !130)
!136 = !DILocation(line: 60, column: 7, scope: !130)
!137 = !DILocation(line: 61, column: 5, scope: !130)
!138 = !DILocation(line: 62, column: 5, scope: !130)
!139 = !DILocation(line: 63, column: 5, scope: !130)
!140 = !DILocation(line: 64, column: 10, scope: !130)
!141 = !DILocation(line: 64, column: 5, scope: !130)
!142 = !DILocation(line: 65, column: 10, scope: !130)
!143 = !DILocation(line: 65, column: 5, scope: !130)
!144 = !DILocation(line: 66, column: 10, scope: !130)
!145 = !DILocation(line: 66, column: 5, scope: !130)
!146 = !DILocation(line: 67, column: 5, scope: !130)
