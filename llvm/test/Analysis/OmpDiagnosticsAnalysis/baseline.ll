; ModuleID = '/home/prithayan/work/Openmp/test/OpenMP-Benchmakrs/lechen/OpenMP/DRACC022_OMP_MxV_Missing_Data_yes.c'
source_filename = "/home/prithayan/work/Openmp/test/OpenMP-Benchmakrs/lechen/OpenMP/DRACC022_OMP_MxV_Missing_Data_yes.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@b = dso_local local_unnamed_addr global i32* null, align 8, !dbg !0
@a = dso_local local_unnamed_addr global i32* null, align 8, !dbg !12
@c = dso_local local_unnamed_addr global i32* null, align 8, !dbg !17
@.str = private unnamed_addr constant [23 x i8] c"Data Race occured: %s\0A\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"true\00", align 1
@.str.2 = private unnamed_addr constant [6 x i8] c"false\00", align 1

; Function Attrs: nofree norecurse nounwind uwtable
define dso_local i32 @init() local_unnamed_addr #0 !dbg !23 {
entry:
  call void @llvm.dbg.value(metadata i32 0, metadata !27, metadata !DIExpression()), !dbg !33
  %0 = load i32*, i32** @b, align 8, !dbg !34, !tbaa !37
  %1 = load i32*, i32** @a, align 8, !dbg !41, !tbaa !37
  %2 = load i32*, i32** @c, align 8, !dbg !41, !tbaa !37
  br label %for.cond1.preheader, !dbg !42

for.cond1.preheader:                              ; preds = %for.cond.cleanup3, %entry
  %indvars.iv23 = phi i64 [ 0, %entry ], [ %indvars.iv.next24, %for.cond.cleanup3 ]
  call void @llvm.dbg.value(metadata i64 %indvars.iv23, metadata !27, metadata !DIExpression()), !dbg !33
  call void @llvm.dbg.value(metadata i32 0, metadata !29, metadata !DIExpression()), !dbg !43
  %3 = mul nuw nsw i64 %indvars.iv23, 5000, !dbg !34
  br label %vector.body, !dbg !44

vector.body:                                      ; preds = %vector.body, %for.cond1.preheader
  %index = phi i64 [ 0, %for.cond1.preheader ], [ %index.next.4, %vector.body ], !dbg !45
  %4 = add nuw nsw i64 %index, %3, !dbg !46
  %5 = getelementptr inbounds i32, i32* %0, i64 %4, !dbg !47
  %6 = bitcast i32* %5 to <4 x i32>*, !dbg !48
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %6, align 4, !dbg !48, !tbaa !49
  %7 = getelementptr inbounds i32, i32* %5, i64 4, !dbg !48
  %8 = bitcast i32* %7 to <4 x i32>*, !dbg !48
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %8, align 4, !dbg !48, !tbaa !49
  %index.next = add nuw nsw i64 %index, 8, !dbg !45
  %9 = add nuw nsw i64 %index.next, %3, !dbg !46
  %10 = getelementptr inbounds i32, i32* %0, i64 %9, !dbg !47
  %11 = bitcast i32* %10 to <4 x i32>*, !dbg !48
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %11, align 4, !dbg !48, !tbaa !49
  %12 = getelementptr inbounds i32, i32* %10, i64 4, !dbg !48
  %13 = bitcast i32* %12 to <4 x i32>*, !dbg !48
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %13, align 4, !dbg !48, !tbaa !49
  %index.next.1 = add nuw nsw i64 %index, 16, !dbg !45
  %14 = add nuw nsw i64 %index.next.1, %3, !dbg !46
  %15 = getelementptr inbounds i32, i32* %0, i64 %14, !dbg !47
  %16 = bitcast i32* %15 to <4 x i32>*, !dbg !48
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %16, align 4, !dbg !48, !tbaa !49
  %17 = getelementptr inbounds i32, i32* %15, i64 4, !dbg !48
  %18 = bitcast i32* %17 to <4 x i32>*, !dbg !48
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %18, align 4, !dbg !48, !tbaa !49
  %index.next.2 = add nuw nsw i64 %index, 24, !dbg !45
  %19 = add nuw nsw i64 %index.next.2, %3, !dbg !46
  %20 = getelementptr inbounds i32, i32* %0, i64 %19, !dbg !47
  %21 = bitcast i32* %20 to <4 x i32>*, !dbg !48
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %21, align 4, !dbg !48, !tbaa !49
  %22 = getelementptr inbounds i32, i32* %20, i64 4, !dbg !48
  %23 = bitcast i32* %22 to <4 x i32>*, !dbg !48
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %23, align 4, !dbg !48, !tbaa !49
  %index.next.3 = add nuw nsw i64 %index, 32, !dbg !45
  %24 = add nuw nsw i64 %index.next.3, %3, !dbg !46
  %25 = getelementptr inbounds i32, i32* %0, i64 %24, !dbg !47
  %26 = bitcast i32* %25 to <4 x i32>*, !dbg !48
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %26, align 4, !dbg !48, !tbaa !49
  %27 = getelementptr inbounds i32, i32* %25, i64 4, !dbg !48
  %28 = bitcast i32* %27 to <4 x i32>*, !dbg !48
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %28, align 4, !dbg !48, !tbaa !49
  %index.next.4 = add nuw nsw i64 %index, 40, !dbg !45
  %29 = icmp eq i64 %index.next.4, 5000, !dbg !45
  br i1 %29, label %for.cond.cleanup3, label %vector.body, !dbg !45, !llvm.loop !51

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3
  ret i32 0, !dbg !54

for.cond.cleanup3:                                ; preds = %vector.body
  %arrayidx6 = getelementptr inbounds i32, i32* %1, i64 %indvars.iv23, !dbg !55
  store i32 1, i32* %arrayidx6, align 4, !dbg !56, !tbaa !49
  %arrayidx8 = getelementptr inbounds i32, i32* %2, i64 %indvars.iv23, !dbg !57
  store i32 0, i32* %arrayidx8, align 4, !dbg !58, !tbaa !49
  %indvars.iv.next24 = add nuw nsw i64 %indvars.iv23, 1, !dbg !59
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next24, metadata !27, metadata !DIExpression()), !dbg !33
  %exitcond26 = icmp eq i64 %indvars.iv.next24, 5000, !dbg !60
  br i1 %exitcond26, label %for.cond.cleanup, label %for.cond1.preheader, !dbg !42, !llvm.loop !61
}

