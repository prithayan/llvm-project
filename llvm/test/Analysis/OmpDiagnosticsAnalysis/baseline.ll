; ModuleID = '/home/prithayan/work/Openmp/test/OpenMP-Benchmakrs/lechen/OpenMP/DRACC022_OMP_MxV_Missing_Data_yes.c'
source_filename = "/home/prithayan/work/Openmp/test/OpenMP-Benchmakrs/lechen/OpenMP/DRACC022_OMP_MxV_Missing_Data_yes.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@b = dso_local local_unnamed_addr global i32* null, align 8
@a = dso_local local_unnamed_addr global i32* null, align 8
@c = dso_local local_unnamed_addr global i32* null, align 8
@.str = private unnamed_addr constant [23 x i8] c"Data Race occured: %s\0A\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"true\00", align 1
@.str.2 = private unnamed_addr constant [6 x i8] c"false\00", align 1

; Function Attrs: nofree norecurse nounwind uwtable
define dso_local i32 @init() local_unnamed_addr #0 {
entry:
  %0 = load i32*, i32** @b, align 8, !tbaa !2
  %1 = load i32*, i32** @a, align 8, !tbaa !2
  %2 = load i32*, i32** @c, align 8, !tbaa !2
  br label %for.cond1.preheader

for.cond1.preheader:                              ; preds = %for.cond.cleanup3, %entry
  %indvars.iv23 = phi i64 [ 0, %entry ], [ %indvars.iv.next24, %for.cond.cleanup3 ]
  %3 = mul nuw nsw i64 %indvars.iv23, 5000
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %for.cond1.preheader
  %index = phi i64 [ 0, %for.cond1.preheader ], [ %index.next.4, %vector.body ]
  %4 = add nuw nsw i64 %index, %3
  %5 = getelementptr inbounds i32, i32* %0, i64 %4
  %6 = bitcast i32* %5 to <4 x i32>*
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %6, align 4, !tbaa !6
  %7 = getelementptr inbounds i32, i32* %5, i64 4
  %8 = bitcast i32* %7 to <4 x i32>*
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %8, align 4, !tbaa !6
  %index.next = add nuw nsw i64 %index, 8
  %9 = add nuw nsw i64 %index.next, %3
  %10 = getelementptr inbounds i32, i32* %0, i64 %9
  %11 = bitcast i32* %10 to <4 x i32>*
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %11, align 4, !tbaa !6
  %12 = getelementptr inbounds i32, i32* %10, i64 4
  %13 = bitcast i32* %12 to <4 x i32>*
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %13, align 4, !tbaa !6
  %index.next.1 = add nuw nsw i64 %index, 16
  %14 = add nuw nsw i64 %index.next.1, %3
  %15 = getelementptr inbounds i32, i32* %0, i64 %14
  %16 = bitcast i32* %15 to <4 x i32>*
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %16, align 4, !tbaa !6
  %17 = getelementptr inbounds i32, i32* %15, i64 4
  %18 = bitcast i32* %17 to <4 x i32>*
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %18, align 4, !tbaa !6
  %index.next.2 = add nuw nsw i64 %index, 24
  %19 = add nuw nsw i64 %index.next.2, %3
  %20 = getelementptr inbounds i32, i32* %0, i64 %19
  %21 = bitcast i32* %20 to <4 x i32>*
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %21, align 4, !tbaa !6
  %22 = getelementptr inbounds i32, i32* %20, i64 4
  %23 = bitcast i32* %22 to <4 x i32>*
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %23, align 4, !tbaa !6
  %index.next.3 = add nuw nsw i64 %index, 32
  %24 = add nuw nsw i64 %index.next.3, %3
  %25 = getelementptr inbounds i32, i32* %0, i64 %24
  %26 = bitcast i32* %25 to <4 x i32>*
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %26, align 4, !tbaa !6
  %27 = getelementptr inbounds i32, i32* %25, i64 4
  %28 = bitcast i32* %27 to <4 x i32>*
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %28, align 4, !tbaa !6
  %index.next.4 = add nuw nsw i64 %index, 40
  %29 = icmp eq i64 %index.next.4, 5000
  br i1 %29, label %for.cond.cleanup3, label %vector.body, !llvm.loop !8

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3
  ret i32 0

