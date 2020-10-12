; __CLANG_OFFLOAD_BUNDLE____START__ host-x86_64-unknown-linux-gnu
; ModuleID = '/tmp/DRACC022_OMP_MxV_Missing_Data_yes-dc4c32.bc'
source_filename = "DRACC022_OMP_MxV_Missing_Data_yes.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.ident_t = type { i32, i32, i32, i32, i8* }
%struct.__tgt_offload_entry = type { i8*, i8*, i64, i32, i32 }

@b = dso_local local_unnamed_addr global i32* null, align 8, !dbg !0
@a = dso_local local_unnamed_addr global i32* null, align 8, !dbg !12
@c = dso_local local_unnamed_addr global i32* null, align 8, !dbg !16
@.str = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@0 = private unnamed_addr constant %struct.ident_t { i32 0, i32 2050, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@1 = private unnamed_addr constant [49 x i8] c";DRACC022_OMP_MxV_Missing_Data_yes.c;Mult;32;9;;\00", align 1
@2 = private unnamed_addr constant %struct.ident_t { i32 0, i32 514, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@3 = private unnamed_addr constant [50 x i8] c";DRACC022_OMP_MxV_Missing_Data_yes.c;Mult;32;50;;\00", align 1
@4 = private unnamed_addr constant %struct.ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@.__omp_offloading_802_12c6a1c_Mult_l30.region_id = weak constant i8 0
@.offload_sizes = private unnamed_addr constant [3 x i64] zeroinitializer
@.offload_maptypes = private unnamed_addr constant [3 x i64] [i64 544, i64 544, i64 544]
@.str.3 = private unnamed_addr constant [23 x i8] c"Data Race occured: %s\0A\00", align 1
@.str.4 = private unnamed_addr constant [5 x i8] c"true\00", align 1
@.str.5 = private unnamed_addr constant [6 x i8] c"false\00", align 1
@.omp_offloading.entry_name = internal unnamed_addr constant [38 x i8] c"__omp_offloading_802_12c6a1c_Mult_l30\00"
@.omp_offloading.entry.__omp_offloading_802_12c6a1c_Mult_l30 = weak local_unnamed_addr constant %struct.__tgt_offload_entry { i8* @.__omp_offloading_802_12c6a1c_Mult_l30.region_id, i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.omp_offloading.entry_name, i32 0, i32 0), i64 0, i32 0, i32 0 }, section "omp_offloading_entries", align 1
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 0, void ()* @.omp_offloading.requires_reg, i8* null }]

; Function Attrs: nofree noinline norecurse nounwind uwtable
define dso_local i32 @init() local_unnamed_addr #0 !dbg !23 {
entry:
  call void @llvm.dbg.value(metadata i32 0, metadata !27, metadata !DIExpression()), !dbg !33
  %0 = load i32*, i32** @b, align 8, !dbg !34, !tbaa !37
  %1 = load i32*, i32** @a, align 8, !dbg !41, !tbaa !37
  %2 = load i32*, i32** @c, align 8, !dbg !41, !tbaa !37
  br label %for.cond1.preheader, !dbg !42

for.cond1.preheader:                              ; preds = %for.cond.cleanup3, %entry
  %indvars.iv12 = phi i64 [ 0, %entry ], [ %indvars.iv.next13, %for.cond.cleanup3 ]
  call void @llvm.dbg.value(metadata i64 %indvars.iv12, metadata !27, metadata !DIExpression()), !dbg !33
  call void @llvm.dbg.value(metadata i32 0, metadata !29, metadata !DIExpression()), !dbg !43
  %3 = mul nuw nsw i64 %indvars.iv12, 5000, !dbg !34
  br label %for.body4, !dbg !44

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3
  ret i32 0, !dbg !45

for.cond.cleanup3:                                ; preds = %for.body4
  %arrayidx6 = getelementptr inbounds i32, i32* %1, i64 %indvars.iv12, !dbg !46
  store i32 1, i32* %arrayidx6, align 4, !dbg !47, !tbaa !48
  %arrayidx8 = getelementptr inbounds i32, i32* %2, i64 %indvars.iv12, !dbg !50
  store i32 0, i32* %arrayidx8, align 4, !dbg !51, !tbaa !48
  %indvars.iv.next13 = add nuw nsw i64 %indvars.iv12, 1, !dbg !52
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next13, metadata !27, metadata !DIExpression()), !dbg !33
  %exitcond15 = icmp eq i64 %indvars.iv.next13, 5000, !dbg !53
  br i1 %exitcond15, label %for.cond.cleanup, label %for.cond1.preheader, !dbg !42, !llvm.loop !54

for.body4:                                        ; preds = %for.body4, %for.cond1.preheader
  %indvars.iv = phi i64 [ 0, %for.cond1.preheader ], [ %indvars.iv.next.4, %for.body4 ]
  call void @llvm.dbg.value(metadata i64 %indvars.iv, metadata !29, metadata !DIExpression()), !dbg !43
  %4 = add nuw nsw i64 %indvars.iv, %3, !dbg !56
  %arrayidx = getelementptr inbounds i32, i32* %0, i64 %4, !dbg !57
  store i32 1, i32* %arrayidx, align 4, !dbg !58, !tbaa !48
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !59
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next, metadata !29, metadata !DIExpression()), !dbg !43
  %5 = add nuw nsw i64 %indvars.iv.next, %3, !dbg !56
  %arrayidx.1 = getelementptr inbounds i32, i32* %0, i64 %5, !dbg !57
  store i32 1, i32* %arrayidx.1, align 4, !dbg !58, !tbaa !48
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv, 2, !dbg !59
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.1, metadata !29, metadata !DIExpression()), !dbg !43
  %6 = add nuw nsw i64 %indvars.iv.next.1, %3, !dbg !56
  %arrayidx.2 = getelementptr inbounds i32, i32* %0, i64 %6, !dbg !57
  store i32 1, i32* %arrayidx.2, align 4, !dbg !58, !tbaa !48
  %indvars.iv.next.2 = add nuw nsw i64 %indvars.iv, 3, !dbg !59
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.2, metadata !29, metadata !DIExpression()), !dbg !43
  %7 = add nuw nsw i64 %indvars.iv.next.2, %3, !dbg !56
  %arrayidx.3 = getelementptr inbounds i32, i32* %0, i64 %7, !dbg !57
  store i32 1, i32* %arrayidx.3, align 4, !dbg !58, !tbaa !48
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv, 4, !dbg !59
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.3, metadata !29, metadata !DIExpression()), !dbg !43
  %8 = add nuw nsw i64 %indvars.iv.next.3, %3, !dbg !56
  %arrayidx.4 = getelementptr inbounds i32, i32* %0, i64 %8, !dbg !57
  store i32 1, i32* %arrayidx.4, align 4, !dbg !58, !tbaa !48
  %indvars.iv.next.4 = add nuw nsw i64 %indvars.iv, 5, !dbg !59
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.4, metadata !29, metadata !DIExpression()), !dbg !43
  %exitcond.4 = icmp eq i64 %indvars.iv.next.4, 5000, !dbg !60
  br i1 %exitcond.4, label %for.cond.cleanup3, label %for.body4, !dbg !44, !llvm.loop !61
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @Mult() local_unnamed_addr #2 !dbg !63 {
entry:
  %.offload_baseptrs = alloca [3 x i8*], align 8
  %.offload_ptrs = alloca [3 x i8*], align 8
  %0 = load i32*, i32** @c, align 8, !dbg !69, !tbaa !37
  %1 = load i32*, i32** @b, align 8, !dbg !69, !tbaa !37
  %2 = load i32*, i32** @a, align 8, !dbg !69, !tbaa !37
  %3 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_baseptrs, i64 0, i64 0, !dbg !69
  %4 = bitcast [3 x i8*]* %.offload_baseptrs to i32**, !dbg !69
  store i32* %0, i32** %4, align 8, !dbg !69
  %5 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_ptrs, i64 0, i64 0, !dbg !69
  %6 = bitcast [3 x i8*]* %.offload_ptrs to i32**, !dbg !69
  store i32* %0, i32** %6, align 8, !dbg !69
  %7 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_baseptrs, i64 0, i64 1, !dbg !69
  %8 = bitcast i8** %7 to i32**, !dbg !69
  store i32* %1, i32** %8, align 8, !dbg !69
  %9 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_ptrs, i64 0, i64 1, !dbg !69
  %10 = bitcast i8** %9 to i32**, !dbg !69
  store i32* %1, i32** %10, align 8, !dbg !69
  %11 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_baseptrs, i64 0, i64 2, !dbg !69
  %12 = bitcast i8** %11 to i32**, !dbg !69
  store i32* %2, i32** %12, align 8, !dbg !69
  %13 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_ptrs, i64 0, i64 2, !dbg !69
  %14 = bitcast i8** %13 to i32**, !dbg !69
  store i32* %2, i32** %14, align 8, !dbg !69
  tail call void @__kmpc_push_target_tripcount(i64 -1, i64 5000) #4, !dbg !69
  %15 = call i32 @__tgt_target_teams(i64 -1, i8* nonnull @.__omp_offloading_802_12c6a1c_Mult_l30.region_id, i32 3, i8** nonnull %3, i8** nonnull %5, i64* getelementptr inbounds ([3 x i64], [3 x i64]* @.offload_sizes, i64 0, i64 0), i64* getelementptr inbounds ([3 x i64], [3 x i64]* @.offload_maptypes, i64 0, i64 0), i32 0, i32 0) #4, !dbg !69
  %16 = icmp eq i32 %15, 0, !dbg !69
  br i1 %16, label %omp_offload.cont, label %omp_offload.failed, !dbg !69

