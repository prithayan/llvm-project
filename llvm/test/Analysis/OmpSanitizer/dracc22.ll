; RUN: opt < %s -passes='print-omp-sanitizer' -disable-output 2>&1 | FileCheck %s --check-prefixes=NUF,CHECK

; CHECK: Definition of variable:'b' on Line: DRACC_OMP_022_MxV_Missing_Data_yes.c:18 does not reach the use of variable:'b' on Line: DRACC_OMP_022_MxV_Missing_Data_yes.c:34
; CHECK: Possible Fix, Add omp map clause : 'to:b' At Line:DRACC_OMP_022_MxV_Missing_Data_yes.c:29

; ModuleID = 'DRACC_OMP_022_MxV_Missing_Data_yes.ll'
source_filename = "DRACC_OMP_022_MxV_Missing_Data_yes.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.ident_t = type { i32, i32, i32, i32, i8* }
%struct.__tgt_offload_entry = type { i8*, i8*, i64, i32, i32 }
%struct.__tgt_device_image = type { i8*, i8*, %struct.__tgt_offload_entry*, %struct.__tgt_offload_entry* }
%struct.__tgt_bin_desc = type { i32, %struct.__tgt_device_image*, %struct.__tgt_offload_entry*, %struct.__tgt_offload_entry* }

$.omp_offloading.descriptor_reg.nvptx64-nvidia-cuda = comdat any

@b = common dso_local global i32* null, align 8, !dbg !0
@a = common dso_local global i32* null, align 8, !dbg !6
@c = common dso_local global i32* null, align 8, !dbg !10
@.str = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@0 = private unnamed_addr global %struct.ident_t { i32 0, i32 2050, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@1 = private unnamed_addr constant [51 x i8] c";DRACC_OMP_022_MxV_Missing_Data_yes.c;Mult;31;17;;\00", align 1
@2 = private unnamed_addr global %struct.ident_t { i32 0, i32 514, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@3 = private unnamed_addr constant [51 x i8] c";DRACC_OMP_022_MxV_Missing_Data_yes.c;Mult;31;50;;\00", align 1
@4 = private unnamed_addr global %struct.ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@.__omp_offloading_801_15a4794_Mult_l29.region_id = weak constant i8 0
@.offload_sizes = private unnamed_addr constant [3 x i64] [i64 20000, i64 100000000, i64 20000]
@.offload_maptypes = private unnamed_addr constant [3 x i64] [i64 35, i64 32, i64 33]
@.str.3 = private unnamed_addr constant [23 x i8] c"Data Race occured: %s\0A\00", align 1
@.str.4 = private unnamed_addr constant [5 x i8] c"true\00", align 1
@.str.5 = private unnamed_addr constant [6 x i8] c"false\00", align 1
@.omp_offloading.entry_name = internal unnamed_addr constant [38 x i8] c"__omp_offloading_801_15a4794_Mult_l29\00"
@.omp_offloading.entry.__omp_offloading_801_15a4794_Mult_l29 = weak constant %struct.__tgt_offload_entry { i8* @.__omp_offloading_801_15a4794_Mult_l29.region_id, i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.omp_offloading.entry_name, i32 0, i32 0), i64 0, i32 0, i32 0 }, section ".omp_offloading.entries", align 1
@.omp_offloading.entries_begin = external constant %struct.__tgt_offload_entry
@.omp_offloading.entries_end = external constant %struct.__tgt_offload_entry
@.omp_offloading.img_start.nvptx64-nvidia-cuda = extern_weak constant i8
@.omp_offloading.img_end.nvptx64-nvidia-cuda = extern_weak constant i8
@.omp_offloading.device_images = internal unnamed_addr constant [1 x %struct.__tgt_device_image] [%struct.__tgt_device_image { i8* @.omp_offloading.img_start.nvptx64-nvidia-cuda, i8* @.omp_offloading.img_end.nvptx64-nvidia-cuda, %struct.__tgt_offload_entry* @.omp_offloading.entries_begin, %struct.__tgt_offload_entry* @.omp_offloading.entries_end }], comdat($.omp_offloading.descriptor_reg.nvptx64-nvidia-cuda), align 8
@.omp_offloading.descriptor = internal constant %struct.__tgt_bin_desc { i32 1, %struct.__tgt_device_image* getelementptr inbounds ([1 x %struct.__tgt_device_image], [1 x %struct.__tgt_device_image]* @.omp_offloading.device_images, i32 0, i32 0), %struct.__tgt_offload_entry* @.omp_offloading.entries_begin, %struct.__tgt_offload_entry* @.omp_offloading.entries_end }, comdat($.omp_offloading.descriptor_reg.nvptx64-nvidia-cuda), align 8
@__dso_handle = external hidden global i8
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 0, void ()* @.omp_offloading.descriptor_reg.nvptx64-nvidia-cuda, i8* bitcast (void ()* @.omp_offloading.descriptor_reg.nvptx64-nvidia-cuda to i8*) }]

; Function Attrs: nounwind uwtable
define dso_local i32 @init() #0 !dbg !17 {
entry:
  call void @llvm.dbg.value(metadata i32 0, metadata !21, metadata !DIExpression()), !dbg !27
  br label %for.cond, !dbg !28

for.cond:                                         ; preds = %for.inc9, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc10, %for.inc9 ], !dbg !27
  call void @llvm.dbg.value(metadata i32 %i.0, metadata !21, metadata !DIExpression()), !dbg !27
  %cmp = icmp slt i32 %i.0, 5000, !dbg !29
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !dbg !30

for.cond.cleanup:                                 ; preds = %for.cond
  br label %for.end11

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.value(metadata i32 0, metadata !23, metadata !DIExpression()), !dbg !31
  br label %for.cond1, !dbg !32

for.cond1:                                        ; preds = %for.inc, %for.body
  %j.0 = phi i32 [ 0, %for.body ], [ %inc, %for.inc ], !dbg !31
  call void @llvm.dbg.value(metadata i32 %j.0, metadata !23, metadata !DIExpression()), !dbg !31
  %cmp2 = icmp slt i32 %j.0, 5000, !dbg !33
  br i1 %cmp2, label %for.body4, label %for.cond.cleanup3, !dbg !35

for.cond.cleanup3:                                ; preds = %for.cond1
  br label %for.end

for.body4:                                        ; preds = %for.cond1
  %0 = load i32*, i32** @b, align 8, !dbg !36, !tbaa !38
  %mul = mul nsw i32 %i.0, 5000, !dbg !42
  %add = add nsw i32 %j.0, %mul, !dbg !43
  %idxprom = sext i32 %add to i64, !dbg !36
  %arrayidx = getelementptr inbounds i32, i32* %0, i64 %idxprom, !dbg !36
  store i32 1, i32* %arrayidx, align 4, !dbg !44, !tbaa !45
  br label %for.inc, !dbg !47

for.inc:                                          ; preds = %for.body4
  %inc = add nsw i32 %j.0, 1, !dbg !48
  call void @llvm.dbg.value(metadata i32 %inc, metadata !23, metadata !DIExpression()), !dbg !31
  br label %for.cond1, !dbg !49, !llvm.loop !50

for.end:                                          ; preds = %for.cond.cleanup3
  %1 = load i32*, i32** @a, align 8, !dbg !52, !tbaa !38
  %idxprom5 = sext i32 %i.0 to i64, !dbg !52
  %arrayidx6 = getelementptr inbounds i32, i32* %1, i64 %idxprom5, !dbg !52
  store i32 1, i32* %arrayidx6, align 4, !dbg !53, !tbaa !45
  %2 = load i32*, i32** @c, align 8, !dbg !54, !tbaa !38
  %idxprom7 = sext i32 %i.0 to i64, !dbg !54
  %arrayidx8 = getelementptr inbounds i32, i32* %2, i64 %idxprom7, !dbg !54
  store i32 0, i32* %arrayidx8, align 4, !dbg !55, !tbaa !45
  br label %for.inc9, !dbg !56