for.cond.cleanup3:                                ; preds = %vector.body
  %arrayidx6 = getelementptr inbounds i32, i32* %1, i64 %indvars.iv23
  store i32 1, i32* %arrayidx6, align 4, !tbaa !6
  %arrayidx8 = getelementptr inbounds i32, i32* %2, i64 %indvars.iv23
  store i32 0, i32* %arrayidx8, align 4, !tbaa !6
  %indvars.iv.next24 = add nuw nsw i64 %indvars.iv23, 1
  %exitcond26 = icmp eq i64 %indvars.iv.next24, 5000
  br i1 %exitcond26, label %for.cond.cleanup, label %for.cond1.preheader
}

; Function Attrs: nofree norecurse nounwind uwtable
define dso_local i32 @Mult() local_unnamed_addr #0 {
entry:
  %0 = load i32*, i32** @b, align 8, !tbaa !2
  %1 = load i32*, i32** @a, align 8, !tbaa !2
  %2 = load i32*, i32** @c, align 8, !tbaa !2
  br label %for.cond1.preheader

for.cond1.preheader:                              ; preds = %for.cond.cleanup3, %entry
  %indvars.iv26 = phi i64 [ 0, %entry ], [ %indvars.iv.next27, %for.cond.cleanup3 ]
  %3 = mul nuw nsw i64 %indvars.iv26, 5000
  %arrayidx9 = getelementptr inbounds i32, i32* %2, i64 %indvars.iv26
  %.pre = load i32, i32* %arrayidx9, align 4, !tbaa !6
  br label %for.body4

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3
  ret i32 0

for.cond.cleanup3:                                ; preds = %for.body4
  %indvars.iv.next27 = add nuw nsw i64 %indvars.iv26, 1
  %exitcond29 = icmp eq i64 %indvars.iv.next27, 5000
  br i1 %exitcond29, label %for.cond.cleanup, label %for.cond1.preheader

for.body4:                                        ; preds = %for.body4, %for.cond1.preheader
  %4 = phi i32 [ %.pre, %for.cond1.preheader ], [ %add10.1, %for.body4 ]
  %indvars.iv = phi i64 [ 0, %for.cond1.preheader ], [ %indvars.iv.next.1, %for.body4 ]
  %5 = add nuw nsw i64 %indvars.iv, %3
  %arrayidx = getelementptr inbounds i32, i32* %0, i64 %5
  %6 = load i32, i32* %arrayidx, align 4, !tbaa !6
  %arrayidx6 = getelementptr inbounds i32, i32* %1, i64 %indvars.iv
  %7 = load i32, i32* %arrayidx6, align 4, !tbaa !6
  %mul7 = mul nsw i32 %7, %6
  %add10 = add nsw i32 %4, %mul7
  store i32 %add10, i32* %arrayidx9, align 4, !tbaa !6
  %indvars.iv.next = or i64 %indvars.iv, 1
  %8 = add nuw nsw i64 %indvars.iv.next, %3
  %arrayidx.1 = getelementptr inbounds i32, i32* %0, i64 %8
  %9 = load i32, i32* %arrayidx.1, align 4, !tbaa !6
  %arrayidx6.1 = getelementptr inbounds i32, i32* %1, i64 %indvars.iv.next
  %10 = load i32, i32* %arrayidx6.1, align 4, !tbaa !6
  %mul7.1 = mul nsw i32 %10, %9
  %add10.1 = add nsw i32 %add10, %mul7.1
  store i32 %add10.1, i32* %arrayidx9, align 4, !tbaa !6
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv, 2
  %exitcond.1 = icmp eq i64 %indvars.iv.next.1, 5000
  br i1 %exitcond.1, label %for.cond.cleanup3, label %for.body4
}

