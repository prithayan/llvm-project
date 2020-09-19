; ModuleID = 'DRACC022_OMP_MxV_Missing_Data_yes.c'
source_filename = "DRACC022_OMP_MxV_Missing_Data_yes.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@b = dso_local local_unnamed_addr global i32* null, align 8, !dbg !0
@a = dso_local local_unnamed_addr global i32* null, align 8, !dbg !12
@c = dso_local local_unnamed_addr global i32* null, align 8, !dbg !16
@.str = private unnamed_addr constant [23 x i8] c"Data Race occured: %s\0A\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"true\00", align 1
@.str.2 = private unnamed_addr constant [6 x i8] c"false\00", align 1

; Function Attrs: nofree noinline norecurse nounwind uwtable
define dso_local i32 @init() local_unnamed_addr #0 !dbg !22 {
entry:
  call void @llvm.dbg.value(metadata i32 0, metadata !26, metadata !DIExpression()), !dbg !32
  %0 = load i32*, i32** @b, align 8, !dbg !33, !tbaa !36
  %1 = load i32*, i32** @a, align 8, !dbg !40, !tbaa !36
  %2 = load i32*, i32** @c, align 8, !dbg !40, !tbaa !36
  br label %for.cond1.preheader, !dbg !41

for.cond1.preheader:                              ; preds = %for.cond.cleanup3, %entry
  %indvars.iv23 = phi i64 [ 0, %entry ], [ %indvars.iv.next24, %for.cond.cleanup3 ]
  call void @llvm.dbg.value(metadata i64 %indvars.iv23, metadata !26, metadata !DIExpression()), !dbg !32
  call void @llvm.dbg.value(metadata i32 0, metadata !28, metadata !DIExpression()), !dbg !42
  %3 = mul nuw nsw i64 %indvars.iv23, 5000, !dbg !33
  br label %for.body4, !dbg !43

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3
  ret i32 0, !dbg !44

for.cond.cleanup3:                                ; preds = %for.body4
  %arrayidx6 = getelementptr inbounds i32, i32* %1, i64 %indvars.iv23, !dbg !45
  store i32 1, i32* %arrayidx6, align 4, !dbg !46, !tbaa !47
  %arrayidx8 = getelementptr inbounds i32, i32* %2, i64 %indvars.iv23, !dbg !49
  store i32 0, i32* %arrayidx8, align 4, !dbg !50, !tbaa !47
  %indvars.iv.next24 = add nuw nsw i64 %indvars.iv23, 1, !dbg !51
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next24, metadata !26, metadata !DIExpression()), !dbg !32
  %exitcond26 = icmp eq i64 %indvars.iv.next24, 5000, !dbg !52
  br i1 %exitcond26, label %for.cond.cleanup, label %for.cond1.preheader, !dbg !41, !llvm.loop !53

for.body4:                                        ; preds = %for.body4, %for.cond1.preheader
  %indvars.iv = phi i64 [ 0, %for.cond1.preheader ], [ %indvars.iv.next.4, %for.body4 ]
  call void @llvm.dbg.value(metadata i64 %indvars.iv, metadata !28, metadata !DIExpression()), !dbg !42
  %4 = add nuw nsw i64 %indvars.iv, %3, !dbg !55
  %arrayidx = getelementptr inbounds i32, i32* %0, i64 %4, !dbg !56
  store i32 1, i32* %arrayidx, align 4, !dbg !57, !tbaa !47
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !58
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next, metadata !28, metadata !DIExpression()), !dbg !42
  %5 = add nuw nsw i64 %indvars.iv.next, %3, !dbg !55
  %arrayidx.1 = getelementptr inbounds i32, i32* %0, i64 %5, !dbg !56
  store i32 1, i32* %arrayidx.1, align 4, !dbg !57, !tbaa !47
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv, 2, !dbg !58
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.1, metadata !28, metadata !DIExpression()), !dbg !42
  %6 = add nuw nsw i64 %indvars.iv.next.1, %3, !dbg !55
  %arrayidx.2 = getelementptr inbounds i32, i32* %0, i64 %6, !dbg !56
  store i32 1, i32* %arrayidx.2, align 4, !dbg !57, !tbaa !47
  %indvars.iv.next.2 = add nuw nsw i64 %indvars.iv, 3, !dbg !58
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.2, metadata !28, metadata !DIExpression()), !dbg !42
  %7 = add nuw nsw i64 %indvars.iv.next.2, %3, !dbg !55
  %arrayidx.3 = getelementptr inbounds i32, i32* %0, i64 %7, !dbg !56
  store i32 1, i32* %arrayidx.3, align 4, !dbg !57, !tbaa !47
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv, 4, !dbg !58
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.3, metadata !28, metadata !DIExpression()), !dbg !42
  %8 = add nuw nsw i64 %indvars.iv.next.3, %3, !dbg !55
  %arrayidx.4 = getelementptr inbounds i32, i32* %0, i64 %8, !dbg !56
  store i32 1, i32* %arrayidx.4, align 4, !dbg !57, !tbaa !47
  %indvars.iv.next.4 = add nuw nsw i64 %indvars.iv, 5, !dbg !58
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.4, metadata !28, metadata !DIExpression()), !dbg !42
  %exitcond.4 = icmp eq i64 %indvars.iv.next.4, 5000, !dbg !59
  br i1 %exitcond.4, label %for.cond.cleanup3, label %for.body4, !dbg !43, !llvm.loop !60
}