omp_offload.failed:                               ; preds = %entry
  call fastcc void @__omp_offloading_802_12c6a1c_Mult_l30(i32* %0, i32* %1, i32* %2) #4, !dbg !70
  br label %omp_offload.cont, !dbg !69

omp_offload.cont:                                 ; preds = %entry, %omp_offload.failed
  ret i32 0, !dbg !72
}

; Function Attrs: noinline norecurse nounwind uwtable
define internal fastcc void @__omp_offloading_802_12c6a1c_Mult_l30_debug__(i32* %c, i32* %b, i32* %a) unnamed_addr #3 !dbg !73 {
entry:
  %c.addr = alloca i32*, align 8
  %b.addr = alloca i32*, align 8
  %a.addr = alloca i32*, align 8
  %.kmpc_loc.addr = alloca %struct.ident_t, align 8
  %0 = bitcast %struct.ident_t* %.kmpc_loc.addr to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(24) %0, i8* nonnull align 8 dereferenceable(24) bitcast (%struct.ident_t* @4 to i8*), i64 16, i1 false)
  call void @llvm.dbg.value(metadata i32* %c, metadata !77, metadata !DIExpression()), !dbg !80
  store i32* %c, i32** %c.addr, align 8, !tbaa !37
  call void @llvm.dbg.value(metadata i32* %b, metadata !78, metadata !DIExpression()), !dbg !80
  store i32* %b, i32** %b.addr, align 8, !tbaa !37
  call void @llvm.dbg.value(metadata i32* %a, metadata !79, metadata !DIExpression()), !dbg !80
  store i32* %a, i32** %a.addr, align 8, !tbaa !37
  %1 = getelementptr inbounds %struct.ident_t, %struct.ident_t* %.kmpc_loc.addr, i64 0, i32 4, !dbg !81
  store i8* getelementptr inbounds ([49 x i8], [49 x i8]* @1, i64 0, i64 0), i8** %1, align 8, !dbg !81, !tbaa !83
  call void @llvm.dbg.value(metadata i32** %c.addr, metadata !77, metadata !DIExpression(DW_OP_deref)), !dbg !80
  call void @llvm.dbg.value(metadata i32** %b.addr, metadata !78, metadata !DIExpression(DW_OP_deref)), !dbg !80
  call void @llvm.dbg.value(metadata i32** %a.addr, metadata !79, metadata !DIExpression(DW_OP_deref)), !dbg !80
  call void (%struct.ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_teams(%struct.ident_t* nonnull %.kmpc_loc.addr, i32 3, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, i32**, i32**, i32**)* @.omp_outlined..2 to void (i32*, i32*, ...)*), i32** nonnull %c.addr, i32** nonnull %b.addr, i32** nonnull %a.addr) #4, !dbg !81
  ret void, !dbg !85
}

; Function Attrs: noinline norecurse nounwind uwtable
define internal fastcc void @.omp_outlined._debug__(i32 %.global_tid..val, i32** dereferenceable(8) %c, i32** dereferenceable(8) %b, i32** dereferenceable(8) %a) unnamed_addr #3 !dbg !86 {
entry:
  %.omp.comb.lb = alloca i32, align 4
  %.omp.comb.ub = alloca i32, align 4
  %.omp.stride = alloca i32, align 4
  %.omp.is_last = alloca i32, align 4
  %.kmpc_loc.addr = alloca %struct.ident_t, align 8
  %0 = bitcast %struct.ident_t* %.kmpc_loc.addr to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(24) %0, i8* nonnull align 8 dereferenceable(24) bitcast (%struct.ident_t* @0 to i8*), i64 16, i1 false)
  call void @llvm.dbg.value(metadata i32* undef, metadata !96, metadata !DIExpression()), !dbg !106
  call void @llvm.dbg.value(metadata i32** %c, metadata !97, metadata !DIExpression()), !dbg !106
  call void @llvm.dbg.value(metadata i32** %b, metadata !98, metadata !DIExpression()), !dbg !106
  call void @llvm.dbg.value(metadata i32** %a, metadata !99, metadata !DIExpression()), !dbg !106
  %1 = bitcast i32* %.omp.comb.lb to i8*, !dbg !107
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %1) #4, !dbg !107
  call void @llvm.dbg.value(metadata i32 0, metadata !101, metadata !DIExpression()), !dbg !106
  store i32 0, i32* %.omp.comb.lb, align 4, !dbg !108, !tbaa !48
  %2 = bitcast i32* %.omp.comb.ub to i8*, !dbg !107
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %2) #4, !dbg !107
  call void @llvm.dbg.value(metadata i32 4999, metadata !102, metadata !DIExpression()), !dbg !106
  store i32 4999, i32* %.omp.comb.ub, align 4, !dbg !108, !tbaa !48
  %3 = bitcast i32* %.omp.stride to i8*, !dbg !107
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %3) #4, !dbg !107
  call void @llvm.dbg.value(metadata i32 1, metadata !103, metadata !DIExpression()), !dbg !106
  store i32 1, i32* %.omp.stride, align 4, !dbg !108, !tbaa !48
  %4 = bitcast i32* %.omp.is_last to i8*, !dbg !107
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %4) #4, !dbg !107
  call void @llvm.dbg.value(metadata i32 0, metadata !104, metadata !DIExpression()), !dbg !106
  store i32 0, i32* %.omp.is_last, align 4, !dbg !108, !tbaa !48
  %5 = getelementptr inbounds %struct.ident_t, %struct.ident_t* %.kmpc_loc.addr, i64 0, i32 4, !dbg !107
  store i8* getelementptr inbounds ([49 x i8], [49 x i8]* @1, i64 0, i64 0), i8** %5, align 8, !dbg !107, !tbaa !83
  call void @llvm.dbg.value(metadata i32* %.omp.comb.lb, metadata !101, metadata !DIExpression(DW_OP_deref)), !dbg !106
  call void @llvm.dbg.value(metadata i32* %.omp.comb.ub, metadata !102, metadata !DIExpression(DW_OP_deref)), !dbg !106
  call void @llvm.dbg.value(metadata i32* %.omp.stride, metadata !103, metadata !DIExpression(DW_OP_deref)), !dbg !106
  call void @llvm.dbg.value(metadata i32* %.omp.is_last, metadata !104, metadata !DIExpression(DW_OP_deref)), !dbg !106
  call void @__kmpc_for_static_init_4(%struct.ident_t* nonnull %.kmpc_loc.addr, i32 %.global_tid..val, i32 92, i32* nonnull %.omp.is_last, i32* nonnull %.omp.comb.lb, i32* nonnull %.omp.comb.ub, i32* nonnull %.omp.stride, i32 1, i32 1) #4, !dbg !107
  %6 = load i32, i32* %.omp.comb.ub, align 4, !dbg !108, !tbaa !48
  call void @llvm.dbg.value(metadata i32 %6, metadata !102, metadata !DIExpression()), !dbg !106
  %7 = icmp slt i32 %6, 4999, !dbg !108
  %cond = select i1 %7, i32 %6, i32 4999, !dbg !108
  call void @llvm.dbg.value(metadata i32 %cond, metadata !102, metadata !DIExpression()), !dbg !106
  store i32 %cond, i32* %.omp.comb.ub, align 4, !dbg !108, !tbaa !48
  %8 = load i32, i32* %.omp.comb.lb, align 4, !dbg !108, !tbaa !48
  call void @llvm.dbg.value(metadata i32 %8, metadata !101, metadata !DIExpression()), !dbg !106
  call void @llvm.dbg.value(metadata i32 %8, metadata !100, metadata !DIExpression()), !dbg !106
  call void @llvm.dbg.value(metadata i32 %cond, metadata !102, metadata !DIExpression()), !dbg !106
  %cmp11 = icmp sgt i32 %8, %cond, !dbg !107
  br i1 %cmp11, label %omp.loop.exit, label %omp.inner.for.body.preheader, !dbg !107