; Function Attrs: nofree nounwind uwtable
define dso_local i32 @check() local_unnamed_addr #1 {
entry:
  %0 = load i32*, i32** @c, align 8, !tbaa !2
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  %1 = and i8 %spec.select.4, 1
  %tobool = icmp eq i8 %1, 0
  %cond = select i1 %tobool, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i64 0, i64 0)
  %call = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i64 0, i64 0), i8* %cond)
  ret i32 0

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next.4, %for.body ]
  %test.05 = phi i8 [ 0, %entry ], [ %spec.select.4, %for.body ]
  %arrayidx = getelementptr inbounds i32, i32* %0, i64 %indvars.iv
  %2 = load i32, i32* %arrayidx, align 4, !tbaa !6
  %cmp1 = icmp eq i32 %2, 5000
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %arrayidx.1 = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next
  %3 = load i32, i32* %arrayidx.1, align 4, !tbaa !6
  %cmp1.1 = icmp eq i32 %3, 5000
  %4 = and i1 %cmp1.1, %cmp1
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv, 2
  %arrayidx.2 = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next.1
  %5 = load i32, i32* %arrayidx.2, align 4, !tbaa !6
  %cmp1.2 = icmp eq i32 %5, 5000
  %6 = and i1 %cmp1.2, %4
  %indvars.iv.next.2 = add nuw nsw i64 %indvars.iv, 3
  %arrayidx.3 = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next.2
  %7 = load i32, i32* %arrayidx.3, align 4, !tbaa !6
  %cmp1.3 = icmp eq i32 %7, 5000
  %8 = and i1 %cmp1.3, %6
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv, 4
  %arrayidx.4 = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next.3
  %9 = load i32, i32* %arrayidx.4, align 4, !tbaa !6
  %cmp1.4 = icmp eq i32 %9, 5000
  %10 = and i1 %cmp1.4, %8
  %spec.select.4 = select i1 %10, i8 %test.05, i8 1
  %indvars.iv.next.4 = add nuw nsw i64 %indvars.iv, 5
  %exitcond.4 = icmp eq i64 %indvars.iv.next.4, 5000
  br i1 %exitcond.4, label %for.cond.cleanup, label %for.body
}

; Function Attrs: nofree nounwind
declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #2

; Function Attrs: nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #3 {
entry:
  %call = tail call noalias dereferenceable_or_null(20000) i8* @malloc(i64 20000) #6
  store i8* %call, i8** bitcast (i32** @a to i8**), align 8, !tbaa !2
  %call1 = tail call noalias dereferenceable_or_null(100000000) i8* @malloc(i64 100000000) #6
  store i8* %call1, i8** bitcast (i32** @b to i8**), align 8, !tbaa !2
  %call2 = tail call noalias dereferenceable_or_null(20000) i8* @malloc(i64 20000) #6
  store i8* %call2, i8** bitcast (i32** @c to i8**), align 8, !tbaa !2
  %.cast = bitcast i8* %call1 to i32*
  %.cast18 = bitcast i8* %call to i32*
  %.cast19 = bitcast i8* %call2 to i32*
  call void @llvm.memset.p0i8.i64(i8* nonnull align 4 dereferenceable(20000) %call2, i8 0, i64 20000, i1 false)
  br label %for.cond1.preheader.i