for.inc9:                                         ; preds = %for.end
  %inc10 = add nsw i32 %i.0, 1, !dbg !57
  call void @llvm.dbg.value(metadata i32 %inc10, metadata !21, metadata !DIExpression()), !dbg !27
  br label %for.cond, !dbg !58, !llvm.loop !59

for.end11:                                        ; preds = %for.cond.cleanup
  ret i32 0, !dbg !61
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define dso_local i32 @Mult() #0 !dbg !62 {
entry:
  %.offload_baseptrs = alloca [3 x i8*], align 8
  %.offload_ptrs = alloca [3 x i8*], align 8
  call void @__kmpc_push_target_tripcount(i64 0, i64 5000), !dbg !63
  %0 = load i32*, i32** @c, align 8, !dbg !63, !tbaa !38
  %1 = load i32*, i32** @b, align 8, !dbg !63, !tbaa !38
  %2 = load i32*, i32** @a, align 8, !dbg !63, !tbaa !38
  %3 = load i32*, i32** @c, align 8, !dbg !63
  %4 = load i32*, i32** @c, align 8, !dbg !64, !tbaa !38
  %arrayidx = getelementptr inbounds i32, i32* %4, i64 0, !dbg !64
  %5 = load i32*, i32** @b, align 8, !dbg !63
  %6 = load i32*, i32** @b, align 8, !dbg !66, !tbaa !38
  %arrayidx1 = getelementptr inbounds i32, i32* %6, i64 0, !dbg !66
  %7 = load i32*, i32** @a, align 8, !dbg !63
  %8 = load i32*, i32** @a, align 8, !dbg !67, !tbaa !38
  %arrayidx2 = getelementptr inbounds i32, i32* %8, i64 0, !dbg !67
  %9 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_baseptrs, i32 0, i32 0, !dbg !63
  %10 = bitcast i8** %9 to i32**, !dbg !63
  store i32* %3, i32** %10, align 8, !dbg !63
  %11 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_ptrs, i32 0, i32 0, !dbg !63
  %12 = bitcast i8** %11 to i32**, !dbg !63
  store i32* %arrayidx, i32** %12, align 8, !dbg !63
  %13 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_baseptrs, i32 0, i32 1, !dbg !63
  %14 = bitcast i8** %13 to i32**, !dbg !63
  store i32* %5, i32** %14, align 8, !dbg !63
  %15 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_ptrs, i32 0, i32 1, !dbg !63
  %16 = bitcast i8** %15 to i32**, !dbg !63
  store i32* %arrayidx1, i32** %16, align 8, !dbg !63
  %17 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_baseptrs, i32 0, i32 2, !dbg !63
  %18 = bitcast i8** %17 to i32**, !dbg !63
  store i32* %7, i32** %18, align 8, !dbg !63
  %19 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_ptrs, i32 0, i32 2, !dbg !63
  %20 = bitcast i8** %19 to i32**, !dbg !63
  store i32* %arrayidx2, i32** %20, align 8, !dbg !63
  %21 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_baseptrs, i32 0, i32 0, !dbg !63
  %22 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_ptrs, i32 0, i32 0, !dbg !63
  %23 = call i32 @__tgt_target_teams(i64 0, i8* @.__omp_offloading_801_15a4794_Mult_l29.region_id, i32 3, i8** %21, i8** %22, i64* getelementptr inbounds ([3 x i64], [3 x i64]* @.offload_sizes, i32 0, i32 0), i64* getelementptr inbounds ([3 x i64], [3 x i64]* @.offload_maptypes, i32 0, i32 0), i32 0, i32 0), !dbg !63
  %24 = icmp ne i32 %23, 0, !dbg !63
  br i1 %24, label %omp_offload.failed, label %omp_offload.cont, !dbg !63

omp_offload.failed:                               ; preds = %entry
  call void @__omp_offloading_801_15a4794_Mult_l29(i32* %0, i32* %1, i32* %2) #6, !dbg !68
  br label %omp_offload.cont, !dbg !63

omp_offload.cont:                                 ; preds = %omp_offload.failed, %entry
  ret i32 0, !dbg !69
}

; Function Attrs: norecurse nounwind uwtable
define internal void @__omp_offloading_801_15a4794_Mult_l29_debug__(i32* %c, i32* %b, i32* %a) #3 !dbg !70 {
entry:
  %c.addr = alloca i32*, align 8
  %b.addr = alloca i32*, align 8
  %a.addr = alloca i32*, align 8
  %.kmpc_loc.addr = alloca %struct.ident_t, align 8
  %0 = bitcast %struct.ident_t* %.kmpc_loc.addr to i8*
  %1 = bitcast %struct.ident_t* @4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %0, i8* align 8 %1, i64 24, i1 false)
  store i32* %c, i32** %c.addr, align 8, !tbaa !38
  call void @llvm.dbg.declare(metadata i32** %c.addr, metadata !74, metadata !DIExpression()), !dbg !77
  store i32* %b, i32** %b.addr, align 8, !tbaa !38
  call void @llvm.dbg.declare(metadata i32** %b.addr, metadata !75, metadata !DIExpression()), !dbg !78
  store i32* %a, i32** %a.addr, align 8, !tbaa !38
  call void @llvm.dbg.declare(metadata i32** %a.addr, metadata !76, metadata !DIExpression()), !dbg !79
  %2 = getelementptr inbounds %struct.ident_t, %struct.ident_t* %.kmpc_loc.addr, i32 0, i32 4, !dbg !80
  store i8* getelementptr inbounds ([51 x i8], [51 x i8]* @1, i32 0, i32 0), i8** %2, align 8, !dbg !80, !tbaa !82
  call void (%struct.ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_teams(%struct.ident_t* %.kmpc_loc.addr, i32 3, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, i32**, i32**, i32**)* @.omp_outlined..2 to void (i32*, i32*, ...)*), i32** %c.addr, i32** %b.addr, i32** %a.addr), !dbg !80
  ret void, !dbg !84
}