; Function Attrs: nofree noinline norecurse nounwind uwtable
define dso_local i32 @Mult() local_unnamed_addr #0 !dbg !62 {
entry:
  call void @llvm.dbg.value(metadata i32 0, metadata !68, metadata !DIExpression()), !dbg !75
  %0 = load i32*, i32** @b, align 8, !dbg !76, !tbaa !36
  %1 = load i32*, i32** @a, align 8, !dbg !76, !tbaa !36
  %2 = load i32*, i32** @c, align 8, !dbg !76, !tbaa !36
  br label %for.cond1.preheader, !dbg !79

for.cond1.preheader:                              ; preds = %for.cond.cleanup3, %entry
  %indvars.iv26 = phi i64 [ 0, %entry ], [ %indvars.iv.next27, %for.cond.cleanup3 ]
  call void @llvm.dbg.value(metadata i64 %indvars.iv26, metadata !68, metadata !DIExpression()), !dbg !75
  call void @llvm.dbg.value(metadata i32 0, metadata !71, metadata !DIExpression()), !dbg !80
  %3 = mul nuw nsw i64 %indvars.iv26, 5000, !dbg !76
  %arrayidx9 = getelementptr inbounds i32, i32* %2, i64 %indvars.iv26, !dbg !76
  %.pre = load i32, i32* %arrayidx9, align 4, !dbg !81, !tbaa !47
  br label %for.body4, !dbg !82

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3
  ret i32 0, !dbg !83

for.cond.cleanup3:                                ; preds = %for.body4
  %indvars.iv.next27 = add nuw nsw i64 %indvars.iv26, 1, !dbg !84
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next27, metadata !68, metadata !DIExpression()), !dbg !75
  %exitcond29 = icmp eq i64 %indvars.iv.next27, 5000, !dbg !85
  br i1 %exitcond29, label %for.cond.cleanup, label %for.cond1.preheader, !dbg !79, !llvm.loop !86

for.body4:                                        ; preds = %for.body4, %for.cond1.preheader
  %4 = phi i32 [ %.pre, %for.cond1.preheader ], [ %add10.1, %for.body4 ], !dbg !81
  %indvars.iv = phi i64 [ 0, %for.cond1.preheader ], [ %indvars.iv.next.1, %for.body4 ]
  call void @llvm.dbg.value(metadata i64 %indvars.iv, metadata !71, metadata !DIExpression()), !dbg !80
  %5 = add nuw nsw i64 %indvars.iv, %3, !dbg !88
  %arrayidx = getelementptr inbounds i32, i32* %0, i64 %5, !dbg !89
  %6 = load i32, i32* %arrayidx, align 4, !dbg !89, !tbaa !47
  %arrayidx6 = getelementptr inbounds i32, i32* %1, i64 %indvars.iv, !dbg !90
  %7 = load i32, i32* %arrayidx6, align 4, !dbg !90, !tbaa !47
  %mul7 = mul nsw i32 %7, %6, !dbg !91
  %add10 = add nsw i32 %4, %mul7, !dbg !81
  store i32 %add10, i32* %arrayidx9, align 4, !dbg !81, !tbaa !47
  %indvars.iv.next = or i64 %indvars.iv, 1, !dbg !92
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next, metadata !71, metadata !DIExpression()), !dbg !80
  %8 = add nuw nsw i64 %indvars.iv.next, %3, !dbg !88
  %arrayidx.1 = getelementptr inbounds i32, i32* %0, i64 %8, !dbg !89
  %9 = load i32, i32* %arrayidx.1, align 4, !dbg !89, !tbaa !47
  %arrayidx6.1 = getelementptr inbounds i32, i32* %1, i64 %indvars.iv.next, !dbg !90
  %10 = load i32, i32* %arrayidx6.1, align 4, !dbg !90, !tbaa !47
  %mul7.1 = mul nsw i32 %10, %9, !dbg !91
  %add10.1 = add nsw i32 %add10, %mul7.1, !dbg !81
  store i32 %add10.1, i32* %arrayidx9, align 4, !dbg !81, !tbaa !47
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv, 2, !dbg !92
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.1, metadata !71, metadata !DIExpression()), !dbg !80
  %exitcond.1 = icmp eq i64 %indvars.iv.next.1, 5000, !dbg !93
  br i1 %exitcond.1, label %for.cond.cleanup3, label %for.body4, !dbg !82, !llvm.loop !94
}