; Function Attrs: nofree norecurse nounwind uwtable
define dso_local i32 @Mult() local_unnamed_addr #0 !dbg !63 {
entry:
  call void @llvm.dbg.value(metadata i32 0, metadata !69, metadata !DIExpression()), !dbg !76
  %0 = load i32*, i32** @b, align 8, !dbg !77, !tbaa !37
  %1 = load i32*, i32** @a, align 8, !dbg !77, !tbaa !37
  %2 = load i32*, i32** @c, align 8, !dbg !77, !tbaa !37
  br label %for.cond1.preheader, !dbg !80

for.cond1.preheader:                              ; preds = %for.cond.cleanup3, %entry
  %indvars.iv26 = phi i64 [ 0, %entry ], [ %indvars.iv.next27, %for.cond.cleanup3 ]
  call void @llvm.dbg.value(metadata i64 %indvars.iv26, metadata !69, metadata !DIExpression()), !dbg !76
  call void @llvm.dbg.value(metadata i32 0, metadata !72, metadata !DIExpression()), !dbg !81
  %3 = mul nuw nsw i64 %indvars.iv26, 5000, !dbg !77
  %arrayidx9 = getelementptr inbounds i32, i32* %2, i64 %indvars.iv26, !dbg !77
  %.pre = load i32, i32* %arrayidx9, align 4, !dbg !82, !tbaa !49
  br label %for.body4, !dbg !83

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3
  ret i32 0, !dbg !84

for.cond.cleanup3:                                ; preds = %for.body4
  %indvars.iv.next27 = add nuw nsw i64 %indvars.iv26, 1, !dbg !85
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next27, metadata !69, metadata !DIExpression()), !dbg !76
  %exitcond29 = icmp eq i64 %indvars.iv.next27, 5000, !dbg !86
  br i1 %exitcond29, label %for.cond.cleanup, label %for.cond1.preheader, !dbg !80, !llvm.loop !87

for.body4:                                        ; preds = %for.body4, %for.cond1.preheader
  %4 = phi i32 [ %.pre, %for.cond1.preheader ], [ %add10.1, %for.body4 ], !dbg !82
  %indvars.iv = phi i64 [ 0, %for.cond1.preheader ], [ %indvars.iv.next.1, %for.body4 ]
  call void @llvm.dbg.value(metadata i64 %indvars.iv, metadata !72, metadata !DIExpression()), !dbg !81
  %5 = add nuw nsw i64 %indvars.iv, %3, !dbg !89
  %arrayidx = getelementptr inbounds i32, i32* %0, i64 %5, !dbg !90
  %6 = load i32, i32* %arrayidx, align 4, !dbg !90, !tbaa !49
  %arrayidx6 = getelementptr inbounds i32, i32* %1, i64 %indvars.iv, !dbg !91
  %7 = load i32, i32* %arrayidx6, align 4, !dbg !91, !tbaa !49
  %mul7 = mul nsw i32 %7, %6, !dbg !92
  %add10 = add nsw i32 %4, %mul7, !dbg !82
  store i32 %add10, i32* %arrayidx9, align 4, !dbg !82, !tbaa !49
  %indvars.iv.next = or i64 %indvars.iv, 1, !dbg !93
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next, metadata !72, metadata !DIExpression()), !dbg !81
  %8 = add nuw nsw i64 %indvars.iv.next, %3, !dbg !89
  %arrayidx.1 = getelementptr inbounds i32, i32* %0, i64 %8, !dbg !90
  %9 = load i32, i32* %arrayidx.1, align 4, !dbg !90, !tbaa !49
  %arrayidx6.1 = getelementptr inbounds i32, i32* %1, i64 %indvars.iv.next, !dbg !91
  %10 = load i32, i32* %arrayidx6.1, align 4, !dbg !91, !tbaa !49
  %mul7.1 = mul nsw i32 %10, %9, !dbg !92
  %add10.1 = add nsw i32 %add10, %mul7.1, !dbg !82
  store i32 %add10.1, i32* %arrayidx9, align 4, !dbg !82, !tbaa !49
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv, 2, !dbg !93
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.1, metadata !72, metadata !DIExpression()), !dbg !81
  %exitcond.1 = icmp eq i64 %indvars.iv.next.1, 5000, !dbg !94
  br i1 %exitcond.1, label %for.cond.cleanup3, label %for.body4, !dbg !83, !llvm.loop !95
}

; Function Attrs: nofree nounwind uwtable
define dso_local i32 @check() local_unnamed_addr #1 !dbg !97 {
entry:
  call void @llvm.dbg.value(metadata i8 0, metadata !99, metadata !DIExpression()), !dbg !103
  call void @llvm.dbg.value(metadata i32 0, metadata !101, metadata !DIExpression()), !dbg !104
  %0 = load i32*, i32** @c, align 8, !dbg !105, !tbaa !37
  br label %for.body, !dbg !109