; Function Attrs: norecurse nounwind uwtable
define internal void @.omp_outlined._debug__(i32* noalias %.global_tid., i32* noalias %.bound_tid., i32** dereferenceable(8) %c, i32** dereferenceable(8) %b, i32** dereferenceable(8) %a) #3 !dbg !85 {
entry:
  %.omp.comb.lb = alloca i32, align 4
  %.omp.comb.ub = alloca i32, align 4
  %.omp.stride = alloca i32, align 4
  %.omp.is_last = alloca i32, align 4
  %.kmpc_loc.addr = alloca %struct.ident_t, align 8
  %0 = bitcast %struct.ident_t* %.kmpc_loc.addr to i8*
  %1 = bitcast %struct.ident_t* @0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %0, i8* align 8 %1, i64 24, i1 false)
  call void @llvm.dbg.value(metadata i32* %.global_tid., metadata !94, metadata !DIExpression()), !dbg !105
  call void @llvm.dbg.value(metadata i32* %.bound_tid., metadata !95, metadata !DIExpression()), !dbg !105
  call void @llvm.dbg.value(metadata i32** %c, metadata !96, metadata !DIExpression()), !dbg !105
  call void @llvm.dbg.value(metadata i32** %b, metadata !97, metadata !DIExpression()), !dbg !105
  call void @llvm.dbg.value(metadata i32** %a, metadata !98, metadata !DIExpression()), !dbg !105
  %2 = bitcast i32* %.omp.comb.lb to i8*, !dbg !106
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %2) #6, !dbg !106
  call void @llvm.dbg.declare(metadata i32* %.omp.comb.lb, metadata !100, metadata !DIExpression()), !dbg !105
  store i32 0, i32* %.omp.comb.lb, align 4, !dbg !107, !tbaa !45
  %3 = bitcast i32* %.omp.comb.ub to i8*, !dbg !106
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %3) #6, !dbg !106
  call void @llvm.dbg.declare(metadata i32* %.omp.comb.ub, metadata !101, metadata !DIExpression()), !dbg !105
  store i32 4999, i32* %.omp.comb.ub, align 4, !dbg !107, !tbaa !45
  %4 = bitcast i32* %.omp.stride to i8*, !dbg !106
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %4) #6, !dbg !106
  call void @llvm.dbg.declare(metadata i32* %.omp.stride, metadata !102, metadata !DIExpression()), !dbg !105
  store i32 1, i32* %.omp.stride, align 4, !dbg !107, !tbaa !45
  %5 = bitcast i32* %.omp.is_last to i8*, !dbg !106
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %5) #6, !dbg !106
  call void @llvm.dbg.declare(metadata i32* %.omp.is_last, metadata !103, metadata !DIExpression()), !dbg !105
  store i32 0, i32* %.omp.is_last, align 4, !dbg !107, !tbaa !45
  call void @llvm.dbg.declare(metadata !4, metadata !104, metadata !DIExpression()), !dbg !105
  %6 = getelementptr inbounds %struct.ident_t, %struct.ident_t* %.kmpc_loc.addr, i32 0, i32 4, !dbg !106
  store i8* getelementptr inbounds ([51 x i8], [51 x i8]* @1, i32 0, i32 0), i8** %6, align 8, !dbg !106, !tbaa !82
  %7 = load i32, i32* %.global_tid., align 4, !dbg !106, !tbaa !45
  call void @__kmpc_for_static_init_4(%struct.ident_t* %.kmpc_loc.addr, i32 %7, i32 92, i32* %.omp.is_last, i32* %.omp.comb.lb, i32* %.omp.comb.ub, i32* %.omp.stride, i32 1, i32 1), !dbg !106
  %8 = load i32, i32* %.omp.comb.ub, align 4, !dbg !107, !tbaa !45
  %cmp = icmp sgt i32 %8, 4999, !dbg !107
  br i1 %cmp, label %cond.true, label %cond.false, !dbg !107

cond.true:                                        ; preds = %entry
  br label %cond.end, !dbg !107

cond.false:                                       ; preds = %entry
  %9 = load i32, i32* %.omp.comb.ub, align 4, !dbg !107, !tbaa !45
  br label %cond.end, !dbg !107

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ 4999, %cond.true ], [ %9, %cond.false ], !dbg !107
  store i32 %cond, i32* %.omp.comb.ub, align 4, !dbg !107, !tbaa !45
  %10 = load i32, i32* %.omp.comb.lb, align 4, !dbg !107, !tbaa !45
  call void @llvm.dbg.value(metadata i32 %10, metadata !99, metadata !DIExpression()), !dbg !105
  br label %omp.inner.for.cond, !dbg !106

omp.inner.for.cond:                               ; preds = %omp.inner.for.inc, %cond.end
  %.omp.iv.0 = phi i32 [ %10, %cond.end ], [ %add, %omp.inner.for.inc ], !dbg !105
  call void @llvm.dbg.value(metadata i32 %.omp.iv.0, metadata !99, metadata !DIExpression()), !dbg !105
  %11 = load i32, i32* %.omp.comb.ub, align 4, !dbg !107, !tbaa !45
  %cmp1 = icmp sle i32 %.omp.iv.0, %11, !dbg !106
  br i1 %cmp1, label %omp.inner.for.body, label %omp.inner.for.cond.cleanup, !dbg !106

omp.inner.for.cond.cleanup:                       ; preds = %omp.inner.for.cond
  br label %omp.inner.for.end, !dbg !106

omp.inner.for.body:                               ; preds = %omp.inner.for.cond
  %12 = load i32, i32* %.omp.comb.lb, align 4, !dbg !108
  %13 = zext i32 %12 to i64, !dbg !108
  %14 = load i32, i32* %.omp.comb.ub, align 4, !dbg !108
  %15 = zext i32 %14 to i64, !dbg !108
  %16 = getelementptr inbounds %struct.ident_t, %struct.ident_t* %.kmpc_loc.addr, i32 0, i32 4, !dbg !108
  store i8* getelementptr inbounds ([51 x i8], [51 x i8]* @1, i32 0, i32 0), i8** %16, align 8, !dbg !108, !tbaa !82
  call void (%struct.ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%struct.ident_t* %.kmpc_loc.addr, i32 5, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, i64, i64, i32**, i32**, i32**)* @.omp_outlined. to void (i32*, i32*, ...)*), i64 %13, i64 %15, i32** %c, i32** %b, i32** %a), !dbg !108
  br label %omp.inner.for.inc, !dbg !109

omp.inner.for.inc:                                ; preds = %omp.inner.for.body
  %17 = load i32, i32* %.omp.stride, align 4, !dbg !107, !tbaa !45
  %add = add nsw i32 %.omp.iv.0, %17, !dbg !106
  call void @llvm.dbg.value(metadata i32 %add, metadata !99, metadata !DIExpression()), !dbg !105
  br label %omp.inner.for.cond, !dbg !109, !llvm.loop !111

omp.inner.for.end:                                ; preds = %omp.inner.for.cond.cleanup
  br label %omp.loop.exit, !dbg !109

omp.loop.exit:                                    ; preds = %omp.inner.for.end
  %18 = getelementptr inbounds %struct.ident_t, %struct.ident_t* %.kmpc_loc.addr, i32 0, i32 4, !dbg !109
  store i8* getelementptr inbounds ([51 x i8], [51 x i8]* @1, i32 0, i32 0), i8** %18, align 8, !dbg !109, !tbaa !82
  call void @__kmpc_for_static_fini(%struct.ident_t* %.kmpc_loc.addr, i32 %7), !dbg !109
  %19 = bitcast i32* %.omp.is_last to i8*, !dbg !109
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %19) #6, !dbg !109
  %20 = bitcast i32* %.omp.stride to i8*, !dbg !109
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %20) #6, !dbg !109
  %21 = bitcast i32* %.omp.comb.ub to i8*, !dbg !109
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %21) #6, !dbg !109
  %22 = bitcast i32* %.omp.comb.lb to i8*, !dbg !109
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %22) #6, !dbg !109
  ret void, !dbg !113
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1 immarg) #1

declare dso_local void @__kmpc_for_static_init_4(%struct.ident_t*, i32, i32, i32*, i32*, i32*, i32*, i32, i32)