omp.inner.for.body.preheader:                     ; preds = %entry
  call void @llvm.dbg.value(metadata i32 %8, metadata !100, metadata !DIExpression()), !dbg !106
  call void @llvm.dbg.value(metadata i32 %8, metadata !101, metadata !DIExpression()), !dbg !106
  %9 = zext i32 %8 to i64, !dbg !109
  %10 = zext i32 %cond to i64, !dbg !109
  store i8* getelementptr inbounds ([49 x i8], [49 x i8]* @1, i64 0, i64 0), i8** %5, align 8, !dbg !109, !tbaa !83
  call void (%struct.ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%struct.ident_t* nonnull %.kmpc_loc.addr, i32 5, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, i64, i64, i32**, i32**, i32**)* @.omp_outlined. to void (i32*, i32*, ...)*), i64 %9, i64 %10, i32** nonnull %c, i32** nonnull %b, i32** nonnull %a) #4, !dbg !109
  %11 = load i32, i32* %.omp.stride, align 4, !dbg !108, !tbaa !48
  call void @llvm.dbg.value(metadata i32 %11, metadata !103, metadata !DIExpression()), !dbg !106
  %add3 = add nsw i32 %11, %8, !dbg !107
  call void @llvm.dbg.value(metadata i32 %add3, metadata !100, metadata !DIExpression()), !dbg !106
  %12 = load i32, i32* %.omp.comb.ub, align 4, !dbg !108, !tbaa !48
  call void @llvm.dbg.value(metadata i32 %12, metadata !102, metadata !DIExpression()), !dbg !106
  %cmp14 = icmp sgt i32 %add3, %12, !dbg !107
  br i1 %cmp14, label %omp.loop.exit, label %omp.inner.for.body.omp.inner.for.body_crit_edge, !dbg !107, !llvm.loop !110

omp.inner.for.body.omp.inner.for.body_crit_edge:  ; preds = %omp.inner.for.body.preheader, %omp.inner.for.body.omp.inner.for.body_crit_edge
  %13 = phi i32 [ %17, %omp.inner.for.body.omp.inner.for.body_crit_edge ], [ %12, %omp.inner.for.body.preheader ]
  %add5 = phi i32 [ %add, %omp.inner.for.body.omp.inner.for.body_crit_edge ], [ %add3, %omp.inner.for.body.preheader ]
  %.pre = load i32, i32* %.omp.comb.lb, align 4, !dbg !109
  call void @llvm.dbg.value(metadata i32 %add5, metadata !100, metadata !DIExpression()), !dbg !106
  call void @llvm.dbg.value(metadata i32 %.pre, metadata !101, metadata !DIExpression()), !dbg !106
  %14 = zext i32 %.pre to i64, !dbg !109
  %15 = zext i32 %13 to i64, !dbg !109
  store i8* getelementptr inbounds ([49 x i8], [49 x i8]* @1, i64 0, i64 0), i8** %5, align 8, !dbg !109, !tbaa !83
  call void (%struct.ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%struct.ident_t* nonnull %.kmpc_loc.addr, i32 5, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, i64, i64, i32**, i32**, i32**)* @.omp_outlined. to void (i32*, i32*, ...)*), i64 %14, i64 %15, i32** nonnull %c, i32** nonnull %b, i32** nonnull %a) #4, !dbg !109
  %16 = load i32, i32* %.omp.stride, align 4, !dbg !108, !tbaa !48
  call void @llvm.dbg.value(metadata i32 %16, metadata !103, metadata !DIExpression()), !dbg !106
  %add = add nsw i32 %16, %add5, !dbg !107
  call void @llvm.dbg.value(metadata i32 %add, metadata !100, metadata !DIExpression()), !dbg !106
  %17 = load i32, i32* %.omp.comb.ub, align 4, !dbg !108, !tbaa !48
  call void @llvm.dbg.value(metadata i32 %17, metadata !102, metadata !DIExpression()), !dbg !106
  %cmp1 = icmp sgt i32 %add, %17, !dbg !107
  br i1 %cmp1, label %omp.loop.exit, label %omp.inner.for.body.omp.inner.for.body_crit_edge, !dbg !107, !llvm.loop !110

omp.loop.exit:                                    ; preds = %omp.inner.for.body.omp.inner.for.body_crit_edge, %omp.inner.for.body.preheader, %entry
  store i8* getelementptr inbounds ([50 x i8], [50 x i8]* @3, i64 0, i64 0), i8** %5, align 8, !dbg !112, !tbaa !83
  call void @__kmpc_for_static_fini(%struct.ident_t* nonnull %.kmpc_loc.addr, i32 %.global_tid..val) #4, !dbg !111
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %4) #4, !dbg !112
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %3) #4, !dbg !112
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %2) #4, !dbg !112
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %1) #4, !dbg !112
  ret void, !dbg !114
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #1

declare dso_local void @__kmpc_for_static_init_4(%struct.ident_t*, i32, i32, i32*, i32*, i32*, i32*, i32, i32) local_unnamed_addr