for.cond.cleanup:                                 ; preds = %for.body
  call void @llvm.dbg.value(metadata i8 %spec.select.4, metadata !99, metadata !DIExpression()), !dbg !103
  %1 = and i8 %spec.select.4, 1, !dbg !110
  %tobool = icmp eq i8 %1, 0, !dbg !110
  %cond = select i1 %tobool, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i64 0, i64 0), !dbg !110
  %call = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i64 0, i64 0), i8* %cond), !dbg !111
  ret i32 0, !dbg !112

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next.4, %for.body ]
  %test.05 = phi i8 [ 0, %entry ], [ %spec.select.4, %for.body ]
  call void @llvm.dbg.value(metadata i64 %indvars.iv, metadata !101, metadata !DIExpression()), !dbg !104
  call void @llvm.dbg.value(metadata i8 %test.05, metadata !99, metadata !DIExpression()), !dbg !103
  %arrayidx = getelementptr inbounds i32, i32* %0, i64 %indvars.iv, !dbg !113
  %2 = load i32, i32* %arrayidx, align 4, !dbg !113, !tbaa !49
  %cmp1 = icmp eq i32 %2, 5000, !dbg !114
  call void @llvm.dbg.value(metadata i8 undef, metadata !99, metadata !DIExpression()), !dbg !103
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !115
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next, metadata !101, metadata !DIExpression()), !dbg !104
  %arrayidx.1 = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next, !dbg !113
  %3 = load i32, i32* %arrayidx.1, align 4, !dbg !113, !tbaa !49
  %cmp1.1 = icmp eq i32 %3, 5000, !dbg !114
  %4 = and i1 %cmp1.1, %cmp1, !dbg !116
  call void @llvm.dbg.value(metadata i8 undef, metadata !99, metadata !DIExpression()), !dbg !103
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv, 2, !dbg !115
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.1, metadata !101, metadata !DIExpression()), !dbg !104
  %arrayidx.2 = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next.1, !dbg !113
  %5 = load i32, i32* %arrayidx.2, align 4, !dbg !113, !tbaa !49
  %cmp1.2 = icmp eq i32 %5, 5000, !dbg !114
  %6 = and i1 %cmp1.2, %4, !dbg !116
  call void @llvm.dbg.value(metadata i8 undef, metadata !99, metadata !DIExpression()), !dbg !103
  %indvars.iv.next.2 = add nuw nsw i64 %indvars.iv, 3, !dbg !115
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.2, metadata !101, metadata !DIExpression()), !dbg !104
  %arrayidx.3 = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next.2, !dbg !113
  %7 = load i32, i32* %arrayidx.3, align 4, !dbg !113, !tbaa !49
  %cmp1.3 = icmp eq i32 %7, 5000, !dbg !114
  %8 = and i1 %cmp1.3, %6, !dbg !116
  call void @llvm.dbg.value(metadata i8 undef, metadata !99, metadata !DIExpression()), !dbg !103
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv, 4, !dbg !115
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.3, metadata !101, metadata !DIExpression()), !dbg !104
  %arrayidx.4 = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next.3, !dbg !113
  %9 = load i32, i32* %arrayidx.4, align 4, !dbg !113, !tbaa !49
  %cmp1.4 = icmp eq i32 %9, 5000, !dbg !114
  %10 = and i1 %cmp1.4, %8, !dbg !116
  %spec.select.4 = select i1 %10, i8 %test.05, i8 1, !dbg !116
  call void @llvm.dbg.value(metadata i8 %spec.select.4, metadata !99, metadata !DIExpression()), !dbg !103
  %indvars.iv.next.4 = add nuw nsw i64 %indvars.iv, 5, !dbg !115
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.4, metadata !101, metadata !DIExpression()), !dbg !104
  %exitcond.4 = icmp eq i64 %indvars.iv.next.4, 5000, !dbg !117
  br i1 %exitcond.4, label %for.cond.cleanup, label %for.body, !dbg !109, !llvm.loop !118
}

; Function Attrs: nofree nounwind
declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #2

; Function Attrs: nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #3 !dbg !120 {
entry:
  %call = tail call noalias dereferenceable_or_null(20000) i8* @malloc(i64 20000) #7, !dbg !121
  store i8* %call, i8** bitcast (i32** @a to i8**), align 8, !dbg !122, !tbaa !37
  %call1 = tail call noalias dereferenceable_or_null(100000000) i8* @malloc(i64 100000000) #7, !dbg !123
  store i8* %call1, i8** bitcast (i32** @b to i8**), align 8, !dbg !124, !tbaa !37
  %call2 = tail call noalias dereferenceable_or_null(20000) i8* @malloc(i64 20000) #7, !dbg !125
  store i8* %call2, i8** bitcast (i32** @c to i8**), align 8, !dbg !126, !tbaa !37
  call void @llvm.dbg.value(metadata i32 0, metadata !27, metadata !DIExpression()), !dbg !127
  %.cast = bitcast i8* %call1 to i32*, !dbg !129
  %.cast18 = bitcast i8* %call to i32*, !dbg !130
  %.cast19 = bitcast i8* %call2 to i32*, !dbg !130
  call void @llvm.memset.p0i8.i64(i8* nonnull align 4 dereferenceable(20000) %call2, i8 0, i64 20000, i1 false), !dbg !131
  br label %for.cond1.preheader.i, !dbg !132

for.cond1.preheader.i:                            ; preds = %for.cond.cleanup3.i, %entry
  %indvars.iv23.i = phi i64 [ 0, %entry ], [ %indvars.iv.next24.i, %for.cond.cleanup3.i ]
  call void @llvm.dbg.value(metadata i64 %indvars.iv23.i, metadata !27, metadata !DIExpression()), !dbg !127
  call void @llvm.dbg.value(metadata i32 0, metadata !29, metadata !DIExpression()), !dbg !133
  %0 = mul nuw nsw i64 %indvars.iv23.i, 5000, !dbg !129
  br label %vector.body, !dbg !134