; Function Attrs: norecurse nounwind uwtable
define internal void @.omp_outlined._debug__.1(i32* noalias %.global_tid., i32* noalias %.bound_tid., i64 %.previous.lb., i64 %.previous.ub., i32** dereferenceable(8) %c, i32** dereferenceable(8) %b, i32** dereferenceable(8) %a) #3 !dbg !114 {
entry:
  %.omp.lb = alloca i32, align 4
  %.omp.ub = alloca i32, align 4
  %.omp.stride = alloca i32, align 4
  %.omp.is_last = alloca i32, align 4
  %.kmpc_loc.addr = alloca %struct.ident_t, align 8
  %0 = bitcast %struct.ident_t* %.kmpc_loc.addr to i8*
  %1 = bitcast %struct.ident_t* @2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %0, i8* align 8 %1, i64 24, i1 false)
  call void @llvm.dbg.value(metadata i32* %.global_tid., metadata !120, metadata !DIExpression()), !dbg !136
  call void @llvm.dbg.value(metadata i32* %.bound_tid., metadata !121, metadata !DIExpression()), !dbg !136
  call void @llvm.dbg.value(metadata i64 %.previous.lb., metadata !122, metadata !DIExpression()), !dbg !136
  call void @llvm.dbg.value(metadata i64 %.previous.ub., metadata !123, metadata !DIExpression()), !dbg !136
  call void @llvm.dbg.value(metadata i32** %c, metadata !124, metadata !DIExpression()), !dbg !136
  call void @llvm.dbg.value(metadata i32** %b, metadata !125, metadata !DIExpression()), !dbg !136
  call void @llvm.dbg.value(metadata i32** %a, metadata !126, metadata !DIExpression()), !dbg !136
  %2 = bitcast i32* %.omp.lb to i8*, !dbg !137
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %2) #6, !dbg !137
  call void @llvm.dbg.declare(metadata i32* %.omp.lb, metadata !128, metadata !DIExpression()), !dbg !136
  store i32 0, i32* %.omp.lb, align 4, !dbg !138, !tbaa !45
  %3 = bitcast i32* %.omp.ub to i8*, !dbg !137
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %3) #6, !dbg !137
  call void @llvm.dbg.declare(metadata i32* %.omp.ub, metadata !129, metadata !DIExpression()), !dbg !136
  store i32 4999, i32* %.omp.ub, align 4, !dbg !138, !tbaa !45
  %conv = trunc i64 %.previous.lb. to i32, !dbg !137
  %conv1 = trunc i64 %.previous.ub. to i32, !dbg !137
  store i32 %conv, i32* %.omp.lb, align 4, !dbg !137, !tbaa !45
  store i32 %conv1, i32* %.omp.ub, align 4, !dbg !137, !tbaa !45
  %4 = bitcast i32* %.omp.stride to i8*, !dbg !137
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %4) #6, !dbg !137
  call void @llvm.dbg.declare(metadata i32* %.omp.stride, metadata !130, metadata !DIExpression()), !dbg !136
  store i32 1, i32* %.omp.stride, align 4, !dbg !138, !tbaa !45
  %5 = bitcast i32* %.omp.is_last to i8*, !dbg !137
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %5) #6, !dbg !137
  call void @llvm.dbg.declare(metadata i32* %.omp.is_last, metadata !131, metadata !DIExpression()), !dbg !136
  store i32 0, i32* %.omp.is_last, align 4, !dbg !138, !tbaa !45
  %6 = getelementptr inbounds %struct.ident_t, %struct.ident_t* %.kmpc_loc.addr, i32 0, i32 4, !dbg !137
  store i8* getelementptr inbounds ([51 x i8], [51 x i8]* @1, i32 0, i32 0), i8** %6, align 8, !dbg !137, !tbaa !82
  %7 = load i32, i32* %.global_tid., align 4, !dbg !137, !tbaa !45
  call void @__kmpc_for_static_init_4(%struct.ident_t* %.kmpc_loc.addr, i32 %7, i32 34, i32* %.omp.is_last, i32* %.omp.lb, i32* %.omp.ub, i32* %.omp.stride, i32 1, i32 1), !dbg !137
  %8 = load i32, i32* %.omp.ub, align 4, !dbg !138, !tbaa !45
  %cmp = icmp sgt i32 %8, 4999, !dbg !138
  br i1 %cmp, label %cond.true, label %cond.false, !dbg !138

cond.true:                                        ; preds = %entry
  br label %cond.end, !dbg !138

cond.false:                                       ; preds = %entry
  %9 = load i32, i32* %.omp.ub, align 4, !dbg !138, !tbaa !45
  br label %cond.end, !dbg !138

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ 4999, %cond.true ], [ %9, %cond.false ], !dbg !138
  store i32 %cond, i32* %.omp.ub, align 4, !dbg !138, !tbaa !45
  %10 = load i32, i32* %.omp.lb, align 4, !dbg !138, !tbaa !45
  call void @llvm.dbg.value(metadata i32 %10, metadata !127, metadata !DIExpression()), !dbg !136
  br label %omp.inner.for.cond, !dbg !137

omp.inner.for.cond:                               ; preds = %omp.inner.for.inc, %cond.end
  %.omp.iv.0 = phi i32 [ %10, %cond.end ], [ %add15, %omp.inner.for.inc ], !dbg !136
  call void @llvm.dbg.value(metadata i32 %.omp.iv.0, metadata !127, metadata !DIExpression()), !dbg !136
  %11 = load i32, i32* %.omp.ub, align 4, !dbg !138, !tbaa !45
  %cmp3 = icmp sle i32 %.omp.iv.0, %11, !dbg !137
  br i1 %cmp3, label %omp.inner.for.body, label %omp.inner.for.cond.cleanup, !dbg !137

omp.inner.for.cond.cleanup:                       ; preds = %omp.inner.for.cond
  br label %omp.inner.for.end, !dbg !137

omp.inner.for.body:                               ; preds = %omp.inner.for.cond
  %mul = mul nsw i32 %.omp.iv.0, 1, !dbg !139
  %add = add nsw i32 0, %mul, !dbg !139
  call void @llvm.dbg.value(metadata i32 %add, metadata !132, metadata !DIExpression()), !dbg !136
  call void @llvm.dbg.value(metadata i32 0, metadata !133, metadata !DIExpression()), !dbg !140
  br label %for.cond, !dbg !141

for.cond:                                         ; preds = %for.inc, %omp.inner.for.body
  %j.0 = phi i32 [ 0, %omp.inner.for.body ], [ %inc, %for.inc ], !dbg !140
  call void @llvm.dbg.value(metadata i32 %j.0, metadata !133, metadata !DIExpression()), !dbg !140
  %cmp5 = icmp slt i32 %j.0, 5000, !dbg !142
  br i1 %cmp5, label %for.body, label %for.cond.cleanup, !dbg !144

for.cond.cleanup:                                 ; preds = %for.cond
  br label %for.end

for.body:                                         ; preds = %for.cond
  %12 = load i32*, i32** %b, align 8, !dbg !145, !tbaa !38
  %mul7 = mul nsw i32 %add, 5000, !dbg !147
  %add8 = add nsw i32 %j.0, %mul7, !dbg !148
  %idxprom = sext i32 %add8 to i64, !dbg !145
  %arrayidx = getelementptr inbounds i32, i32* %12, i64 %idxprom, !dbg !145
  %13 = load i32, i32* %arrayidx, align 4, !dbg !145, !tbaa !45
  %14 = load i32*, i32** %a, align 8, !dbg !149, !tbaa !38
  %idxprom9 = sext i32 %j.0 to i64, !dbg !149
  %arrayidx10 = getelementptr inbounds i32, i32* %14, i64 %idxprom9, !dbg !149
  %15 = load i32, i32* %arrayidx10, align 4, !dbg !149, !tbaa !45
  %mul11 = mul nsw i32 %13, %15, !dbg !150
  %16 = load i32*, i32** %c, align 8, !dbg !151, !tbaa !38
  %idxprom12 = sext i32 %add to i64, !dbg !151
  %arrayidx13 = getelementptr inbounds i32, i32* %16, i64 %idxprom12, !dbg !151
  %17 = load i32, i32* %arrayidx13, align 4, !dbg !152, !tbaa !45
  %add14 = add nsw i32 %17, %mul11, !dbg !152
  store i32 %add14, i32* %arrayidx13, align 4, !dbg !152, !tbaa !45
  br label %for.inc, !dbg !153

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %j.0, 1, !dbg !154
  call void @llvm.dbg.value(metadata i32 %inc, metadata !133, metadata !DIExpression()), !dbg !140
  br label %for.cond, !dbg !155, !llvm.loop !156