; Function Attrs: noinline norecurse nounwind uwtable
define internal fastcc void @.omp_outlined._debug__.1(i32 %.global_tid..val, i64 %.previous.lb., i64 %.previous.ub., i32** nocapture readonly dereferenceable(8) %c, i32** nocapture readonly dereferenceable(8) %b, i32** nocapture readonly dereferenceable(8) %a) unnamed_addr #3 !dbg !115 {
entry:
  %.omp.lb = alloca i32, align 4
  %.omp.ub = alloca i32, align 4
  %.omp.stride = alloca i32, align 4
  %.omp.is_last = alloca i32, align 4
  %.kmpc_loc.addr = alloca %struct.ident_t, align 8
  %0 = bitcast %struct.ident_t* %.kmpc_loc.addr to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(24) %0, i8* nonnull align 8 dereferenceable(24) bitcast (%struct.ident_t* @2 to i8*), i64 16, i1 false)
  call void @llvm.dbg.value(metadata i32* undef, metadata !122, metadata !DIExpression()), !dbg !137
  call void @llvm.dbg.value(metadata i64 %.previous.lb., metadata !123, metadata !DIExpression()), !dbg !137
  call void @llvm.dbg.value(metadata i64 %.previous.ub., metadata !124, metadata !DIExpression()), !dbg !137
  call void @llvm.dbg.value(metadata i32** %c, metadata !125, metadata !DIExpression()), !dbg !137
  call void @llvm.dbg.value(metadata i32** %b, metadata !126, metadata !DIExpression()), !dbg !137
  call void @llvm.dbg.value(metadata i32** %a, metadata !127, metadata !DIExpression()), !dbg !137
  %1 = bitcast i32* %.omp.lb to i8*, !dbg !138
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %1) #4, !dbg !138
  call void @llvm.dbg.value(metadata i32 0, metadata !129, metadata !DIExpression()), !dbg !137
  %2 = bitcast i32* %.omp.ub to i8*, !dbg !138
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %2) #4, !dbg !138
  call void @llvm.dbg.value(metadata i32 4999, metadata !130, metadata !DIExpression()), !dbg !137
  %conv = trunc i64 %.previous.lb. to i32, !dbg !138
  %conv1 = trunc i64 %.previous.ub. to i32, !dbg !138
  call void @llvm.dbg.value(metadata i32 %conv, metadata !129, metadata !DIExpression()), !dbg !137
  store i32 %conv, i32* %.omp.lb, align 4, !dbg !138, !tbaa !48
  call void @llvm.dbg.value(metadata i32 %conv1, metadata !130, metadata !DIExpression()), !dbg !137
  store i32 %conv1, i32* %.omp.ub, align 4, !dbg !138, !tbaa !48
  %3 = bitcast i32* %.omp.stride to i8*, !dbg !138
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %3) #4, !dbg !138
  call void @llvm.dbg.value(metadata i32 1, metadata !131, metadata !DIExpression()), !dbg !137
  store i32 1, i32* %.omp.stride, align 4, !dbg !139, !tbaa !48
  %4 = bitcast i32* %.omp.is_last to i8*, !dbg !138
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %4) #4, !dbg !138
  call void @llvm.dbg.value(metadata i32 0, metadata !132, metadata !DIExpression()), !dbg !137
  store i32 0, i32* %.omp.is_last, align 4, !dbg !139, !tbaa !48
  %5 = getelementptr inbounds %struct.ident_t, %struct.ident_t* %.kmpc_loc.addr, i64 0, i32 4, !dbg !138
  store i8* getelementptr inbounds ([49 x i8], [49 x i8]* @1, i64 0, i64 0), i8** %5, align 8, !dbg !138, !tbaa !83
  call void @llvm.dbg.value(metadata i32* %.omp.lb, metadata !129, metadata !DIExpression(DW_OP_deref)), !dbg !137
  call void @llvm.dbg.value(metadata i32* %.omp.ub, metadata !130, metadata !DIExpression(DW_OP_deref)), !dbg !137
  call void @llvm.dbg.value(metadata i32* %.omp.stride, metadata !131, metadata !DIExpression(DW_OP_deref)), !dbg !137
  call void @llvm.dbg.value(metadata i32* %.omp.is_last, metadata !132, metadata !DIExpression(DW_OP_deref)), !dbg !137
  call void @__kmpc_for_static_init_4(%struct.ident_t* nonnull %.kmpc_loc.addr, i32 %.global_tid..val, i32 34, i32* nonnull %.omp.is_last, i32* nonnull %.omp.lb, i32* nonnull %.omp.ub, i32* nonnull %.omp.stride, i32 1, i32 1) #4, !dbg !140
  %6 = load i32, i32* %.omp.ub, align 4, !dbg !139, !tbaa !48
  call void @llvm.dbg.value(metadata i32 %6, metadata !130, metadata !DIExpression()), !dbg !137
  %7 = icmp slt i32 %6, 4999, !dbg !139
  %cond = select i1 %7, i32 %6, i32 4999, !dbg !139
  call void @llvm.dbg.value(metadata i32 %cond, metadata !130, metadata !DIExpression()), !dbg !137
  store i32 %cond, i32* %.omp.ub, align 4, !dbg !139, !tbaa !48
  %8 = load i32, i32* %.omp.lb, align 4, !dbg !139, !tbaa !48
  call void @llvm.dbg.value(metadata i32 %8, metadata !129, metadata !DIExpression()), !dbg !137
  call void @llvm.dbg.value(metadata i32 %8, metadata !128, metadata !DIExpression()), !dbg !137
  call void @llvm.dbg.value(metadata i32 %cond, metadata !130, metadata !DIExpression()), !dbg !137
  %cmp32 = icmp sgt i32 %8, %cond, !dbg !138
  br i1 %cmp32, label %omp.loop.exit, label %for.cond.preheader.lr.ph, !dbg !138

for.cond.preheader.lr.ph:                         ; preds = %entry
  %9 = load i32*, i32** %b, align 8, !dbg !141, !tbaa !37
  %10 = load i32*, i32** %a, align 8, !dbg !141, !tbaa !37
  %11 = load i32*, i32** %c, align 8, !dbg !141, !tbaa !37
  %12 = sext i32 %8 to i64, !dbg !138
  br label %for.cond.preheader, !dbg !138

for.cond.preheader:                               ; preds = %for.cond.cleanup, %for.cond.preheader.lr.ph
  %indvars.iv5 = phi i64 [ %indvars.iv.next6, %for.cond.cleanup ], [ %12, %for.cond.preheader.lr.ph ]
  call void @llvm.dbg.value(metadata i64 %indvars.iv5, metadata !128, metadata !DIExpression()), !dbg !137
  call void @llvm.dbg.value(metadata i32 0, metadata !134, metadata !DIExpression()), !dbg !144
  %13 = mul nsw i64 %indvars.iv5, 5000, !dbg !141
  %arrayidx13 = getelementptr inbounds i32, i32* %11, i64 %indvars.iv5, !dbg !141
  %.pre = load i32, i32* %arrayidx13, align 4, !dbg !145, !tbaa !48
  br label %for.body, !dbg !146

for.cond.cleanup:                                 ; preds = %for.body
  %indvars.iv.next6 = add nsw i64 %indvars.iv5, 1, !dbg !138
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next6, metadata !128, metadata !DIExpression()), !dbg !137
  %14 = load i32, i32* %.omp.ub, align 4, !dbg !139, !tbaa !48
  call void @llvm.dbg.value(metadata i32 %14, metadata !130, metadata !DIExpression()), !dbg !137
  %15 = sext i32 %14 to i64, !dbg !138
  %cmp3 = icmp slt i64 %indvars.iv5, %15, !dbg !138
  br i1 %cmp3, label %for.cond.preheader, label %omp.loop.exit, !dbg !138, !llvm.loop !147