for.cond1.preheader.i:                            ; preds = %for.cond.cleanup3.i, %entry
  %indvars.iv23.i = phi i64 [ 0, %entry ], [ %indvars.iv.next24.i, %for.cond.cleanup3.i ]
  %0 = mul nuw nsw i64 %indvars.iv23.i, 5000
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %for.cond1.preheader.i
  %index = phi i64 [ 0, %for.cond1.preheader.i ], [ %index.next.4, %vector.body ]
  %1 = add nuw nsw i64 %index, %0
  %2 = getelementptr inbounds i32, i32* %.cast, i64 %1
  %3 = bitcast i32* %2 to <4 x i32>*
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %3, align 4, !tbaa !6
  %4 = getelementptr inbounds i32, i32* %2, i64 4
  %5 = bitcast i32* %4 to <4 x i32>*
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %5, align 4, !tbaa !6
  %index.next = add nuw nsw i64 %index, 8
  %6 = add nuw nsw i64 %index.next, %0
  %7 = getelementptr inbounds i32, i32* %.cast, i64 %6
  %8 = bitcast i32* %7 to <4 x i32>*
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %8, align 4, !tbaa !6
  %9 = getelementptr inbounds i32, i32* %7, i64 4
  %10 = bitcast i32* %9 to <4 x i32>*
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %10, align 4, !tbaa !6
  %index.next.1 = add nuw nsw i64 %index, 16
  %11 = add nuw nsw i64 %index.next.1, %0
  %12 = getelementptr inbounds i32, i32* %.cast, i64 %11
  %13 = bitcast i32* %12 to <4 x i32>*
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %13, align 4, !tbaa !6
  %14 = getelementptr inbounds i32, i32* %12, i64 4
  %15 = bitcast i32* %14 to <4 x i32>*
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %15, align 4, !tbaa !6
  %index.next.2 = add nuw nsw i64 %index, 24
  %16 = add nuw nsw i64 %index.next.2, %0
  %17 = getelementptr inbounds i32, i32* %.cast, i64 %16
  %18 = bitcast i32* %17 to <4 x i32>*
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %18, align 4, !tbaa !6
  %19 = getelementptr inbounds i32, i32* %17, i64 4
  %20 = bitcast i32* %19 to <4 x i32>*
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %20, align 4, !tbaa !6
  %index.next.3 = add nuw nsw i64 %index, 32
  %21 = add nuw nsw i64 %index.next.3, %0
  %22 = getelementptr inbounds i32, i32* %.cast, i64 %21
  %23 = bitcast i32* %22 to <4 x i32>*
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %23, align 4, !tbaa !6
  %24 = getelementptr inbounds i32, i32* %22, i64 4
  %25 = bitcast i32* %24 to <4 x i32>*
  store <4 x i32> <i32 1, i32 1, i32 1, i32 1>, <4 x i32>* %25, align 4, !tbaa !6
  %index.next.4 = add nuw nsw i64 %index, 40
  %26 = icmp eq i64 %index.next.4, 5000
  br i1 %26, label %for.cond.cleanup3.i, label %vector.body, !llvm.loop !10

for.cond.cleanup3.i:                              ; preds = %vector.body
  %arrayidx6.i = getelementptr inbounds i32, i32* %.cast18, i64 %indvars.iv23.i
  store i32 1, i32* %arrayidx6.i, align 4, !tbaa !6
  %indvars.iv.next24.i = add nuw nsw i64 %indvars.iv23.i, 1
  %exitcond26.i = icmp eq i64 %indvars.iv.next24.i, 5000
  br i1 %exitcond26.i, label %for.cond1.preheader.i10, label %for.cond1.preheader.i

for.cond1.preheader.i10:                          ; preds = %for.cond.cleanup3.i, %for.cond.cleanup3.i11.for.cond1.preheader.i10_crit_edge
  %.pre.i = phi i32 [ %.pre.i.pre, %for.cond.cleanup3.i11.for.cond1.preheader.i10_crit_edge ], [ 0, %for.cond.cleanup3.i ]
  %indvars.iv26.i = phi i64 [ %indvars.iv.next27.i, %for.cond.cleanup3.i11.for.cond1.preheader.i10_crit_edge ], [ 0, %for.cond.cleanup3.i ]
  %27 = mul nuw nsw i64 %indvars.iv26.i, 5000
  %arrayidx9.i = getelementptr inbounds i32, i32* %.cast19, i64 %indvars.iv26.i
  %28 = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %.pre.i, i32 0
  br label %vector.body23