for.end:                                          ; preds = %for.cond.cleanup
  br label %omp.body.continue, !dbg !158

omp.body.continue:                                ; preds = %for.end
  br label %omp.inner.for.inc, !dbg !159

omp.inner.for.inc:                                ; preds = %omp.body.continue
  %add15 = add nsw i32 %.omp.iv.0, 1, !dbg !137
  call void @llvm.dbg.value(metadata i32 %add15, metadata !127, metadata !DIExpression()), !dbg !136
  br label %omp.inner.for.cond, !dbg !159, !llvm.loop !160

omp.inner.for.end:                                ; preds = %omp.inner.for.cond.cleanup
  br label %omp.loop.exit, !dbg !159

omp.loop.exit:                                    ; preds = %omp.inner.for.end
  %18 = getelementptr inbounds %struct.ident_t, %struct.ident_t* %.kmpc_loc.addr, i32 0, i32 4, !dbg !159
  store i8* getelementptr inbounds ([51 x i8], [51 x i8]* @3, i32 0, i32 0), i8** %18, align 8, !dbg !159, !tbaa !82
  call void @__kmpc_for_static_fini(%struct.ident_t* %.kmpc_loc.addr, i32 %7), !dbg !159
  %19 = bitcast i32* %.omp.is_last to i8*, !dbg !159
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %19) #6, !dbg !159
  %20 = bitcast i32* %.omp.stride to i8*, !dbg !159
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %20) #6, !dbg !159
  %21 = bitcast i32* %.omp.ub to i8*, !dbg !159
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %21) #6, !dbg !159
  %22 = bitcast i32* %.omp.lb to i8*, !dbg !159
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %22) #6, !dbg !159
  ret void, !dbg !162
}

declare dso_local void @__kmpc_for_static_fini(%struct.ident_t*, i32)

; Function Attrs: norecurse nounwind uwtable
define internal void @.omp_outlined.(i32* noalias %.global_tid., i32* noalias %.bound_tid., i64 %.previous.lb., i64 %.previous.ub., i32** dereferenceable(8) %c, i32** dereferenceable(8) %b, i32** dereferenceable(8) %a) #3 !dbg !163 {
entry:
  call void @llvm.dbg.value(metadata i32* %.global_tid., metadata !165, metadata !DIExpression()), !dbg !172
  call void @llvm.dbg.value(metadata i32* %.bound_tid., metadata !166, metadata !DIExpression()), !dbg !172
  call void @llvm.dbg.value(metadata i64 %.previous.lb., metadata !167, metadata !DIExpression()), !dbg !172
  call void @llvm.dbg.value(metadata i64 %.previous.ub., metadata !168, metadata !DIExpression()), !dbg !172
  call void @llvm.dbg.value(metadata i32** %c, metadata !169, metadata !DIExpression()), !dbg !172
  call void @llvm.dbg.value(metadata i32** %b, metadata !170, metadata !DIExpression()), !dbg !172
  call void @llvm.dbg.value(metadata i32** %a, metadata !171, metadata !DIExpression()), !dbg !172
  call void @.omp_outlined._debug__.1(i32* %.global_tid., i32* %.bound_tid., i64 %.previous.lb., i64 %.previous.ub., i32** %c, i32** %b, i32** %a) #6, !dbg !173
  ret void, !dbg !173
}

declare !callback !174 dso_local void @__kmpc_fork_call(%struct.ident_t*, i32, void (i32*, i32*, ...)*, ...)

; Function Attrs: norecurse nounwind uwtable
define internal void @.omp_outlined..2(i32* noalias %.global_tid., i32* noalias %.bound_tid., i32** dereferenceable(8) %c, i32** dereferenceable(8) %b, i32** dereferenceable(8) %a) #3 !dbg !176 {
entry:
  call void @llvm.dbg.value(metadata i32* %.global_tid., metadata !178, metadata !DIExpression()), !dbg !183
  call void @llvm.dbg.value(metadata i32* %.bound_tid., metadata !179, metadata !DIExpression()), !dbg !183
  call void @llvm.dbg.value(metadata i32** %c, metadata !180, metadata !DIExpression()), !dbg !183
  call void @llvm.dbg.value(metadata i32** %b, metadata !181, metadata !DIExpression()), !dbg !183
  call void @llvm.dbg.value(metadata i32** %a, metadata !182, metadata !DIExpression()), !dbg !183
  call void @.omp_outlined._debug__(i32* %.global_tid., i32* %.bound_tid., i32** %c, i32** %b, i32** %a) #6, !dbg !184
  ret void, !dbg !184
}

declare !callback !174 dso_local void @__kmpc_fork_teams(%struct.ident_t*, i32, void (i32*, i32*, ...)*, ...)

; Function Attrs: norecurse nounwind uwtable
define internal void @__omp_offloading_801_15a4794_Mult_l29(i32* %c, i32* %b, i32* %a) #3 !dbg !185 {
entry:
  call void @llvm.dbg.value(metadata i32* %c, metadata !187, metadata !DIExpression()), !dbg !190
  call void @llvm.dbg.value(metadata i32* %b, metadata !188, metadata !DIExpression()), !dbg !190
  call void @llvm.dbg.value(metadata i32* %a, metadata !189, metadata !DIExpression()), !dbg !190
  call void @__omp_offloading_801_15a4794_Mult_l29_debug__(i32* %c, i32* %b, i32* %a) #6, !dbg !191
  ret void, !dbg !191
}

declare dso_local void @__kmpc_push_target_tripcount(i64, i64)

declare dso_local i32 @__tgt_target_teams(i64, i8*, i32, i8**, i8**, i64*, i64*, i32, i32)

; Function Attrs: nounwind uwtable
define dso_local i32 @check() #0 !dbg !192 {
entry:
  call void @llvm.dbg.value(metadata i8 0, metadata !194, metadata !DIExpression()), !dbg !198
  call void @llvm.dbg.value(metadata i32 0, metadata !196, metadata !DIExpression()), !dbg !199
  br label %for.cond, !dbg !200

for.cond:                                         ; preds = %for.inc, %entry
  %test.0 = phi i8 [ 0, %entry ], [ %test.1, %for.inc ], !dbg !198
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ], !dbg !199
  call void @llvm.dbg.value(metadata i32 %i.0, metadata !196, metadata !DIExpression()), !dbg !199
  call void @llvm.dbg.value(metadata i8 %test.0, metadata !194, metadata !DIExpression()), !dbg !198
  %cmp = icmp slt i32 %i.0, 5000, !dbg !201
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !dbg !203

for.cond.cleanup:                                 ; preds = %for.cond
  br label %for.end

for.body:                                         ; preds = %for.cond
  %0 = load i32*, i32** @c, align 8, !dbg !204, !tbaa !38
  %idxprom = sext i32 %i.0 to i64, !dbg !204
  %arrayidx = getelementptr inbounds i32, i32* %0, i64 %idxprom, !dbg !204
  %1 = load i32, i32* %arrayidx, align 4, !dbg !204, !tbaa !45
  %cmp1 = icmp ne i32 %1, 5000, !dbg !207
  br i1 %cmp1, label %if.then, label %if.end, !dbg !208

if.then:                                          ; preds = %for.body
  call void @llvm.dbg.value(metadata i8 1, metadata !194, metadata !DIExpression()), !dbg !198
  br label %if.end, !dbg !209

if.end:                                           ; preds = %if.then, %for.body
  %test.1 = phi i8 [ 1, %if.then ], [ %test.0, %for.body ], !dbg !198
  call void @llvm.dbg.value(metadata i8 %test.1, metadata !194, metadata !DIExpression()), !dbg !198
  br label %for.inc, !dbg !211