for.body:                                         ; preds = %for.body, %for.cond.preheader
  %16 = phi i32 [ %.pre, %for.cond.preheader ], [ %add14.1, %for.body ], !dbg !145
  %indvars.iv = phi i64 [ 0, %for.cond.preheader ], [ %indvars.iv.next.1, %for.body ]
  call void @llvm.dbg.value(metadata i64 %indvars.iv, metadata !134, metadata !DIExpression()), !dbg !144
  %17 = add nsw i64 %indvars.iv, %13, !dbg !149
  %arrayidx = getelementptr inbounds i32, i32* %9, i64 %17, !dbg !150
  %18 = load i32, i32* %arrayidx, align 4, !dbg !150, !tbaa !48
  %arrayidx10 = getelementptr inbounds i32, i32* %10, i64 %indvars.iv, !dbg !151
  %19 = load i32, i32* %arrayidx10, align 4, !dbg !151, !tbaa !48
  %mul11 = mul nsw i32 %19, %18, !dbg !152
  %add14 = add nsw i32 %16, %mul11, !dbg !145
  store i32 %add14, i32* %arrayidx13, align 4, !dbg !145, !tbaa !48
  %indvars.iv.next = or i64 %indvars.iv, 1, !dbg !153
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next, metadata !134, metadata !DIExpression()), !dbg !144
  %20 = add nsw i64 %indvars.iv.next, %13, !dbg !149
  %arrayidx.1 = getelementptr inbounds i32, i32* %9, i64 %20, !dbg !150
  %21 = load i32, i32* %arrayidx.1, align 4, !dbg !150, !tbaa !48
  %arrayidx10.1 = getelementptr inbounds i32, i32* %10, i64 %indvars.iv.next, !dbg !151
  %22 = load i32, i32* %arrayidx10.1, align 4, !dbg !151, !tbaa !48
  %mul11.1 = mul nsw i32 %22, %21, !dbg !152
  %add14.1 = add nsw i32 %add14, %mul11.1, !dbg !145
  store i32 %add14.1, i32* %arrayidx13, align 4, !dbg !145, !tbaa !48
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv, 2, !dbg !153
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.1, metadata !134, metadata !DIExpression()), !dbg !144
  %exitcond.1 = icmp eq i64 %indvars.iv.next.1, 5000, !dbg !154
  br i1 %exitcond.1, label %for.cond.cleanup, label %for.body, !dbg !146, !llvm.loop !155

omp.loop.exit:                                    ; preds = %for.cond.cleanup, %entry
  store i8* getelementptr inbounds ([50 x i8], [50 x i8]* @3, i64 0, i64 0), i8** %5, align 8, !dbg !140, !tbaa !83
  call void @__kmpc_for_static_fini(%struct.ident_t* nonnull %.kmpc_loc.addr, i32 %.global_tid..val) #4, !dbg !148
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %4) #4, !dbg !140
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %3) #4, !dbg !140
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %2) #4, !dbg !140
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %1) #4, !dbg !140
  ret void, !dbg !157
}

declare dso_local void @__kmpc_for_static_fini(%struct.ident_t*, i32) local_unnamed_addr

; Function Attrs: noinline norecurse nounwind uwtable
define internal void @.omp_outlined.(i32* noalias nocapture readonly %.global_tid., i32* noalias nocapture readnone %.bound_tid., i64 %.previous.lb., i64 %.previous.ub., i32** nocapture readonly dereferenceable(8) %c, i32** nocapture readonly dereferenceable(8) %b, i32** nocapture readonly dereferenceable(8) %a) #3 !dbg !158 {
entry:
  call void @llvm.dbg.value(metadata i32* %.global_tid., metadata !160, metadata !DIExpression()), !dbg !167
  call void @llvm.dbg.value(metadata i32* %.bound_tid., metadata !161, metadata !DIExpression()), !dbg !167
  call void @llvm.dbg.value(metadata i64 %.previous.lb., metadata !162, metadata !DIExpression()), !dbg !167
  call void @llvm.dbg.value(metadata i64 %.previous.ub., metadata !163, metadata !DIExpression()), !dbg !167
  call void @llvm.dbg.value(metadata i32** %c, metadata !164, metadata !DIExpression()), !dbg !167
  call void @llvm.dbg.value(metadata i32** %b, metadata !165, metadata !DIExpression()), !dbg !167
  call void @llvm.dbg.value(metadata i32** %a, metadata !166, metadata !DIExpression()), !dbg !167
  %.global_tid..val = load i32, i32* %.global_tid., align 4, !dbg !168, !tbaa !48
  tail call fastcc void @.omp_outlined._debug__.1(i32 %.global_tid..val, i64 %.previous.lb., i64 %.previous.ub., i32** nonnull %c, i32** nonnull %b, i32** nonnull %a) #4, !dbg !168
  ret void, !dbg !168
}

; Function Attrs: nounwind
declare !callback !169 dso_local void @__kmpc_fork_call(%struct.ident_t*, i32, void (i32*, i32*, ...)*, ...) local_unnamed_addr #4

; Function Attrs: noinline norecurse nounwind uwtable
define internal void @.omp_outlined..2(i32* noalias nocapture readonly %.global_tid., i32* noalias nocapture readnone %.bound_tid., i32** dereferenceable(8) %c, i32** dereferenceable(8) %b, i32** dereferenceable(8) %a) #3 !dbg !171 {
entry:
  call void @llvm.dbg.value(metadata i32* %.global_tid., metadata !173, metadata !DIExpression()), !dbg !178
  call void @llvm.dbg.value(metadata i32* %.bound_tid., metadata !174, metadata !DIExpression()), !dbg !178
  call void @llvm.dbg.value(metadata i32** %c, metadata !175, metadata !DIExpression()), !dbg !178
  call void @llvm.dbg.value(metadata i32** %b, metadata !176, metadata !DIExpression()), !dbg !178
  call void @llvm.dbg.value(metadata i32** %a, metadata !177, metadata !DIExpression()), !dbg !178
  %.global_tid..val = load i32, i32* %.global_tid., align 4, !dbg !179, !tbaa !48
  tail call fastcc void @.omp_outlined._debug__(i32 %.global_tid..val, i32** nonnull %c, i32** nonnull %b, i32** nonnull %a) #4, !dbg !179
  ret void, !dbg !179
}

declare !callback !169 dso_local void @__kmpc_fork_teams(%struct.ident_t*, i32, void (i32*, i32*, ...)*, ...) local_unnamed_addr

; Function Attrs: noinline norecurse nounwind uwtable
define internal fastcc void @__omp_offloading_802_12c6a1c_Mult_l30(i32* %c, i32* %b, i32* %a) unnamed_addr #3 !dbg !180 {
entry:
  call void @llvm.dbg.value(metadata i32* %c, metadata !182, metadata !DIExpression()), !dbg !185
  call void @llvm.dbg.value(metadata i32* %b, metadata !183, metadata !DIExpression()), !dbg !185
  call void @llvm.dbg.value(metadata i32* %a, metadata !184, metadata !DIExpression()), !dbg !185
  tail call fastcc void @__omp_offloading_802_12c6a1c_Mult_l30_debug__(i32* %c, i32* %b, i32* %a) #4, !dbg !186
  ret void, !dbg !186
}

declare dso_local void @__kmpc_push_target_tripcount(i64, i64) local_unnamed_addr

declare dso_local i32 @__tgt_target_teams(i64, i8*, i32, i8**, i8**, i64*, i64*, i32, i32) local_unnamed_addr

; Function Attrs: nofree noinline nounwind uwtable
define dso_local i32 @check() local_unnamed_addr #5 !dbg !187 {
entry:
  call void @llvm.dbg.value(metadata i8 0, metadata !189, metadata !DIExpression()), !dbg !193
  call void @llvm.dbg.value(metadata i32 0, metadata !191, metadata !DIExpression()), !dbg !194
  %0 = load i32*, i32** @c, align 8, !dbg !195, !tbaa !37
  br label %for.body, !dbg !199