vector.body:                                      ; preds = %vector.body, %for.cond1.preheader.i
  %index = phi i64 [ 0, %for.cond1.preheader.i ], [ %index.next.4, %vector.body ], !dbg !135
  %1 = add nuw nsw i64 %index, %0, !dbg !136
  %2 = getelementptr inbounds i32, i32* %.cast, i64 %1, !dbg !137
  %3 = bitcast i32* %2 to <4 x i32>*, !dbg !138
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %3, align 4, !dbg !138, !tbaa !49
  %4 = getelementptr inbounds i32, i32* %2, i64 4, !dbg !138
  %5 = bitcast i32* %4 to <4 x i32>*, !dbg !138
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %5, align 4, !dbg !138, !tbaa !49
  %index.next = add nuw nsw i64 %index, 8, !dbg !135
  %6 = add nuw nsw i64 %index.next, %0, !dbg !136
  %7 = getelementptr inbounds i32, i32* %.cast, i64 %6, !dbg !137
  %8 = bitcast i32* %7 to <4 x i32>*, !dbg !138
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %8, align 4, !dbg !138, !tbaa !49
  %9 = getelementptr inbounds i32, i32* %7, i64 4, !dbg !138
  %10 = bitcast i32* %9 to <4 x i32>*, !dbg !138
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %10, align 4, !dbg !138, !tbaa !49
  %index.next.1 = add nuw nsw i64 %index, 16, !dbg !135
  %11 = add nuw nsw i64 %index.next.1, %0, !dbg !136
  %12 = getelementptr inbounds i32, i32* %.cast, i64 %11, !dbg !137
  %13 = bitcast i32* %12 to <4 x i32>*, !dbg !138
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %13, align 4, !dbg !138, !tbaa !49
  %14 = getelementptr inbounds i32, i32* %12, i64 4, !dbg !138
  %15 = bitcast i32* %14 to <4 x i32>*, !dbg !138
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %15, align 4, !dbg !138, !tbaa !49
  %index.next.2 = add nuw nsw i64 %index, 24, !dbg !135
  %16 = add nuw nsw i64 %index.next.2, %0, !dbg !136
  %17 = getelementptr inbounds i32, i32* %.cast, i64 %16, !dbg !137
  %18 = bitcast i32* %17 to <4 x i32>*, !dbg !138
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %18, align 4, !dbg !138, !tbaa !49
  %19 = getelementptr inbounds i32, i32* %17, i64 4, !dbg !138
  %20 = bitcast i32* %19 to <4 x i32>*, !dbg !138
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %20, align 4, !dbg !138, !tbaa !49
  %index.next.3 = add nuw nsw i64 %index, 32, !dbg !135
  %21 = add nuw nsw i64 %index.next.3, %0, !dbg !136
  %22 = getelementptr inbounds i32, i32* %.cast, i64 %21, !dbg !137
  %23 = bitcast i32* %22 to <4 x i32>*, !dbg !138
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %23, align 4, !dbg !138, !tbaa !49
  %24 = getelementptr inbounds i32, i32* %22, i64 4, !dbg !138
  %25 = bitcast i32* %24 to <4 x i32>*, !dbg !138
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %25, align 4, !dbg !138, !tbaa !49
  %index.next.4 = add nuw nsw i64 %index, 40, !dbg !135
  %26 = icmp eq i64 %index.next.4, 5000, !dbg !135
  br i1 %26, label %for.cond.cleanup3.i, label %vector.body, !dbg !135, !llvm.loop !139

for.cond.cleanup3.i:                              ; preds = %vector.body
  %arrayidx6.i = getelementptr inbounds i32, i32* %.cast18, i64 %indvars.iv23.i, !dbg !141
  store i32 1, i32* %arrayidx6.i, align 4, !dbg !142, !tbaa !49
  %indvars.iv.next24.i = add nuw nsw i64 %indvars.iv23.i, 1, !dbg !143
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next24.i, metadata !27, metadata !DIExpression()), !dbg !127
  %exitcond26.i = icmp eq i64 %indvars.iv.next24.i, 5000, !dbg !144
  br i1 %exitcond26.i, label %for.cond1.preheader.i10, label %for.cond1.preheader.i, !dbg !132, !llvm.loop !145

for.cond1.preheader.i10:                          ; preds = %for.cond.cleanup3.i, %for.cond.cleanup3.i11.for.cond1.preheader.i10_crit_edge
  %.pre.i = phi i32 [ %.pre.i.pre, %for.cond.cleanup3.i11.for.cond1.preheader.i10_crit_edge ], [ 0, %for.cond.cleanup3.i ], !dbg !147
  %indvars.iv26.i = phi i64 [ %indvars.iv.next27.i, %for.cond.cleanup3.i11.for.cond1.preheader.i10_crit_edge ], [ 0, %for.cond.cleanup3.i ]
  call void @llvm.dbg.value(metadata i64 %indvars.iv26.i, metadata !69, metadata !DIExpression()), !dbg !149
  call void @llvm.dbg.value(metadata i32 0, metadata !72, metadata !DIExpression()), !dbg !150
  %27 = mul nuw nsw i64 %indvars.iv26.i, 5000, !dbg !151
  %arrayidx9.i = getelementptr inbounds i32, i32* %.cast19, i64 %indvars.iv26.i, !dbg !151
  %28 = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %.pre.i, i32 0, !dbg !152
  br label %vector.body23, !dbg !152

vector.body23:                                    ; preds = %vector.body23.1, %for.cond1.preheader.i10
  %index25 = phi i64 [ 0, %for.cond1.preheader.i10 ], [ %index.next26.1, %vector.body23.1 ], !dbg !153
  %vec.phi = phi <4 x i32> [ %28, %for.cond1.preheader.i10 ], [ %68, %vector.body23.1 ]
  %vec.phi29 = phi <4 x i32> [ zeroinitializer, %for.cond1.preheader.i10 ], [ %69, %vector.body23.1 ]
  %29 = add nuw nsw i64 %index25, %27, !dbg !154
  %30 = getelementptr inbounds i32, i32* %.cast, i64 %29, !dbg !155
  %31 = bitcast i32* %30 to <4 x i32>*, !dbg !155
  %wide.load = load <4 x i32>, <4 x i32>* %31, align 4, !dbg !155, !tbaa !49
  %32 = getelementptr inbounds i32, i32* %30, i64 4, !dbg !155
  %33 = bitcast i32* %32 to <4 x i32>*, !dbg !155
  %wide.load30 = load <4 x i32>, <4 x i32>* %33, align 4, !dbg !155, !tbaa !49
  %34 = getelementptr inbounds i32, i32* %.cast18, i64 %index25, !dbg !156
  %35 = bitcast i32* %34 to <4 x i32>*, !dbg !156
  %wide.load31 = load <4 x i32>, <4 x i32>* %35, align 4, !dbg !156, !tbaa !49
  %36 = getelementptr inbounds i32, i32* %34, i64 4, !dbg !156
  %37 = bitcast i32* %36 to <4 x i32>*, !dbg !156
  %wide.load32 = load <4 x i32>, <4 x i32>* %37, align 4, !dbg !156, !tbaa !49
  %38 = mul nsw <4 x i32> %wide.load31, %wide.load, !dbg !157
  %39 = mul nsw <4 x i32> %wide.load32, %wide.load30, !dbg !157
  %40 = add <4 x i32> %38, %vec.phi, !dbg !147
  %41 = add <4 x i32> %39, %vec.phi29, !dbg !147
  %index.next26 = or i64 %index25, 8, !dbg !153
  %42 = icmp eq i64 %index.next26, 5000, !dbg !153
  br i1 %42, label %middle.block21, label %vector.body23.1, !dbg !153, !llvm.loop !158