vector.body23:                                    ; preds = %vector.body23.1, %for.cond1.preheader.i10
  %index25 = phi i64 [ 0, %for.cond1.preheader.i10 ], [ %index.next26.1, %vector.body23.1 ]
  %vec.phi = phi <4 x i32> [ %28, %for.cond1.preheader.i10 ], [ %68, %vector.body23.1 ]
  %vec.phi29 = phi <4 x i32> [ zeroinitializer, %for.cond1.preheader.i10 ], [ %69, %vector.body23.1 ]
  %29 = add nuw nsw i64 %index25, %27
  %30 = getelementptr inbounds i32, i32* %.cast, i64 %29
  %31 = bitcast i32* %30 to <4 x i32>*
  %wide.load = load <4 x i32>, <4 x i32>* %31, align 4, !tbaa !6
  %32 = getelementptr inbounds i32, i32* %30, i64 4
  %33 = bitcast i32* %32 to <4 x i32>*
  %wide.load30 = load <4 x i32>, <4 x i32>* %33, align 4, !tbaa !6
  %34 = getelementptr inbounds i32, i32* %.cast18, i64 %index25
  %35 = bitcast i32* %34 to <4 x i32>*
  %wide.load31 = load <4 x i32>, <4 x i32>* %35, align 4, !tbaa !6
  %36 = getelementptr inbounds i32, i32* %34, i64 4
  %37 = bitcast i32* %36 to <4 x i32>*
  %wide.load32 = load <4 x i32>, <4 x i32>* %37, align 4, !tbaa !6
  %38 = mul nsw <4 x i32> %wide.load31, %wide.load
  %39 = mul nsw <4 x i32> %wide.load32, %wide.load30
  %40 = add <4 x i32> %38, %vec.phi
  %41 = add <4 x i32> %39, %vec.phi29
  %index.next26 = or i64 %index25, 8
  %42 = icmp eq i64 %index.next26, 5000
  br i1 %42, label %middle.block21, label %vector.body23.1, !llvm.loop !11

middle.block21:                                   ; preds = %vector.body23
  %bin.rdx = add <4 x i32> %41, %40
  %rdx.shuf = shufflevector <4 x i32> %bin.rdx, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx33 = add <4 x i32> %bin.rdx, %rdx.shuf
  %rdx.shuf34 = shufflevector <4 x i32> %bin.rdx33, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx35 = add <4 x i32> %bin.rdx33, %rdx.shuf34
  %43 = extractelement <4 x i32> %bin.rdx35, i32 0
  store i32 %43, i32* %arrayidx9.i, align 4, !tbaa !6
  %indvars.iv.next27.i = add nuw nsw i64 %indvars.iv26.i, 1
  %exitcond29.i = icmp eq i64 %indvars.iv.next27.i, 5000
  br i1 %exitcond29.i, label %for.body.i, label %for.cond.cleanup3.i11.for.cond1.preheader.i10_crit_edge

for.cond.cleanup3.i11.for.cond1.preheader.i10_crit_edge: ; preds = %middle.block21
  %arrayidx9.i.phi.trans.insert = getelementptr inbounds i32, i32* %.cast19, i64 %indvars.iv.next27.i
  %.pre.i.pre = load i32, i32* %arrayidx9.i.phi.trans.insert, align 4, !tbaa !6
  br label %for.cond1.preheader.i10

for.body.i:                                       ; preds = %middle.block21, %for.body.i
  %indvars.iv.i6 = phi i64 [ %indvars.iv.next.i8.4, %for.body.i ], [ 0, %middle.block21 ]
  %test.05.i = phi i8 [ %spec.select.i.4, %for.body.i ], [ 0, %middle.block21 ]
  %arrayidx.i7 = getelementptr inbounds i32, i32* %.cast19, i64 %indvars.iv.i6
  %44 = load i32, i32* %arrayidx.i7, align 4, !tbaa !6
  %cmp1.i = icmp eq i32 %44, 5000
  %indvars.iv.next.i8 = add nuw nsw i64 %indvars.iv.i6, 1
  %arrayidx.i7.1 = getelementptr inbounds i32, i32* %.cast19, i64 %indvars.iv.next.i8
  %45 = load i32, i32* %arrayidx.i7.1, align 4, !tbaa !6
  %cmp1.i.1 = icmp eq i32 %45, 5000
  %46 = and i1 %cmp1.i.1, %cmp1.i
  %indvars.iv.next.i8.1 = add nuw nsw i64 %indvars.iv.i6, 2
  %arrayidx.i7.2 = getelementptr inbounds i32, i32* %.cast19, i64 %indvars.iv.next.i8.1
  %47 = load i32, i32* %arrayidx.i7.2, align 4, !tbaa !6
  %cmp1.i.2 = icmp eq i32 %47, 5000
  %48 = and i1 %cmp1.i.2, %46
  %indvars.iv.next.i8.2 = add nuw nsw i64 %indvars.iv.i6, 3
  %arrayidx.i7.3 = getelementptr inbounds i32, i32* %.cast19, i64 %indvars.iv.next.i8.2
  %49 = load i32, i32* %arrayidx.i7.3, align 4, !tbaa !6
  %cmp1.i.3 = icmp eq i32 %49, 5000
  %50 = and i1 %cmp1.i.3, %48
  %indvars.iv.next.i8.3 = add nuw nsw i64 %indvars.iv.i6, 4
  %arrayidx.i7.4 = getelementptr inbounds i32, i32* %.cast19, i64 %indvars.iv.next.i8.3
  %51 = load i32, i32* %arrayidx.i7.4, align 4, !tbaa !6
  %cmp1.i.4 = icmp eq i32 %51, 5000
  %52 = and i1 %cmp1.i.4, %50
  %spec.select.i.4 = select i1 %52, i8 %test.05.i, i8 1
  %indvars.iv.next.i8.4 = add nuw nsw i64 %indvars.iv.i6, 5
  %exitcond.i9.4 = icmp eq i64 %indvars.iv.next.i8.4, 5000
  br i1 %exitcond.i9.4, label %check.exit, label %for.body.i