for.cond.cleanup:                                 ; preds = %for.body
  call void @llvm.dbg.value(metadata i8 %spec.select.4, metadata !189, metadata !DIExpression()), !dbg !193
  %1 = and i8 %spec.select.4, 1, !dbg !200
  %tobool = icmp eq i8 %1, 0, !dbg !200
  %cond = select i1 %tobool, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.4, i64 0, i64 0), !dbg !200
  %call = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([23 x i8], [23 x i8]* @.str.3, i64 0, i64 0), i8* %cond), !dbg !201
  ret i32 0, !dbg !202

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next.4, %for.body ]
  %test.04 = phi i8 [ 0, %entry ], [ %spec.select.4, %for.body ]
  call void @llvm.dbg.value(metadata i64 %indvars.iv, metadata !191, metadata !DIExpression()), !dbg !194
  call void @llvm.dbg.value(metadata i8 %test.04, metadata !189, metadata !DIExpression()), !dbg !193
  %arrayidx = getelementptr inbounds i32, i32* %0, i64 %indvars.iv, !dbg !203
  %2 = load i32, i32* %arrayidx, align 4, !dbg !203, !tbaa !48
  %cmp1 = icmp eq i32 %2, 5000, !dbg !204
  call void @llvm.dbg.value(metadata i8 undef, metadata !189, metadata !DIExpression()), !dbg !193
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !205
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next, metadata !191, metadata !DIExpression()), !dbg !194
  %arrayidx.1 = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next, !dbg !203
  %3 = load i32, i32* %arrayidx.1, align 4, !dbg !203, !tbaa !48
  %cmp1.1 = icmp eq i32 %3, 5000, !dbg !204
  %4 = and i1 %cmp1.1, %cmp1, !dbg !206
  call void @llvm.dbg.value(metadata i8 undef, metadata !189, metadata !DIExpression()), !dbg !193
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv, 2, !dbg !205
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.1, metadata !191, metadata !DIExpression()), !dbg !194
  %arrayidx.2 = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next.1, !dbg !203
  %5 = load i32, i32* %arrayidx.2, align 4, !dbg !203, !tbaa !48
  %cmp1.2 = icmp eq i32 %5, 5000, !dbg !204
  %6 = and i1 %cmp1.2, %4, !dbg !206
  call void @llvm.dbg.value(metadata i8 undef, metadata !189, metadata !DIExpression()), !dbg !193
  %indvars.iv.next.2 = add nuw nsw i64 %indvars.iv, 3, !dbg !205
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.2, metadata !191, metadata !DIExpression()), !dbg !194
  %arrayidx.3 = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next.2, !dbg !203
  %7 = load i32, i32* %arrayidx.3, align 4, !dbg !203, !tbaa !48
  %cmp1.3 = icmp eq i32 %7, 5000, !dbg !204
  %8 = and i1 %cmp1.3, %6, !dbg !206
  call void @llvm.dbg.value(metadata i8 undef, metadata !189, metadata !DIExpression()), !dbg !193
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv, 4, !dbg !205
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.3, metadata !191, metadata !DIExpression()), !dbg !194
  %arrayidx.4 = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next.3, !dbg !203
  %9 = load i32, i32* %arrayidx.4, align 4, !dbg !203, !tbaa !48
  %cmp1.4 = icmp eq i32 %9, 5000, !dbg !204
  %10 = and i1 %cmp1.4, %8, !dbg !206
  %spec.select.4 = select i1 %10, i8 %test.04, i8 1, !dbg !206
  call void @llvm.dbg.value(metadata i8 %spec.select.4, metadata !189, metadata !DIExpression()), !dbg !193
  %indvars.iv.next.4 = add nuw nsw i64 %indvars.iv, 5, !dbg !205
  call void @llvm.dbg.value(metadata i64 %indvars.iv.next.4, metadata !191, metadata !DIExpression()), !dbg !194
  %exitcond.4 = icmp eq i64 %indvars.iv.next.4, 5000, !dbg !207
  br i1 %exitcond.4, label %for.cond.cleanup, label %for.body, !dbg !199, !llvm.loop !208
}

; Function Attrs: nofree nounwind
declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #6

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #2 !dbg !210 {
entry:
  %call = tail call noalias dereferenceable_or_null(20000) i8* @malloc(i64 20000) #4, !dbg !211
  store i8* %call, i8** bitcast (i32** @a to i8**), align 8, !dbg !212, !tbaa !37
  %call1 = tail call noalias dereferenceable_or_null(100000000) i8* @malloc(i64 100000000) #4, !dbg !213
  store i8* %call1, i8** bitcast (i32** @b to i8**), align 8, !dbg !214, !tbaa !37
  %call2 = tail call noalias dereferenceable_or_null(20000) i8* @malloc(i64 20000) #4, !dbg !215
  store i8* %call2, i8** bitcast (i32** @c to i8**), align 8, !dbg !216, !tbaa !37
  %call3 = tail call i32 @init(), !dbg !217
  %call4 = tail call i32 @Mult(), !dbg !218
  %call5 = tail call i32 @check(), !dbg !219
  %0 = load i8*, i8** bitcast (i32** @a to i8**), align 8, !dbg !220, !tbaa !37
  tail call void @free(i8* %0) #4, !dbg !221
  %1 = load i8*, i8** bitcast (i32** @b to i8**), align 8, !dbg !222, !tbaa !37
  tail call void @free(i8* %1) #4, !dbg !223
  %2 = load i8*, i8** bitcast (i32** @c to i8**), align 8, !dbg !224, !tbaa !37
  tail call void @free(i8* %2) #4, !dbg !225
  ret i32 0, !dbg !226
}

; Function Attrs: nofree nounwind
declare dso_local noalias i8* @malloc(i64) local_unnamed_addr #6

; Function Attrs: nounwind
declare !dbg !6 dso_local void @free(i8* nocapture) local_unnamed_addr #7

; Function Attrs: noinline nounwind uwtable
define internal void @.omp_offloading.requires_reg() #2 section ".text.startup" !dbg !227 {
entry:
  tail call void @__tgt_register_requires(i64 1) #4
  ret void
}

declare dso_local void @__tgt_register_requires(i64) local_unnamed_addr

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #8