middle.block21:                                   ; preds = %vector.body23
  %bin.rdx = add <4 x i32> %41, %40, !dbg !152
  %rdx.shuf = shufflevector <4 x i32> %bin.rdx, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>, !dbg !152
  %bin.rdx33 = add <4 x i32> %bin.rdx, %rdx.shuf, !dbg !152
  %rdx.shuf34 = shufflevector <4 x i32> %bin.rdx33, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>, !dbg !152
  %bin.rdx35 = add <4 x i32> %bin.rdx33, %rdx.shuf34, !dbg !152
  %43 = extractelement <4 x i32> %bin.rdx35, i32 0, !dbg !152
  store i32 %43, i32* %arrayidx9.i, align 4, !dbg !147, !tbaa !49
  %indvars.iv.next27.i = add nuw nsw i64 %indvars.iv26.i, 1, !dbg !160
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next27.i, metadata !69, metadata !DIExpression()), !dbg !149
  %exitcond29.i = icmp eq i64 %indvars.iv.next27.i, 5000, !dbg !161
  br i1 %exitcond29.i, label %for.body.i, label %for.cond.cleanup3.i11.for.cond1.preheader.i10_crit_edge, !dbg !162, !llvm.loop !163

for.cond.cleanup3.i11.for.cond1.preheader.i10_crit_edge: ; preds = %middle.block21
  %arrayidx9.i.phi.trans.insert = getelementptr inbounds i32, i32* %.cast19, i64 %indvars.iv.next27.i, !dbg !151
  %.pre.i.pre = load i32, i32* %arrayidx9.i.phi.trans.insert, align 4, !dbg !147, !tbaa !49
  br label %for.cond1.preheader.i10, !dbg !162

for.body.i:                                       ; preds = %middle.block21, %for.body.i
  %indvars.iv.i6 = phi i64 [ %indvars.iv.next.i8.4, %for.body.i ], [ 0, %middle.block21 ]
  %test.05.i = phi i8 [ %spec.select.i.4, %for.body.i ], [ 0, %middle.block21 ]
  call void @llvm.dbg.value(metadata i64 %indvars.iv.i6, metadata !101, metadata !DIExpression()) #7, !dbg !165
  call void @llvm.dbg.value(metadata i8 %test.05.i, metadata !99, metadata !DIExpression()) #7, !dbg !167
  %arrayidx.i7 = getelementptr inbounds i32, i32* %.cast19, i64 %indvars.iv.i6, !dbg !168
  %44 = load i32, i32* %arrayidx.i7, align 4, !dbg !168, !tbaa !49
  %cmp1.i = icmp eq i32 %44, 5000, !dbg !169
  call void @llvm.dbg.value(metadata i8 undef, metadata !99, metadata !DIExpression()) #7, !dbg !167
  %indvars.iv.next.i8 = add nuw nsw i64 %indvars.iv.i6, 1, !dbg !170
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.i8, metadata !101, metadata !DIExpression()) #7, !dbg !165
  %arrayidx.i7.1 = getelementptr inbounds i32, i32* %.cast19, i64 %indvars.iv.next.i8, !dbg !168
  %45 = load i32, i32* %arrayidx.i7.1, align 4, !dbg !168, !tbaa !49
  %cmp1.i.1 = icmp eq i32 %45, 5000, !dbg !169
  %46 = and i1 %cmp1.i.1, %cmp1.i, !dbg !171
  call void @llvm.dbg.value(metadata i8 undef, metadata !99, metadata !DIExpression()) #7, !dbg !167
  %indvars.iv.next.i8.1 = add nuw nsw i64 %indvars.iv.i6, 2, !dbg !170
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.i8.1, metadata !101, metadata !DIExpression()) #7, !dbg !165
  %arrayidx.i7.2 = getelementptr inbounds i32, i32* %.cast19, i64 %indvars.iv.next.i8.1, !dbg !168
  %47 = load i32, i32* %arrayidx.i7.2, align 4, !dbg !168, !tbaa !49
  %cmp1.i.2 = icmp eq i32 %47, 5000, !dbg !169
  %48 = and i1 %cmp1.i.2, %46, !dbg !171
  call void @llvm.dbg.value(metadata i8 undef, metadata !99, metadata !DIExpression()) #7, !dbg !167
  %indvars.iv.next.i8.2 = add nuw nsw i64 %indvars.iv.i6, 3, !dbg !170
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.i8.2, metadata !101, metadata !DIExpression()) #7, !dbg !165
  %arrayidx.i7.3 = getelementptr inbounds i32, i32* %.cast19, i64 %indvars.iv.next.i8.2, !dbg !168
  %49 = load i32, i32* %arrayidx.i7.3, align 4, !dbg !168, !tbaa !49
  %cmp1.i.3 = icmp eq i32 %49, 5000, !dbg !169
  %50 = and i1 %cmp1.i.3, %48, !dbg !171
  call void @llvm.dbg.value(metadata i8 undef, metadata !99, metadata !DIExpression()) #7, !dbg !167
  %indvars.iv.next.i8.3 = add nuw nsw i64 %indvars.iv.i6, 4, !dbg !170
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.i8.3, metadata !101, metadata !DIExpression()) #7, !dbg !165
  %arrayidx.i7.4 = getelementptr inbounds i32, i32* %.cast19, i64 %indvars.iv.next.i8.3, !dbg !168
  %51 = load i32, i32* %arrayidx.i7.4, align 4, !dbg !168, !tbaa !49
  %cmp1.i.4 = icmp eq i32 %51, 5000, !dbg !169
  %52 = and i1 %cmp1.i.4, %50, !dbg !171
  %spec.select.i.4 = select i1 %52, i8 %test.05.i, i8 1, !dbg !171
  call void @llvm.dbg.value(metadata i8 %spec.select.i.4, metadata !99, metadata !DIExpression()) #7, !dbg !167
  %indvars.iv.next.i8.4 = add nuw nsw i64 %indvars.iv.i6, 5, !dbg !170
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.i8.4, metadata !101, metadata !DIExpression()) #7, !dbg !165
  %exitcond.i9.4 = icmp eq i64 %indvars.iv.next.i8.4, 5000, !dbg !172
  br i1 %exitcond.i9.4, label %check.exit, label %for.body.i, !dbg !173, !llvm.loop !174