check.exit:                                       ; preds = %for.body.i
  %53 = and i8 %spec.select.i.4, 1
  %tobool.i = icmp eq i8 %53, 0
  %cond.i = select i1 %tobool.i, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i64 0, i64 0)
  %call.i = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i64 0, i64 0), i8* %cond.i) #6
  %54 = load i8*, i8** bitcast (i32** @a to i8**), align 8, !tbaa !2
  tail call void @free(i8* %54) #6
  %55 = load i8*, i8** bitcast (i32** @b to i8**), align 8, !tbaa !2
  tail call void @free(i8* %55) #6
  %56 = load i8*, i8** bitcast (i32** @c to i8**), align 8, !tbaa !2
  tail call void @free(i8* %56) #6
  ret i32 0

vector.body23.1:                                  ; preds = %vector.body23
  %57 = add nuw nsw i64 %index.next26, %27
  %58 = getelementptr inbounds i32, i32* %.cast, i64 %57
  %59 = bitcast i32* %58 to <4 x i32>*
  %wide.load.1 = load <4 x i32>, <4 x i32>* %59, align 4, !tbaa !6
  %60 = getelementptr inbounds i32, i32* %58, i64 4
  %61 = bitcast i32* %60 to <4 x i32>*
  %wide.load30.1 = load <4 x i32>, <4 x i32>* %61, align 4, !tbaa !6
  %62 = getelementptr inbounds i32, i32* %.cast18, i64 %index.next26
  %63 = bitcast i32* %62 to <4 x i32>*
  %wide.load31.1 = load <4 x i32>, <4 x i32>* %63, align 4, !tbaa !6
  %64 = getelementptr inbounds i32, i32* %62, i64 4
  %65 = bitcast i32* %64 to <4 x i32>*
  %wide.load32.1 = load <4 x i32>, <4 x i32>* %65, align 4, !tbaa !6
  %66 = mul nsw <4 x i32> %wide.load31.1, %wide.load.1
  %67 = mul nsw <4 x i32> %wide.load32.1, %wide.load30.1
  %68 = add <4 x i32> %66, %40
  %69 = add <4 x i32> %67, %41
  %index.next26.1 = add nuw nsw i64 %index25, 16
  br label %vector.body23
}

; Function Attrs: nofree nounwind
declare dso_local noalias i8* @malloc(i64) local_unnamed_addr #2

; Function Attrs: nounwind
declare dso_local void @free(i8* nocapture) local_unnamed_addr #4

; Function Attrs: argmemonly nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #5

attributes #0 = { nofree norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nofree nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { argmemonly nounwind willreturn writeonly }
attributes #6 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 11.0.0 (https://github.com/prithayan/llvm-project.git 8fd35f88270ed30453c9ed4bbf8c49488858805d)"}
!2 = !{!3, !3, i64 0}
!3 = !{!"any pointer", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{!7, !7, i64 0}
!7 = !{!"int", !4, i64 0}
!8 = distinct !{!8, !9}
!9 = !{!"llvm.loop.isvectorized", i32 1}
!10 = distinct !{!10, !9}
!11 = distinct !{!11, !9}