attributes #0 = { nofree noinline norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }
attributes #2 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noinline norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { nofree noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nofree nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!2}
!omp_offload.info = !{!18}
!llvm.module.flags = !{!19, !20, !21}
!llvm.ident = !{!22}

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
!18 = !{i32 0, i32 2050, i32 19687964, !"Mult", i32 30, i32 0}
!19 = !{i32 7, !"Dwarf Version", i32 4}
!20 = !{i32 2, !"Debug Info Version", i32 3}
!21 = !{i32 1, !"wchar_size", i32 4}
!22 = !{!"clang version 11.0.0 (https://github.com/prithayan/llvm-project.git 8fd35f88270ed30453c9ed4bbf8c49488858805d)"}
!23 = distinct !DISubprogram(name: "init", scope: !3, file: !3, line: 15, type: !24, scopeLine: 15, flags: DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !26)
!24 = !DISubroutineType(types: !25)
!25 = !{!15}
!26 = !{!27, !29}
!27 = !DILocalVariable(name: "i", scope: !28, file: !3, line: 16, type: !15)
!28 = distinct !DILexicalBlock(scope: !23, file: !3, line: 16, column: 5)
!29 = !DILocalVariable(name: "j", scope: !30, file: !3, line: 17, type: !15)
!30 = distinct !DILexicalBlock(scope: !31, file: !3, line: 17, column: 9)
!31 = distinct !DILexicalBlock(scope: !32, file: !3, line: 16, column: 27)
!32 = distinct !DILexicalBlock(scope: !28, file: !3, line: 16, column: 5)
!33 = !DILocation(line: 0, scope: !28)
!34 = !DILocation(line: 0, scope: !35)
!35 = distinct !DILexicalBlock(scope: !36, file: !3, line: 17, column: 31)
!36 = distinct !DILexicalBlock(scope: !30, file: !3, line: 17, column: 9)
!37 = !{!38, !38, i64 0}
!38 = !{!"any pointer", !39, i64 0}
!39 = !{!"omnipotent char", !40, i64 0}
!40 = !{!"Simple C/C++ TBAA"}
!41 = !DILocation(line: 0, scope: !31)
!42 = !DILocation(line: 16, column: 5, scope: !28)
!43 = !DILocation(line: 0, scope: !30)
!44 = !DILocation(line: 17, column: 9, scope: !30)
!45 = !DILocation(line: 23, column: 9, scope: !23)
!46 = !DILocation(line: 20, column: 9, scope: !31)
!47 = !DILocation(line: 20, column: 13, scope: !31)
!48 = !{!49, !49, i64 0}
!49 = !{!"int", !39, i64 0}
!50 = !DILocation(line: 21, column: 9, scope: !31)
!51 = !DILocation(line: 21, column: 13, scope: !31)
!52 = !DILocation(line: 16, column: 24, scope: !32)
!53 = !DILocation(line: 16, column: 19, scope: !32)
!54 = distinct !{!54, !42, !55}
!55 = !DILocation(line: 22, column: 5, scope: !28)
!56 = !DILocation(line: 18, column: 16, scope: !35)
!57 = !DILocation(line: 18, column: 13, scope: !35)
!58 = !DILocation(line: 18, column: 21, scope: !35)
!59 = !DILocation(line: 17, column: 28, scope: !36)
!60 = !DILocation(line: 17, column: 23, scope: !36)
!61 = distinct !{!61, !44, !62}
!62 = !DILocation(line: 19, column: 9, scope: !30)
!63 = distinct !DISubprogram(name: "Mult", scope: !3, file: !3, line: 27, type: !24, scopeLine: 27, flags: DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !64)
!64 = !{!65}
!65 = !DILocalVariable(name: "z", scope: !63, file: !3, line: 28, type: !66)
!66 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 32000, elements: !67)
!67 = !{!68, !68, !68}
!68 = !DISubrange(count: 10)
!69 = !DILocation(line: 30, column: 5, scope: !63)
!70 = !DILocation(line: 30, column: 5, scope: !71)
!71 = distinct !DILexicalBlock(scope: !63, file: !3, line: 30, column: 5)
!72 = !DILocation(line: 40, column: 5, scope: !63)
!73 = distinct !DISubprogram(name: "__omp_offloading_802_12c6a1c_Mult_l30_debug__", scope: !3, file: !3, line: 31, type: !74, scopeLine: 31, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !76)
!74 = !DISubroutineType(types: !75)
!75 = !{null, !14, !14, !14}
!76 = !{!77, !78, !79}
!77 = !DILocalVariable(name: "c", arg: 1, scope: !73, file: !3, line: 12, type: !14)
!78 = !DILocalVariable(name: "b", arg: 2, scope: !73, file: !3, line: 11, type: !14)
!79 = !DILocalVariable(name: "a", arg: 3, scope: !73, file: !3, line: 10, type: !14)
!80 = !DILocation(line: 0, scope: !73)
!81 = !DILocation(line: 32, column: 9, scope: !82)
!82 = distinct !DILexicalBlock(scope: !73, file: !3, line: 31, column: 5)
!83 = !{!84, !38, i64 16}
!84 = !{!"ident_t", !49, i64 0, !49, i64 4, !49, i64 8, !49, i64 12, !38, i64 16}
!85 = !DILocation(line: 38, column: 5, scope: !73)
!86 = distinct !DISubprogram(name: ".omp_outlined._debug__", scope: !3, file: !3, line: 33, type: !87, scopeLine: 33, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !94)
!87 = !DISubroutineType(types: !88)
!88 = !{null, !89, !89, !93, !93, !93}
!89 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !90)
!90 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !91)
!91 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !92, size: 64)
!92 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !15)
!93 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !14, size: 64)
!94 = !{!95, !96, !97, !98, !99, !100, !101, !102, !103, !104, !105}
!95 = !DILocalVariable(name: ".global_tid.", arg: 1, scope: !86, type: !89, flags: DIFlagArtificial)
!96 = !DILocalVariable(name: ".bound_tid.", arg: 2, scope: !86, type: !89, flags: DIFlagArtificial)
!97 = !DILocalVariable(name: "c", arg: 3, scope: !86, file: !3, line: 12, type: !93)
!98 = !DILocalVariable(name: "b", arg: 4, scope: !86, file: !3, line: 11, type: !93)
!99 = !DILocalVariable(name: "a", arg: 5, scope: !86, file: !3, line: 10, type: !93)
!100 = !DILocalVariable(name: ".omp.iv", scope: !86, type: !15, flags: DIFlagArtificial)
!101 = !DILocalVariable(name: ".omp.comb.lb", scope: !86, type: !15, flags: DIFlagArtificial)
!102 = !DILocalVariable(name: ".omp.comb.ub", scope: !86, type: !15, flags: DIFlagArtificial)
!103 = !DILocalVariable(name: ".omp.stride", scope: !86, type: !15, flags: DIFlagArtificial)
!104 = !DILocalVariable(name: ".omp.is_last", scope: !86, type: !15, flags: DIFlagArtificial)
!105 = !DILocalVariable(name: "i", scope: !86, type: !15, flags: DIFlagArtificial)
!106 = !DILocation(line: 0, scope: !86)
!107 = !DILocation(line: 33, column: 9, scope: !86)
!108 = !DILocation(line: 33, column: 13, scope: !86)
!109 = !DILocation(line: 32, column: 9, scope: !86)
!110 = distinct !{!110, !109, !111}
!111 = !DILocation(line: 32, column: 50, scope: !86)
!112 = !DILocation(line: 32, column: 50, scope: !113)
!113 = distinct !DILexicalBlock(scope: !86, file: !3, line: 32, column: 9)
!114 = !DILocation(line: 37, column: 9, scope: !86)
!115 = distinct !DISubprogram(name: ".omp_outlined._debug__.1", scope: !3, file: !3, line: 33, type: !116, scopeLine: 33, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !120)
!116 = !DISubroutineType(types: !117)
!117 = !{null, !89, !89, !118, !118, !93, !93, !93}
!118 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !119)
!119 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!120 = !{!121, !122, !123, !124, !125, !126, !127, !128, !129, !130, !131, !132, !133, !134}
!121 = !DILocalVariable(name: ".global_tid.", arg: 1, scope: !115, type: !89, flags: DIFlagArtificial)
!122 = !DILocalVariable(name: ".bound_tid.", arg: 2, scope: !115, type: !89, flags: DIFlagArtificial)
!123 = !DILocalVariable(name: ".previous.lb.", arg: 3, scope: !115, type: !118, flags: DIFlagArtificial)
!124 = !DILocalVariable(name: ".previous.ub.", arg: 4, scope: !115, type: !118, flags: DIFlagArtificial)
!125 = !DILocalVariable(name: "c", arg: 5, scope: !115, file: !3, line: 12, type: !93)
!126 = !DILocalVariable(name: "b", arg: 6, scope: !115, file: !3, line: 11, type: !93)
!127 = !DILocalVariable(name: "a", arg: 7, scope: !115, file: !3, line: 10, type: !93)
!128 = !DILocalVariable(name: ".omp.iv", scope: !115, type: !15, flags: DIFlagArtificial)
!129 = !DILocalVariable(name: ".omp.lb", scope: !115, type: !15, flags: DIFlagArtificial)
!130 = !DILocalVariable(name: ".omp.ub", scope: !115, type: !15, flags: DIFlagArtificial)
!131 = !DILocalVariable(name: ".omp.stride", scope: !115, type: !15, flags: DIFlagArtificial)
!132 = !DILocalVariable(name: ".omp.is_last", scope: !115, type: !15, flags: DIFlagArtificial)
!133 = !DILocalVariable(name: "i", scope: !115, type: !15, flags: DIFlagArtificial)
!134 = !DILocalVariable(name: "j", scope: !135, file: !3, line: 34, type: !15)
!135 = distinct !DILexicalBlock(scope: !136, file: !3, line: 34, column: 13)
!136 = distinct !DILexicalBlock(scope: !115, file: !3, line: 33, column: 31)
!137 = !DILocation(line: 0, scope: !115)
!138 = !DILocation(line: 33, column: 9, scope: !115)
!139 = !DILocation(line: 33, column: 13, scope: !115)
!140 = !DILocation(line: 32, column: 9, scope: !115)
!141 = !DILocation(line: 0, scope: !142)
!142 = distinct !DILexicalBlock(scope: !143, file: !3, line: 34, column: 35)
!143 = distinct !DILexicalBlock(scope: !135, file: !3, line: 34, column: 13)
!144 = !DILocation(line: 0, scope: !135)
!145 = !DILocation(line: 35, column: 21, scope: !142)
!146 = !DILocation(line: 34, column: 13, scope: !135)
!147 = distinct !{!147, !140, !148}
!148 = !DILocation(line: 32, column: 50, scope: !115)
!149 = !DILocation(line: 35, column: 26, scope: !142)
!150 = !DILocation(line: 35, column: 23, scope: !142)
!151 = !DILocation(line: 35, column: 32, scope: !142)
!152 = !DILocation(line: 35, column: 31, scope: !142)
!153 = !DILocation(line: 34, column: 32, scope: !143)
!154 = !DILocation(line: 34, column: 27, scope: !143)
!155 = distinct !{!155, !146, !156}
!156 = !DILocation(line: 36, column: 13, scope: !135)
!157 = !DILocation(line: 37, column: 9, scope: !115)
!158 = distinct !DISubprogram(name: ".omp_outlined.", scope: !3, file: !3, line: 32, type: !116, scopeLine: 32, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !159)
!159 = !{!160, !161, !162, !163, !164, !165, !166}
!160 = !DILocalVariable(name: ".global_tid.", arg: 1, scope: !158, type: !89, flags: DIFlagArtificial)
!161 = !DILocalVariable(name: ".bound_tid.", arg: 2, scope: !158, type: !89, flags: DIFlagArtificial)
!162 = !DILocalVariable(name: ".previous.lb.", arg: 3, scope: !158, type: !118, flags: DIFlagArtificial)
!163 = !DILocalVariable(name: ".previous.ub.", arg: 4, scope: !158, type: !118, flags: DIFlagArtificial)
!164 = !DILocalVariable(name: "c", arg: 5, scope: !158, type: !93, flags: DIFlagArtificial)
!165 = !DILocalVariable(name: "b", arg: 6, scope: !158, type: !93, flags: DIFlagArtificial)
!166 = !DILocalVariable(name: "a", arg: 7, scope: !158, type: !93, flags: DIFlagArtificial)
!167 = !DILocation(line: 0, scope: !158)
!168 = !DILocation(line: 32, column: 9, scope: !158)
!169 = !{!170}
!170 = !{i64 2, i64 -1, i64 -1, i1 true}
!171 = distinct !DISubprogram(name: ".omp_outlined..2", scope: !3, file: !3, line: 32, type: !87, scopeLine: 32, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !172)
!172 = !{!173, !174, !175, !176, !177}
!173 = !DILocalVariable(name: ".global_tid.", arg: 1, scope: !171, type: !89, flags: DIFlagArtificial)
!174 = !DILocalVariable(name: ".bound_tid.", arg: 2, scope: !171, type: !89, flags: DIFlagArtificial)
!175 = !DILocalVariable(name: "c", arg: 3, scope: !171, type: !93, flags: DIFlagArtificial)
!176 = !DILocalVariable(name: "b", arg: 4, scope: !171, type: !93, flags: DIFlagArtificial)
!177 = !DILocalVariable(name: "a", arg: 5, scope: !171, type: !93, flags: DIFlagArtificial)
!178 = !DILocation(line: 0, scope: !171)
!179 = !DILocation(line: 32, column: 9, scope: !171)
!180 = distinct !DISubprogram(name: "__omp_offloading_802_12c6a1c_Mult_l30", scope: !3, file: !3, line: 30, type: !74, scopeLine: 30, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !181)
!181 = !{!182, !183, !184}
!182 = !DILocalVariable(name: "c", arg: 1, scope: !180, type: !14, flags: DIFlagArtificial)
!183 = !DILocalVariable(name: "b", arg: 2, scope: !180, type: !14, flags: DIFlagArtificial)
!184 = !DILocalVariable(name: "a", arg: 3, scope: !180, type: !14, flags: DIFlagArtificial)
!185 = !DILocation(line: 0, scope: !180)
!186 = !DILocation(line: 30, column: 5, scope: !180)
!187 = distinct !DISubprogram(name: "check", scope: !3, file: !3, line: 43, type: !24, scopeLine: 43, flags: DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !188)
!188 = !{!189, !191}
!189 = !DILocalVariable(name: "test", scope: !187, file: !3, line: 44, type: !190)
!190 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!191 = !DILocalVariable(name: "i", scope: !192, file: !3, line: 45, type: !15)
!192 = distinct !DILexicalBlock(scope: !187, file: !3, line: 45, column: 5)
!193 = !DILocation(line: 0, scope: !187)
!194 = !DILocation(line: 0, scope: !192)
!195 = !DILocation(line: 0, scope: !196)
!196 = distinct !DILexicalBlock(scope: !197, file: !3, line: 46, column: 12)
!197 = distinct !DILexicalBlock(scope: !198, file: !3, line: 45, column: 27)
!198 = distinct !DILexicalBlock(scope: !192, file: !3, line: 45, column: 5)
!199 = !DILocation(line: 45, column: 5, scope: !192)
!200 = !DILocation(line: 50, column: 38, scope: !187)
!201 = !DILocation(line: 50, column: 5, scope: !187)
!202 = !DILocation(line: 51, column: 5, scope: !187)
!203 = !DILocation(line: 46, column: 12, scope: !196)
!204 = !DILocation(line: 46, column: 16, scope: !196)
!205 = !DILocation(line: 45, column: 24, scope: !198)
!206 = !DILocation(line: 46, column: 12, scope: !197)
!207 = !DILocation(line: 45, column: 19, scope: !198)
!208 = distinct !{!208, !199, !209}
!209 = !DILocation(line: 49, column: 5, scope: !192)
!210 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 57, type: !24, scopeLine: 57, flags: DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !4)
!211 = !DILocation(line: 58, column: 9, scope: !210)
!212 = !DILocation(line: 58, column: 7, scope: !210)
!213 = !DILocation(line: 59, column: 9, scope: !210)
!214 = !DILocation(line: 59, column: 7, scope: !210)
!215 = !DILocation(line: 60, column: 9, scope: !210)
!216 = !DILocation(line: 60, column: 7, scope: !210)
!217 = !DILocation(line: 61, column: 5, scope: !210)
!218 = !DILocation(line: 62, column: 5, scope: !210)
!219 = !DILocation(line: 63, column: 5, scope: !210)
!220 = !DILocation(line: 64, column: 10, scope: !210)
!221 = !DILocation(line: 64, column: 5, scope: !210)
!222 = !DILocation(line: 65, column: 10, scope: !210)
!223 = !DILocation(line: 65, column: 5, scope: !210)
!224 = !DILocation(line: 66, column: 10, scope: !210)
!225 = !DILocation(line: 66, column: 5, scope: !210)
!226 = !DILocation(line: 67, column: 5, scope: !210)
!227 = distinct !DISubprogram(linkageName: ".omp_offloading.requires_reg", scope: !3, file: !3, type: !228, flags: DIFlagArtificial | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !4)
!228 = !DISubroutineType(types: !4)

; __CLANG_OFFLOAD_BUNDLE____END__ host-x86_64-unknown-linux-gnu