check.exit:                                       ; preds = %for.body.i
  call void @llvm.dbg.value(metadata i8 %spec.select.i.4, metadata !99, metadata !DIExpression()) #7, !dbg !167
  %53 = and i8 %spec.select.i.4, 1, !dbg !176
  %tobool.i = icmp eq i8 %53, 0, !dbg !176
  %cond.i = select i1 %tobool.i, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i64 0, i64 0), !dbg !176
  %call.i = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i64 0, i64 0), i8* %cond.i) #7, !dbg !177
  %54 = load i8*, i8** bitcast (i32** @a to i8**), align 8, !dbg !178, !tbaa !37
  tail call void @free(i8* %54) #7, !dbg !179
  %55 = load i8*, i8** bitcast (i32** @b to i8**), align 8, !dbg !180, !tbaa !37
  tail call void @free(i8* %55) #7, !dbg !181
  %56 = load i8*, i8** bitcast (i32** @c to i8**), align 8, !dbg !182, !tbaa !37
  tail call void @free(i8* %56) #7, !dbg !183
  ret i32 0, !dbg !184

vector.body23.1:                                  ; preds = %vector.body23
  %57 = add nuw nsw i64 %index.next26, %27, !dbg !154
  %58 = getelementptr inbounds i32, i32* %.cast, i64 %57, !dbg !155
  %59 = bitcast i32* %58 to <4 x i32>*, !dbg !155
  %wide.load.1 = load <4 x i32>, <4 x i32>* %59, align 4, !dbg !155, !tbaa !49
  %60 = getelementptr inbounds i32, i32* %58, i64 4, !dbg !155
  %61 = bitcast i32* %60 to <4 x i32>*, !dbg !155
  %wide.load30.1 = load <4 x i32>, <4 x i32>* %61, align 4, !dbg !155, !tbaa !49
  %62 = getelementptr inbounds i32, i32* %.cast18, i64 %index.next26, !dbg !156
  %63 = bitcast i32* %62 to <4 x i32>*, !dbg !156
  %wide.load31.1 = load <4 x i32>, <4 x i32>* %63, align 4, !dbg !156, !tbaa !49
  %64 = getelementptr inbounds i32, i32* %62, i64 4, !dbg !156
  %65 = bitcast i32* %64 to <4 x i32>*, !dbg !156
  %wide.load32.1 = load <4 x i32>, <4 x i32>* %65, align 4, !dbg !156, !tbaa !49
  %66 = mul nsw <4 x i32> %wide.load31.1, %wide.load.1, !dbg !157
  %67 = mul nsw <4 x i32> %wide.load32.1, %wide.load30.1, !dbg !157
  %68 = add <4 x i32> %66, %40, !dbg !147
  %69 = add <4 x i32> %67, %41, !dbg !147
  %index.next26.1 = add nuw nsw i64 %index25, 16, !dbg !153
  br label %vector.body23
}

; Function Attrs: nofree nounwind
declare dso_local noalias i8* @malloc(i64) local_unnamed_addr #2

; Function Attrs: nounwind
declare !dbg !6 dso_local void @free(i8* nocapture) local_unnamed_addr #4

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #5

; Function Attrs: argmemonly nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #6