; Function Attrs: nofree noinline nounwind uwtable
define dso_local i32 @check() local_unnamed_addr #1 !dbg !96 {
entry:
  call void @llvm.dbg.value(metadata i8 0, metadata !98, metadata !DIExpression()), !dbg !102
  call void @llvm.dbg.value(metadata i32 0, metadata !100, metadata !DIExpression()), !dbg !103
  %0 = load i32*, i32** @c, align 8, !dbg !104, !tbaa !36
  br label %for.body, !dbg !108

for.cond.cleanup:                                 ; preds = %for.body
  call void @llvm.dbg.value(metadata i8 %spec.select.4, metadata !98, metadata !DIExpression()), !dbg !102
  %1 = and i8 %spec.select.4, 1, !dbg !109
  %tobool = icmp eq i8 %1, 0, !dbg !109
  %cond = select i1 %tobool, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i64 0, i64 0), !dbg !109
  %call = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i64 0, i64 0), i8* %cond), !dbg !110
  ret i32 0, !dbg !111

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next.4, %for.body ]
  %test.05 = phi i8 [ 0, %entry ], [ %spec.select.4, %for.body ]
  call void @llvm.dbg.value(metadata i64 %indvars.iv, metadata !100, metadata !DIExpression()), !dbg !103
  call void @llvm.dbg.value(metadata i8 %test.05, metadata !98, metadata !DIExpression()), !dbg !102
  %arrayidx = getelementptr inbounds i32, i32* %0, i64 %indvars.iv, !dbg !112
  %2 = load i32, i32* %arrayidx, align 4, !dbg !112, !tbaa !47
  %cmp1 = icmp eq i32 %2, 5000, !dbg !113
  call void @llvm.dbg.value(metadata i8 undef, metadata !98, metadata !DIExpression()), !dbg !102
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !114
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next, metadata !100, metadata !DIExpression()), !dbg !103
  %arrayidx.1 = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next, !dbg !112
  %3 = load i32, i32* %arrayidx.1, align 4, !dbg !112, !tbaa !47
  %cmp1.1 = icmp eq i32 %3, 5000, !dbg !113
  %4 = and i1 %cmp1.1, %cmp1, !dbg !115
  call void @llvm.dbg.value(metadata i8 undef, metadata !98, metadata !DIExpression()), !dbg !102
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv, 2, !dbg !114
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.1, metadata !100, metadata !DIExpression()), !dbg !103
  %arrayidx.2 = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next.1, !dbg !112
  %5 = load i32, i32* %arrayidx.2, align 4, !dbg !112, !tbaa !47
  %cmp1.2 = icmp eq i32 %5, 5000, !dbg !113
  %6 = and i1 %cmp1.2, %4, !dbg !115
  call void @llvm.dbg.value(metadata i8 undef, metadata !98, metadata !DIExpression()), !dbg !102
  %indvars.iv.next.2 = add nuw nsw i64 %indvars.iv, 3, !dbg !114
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.2, metadata !100, metadata !DIExpression()), !dbg !103
  %arrayidx.3 = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next.2, !dbg !112
  %7 = load i32, i32* %arrayidx.3, align 4, !dbg !112, !tbaa !47
  %cmp1.3 = icmp eq i32 %7, 5000, !dbg !113
  %8 = and i1 %cmp1.3, %6, !dbg !115
  call void @llvm.dbg.value(metadata i8 undef, metadata !98, metadata !DIExpression()), !dbg !102
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv, 4, !dbg !114
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.3, metadata !100, metadata !DIExpression()), !dbg !103
  %arrayidx.4 = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next.3, !dbg !112
  %9 = load i32, i32* %arrayidx.4, align 4, !dbg !112, !tbaa !47
  %cmp1.4 = icmp eq i32 %9, 5000, !dbg !113
  %10 = and i1 %cmp1.4, %8, !dbg !115
  %spec.select.4 = select i1 %10, i8 %test.05, i8 1, !dbg !115
  call void @llvm.dbg.value(metadata i8 %spec.select.4, metadata !98, metadata !DIExpression()), !dbg !102
  %indvars.iv.next.4 = add nuw nsw i64 %indvars.iv, 5, !dbg !114
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.4, metadata !100, metadata !DIExpression()), !dbg !103
  %exitcond.4 = icmp eq i64 %indvars.iv.next.4, 5000, !dbg !116
  br i1 %exitcond.4, label %for.cond.cleanup, label %for.body, !dbg !108, !llvm.loop !117
}