for.inc:                                          ; preds = %if.end
  %inc = add nsw i32 %i.0, 1, !dbg !212
  call void @llvm.dbg.value(metadata i32 %inc, metadata !196, metadata !DIExpression()), !dbg !199
  br label %for.cond, !dbg !213, !llvm.loop !214

for.end:                                          ; preds = %for.cond.cleanup
  %tobool = trunc i8 %test.0 to i1, !dbg !216
  %2 = zext i1 %tobool to i64, !dbg !216
  %cond = select i1 %tobool, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.4, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i64 0, i64 0), !dbg !216
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.3, i64 0, i64 0), i8* %cond), !dbg !217
  ret i32 0, !dbg !218
}

declare dso_local i32 @printf(i8*, ...) #4

; Function Attrs: nounwind uwtable
define dso_local i32 @main() #0 !dbg !219 {
entry:
  %call = call noalias i8* @malloc(i64 20000) #6, !dbg !220
  %0 = bitcast i8* %call to i32*, !dbg !220
  store i32* %0, i32** @a, align 8, !dbg !221, !tbaa !38
  %call1 = call noalias i8* @malloc(i64 100000000) #6, !dbg !222
  %1 = bitcast i8* %call1 to i32*, !dbg !222
  store i32* %1, i32** @b, align 8, !dbg !223, !tbaa !38
  %call2 = call noalias i8* @malloc(i64 20000) #6, !dbg !224
  %2 = bitcast i8* %call2 to i32*, !dbg !224
  store i32* %2, i32** @c, align 8, !dbg !225, !tbaa !38
  %call3 = call i32 @init(), !dbg !226
  %call4 = call i32 @Mult(), !dbg !227
  %call5 = call i32 @check(), !dbg !228
  %3 = load i32*, i32** @a, align 8, !dbg !229, !tbaa !38
  %4 = bitcast i32* %3 to i8*, !dbg !229
  call void @free(i8* %4) #6, !dbg !230
  %5 = load i32*, i32** @b, align 8, !dbg !231, !tbaa !38
  %6 = bitcast i32* %5 to i8*, !dbg !231
  call void @free(i8* %6) #6, !dbg !232
  %7 = load i32*, i32** @c, align 8, !dbg !233, !tbaa !38
  %8 = bitcast i32* %7 to i8*, !dbg !233
  call void @free(i8* %8) #6, !dbg !234
  ret i32 0, !dbg !235
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #5

; Function Attrs: nounwind
declare dso_local void @free(i8*) #5

; Function Attrs: nounwind uwtable
define internal void @.omp_offloading.descriptor_unreg(i8*) #0 section ".text.startup" comdat($.omp_offloading.descriptor_reg.nvptx64-nvidia-cuda) {
entry:
  %1 = call i32 @__tgt_unregister_lib(%struct.__tgt_bin_desc* @.omp_offloading.descriptor)
  ret void
}

declare dso_local i32 @__tgt_unregister_lib(%struct.__tgt_bin_desc*)

; Function Attrs: nounwind uwtable
define linkonce hidden void @.omp_offloading.descriptor_reg.nvptx64-nvidia-cuda() #0 section ".text.startup" comdat {
entry:
  %0 = call i32 @__tgt_register_lib(%struct.__tgt_bin_desc* @.omp_offloading.descriptor)
  %1 = call i32 @__cxa_atexit(void (i8*)* @.omp_offloading.descriptor_unreg, i8* bitcast (%struct.__tgt_bin_desc* @.omp_offloading.descriptor to i8*), i8* @__dso_handle) #6
  ret void
}

declare dso_local i32 @__tgt_register_lib(%struct.__tgt_bin_desc*)