attributes #0 = { nofree norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nofree nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readnone speculatable willreturn }
attributes #6 = { argmemonly nounwind willreturn writeonly }
attributes #7 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!19, !20, !21}
!llvm.ident = !{!22}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "b", scope: !2, file: !14, line: 11, type: !15, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 11.0.0 (https://github.com/prithayan/llvm-project.git 8fd35f88270ed30453c9ed4bbf8c49488858805d)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !11, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "/home/prithayan/work/Openmp/test/OpenMP-Benchmakrs/lechen/OpenMP/DRACC022_OMP_MxV_Missing_Data_yes.c", directory: "/home/prithayan/work/Openmp/src/llvm-project/llvm/test/Analysis/OmpDiagnosticsAnalysis")
!4 = !{}
!5 = !{!6}
!6 = !DISubprogram(name: "free", scope: !7, file: !7, line: 563, type: !8, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !4)
!7 = !DIFile(filename: "/usr/include/stdlib.h", directory: "")
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!11 = !{!12, !0, !17}
!12 = !DIGlobalVariableExpression(var: !13, expr: !DIExpression())
!13 = distinct !DIGlobalVariable(name: "a", scope: !2, file: !14, line: 10, type: !15, isLocal: false, isDefinition: true)
!14 = !DIFile(filename: "test/OpenMP-Benchmakrs/lechen/OpenMP/DRACC022_OMP_MxV_Missing_Data_yes.c", directory: "/home/prithayan/work/Openmp")
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!17 = !DIGlobalVariableExpression(var: !18, expr: !DIExpression())
!18 = distinct !DIGlobalVariable(name: "c", scope: !2, file: !14, line: 12, type: !15, isLocal: false, isDefinition: true)
!19 = !{i32 7, !"Dwarf Version", i32 4}
!20 = !{i32 2, !"Debug Info Version", i32 3}
!21 = !{i32 1, !"wchar_size", i32 4}
!22 = !{!"clang version 11.0.0 (https://github.com/prithayan/llvm-project.git 8fd35f88270ed30453c9ed4bbf8c49488858805d)"}
!23 = distinct !DISubprogram(name: "init", scope: !14, file: !14, line: 15, type: !24, scopeLine: 15, flags: DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !26)
!24 = !DISubroutineType(types: !25)
!25 = !{!16}
!26 = !{!27, !29}
!27 = !DILocalVariable(name: "i", scope: !28, file: !14, line: 16, type: !16)
!28 = distinct !DILexicalBlock(scope: !23, file: !14, line: 16, column: 5)
!29 = !DILocalVariable(name: "j", scope: !30, file: !14, line: 17, type: !16)
!30 = distinct !DILexicalBlock(scope: !31, file: !14, line: 17, column: 9)
!31 = distinct !DILexicalBlock(scope: !32, file: !14, line: 16, column: 27)
!32 = distinct !DILexicalBlock(scope: !28, file: !14, line: 16, column: 5)
!33 = !DILocation(line: 0, scope: !28)
!34 = !DILocation(line: 0, scope: !35)
!35 = distinct !DILexicalBlock(scope: !36, file: !14, line: 17, column: 31)
!36 = distinct !DILexicalBlock(scope: !30, file: !14, line: 17, column: 9)
!37 = !{!38, !38, i64 0}
!38 = !{!"any pointer", !39, i64 0}
!39 = !{!"omnipotent char", !40, i64 0}
!40 = !{!"Simple C/C++ TBAA"}
!41 = !DILocation(line: 0, scope: !31)
!42 = !DILocation(line: 16, column: 5, scope: !28)
!43 = !DILocation(line: 0, scope: !30)
!44 = !DILocation(line: 17, column: 9, scope: !30)
!45 = !DILocation(line: 17, column: 28, scope: !36)
!46 = !DILocation(line: 18, column: 16, scope: !35)
!47 = !DILocation(line: 18, column: 13, scope: !35)
!48 = !DILocation(line: 18, column: 21, scope: !35)
!49 = !{!50, !50, i64 0}
!50 = !{!"int", !39, i64 0}
!51 = distinct !{!51, !44, !52, !53}
!52 = !DILocation(line: 19, column: 9, scope: !30)
!53 = !{!"llvm.loop.isvectorized", i32 1}
!54 = !DILocation(line: 23, column: 9, scope: !23)
!55 = !DILocation(line: 20, column: 9, scope: !31)
!56 = !DILocation(line: 20, column: 13, scope: !31)
!57 = !DILocation(line: 21, column: 9, scope: !31)
!58 = !DILocation(line: 21, column: 13, scope: !31)
!59 = !DILocation(line: 16, column: 24, scope: !32)
!60 = !DILocation(line: 16, column: 19, scope: !32)
!61 = distinct !{!61, !42, !62}
!62 = !DILocation(line: 22, column: 5, scope: !28)
!63 = distinct !DISubprogram(name: "Mult", scope: !14, file: !14, line: 27, type: !24, scopeLine: 27, flags: DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !64)
!64 = !{!65, !69, !72}
!65 = !DILocalVariable(name: "z", scope: !63, file: !14, line: 28, type: !66)
!66 = !DICompositeType(tag: DW_TAG_array_type, baseType: !16, size: 32000, elements: !67)
!67 = !{!68, !68, !68}
!68 = !DISubrange(count: 10)
!69 = !DILocalVariable(name: "i", scope: !70, file: !14, line: 33, type: !16)
!70 = distinct !DILexicalBlock(scope: !71, file: !14, line: 33, column: 9)
!71 = distinct !DILexicalBlock(scope: !63, file: !14, line: 31, column: 5)
!72 = !DILocalVariable(name: "j", scope: !73, file: !14, line: 34, type: !16)
!73 = distinct !DILexicalBlock(scope: !74, file: !14, line: 34, column: 13)
!74 = distinct !DILexicalBlock(scope: !75, file: !14, line: 33, column: 31)
!75 = distinct !DILexicalBlock(scope: !70, file: !14, line: 33, column: 9)
!76 = !DILocation(line: 0, scope: !70)
!77 = !DILocation(line: 0, scope: !78)
!78 = distinct !DILexicalBlock(scope: !79, file: !14, line: 34, column: 35)
!79 = distinct !DILexicalBlock(scope: !73, file: !14, line: 34, column: 13)
!80 = !DILocation(line: 33, column: 9, scope: !70)
!81 = !DILocation(line: 0, scope: !73)
!82 = !DILocation(line: 35, column: 21, scope: !78)
!83 = !DILocation(line: 34, column: 13, scope: !73)
!84 = !DILocation(line: 40, column: 5, scope: !63)
!85 = !DILocation(line: 33, column: 28, scope: !75)
!86 = !DILocation(line: 33, column: 23, scope: !75)
!87 = distinct !{!87, !80, !88}
!88 = !DILocation(line: 37, column: 9, scope: !70)
!89 = !DILocation(line: 35, column: 26, scope: !78)
!90 = !DILocation(line: 35, column: 23, scope: !78)
!91 = !DILocation(line: 35, column: 32, scope: !78)
!92 = !DILocation(line: 35, column: 31, scope: !78)
!93 = !DILocation(line: 34, column: 32, scope: !79)
!94 = !DILocation(line: 34, column: 27, scope: !79)
!95 = distinct !{!95, !83, !96}
!96 = !DILocation(line: 36, column: 13, scope: !73)
!97 = distinct !DISubprogram(name: "check", scope: !14, file: !14, line: 43, type: !24, scopeLine: 43, flags: DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !98)
!98 = !{!99, !101}
!99 = !DILocalVariable(name: "test", scope: !97, file: !14, line: 44, type: !100)
!100 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!101 = !DILocalVariable(name: "i", scope: !102, file: !14, line: 45, type: !16)
!102 = distinct !DILexicalBlock(scope: !97, file: !14, line: 45, column: 5)
!103 = !DILocation(line: 0, scope: !97)
!104 = !DILocation(line: 0, scope: !102)
!105 = !DILocation(line: 0, scope: !106)
!106 = distinct !DILexicalBlock(scope: !107, file: !14, line: 46, column: 12)
!107 = distinct !DILexicalBlock(scope: !108, file: !14, line: 45, column: 27)
!108 = distinct !DILexicalBlock(scope: !102, file: !14, line: 45, column: 5)
!109 = !DILocation(line: 45, column: 5, scope: !102)
!110 = !DILocation(line: 50, column: 38, scope: !97)
!111 = !DILocation(line: 50, column: 5, scope: !97)
!112 = !DILocation(line: 51, column: 5, scope: !97)
!113 = !DILocation(line: 46, column: 12, scope: !106)
!114 = !DILocation(line: 46, column: 16, scope: !106)
!115 = !DILocation(line: 45, column: 24, scope: !108)
!116 = !DILocation(line: 46, column: 12, scope: !107)
!117 = !DILocation(line: 45, column: 19, scope: !108)
!118 = distinct !{!118, !109, !119}
!119 = !DILocation(line: 49, column: 5, scope: !102)
!120 = distinct !DISubprogram(name: "main", scope: !14, file: !14, line: 57, type: !24, scopeLine: 57, flags: DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !4)
!121 = !DILocation(line: 58, column: 9, scope: !120)
!122 = !DILocation(line: 58, column: 7, scope: !120)
!123 = !DILocation(line: 59, column: 9, scope: !120)
!124 = !DILocation(line: 59, column: 7, scope: !120)
!125 = !DILocation(line: 60, column: 9, scope: !120)
!126 = !DILocation(line: 60, column: 7, scope: !120)
!127 = !DILocation(line: 0, scope: !28, inlinedAt: !128)
!128 = distinct !DILocation(line: 61, column: 5, scope: !120)
!129 = !DILocation(line: 0, scope: !35, inlinedAt: !128)
!130 = !DILocation(line: 0, scope: !31, inlinedAt: !128)
!131 = !DILocation(line: 21, column: 13, scope: !31, inlinedAt: !128)
!132 = !DILocation(line: 16, column: 5, scope: !28, inlinedAt: !128)
!133 = !DILocation(line: 0, scope: !30, inlinedAt: !128)
!134 = !DILocation(line: 17, column: 9, scope: !30, inlinedAt: !128)
!135 = !DILocation(line: 17, column: 28, scope: !36, inlinedAt: !128)
!136 = !DILocation(line: 18, column: 16, scope: !35, inlinedAt: !128)
!137 = !DILocation(line: 18, column: 13, scope: !35, inlinedAt: !128)
!138 = !DILocation(line: 18, column: 21, scope: !35, inlinedAt: !128)
!139 = distinct !{!139, !134, !140, !53}
!140 = !DILocation(line: 19, column: 9, scope: !30, inlinedAt: !128)
!141 = !DILocation(line: 20, column: 9, scope: !31, inlinedAt: !128)
!142 = !DILocation(line: 20, column: 13, scope: !31, inlinedAt: !128)
!143 = !DILocation(line: 16, column: 24, scope: !32, inlinedAt: !128)
!144 = !DILocation(line: 16, column: 19, scope: !32, inlinedAt: !128)
!145 = distinct !{!145, !132, !146}
!146 = !DILocation(line: 22, column: 5, scope: !28, inlinedAt: !128)
!147 = !DILocation(line: 35, column: 21, scope: !78, inlinedAt: !148)
!148 = distinct !DILocation(line: 62, column: 5, scope: !120)
!149 = !DILocation(line: 0, scope: !70, inlinedAt: !148)
!150 = !DILocation(line: 0, scope: !73, inlinedAt: !148)
!151 = !DILocation(line: 0, scope: !78, inlinedAt: !148)
!152 = !DILocation(line: 34, column: 13, scope: !73, inlinedAt: !148)
!153 = !DILocation(line: 34, column: 32, scope: !79, inlinedAt: !148)
!154 = !DILocation(line: 35, column: 26, scope: !78, inlinedAt: !148)
!155 = !DILocation(line: 35, column: 23, scope: !78, inlinedAt: !148)
!156 = !DILocation(line: 35, column: 32, scope: !78, inlinedAt: !148)
!157 = !DILocation(line: 35, column: 31, scope: !78, inlinedAt: !148)
!158 = distinct !{!158, !152, !159, !53}
!159 = !DILocation(line: 36, column: 13, scope: !73, inlinedAt: !148)
!160 = !DILocation(line: 33, column: 28, scope: !75, inlinedAt: !148)
!161 = !DILocation(line: 33, column: 23, scope: !75, inlinedAt: !148)
!162 = !DILocation(line: 33, column: 9, scope: !70, inlinedAt: !148)
!163 = distinct !{!163, !162, !164}
!164 = !DILocation(line: 37, column: 9, scope: !70, inlinedAt: !148)
!165 = !DILocation(line: 0, scope: !102, inlinedAt: !166)
!166 = distinct !DILocation(line: 63, column: 5, scope: !120)
!167 = !DILocation(line: 0, scope: !97, inlinedAt: !166)
!168 = !DILocation(line: 46, column: 12, scope: !106, inlinedAt: !166)
!169 = !DILocation(line: 46, column: 16, scope: !106, inlinedAt: !166)
!170 = !DILocation(line: 45, column: 24, scope: !108, inlinedAt: !166)
!171 = !DILocation(line: 46, column: 12, scope: !107, inlinedAt: !166)
!172 = !DILocation(line: 45, column: 19, scope: !108, inlinedAt: !166)
!173 = !DILocation(line: 45, column: 5, scope: !102, inlinedAt: !166)
!174 = distinct !{!174, !173, !175}
!175 = !DILocation(line: 49, column: 5, scope: !102, inlinedAt: !166)
!176 = !DILocation(line: 50, column: 38, scope: !97, inlinedAt: !166)
!177 = !DILocation(line: 50, column: 5, scope: !97, inlinedAt: !166)
!178 = !DILocation(line: 64, column: 10, scope: !120)
!179 = !DILocation(line: 64, column: 5, scope: !120)
!180 = !DILocation(line: 65, column: 10, scope: !120)
!181 = !DILocation(line: 65, column: 5, scope: !120)
!182 = !DILocation(line: 66, column: 10, scope: !120)
!183 = !DILocation(line: 66, column: 5, scope: !120)
!184 = !DILocation(line: 67, column: 5, scope: !120)