; Function Attrs: nofree nounwind
declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #2

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #3 !dbg !119 {
entry:
  %call = tail call noalias dereferenceable_or_null(20000) i8* @malloc(i64 20000) #6, !dbg !120
  store i8* %call, i8** bitcast (i32** @a to i8**), align 8, !dbg !121, !tbaa !36
  %call1 = tail call noalias dereferenceable_or_null(100000000) i8* @malloc(i64 100000000) #6, !dbg !122
  store i8* %call1, i8** bitcast (i32** @b to i8**), align 8, !dbg !123, !tbaa !36
  %call2 = tail call noalias dereferenceable_or_null(20000) i8* @malloc(i64 20000) #6, !dbg !124
  store i8* %call2, i8** bitcast (i32** @c to i8**), align 8, !dbg !125, !tbaa !36
  %call3 = tail call i32 @init(), !dbg !126
  %call4 = tail call i32 @Mult(), !dbg !127
  %call5 = tail call i32 @check(), !dbg !128
  %0 = load i8*, i8** bitcast (i32** @a to i8**), align 8, !dbg !129, !tbaa !36
  tail call void @free(i8* %0) #6, !dbg !130
  %1 = load i8*, i8** bitcast (i32** @b to i8**), align 8, !dbg !131, !tbaa !36
  tail call void @free(i8* %1) #6, !dbg !132
  %2 = load i8*, i8** bitcast (i32** @c to i8**), align 8, !dbg !133, !tbaa !36
  tail call void @free(i8* %2) #6, !dbg !134
  ret i32 0, !dbg !135
}

; Function Attrs: nofree nounwind
declare dso_local noalias i8* @malloc(i64) local_unnamed_addr #2

; Function Attrs: nounwind
declare !dbg !6 dso_local void @free(i8* nocapture) local_unnamed_addr #4

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #5