; Function Attrs: nounwind
declare dso_local i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #6

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind readnone speculatable }
attributes #3 = { norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!2}
!omp_offload.info = !{!12}
!llvm.module.flags = !{!13, !14, !15}
!llvm.ident = !{!16}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "b", scope: !2, file: !3, line: 11, type: !8, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 9.0.0 (git@github.com:prithayan/llvm-project.git 9683f06d0ed55984d96f430331d28b1437b7dd07)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, nameTableKind: None)
!3 = !DIFile(filename: "DRACC_OMP_022_MxV_Missing_Data_yes.c", directory: "/home/prithayan/project/openmp_benchmark/testsuite/DRACC/OpenMP")
!4 = !{}
!5 = !{!6, !0, !10}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "a", scope: !2, file: !3, line: 10, type: !8, isLocal: false, isDefinition: true)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DIGlobalVariableExpression(var: !11, expr: !DIExpression())
!11 = distinct !DIGlobalVariable(name: "c", scope: !2, file: !3, line: 12, type: !8, isLocal: false, isDefinition: true)
!12 = !{i32 0, i32 2049, i32 22693780, !"Mult", i32 29, i32 0}
!13 = !{i32 2, !"Dwarf Version", i32 4}
!14 = !{i32 2, !"Debug Info Version", i32 3}
!15 = !{i32 1, !"wchar_size", i32 4}
!16 = !{!"clang version 9.0.0 (git@github.com:prithayan/llvm-project.git 9683f06d0ed55984d96f430331d28b1437b7dd07)"}
!17 = distinct !DISubprogram(name: "init", scope: !3, file: !3, line: 15, type: !18, scopeLine: 15, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !20)
!18 = !DISubroutineType(types: !19)
!19 = !{!9}
!20 = !{!21, !23}
!21 = !DILocalVariable(name: "i", scope: !22, file: !3, line: 16, type: !9)
!22 = distinct !DILexicalBlock(scope: !17, file: !3, line: 16, column: 5)
!23 = !DILocalVariable(name: "j", scope: !24, file: !3, line: 17, type: !9)
!24 = distinct !DILexicalBlock(scope: !25, file: !3, line: 17, column: 9)
!25 = distinct !DILexicalBlock(scope: !26, file: !3, line: 16, column: 27)
!26 = distinct !DILexicalBlock(scope: !22, file: !3, line: 16, column: 5)
!27 = !DILocation(line: 0, scope: !22)
!28 = !DILocation(line: 16, column: 9, scope: !22)
!29 = !DILocation(line: 16, column: 19, scope: !26)
!30 = !DILocation(line: 16, column: 5, scope: !22)
!31 = !DILocation(line: 0, scope: !24)
!32 = !DILocation(line: 17, column: 13, scope: !24)
!33 = !DILocation(line: 17, column: 23, scope: !34)
!34 = distinct !DILexicalBlock(scope: !24, file: !3, line: 17, column: 9)
!35 = !DILocation(line: 17, column: 9, scope: !24)
!36 = !DILocation(line: 18, column: 13, scope: !37)
!37 = distinct !DILexicalBlock(scope: !34, file: !3, line: 17, column: 31)
!38 = !{!39, !39, i64 0}
!39 = !{!"any pointer", !40, i64 0}
!40 = !{!"omnipotent char", !41, i64 0}
!41 = !{!"Simple C/C++ TBAA"}
!42 = !DILocation(line: 18, column: 18, scope: !37)
!43 = !DILocation(line: 18, column: 16, scope: !37)
!44 = !DILocation(line: 18, column: 21, scope: !37)
!45 = !{!46, !46, i64 0}
!46 = !{!"int", !40, i64 0}
!47 = !DILocation(line: 19, column: 9, scope: !37)
!48 = !DILocation(line: 17, column: 28, scope: !34)
!49 = !DILocation(line: 17, column: 9, scope: !34)
!50 = distinct !{!50, !35, !51}
!51 = !DILocation(line: 19, column: 9, scope: !24)
!52 = !DILocation(line: 20, column: 9, scope: !25)
!53 = !DILocation(line: 20, column: 13, scope: !25)
!54 = !DILocation(line: 21, column: 9, scope: !25)
!55 = !DILocation(line: 21, column: 13, scope: !25)
!56 = !DILocation(line: 22, column: 5, scope: !25)
!57 = !DILocation(line: 16, column: 24, scope: !26)
!58 = !DILocation(line: 16, column: 5, scope: !26)
!59 = distinct !{!59, !30, !60}
!60 = !DILocation(line: 22, column: 5, scope: !22)
!61 = !DILocation(line: 23, column: 9, scope: !17)
!62 = distinct !DISubprogram(name: "Mult", scope: !3, file: !3, line: 27, type: !18, scopeLine: 27, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !4)
!63 = !DILocation(line: 29, column: 13, scope: !62)
!64 = !DILocation(line: 29, column: 50, scope: !65)
!65 = distinct !DILexicalBlock(scope: !62, file: !3, line: 29, column: 13)
!66 = !DILocation(line: 29, column: 68, scope: !65)
!67 = !DILocation(line: 29, column: 31, scope: !65)
!68 = !DILocation(line: 29, column: 13, scope: !65)
!69 = !DILocation(line: 39, column: 5, scope: !62)
!70 = distinct !DISubprogram(name: "__omp_offloading_801_15a4794_Mult_l29_debug__", scope: !3, file: !3, line: 30, type: !71, scopeLine: 30, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !73)
!71 = !DISubroutineType(types: !72)
!72 = !{null, !8, !8, !8}
!73 = !{!74, !75, !76}
!74 = !DILocalVariable(name: "c", arg: 1, scope: !70, file: !3, line: 12, type: !8)
!75 = !DILocalVariable(name: "b", arg: 2, scope: !70, file: !3, line: 11, type: !8)
!76 = !DILocalVariable(name: "a", arg: 3, scope: !70, file: !3, line: 10, type: !8)
!77 = !DILocation(line: 12, column: 6, scope: !70)
!78 = !DILocation(line: 11, column: 6, scope: !70)
!79 = !DILocation(line: 10, column: 6, scope: !70)
!80 = !DILocation(line: 31, column: 17, scope: !81)
!81 = distinct !DILexicalBlock(scope: !70, file: !3, line: 30, column: 5)
!82 = !{!83, !39, i64 16}
!83 = !{!"ident_t", !46, i64 0, !46, i64 4, !46, i64 8, !46, i64 12, !39, i64 16}
!84 = !DILocation(line: 37, column: 5, scope: !70)
!85 = distinct !DISubprogram(name: ".omp_outlined._debug__", scope: !3, file: !3, line: 32, type: !86, scopeLine: 32, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !93)
!86 = !DISubroutineType(types: !87)
!87 = !{null, !88, !88, !92, !92, !92}
!88 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !89)
!89 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !90)
!90 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !91, size: 64)
!91 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !9)
!92 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !8, size: 64)
!93 = !{!94, !95, !96, !97, !98, !99, !100, !101, !102, !103, !104}
!94 = !DILocalVariable(name: ".global_tid.", arg: 1, scope: !85, type: !88, flags: DIFlagArtificial)
!95 = !DILocalVariable(name: ".bound_tid.", arg: 2, scope: !85, type: !88, flags: DIFlagArtificial)
!96 = !DILocalVariable(name: "c", arg: 3, scope: !85, file: !3, line: 12, type: !92)
!97 = !DILocalVariable(name: "b", arg: 4, scope: !85, file: !3, line: 11, type: !92)
!98 = !DILocalVariable(name: "a", arg: 5, scope: !85, file: !3, line: 10, type: !92)
!99 = !DILocalVariable(name: ".omp.iv", scope: !85, type: !9, flags: DIFlagArtificial)
!100 = !DILocalVariable(name: ".omp.comb.lb", scope: !85, type: !9, flags: DIFlagArtificial)
!101 = !DILocalVariable(name: ".omp.comb.ub", scope: !85, type: !9, flags: DIFlagArtificial)
!102 = !DILocalVariable(name: ".omp.stride", scope: !85, type: !9, flags: DIFlagArtificial)
!103 = !DILocalVariable(name: ".omp.is_last", scope: !85, type: !9, flags: DIFlagArtificial)
!104 = !DILocalVariable(name: "i", scope: !85, type: !9, flags: DIFlagArtificial)
!105 = !DILocation(line: 0, scope: !85)
!106 = !DILocation(line: 32, column: 9, scope: !85)
!107 = !DILocation(line: 32, column: 13, scope: !85)
!108 = !DILocation(line: 31, column: 17, scope: !85)
!109 = !DILocation(line: 31, column: 50, scope: !110)
!110 = distinct !DILexicalBlock(scope: !85, file: !3, line: 31, column: 17)
!111 = distinct !{!111, !108, !112}
!112 = !DILocation(line: 31, column: 50, scope: !85)
!113 = !DILocation(line: 36, column: 9, scope: !85)
!114 = distinct !DISubprogram(name: ".omp_outlined._debug__.1", scope: !3, file: !3, line: 32, type: !115, scopeLine: 32, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !119)
!115 = !DISubroutineType(types: !116)
!116 = !{null, !88, !88, !117, !117, !92, !92, !92}
!117 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !118)
!118 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!119 = !{!120, !121, !122, !123, !124, !125, !126, !127, !128, !129, !130, !131, !132, !133}
!120 = !DILocalVariable(name: ".global_tid.", arg: 1, scope: !114, type: !88, flags: DIFlagArtificial)
!121 = !DILocalVariable(name: ".bound_tid.", arg: 2, scope: !114, type: !88, flags: DIFlagArtificial)
!122 = !DILocalVariable(name: ".previous.lb.", arg: 3, scope: !114, type: !117, flags: DIFlagArtificial)
!123 = !DILocalVariable(name: ".previous.ub.", arg: 4, scope: !114, type: !117, flags: DIFlagArtificial)
!124 = !DILocalVariable(name: "c", arg: 5, scope: !114, file: !3, line: 12, type: !92)
!125 = !DILocalVariable(name: "b", arg: 6, scope: !114, file: !3, line: 11, type: !92)
!126 = !DILocalVariable(name: "a", arg: 7, scope: !114, file: !3, line: 10, type: !92)
!127 = !DILocalVariable(name: ".omp.iv", scope: !114, type: !9, flags: DIFlagArtificial)
!128 = !DILocalVariable(name: ".omp.lb", scope: !114, type: !9, flags: DIFlagArtificial)
!129 = !DILocalVariable(name: ".omp.ub", scope: !114, type: !9, flags: DIFlagArtificial)
!130 = !DILocalVariable(name: ".omp.stride", scope: !114, type: !9, flags: DIFlagArtificial)
!131 = !DILocalVariable(name: ".omp.is_last", scope: !114, type: !9, flags: DIFlagArtificial)
!132 = !DILocalVariable(name: "i", scope: !114, type: !9, flags: DIFlagArtificial)
!133 = !DILocalVariable(name: "j", scope: !134, file: !3, line: 33, type: !9)
!134 = distinct !DILexicalBlock(scope: !135, file: !3, line: 33, column: 13)
!135 = distinct !DILexicalBlock(scope: !114, file: !3, line: 32, column: 31)
!136 = !DILocation(line: 0, scope: !114)
!137 = !DILocation(line: 32, column: 9, scope: !114)
!138 = !DILocation(line: 32, column: 13, scope: !114)
!139 = !DILocation(line: 32, column: 27, scope: !114)
!140 = !DILocation(line: 0, scope: !134)
!141 = !DILocation(line: 33, column: 17, scope: !134)
!142 = !DILocation(line: 33, column: 27, scope: !143)
!143 = distinct !DILexicalBlock(scope: !134, file: !3, line: 33, column: 13)
!144 = !DILocation(line: 33, column: 13, scope: !134)
!145 = !DILocation(line: 34, column: 23, scope: !146)
!146 = distinct !DILexicalBlock(scope: !143, file: !3, line: 33, column: 35)
!147 = !DILocation(line: 34, column: 28, scope: !146)
!148 = !DILocation(line: 34, column: 26, scope: !146)
!149 = !DILocation(line: 34, column: 32, scope: !146)
!150 = !DILocation(line: 34, column: 31, scope: !146)
!151 = !DILocation(line: 34, column: 17, scope: !146)
!152 = !DILocation(line: 34, column: 21, scope: !146)
!153 = !DILocation(line: 35, column: 13, scope: !146)
!154 = !DILocation(line: 33, column: 32, scope: !143)
!155 = !DILocation(line: 33, column: 13, scope: !143)
!156 = distinct !{!156, !144, !157}
!157 = !DILocation(line: 35, column: 13, scope: !134)
!158 = !DILocation(line: 36, column: 9, scope: !135)
!159 = !DILocation(line: 31, column: 17, scope: !114)
!160 = distinct !{!160, !159, !161}
!161 = !DILocation(line: 31, column: 50, scope: !114)
!162 = !DILocation(line: 36, column: 9, scope: !114)
!163 = distinct !DISubprogram(name: ".omp_outlined.", scope: !3, file: !3, line: 32, type: !115, scopeLine: 32, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !164)
!164 = !{!165, !166, !167, !168, !169, !170, !171}
!165 = !DILocalVariable(name: ".global_tid.", arg: 1, scope: !163, type: !88, flags: DIFlagArtificial)
!166 = !DILocalVariable(name: ".bound_tid.", arg: 2, scope: !163, type: !88, flags: DIFlagArtificial)
!167 = !DILocalVariable(name: ".previous.lb.", arg: 3, scope: !163, type: !117, flags: DIFlagArtificial)
!168 = !DILocalVariable(name: ".previous.ub.", arg: 4, scope: !163, type: !117, flags: DIFlagArtificial)
!169 = !DILocalVariable(name: "c", arg: 5, scope: !163, type: !92, flags: DIFlagArtificial)
!170 = !DILocalVariable(name: "b", arg: 6, scope: !163, type: !92, flags: DIFlagArtificial)
!171 = !DILocalVariable(name: "a", arg: 7, scope: !163, type: !92, flags: DIFlagArtificial)
!172 = !DILocation(line: 0, scope: !163)
!173 = !DILocation(line: 32, column: 9, scope: !163)
!174 = !{!175}
!175 = !{i64 2, i64 -1, i64 -1, i1 true}
!176 = distinct !DISubprogram(name: ".omp_outlined..2", scope: !3, file: !3, line: 32, type: !86, scopeLine: 32, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !177)
!177 = !{!178, !179, !180, !181, !182}
!178 = !DILocalVariable(name: ".global_tid.", arg: 1, scope: !176, type: !88, flags: DIFlagArtificial)
!179 = !DILocalVariable(name: ".bound_tid.", arg: 2, scope: !176, type: !88, flags: DIFlagArtificial)
!180 = !DILocalVariable(name: "c", arg: 3, scope: !176, type: !92, flags: DIFlagArtificial)
!181 = !DILocalVariable(name: "b", arg: 4, scope: !176, type: !92, flags: DIFlagArtificial)
!182 = !DILocalVariable(name: "a", arg: 5, scope: !176, type: !92, flags: DIFlagArtificial)
!183 = !DILocation(line: 0, scope: !176)
!184 = !DILocation(line: 32, column: 9, scope: !176)
!185 = distinct !DISubprogram(name: "__omp_offloading_801_15a4794_Mult_l29", scope: !3, file: !3, line: 30, type: !71, scopeLine: 30, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !186)
!186 = !{!187, !188, !189}
!187 = !DILocalVariable(name: "c", arg: 1, scope: !185, type: !8, flags: DIFlagArtificial)
!188 = !DILocalVariable(name: "b", arg: 2, scope: !185, type: !8, flags: DIFlagArtificial)
!189 = !DILocalVariable(name: "a", arg: 3, scope: !185, type: !8, flags: DIFlagArtificial)
!190 = !DILocation(line: 0, scope: !185)
!191 = !DILocation(line: 30, column: 5, scope: !185)
!192 = distinct !DISubprogram(name: "check", scope: !3, file: !3, line: 42, type: !18, scopeLine: 42, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !193)
!193 = !{!194, !196}
!194 = !DILocalVariable(name: "test", scope: !192, file: !3, line: 43, type: !195)
!195 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!196 = !DILocalVariable(name: "i", scope: !197, file: !3, line: 44, type: !9)
!197 = distinct !DILexicalBlock(scope: !192, file: !3, line: 44, column: 5)
!198 = !DILocation(line: 0, scope: !192)
!199 = !DILocation(line: 0, scope: !197)
!200 = !DILocation(line: 44, column: 9, scope: !197)
!201 = !DILocation(line: 44, column: 19, scope: !202)
!202 = distinct !DILexicalBlock(scope: !197, file: !3, line: 44, column: 5)
!203 = !DILocation(line: 44, column: 5, scope: !197)
!204 = !DILocation(line: 45, column: 12, scope: !205)
!205 = distinct !DILexicalBlock(scope: !206, file: !3, line: 45, column: 12)
!206 = distinct !DILexicalBlock(scope: !202, file: !3, line: 44, column: 27)
!207 = !DILocation(line: 45, column: 16, scope: !205)
!208 = !DILocation(line: 45, column: 12, scope: !206)
!209 = !DILocation(line: 47, column: 9, scope: !210)
!210 = distinct !DILexicalBlock(scope: !205, file: !3, line: 45, column: 20)
!211 = !DILocation(line: 48, column: 5, scope: !206)
!212 = !DILocation(line: 44, column: 24, scope: !202)
!213 = !DILocation(line: 44, column: 5, scope: !202)
!214 = distinct !{!214, !203, !215}
!215 = !DILocation(line: 48, column: 5, scope: !197)
!216 = !DILocation(line: 49, column: 38, scope: !192)
!217 = !DILocation(line: 49, column: 5, scope: !192)
!218 = !DILocation(line: 50, column: 5, scope: !192)
!219 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 56, type: !18, scopeLine: 56, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !4)
!220 = !DILocation(line: 57, column: 9, scope: !219)
!221 = !DILocation(line: 57, column: 7, scope: !219)
!222 = !DILocation(line: 58, column: 9, scope: !219)
!223 = !DILocation(line: 58, column: 7, scope: !219)
!224 = !DILocation(line: 59, column: 9, scope: !219)
!225 = !DILocation(line: 59, column: 7, scope: !219)
!226 = !DILocation(line: 60, column: 5, scope: !219)
!227 = !DILocation(line: 61, column: 5, scope: !219)
!228 = !DILocation(line: 62, column: 5, scope: !219)
!229 = !DILocation(line: 63, column: 10, scope: !219)
!230 = !DILocation(line: 63, column: 5, scope: !219)
!231 = !DILocation(line: 64, column: 10, scope: !219)
!232 = !DILocation(line: 64, column: 5, scope: !219)
!233 = !DILocation(line: 65, column: 10, scope: !219)
!234 = !DILocation(line: 65, column: 5, scope: !219)
!235 = !DILocation(line: 66, column: 5, scope: !219)