attributes #0 = { nofree noinline norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nofree nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readnone speculatable willreturn }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!18, !19, !20}
!llvm.ident = !{!21}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "b", scope: !2, file: !3, line: 11, type: !14, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 11.0.0 (https://github.com/prithayan/llvm-project.git 8fd35f88270ed30453c9ed4bbf8c49488858805d)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !11, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "DRACC022_OMP_MxV_Missing_Data_yes.c", directory: "/home/prithayan/work/Openmp/src/llvm-project/llvm/test/Analysis/OmpDiagnosticsAnalysis")
!4 = !{}
!5 = !{!6}
!6 = !DISubprogram(name: "free", scope: !7, file: !7, line: 563, type: !8, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !4)
!7 = !DIFile(filename: "/usr/include/stdlib.h", directory: "")
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!11 = !{!12, !0, !16}
!12 = !DIGlobalVariableExpression(var: !13, expr: !DIExpression())
!13 = distinct !DIGlobalVariable(name: "a", scope: !2, file: !3, line: 10, type: !14, isLocal: false, isDefinition: true)
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !DIGlobalVariableExpression(var: !17, expr: !DIExpression())
!17 = distinct !DIGlobalVariable(name: "c", scope: !2, file: !3, line: 12, type: !14, isLocal: false, isDefinition: true)
!18 = !{i32 7, !"Dwarf Version", i32 4}
!19 = !{i32 2, !"Debug Info Version", i32 3}
!20 = !{i32 1, !"wchar_size", i32 4}
!21 = !{!"clang version 11.0.0 (https://github.com/prithayan/llvm-project.git 8fd35f88270ed30453c9ed4bbf8c49488858805d)"}
!22 = distinct !DISubprogram(name: "init", scope: !3, file: !3, line: 15, type: !23, scopeLine: 15, flags: DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !25)
!23 = !DISubroutineType(types: !24)
!24 = !{!15}
!25 = !{!26, !28}
!26 = !DILocalVariable(name: "i", scope: !27, file: !3, line: 16, type: !15)
!27 = distinct !DILexicalBlock(scope: !22, file: !3, line: 16, column: 5)
!28 = !DILocalVariable(name: "j", scope: !29, file: !3, line: 17, type: !15)
!29 = distinct !DILexicalBlock(scope: !30, file: !3, line: 17, column: 9)
!30 = distinct !DILexicalBlock(scope: !31, file: !3, line: 16, column: 27)
!31 = distinct !DILexicalBlock(scope: !27, file: !3, line: 16, column: 5)
!32 = !DILocation(line: 0, scope: !27)
!33 = !DILocation(line: 0, scope: !34)
!34 = distinct !DILexicalBlock(scope: !35, file: !3, line: 17, column: 31)
!35 = distinct !DILexicalBlock(scope: !29, file: !3, line: 17, column: 9)
!36 = !{!37, !37, i64 0}
!37 = !{!"any pointer", !38, i64 0}
!38 = !{!"omnipotent char", !39, i64 0}
!39 = !{!"Simple C/C++ TBAA"}
!40 = !DILocation(line: 0, scope: !30)
!41 = !DILocation(line: 16, column: 5, scope: !27)
!42 = !DILocation(line: 0, scope: !29)
!43 = !DILocation(line: 17, column: 9, scope: !29)
!44 = !DILocation(line: 23, column: 9, scope: !22)
!45 = !DILocation(line: 20, column: 9, scope: !30)
!46 = !DILocation(line: 20, column: 13, scope: !30)
!47 = !{!48, !48, i64 0}
!48 = !{!"int", !38, i64 0}
!49 = !DILocation(line: 21, column: 9, scope: !30)
!50 = !DILocation(line: 21, column: 13, scope: !30)
!51 = !DILocation(line: 16, column: 24, scope: !31)
!52 = !DILocation(line: 16, column: 19, scope: !31)
!53 = distinct !{!53, !41, !54}
!54 = !DILocation(line: 22, column: 5, scope: !27)
!55 = !DILocation(line: 18, column: 16, scope: !34)
!56 = !DILocation(line: 18, column: 13, scope: !34)
!57 = !DILocation(line: 18, column: 21, scope: !34)
!58 = !DILocation(line: 17, column: 28, scope: !35)
!59 = !DILocation(line: 17, column: 23, scope: !35)
!60 = distinct !{!60, !43, !61}
!61 = !DILocation(line: 19, column: 9, scope: !29)
!62 = distinct !DISubprogram(name: "Mult", scope: !3, file: !3, line: 27, type: !23, scopeLine: 27, flags: DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !63)
!63 = !{!64, !68, !71}
!64 = !DILocalVariable(name: "z", scope: !62, file: !3, line: 28, type: !65)
!65 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 32000, elements: !66)
!66 = !{!67, !67, !67}
!67 = !DISubrange(count: 10)
!68 = !DILocalVariable(name: "i", scope: !69, file: !3, line: 33, type: !15)
!69 = distinct !DILexicalBlock(scope: !70, file: !3, line: 33, column: 9)
!70 = distinct !DILexicalBlock(scope: !62, file: !3, line: 31, column: 5)
!71 = !DILocalVariable(name: "j", scope: !72, file: !3, line: 34, type: !15)
!72 = distinct !DILexicalBlock(scope: !73, file: !3, line: 34, column: 13)
!73 = distinct !DILexicalBlock(scope: !74, file: !3, line: 33, column: 31)
!74 = distinct !DILexicalBlock(scope: !69, file: !3, line: 33, column: 9)
!75 = !DILocation(line: 0, scope: !69)
!76 = !DILocation(line: 0, scope: !77)
!77 = distinct !DILexicalBlock(scope: !78, file: !3, line: 34, column: 35)
!78 = distinct !DILexicalBlock(scope: !72, file: !3, line: 34, column: 13)
!79 = !DILocation(line: 33, column: 9, scope: !69)
!80 = !DILocation(line: 0, scope: !72)
!81 = !DILocation(line: 35, column: 21, scope: !77)
!82 = !DILocation(line: 34, column: 13, scope: !72)
!83 = !DILocation(line: 40, column: 5, scope: !62)
!84 = !DILocation(line: 33, column: 28, scope: !74)
!85 = !DILocation(line: 33, column: 23, scope: !74)
!86 = distinct !{!86, !79, !87}
!87 = !DILocation(line: 37, column: 9, scope: !69)
!88 = !DILocation(line: 35, column: 26, scope: !77)
!89 = !DILocation(line: 35, column: 23, scope: !77)
!90 = !DILocation(line: 35, column: 32, scope: !77)
!91 = !DILocation(line: 35, column: 31, scope: !77)
!92 = !DILocation(line: 34, column: 32, scope: !78)
!93 = !DILocation(line: 34, column: 27, scope: !78)
!94 = distinct !{!94, !82, !95}
!95 = !DILocation(line: 36, column: 13, scope: !72)
!96 = distinct !DISubprogram(name: "check", scope: !3, file: !3, line: 43, type: !23, scopeLine: 43, flags: DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !97)
!97 = !{!98, !100}
!98 = !DILocalVariable(name: "test", scope: !96, file: !3, line: 44, type: !99)
!99 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!100 = !DILocalVariable(name: "i", scope: !101, file: !3, line: 45, type: !15)
!101 = distinct !DILexicalBlock(scope: !96, file: !3, line: 45, column: 5)
!102 = !DILocation(line: 0, scope: !96)
!103 = !DILocation(line: 0, scope: !101)
!104 = !DILocation(line: 0, scope: !105)
!105 = distinct !DILexicalBlock(scope: !106, file: !3, line: 46, column: 12)
!106 = distinct !DILexicalBlock(scope: !107, file: !3, line: 45, column: 27)
!107 = distinct !DILexicalBlock(scope: !101, file: !3, line: 45, column: 5)
!108 = !DILocation(line: 45, column: 5, scope: !101)
!109 = !DILocation(line: 50, column: 38, scope: !96)
!110 = !DILocation(line: 50, column: 5, scope: !96)
!111 = !DILocation(line: 51, column: 5, scope: !96)
!112 = !DILocation(line: 46, column: 12, scope: !105)
!113 = !DILocation(line: 46, column: 16, scope: !105)
!114 = !DILocation(line: 45, column: 24, scope: !107)
!115 = !DILocation(line: 46, column: 12, scope: !106)
!116 = !DILocation(line: 45, column: 19, scope: !107)
!117 = distinct !{!117, !108, !118}
!118 = !DILocation(line: 49, column: 5, scope: !101)
!119 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 57, type: !23, scopeLine: 57, flags: DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !4)
!120 = !DILocation(line: 58, column: 9, scope: !119)
!121 = !DILocation(line: 58, column: 7, scope: !119)
!122 = !DILocation(line: 59, column: 9, scope: !119)
!123 = !DILocation(line: 59, column: 7, scope: !119)
!124 = !DILocation(line: 60, column: 9, scope: !119)
!125 = !DILocation(line: 60, column: 7, scope: !119)
!126 = !DILocation(line: 61, column: 5, scope: !119)
!127 = !DILocation(line: 62, column: 5, scope: !119)
!128 = !DILocation(line: 63, column: 5, scope: !119)
!129 = !DILocation(line: 64, column: 10, scope: !119)
!130 = !DILocation(line: 64, column: 5, scope: !119)
!131 = !DILocation(line: 65, column: 10, scope: !119)
!132 = !DILocation(line: 65, column: 5, scope: !119)
!133 = !DILocation(line: 66, column: 10, scope: !119)
!134 = !DILocation(line: 66, column: 5, scope: !119)
!135 = !DILocation(line: 67, column: 5, scope: !119)
