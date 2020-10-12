; RUN: opt < %s -passes='print-omp-diagnostics' -disable-output 2>&1 | FileCheck %s --check-prefixes=NUF,CHECK

; CHECK: Host to Device Copy:
; CHECK-NEXT: DRACC_OMP_022_MxV_Missing_Data_yes.c:29
; CHECK-NEXT: Copy:: c[0:20000]
; CHECK-NEXT: Copy:: a[0:20000]
; CHECK-NEXT: Device to Host Copy:
; CHECK-NEXT: DRACC_OMP_022_MxV_Missing_Data_yes.c:29
; CHECK-NEXT: Copy:: c[0:20000]


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
  %i = alloca i32, align 4
  %cleanup.dest.slot = alloca i32, align 4
  %j = alloca i32, align 4
  %0 = bitcast i32* %i to i8*, !dbg !27
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %0) #6, !dbg !27
  call void @llvm.dbg.declare(metadata i32* %i, metadata !21, metadata !DIExpression()), !dbg !28
  store i32 0, i32* %i, align 4, !dbg !28, !tbaa !29
  br label %for.cond, !dbg !27

for.cond:                                         ; preds = %for.inc9, %entry
  %1 = load i32, i32* %i, align 4, !dbg !33, !tbaa !29
  %cmp = icmp slt i32 %1, 5000, !dbg !34
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !dbg !35

for.cond.cleanup:                                 ; preds = %for.cond
  store i32 2, i32* %cleanup.dest.slot, align 4
  %2 = bitcast i32* %i to i8*, !dbg !36
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %2) #6, !dbg !36
  br label %for.end11

for.body:                                         ; preds = %for.cond
  %3 = bitcast i32* %j to i8*, !dbg !37
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %3) #6, !dbg !37
  call void @llvm.dbg.declare(metadata i32* %j, metadata !23, metadata !DIExpression()), !dbg !38
  store i32 0, i32* %j, align 4, !dbg !38, !tbaa !29
  br label %for.cond1, !dbg !37

for.cond1:                                        ; preds = %for.inc, %for.body
  %4 = load i32, i32* %j, align 4, !dbg !39, !tbaa !29
  %cmp2 = icmp slt i32 %4, 5000, !dbg !41
  br i1 %cmp2, label %for.body4, label %for.cond.cleanup3, !dbg !42

for.cond.cleanup3:                                ; preds = %for.cond1
  store i32 5, i32* %cleanup.dest.slot, align 4
  %5 = bitcast i32* %j to i8*, !dbg !43
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %5) #6, !dbg !43
  br label %for.end

for.body4:                                        ; preds = %for.cond1
  %6 = load i32*, i32** @b, align 8, !dbg !44, !tbaa !46
  %7 = load i32, i32* %j, align 4, !dbg !48, !tbaa !29
  %8 = load i32, i32* %i, align 4, !dbg !49, !tbaa !29
  %mul = mul nsw i32 %8, 5000, !dbg !50
  %add = add nsw i32 %7, %mul, !dbg !51
  %idxprom = sext i32 %add to i64, !dbg !44
  %arrayidx = getelementptr inbounds i32, i32* %6, i64 %idxprom, !dbg !44
  store i32 1, i32* %arrayidx, align 4, !dbg !52, !tbaa !29
  br label %for.inc, !dbg !53

for.inc:                                          ; preds = %for.body4
  %9 = load i32, i32* %j, align 4, !dbg !54, !tbaa !29
  %inc = add nsw i32 %9, 1, !dbg !54
  store i32 %inc, i32* %j, align 4, !dbg !54, !tbaa !29
  br label %for.cond1, !dbg !43, !llvm.loop !55

for.end:                                          ; preds = %for.cond.cleanup3
  %10 = load i32*, i32** @a, align 8, !dbg !57, !tbaa !46
  %11 = load i32, i32* %i, align 4, !dbg !58, !tbaa !29
  %idxprom5 = sext i32 %11 to i64, !dbg !57
  %arrayidx6 = getelementptr inbounds i32, i32* %10, i64 %idxprom5, !dbg !57
  store i32 1, i32* %arrayidx6, align 4, !dbg !59, !tbaa !29
  %12 = load i32*, i32** @c, align 8, !dbg !60, !tbaa !46
  %13 = load i32, i32* %i, align 4, !dbg !61, !tbaa !29
  %idxprom7 = sext i32 %13 to i64, !dbg !60
  %arrayidx8 = getelementptr inbounds i32, i32* %12, i64 %idxprom7, !dbg !60
  store i32 0, i32* %arrayidx8, align 4, !dbg !62, !tbaa !29
  br label %for.inc9, !dbg !63

for.inc9:                                         ; preds = %for.end
  %14 = load i32, i32* %i, align 4, !dbg !64, !tbaa !29
  %inc10 = add nsw i32 %14, 1, !dbg !64
  store i32 %inc10, i32* %i, align 4, !dbg !64, !tbaa !29
  br label %for.cond, !dbg !36, !llvm.loop !65

for.end11:                                        ; preds = %for.cond.cleanup
  ret i32 0, !dbg !67
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define dso_local i32 @Mult() #0 !dbg !68 {
entry:
  %tmp = alloca i32, align 4
  %.offload_baseptrs = alloca [3 x i8*], align 8
  %.offload_ptrs = alloca [3 x i8*], align 8
  call void @__kmpc_push_target_tripcount(i64 0, i64 5000), !dbg !69
  %0 = load i32*, i32** @c, align 8, !dbg !69, !tbaa !46
  %1 = load i32*, i32** @b, align 8, !dbg !69, !tbaa !46
  %2 = load i32*, i32** @a, align 8, !dbg !69, !tbaa !46
  %3 = load i32*, i32** @c, align 8, !dbg !69
  %4 = load i32*, i32** @c, align 8, !dbg !70, !tbaa !46
  %arrayidx = getelementptr inbounds i32, i32* %4, i64 0, !dbg !70
  %5 = load i32*, i32** @b, align 8, !dbg !69
  %6 = load i32*, i32** @b, align 8, !dbg !72, !tbaa !46
  %arrayidx1 = getelementptr inbounds i32, i32* %6, i64 0, !dbg !72
  %7 = load i32*, i32** @a, align 8, !dbg !69
  %8 = load i32*, i32** @a, align 8, !dbg !73, !tbaa !46
  %arrayidx2 = getelementptr inbounds i32, i32* %8, i64 0, !dbg !73
  %9 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_baseptrs, i32 0, i32 0, !dbg !69
  %10 = bitcast i8** %9 to i32**, !dbg !69
  store i32* %3, i32** %10, align 8, !dbg !69
  %11 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_ptrs, i32 0, i32 0, !dbg !69
  %12 = bitcast i8** %11 to i32**, !dbg !69
  store i32* %arrayidx, i32** %12, align 8, !dbg !69
  %13 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_baseptrs, i32 0, i32 1, !dbg !69
  %14 = bitcast i8** %13 to i32**, !dbg !69
  store i32* %5, i32** %14, align 8, !dbg !69
  %15 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_ptrs, i32 0, i32 1, !dbg !69
  %16 = bitcast i8** %15 to i32**, !dbg !69
  store i32* %arrayidx1, i32** %16, align 8, !dbg !69
  %17 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_baseptrs, i32 0, i32 2, !dbg !69
  %18 = bitcast i8** %17 to i32**, !dbg !69
  store i32* %7, i32** %18, align 8, !dbg !69
  %19 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_ptrs, i32 0, i32 2, !dbg !69
  %20 = bitcast i8** %19 to i32**, !dbg !69
  store i32* %arrayidx2, i32** %20, align 8, !dbg !69
  %21 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_baseptrs, i32 0, i32 0, !dbg !69
  %22 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_ptrs, i32 0, i32 0, !dbg !69
  %23 = call i32 @__tgt_target_teams(i64 0, i8* @.__omp_offloading_801_15a4794_Mult_l29.region_id, i32 3, i8** %21, i8** %22, i64* getelementptr inbounds ([3 x i64], [3 x i64]* @.offload_sizes, i32 0, i32 0), i64* getelementptr inbounds ([3 x i64], [3 x i64]* @.offload_maptypes, i32 0, i32 0), i32 0, i32 0), !dbg !69
  %24 = icmp ne i32 %23, 0, !dbg !69
  br i1 %24, label %omp_offload.failed, label %omp_offload.cont, !dbg !69

omp_offload.failed:                               ; preds = %entry
  call void @__omp_offloading_801_15a4794_Mult_l29(i32* %0, i32* %1, i32* %2) #6, !dbg !74
  br label %omp_offload.cont, !dbg !69

omp_offload.cont:                                 ; preds = %omp_offload.failed, %entry
  ret i32 0, !dbg !75
}

; Function Attrs: norecurse nounwind uwtable
define internal void @__omp_offloading_801_15a4794_Mult_l29_debug__(i32* %c, i32* %b, i32* %a) #3 !dbg !76 {
entry:
  %c.addr = alloca i32*, align 8
  %b.addr = alloca i32*, align 8
  %a.addr = alloca i32*, align 8
  %.kmpc_loc.addr = alloca %struct.ident_t, align 8
  %0 = bitcast %struct.ident_t* %.kmpc_loc.addr to i8*
  %1 = bitcast %struct.ident_t* @4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %0, i8* align 8 %1, i64 24, i1 false)
  store i32* %c, i32** %c.addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32** %c.addr, metadata !80, metadata !DIExpression()), !dbg !83
  store i32* %b, i32** %b.addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32** %b.addr, metadata !81, metadata !DIExpression()), !dbg !84
  store i32* %a, i32** %a.addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32** %a.addr, metadata !82, metadata !DIExpression()), !dbg !85
  %2 = getelementptr inbounds %struct.ident_t, %struct.ident_t* %.kmpc_loc.addr, i32 0, i32 4, !dbg !86
  store i8* getelementptr inbounds ([51 x i8], [51 x i8]* @1, i32 0, i32 0), i8** %2, align 8, !dbg !86, !tbaa !88
  call void (%struct.ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_teams(%struct.ident_t* %.kmpc_loc.addr, i32 3, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, i32**, i32**, i32**)* @.omp_outlined..2 to void (i32*, i32*, ...)*), i32** %c.addr, i32** %b.addr, i32** %a.addr), !dbg !86
  ret void, !dbg !90
}

; Function Attrs: norecurse nounwind uwtable
define internal void @.omp_outlined._debug__(i32* noalias %.global_tid., i32* noalias %.bound_tid., i32** dereferenceable(8) %c, i32** dereferenceable(8) %b, i32** dereferenceable(8) %a) #3 !dbg !91 {
entry:
  %.global_tid..addr = alloca i32*, align 8
  %.bound_tid..addr = alloca i32*, align 8
  %c.addr = alloca i32**, align 8
  %b.addr = alloca i32**, align 8
  %a.addr = alloca i32**, align 8
  %.omp.iv = alloca i32, align 4
  %tmp = alloca i32, align 4
  %.omp.comb.lb = alloca i32, align 4
  %.omp.comb.ub = alloca i32, align 4
  %.omp.stride = alloca i32, align 4
  %.omp.is_last = alloca i32, align 4
  %i = alloca i32, align 4
  %.kmpc_loc.addr = alloca %struct.ident_t, align 8
  %0 = bitcast %struct.ident_t* %.kmpc_loc.addr to i8*
  %1 = bitcast %struct.ident_t* @0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %0, i8* align 8 %1, i64 24, i1 false)
  store i32* %.global_tid., i32** %.global_tid..addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32** %.global_tid..addr, metadata !100, metadata !DIExpression()), !dbg !111
  store i32* %.bound_tid., i32** %.bound_tid..addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32** %.bound_tid..addr, metadata !101, metadata !DIExpression()), !dbg !111
  store i32** %c, i32*** %c.addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32*** %c.addr, metadata !102, metadata !DIExpression()), !dbg !112
  store i32** %b, i32*** %b.addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32*** %b.addr, metadata !103, metadata !DIExpression()), !dbg !113
  store i32** %a, i32*** %a.addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32*** %a.addr, metadata !104, metadata !DIExpression()), !dbg !114
  %2 = load i32**, i32*** %c.addr, align 8, !dbg !115, !tbaa !46
  %3 = load i32**, i32*** %b.addr, align 8, !dbg !115, !tbaa !46
  %4 = load i32**, i32*** %a.addr, align 8, !dbg !115, !tbaa !46
  %5 = bitcast i32* %.omp.iv to i8*, !dbg !115
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %5) #6, !dbg !115
  call void @llvm.dbg.declare(metadata i32* %.omp.iv, metadata !105, metadata !DIExpression()), !dbg !111
  %6 = bitcast i32* %.omp.comb.lb to i8*, !dbg !115
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %6) #6, !dbg !115
  call void @llvm.dbg.declare(metadata i32* %.omp.comb.lb, metadata !106, metadata !DIExpression()), !dbg !111
  store i32 0, i32* %.omp.comb.lb, align 4, !dbg !116, !tbaa !29
  %7 = bitcast i32* %.omp.comb.ub to i8*, !dbg !115
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %7) #6, !dbg !115
  call void @llvm.dbg.declare(metadata i32* %.omp.comb.ub, metadata !107, metadata !DIExpression()), !dbg !111
  store i32 4999, i32* %.omp.comb.ub, align 4, !dbg !116, !tbaa !29
  %8 = bitcast i32* %.omp.stride to i8*, !dbg !115
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %8) #6, !dbg !115
  call void @llvm.dbg.declare(metadata i32* %.omp.stride, metadata !108, metadata !DIExpression()), !dbg !111
  store i32 1, i32* %.omp.stride, align 4, !dbg !116, !tbaa !29
  %9 = bitcast i32* %.omp.is_last to i8*, !dbg !115
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %9) #6, !dbg !115
  call void @llvm.dbg.declare(metadata i32* %.omp.is_last, metadata !109, metadata !DIExpression()), !dbg !111
  store i32 0, i32* %.omp.is_last, align 4, !dbg !116, !tbaa !29
  %10 = bitcast i32* %i to i8*, !dbg !115
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %10) #6, !dbg !115
  call void @llvm.dbg.declare(metadata i32* %i, metadata !110, metadata !DIExpression()), !dbg !111
  %11 = getelementptr inbounds %struct.ident_t, %struct.ident_t* %.kmpc_loc.addr, i32 0, i32 4, !dbg !115
  store i8* getelementptr inbounds ([51 x i8], [51 x i8]* @1, i32 0, i32 0), i8** %11, align 8, !dbg !115, !tbaa !88
  %12 = load i32*, i32** %.global_tid..addr, align 8, !dbg !115
  %13 = load i32, i32* %12, align 4, !dbg !115, !tbaa !29
  call void @__kmpc_for_static_init_4(%struct.ident_t* %.kmpc_loc.addr, i32 %13, i32 92, i32* %.omp.is_last, i32* %.omp.comb.lb, i32* %.omp.comb.ub, i32* %.omp.stride, i32 1, i32 1), !dbg !115
  %14 = load i32, i32* %.omp.comb.ub, align 4, !dbg !116, !tbaa !29
  %cmp = icmp sgt i32 %14, 4999, !dbg !116
  br i1 %cmp, label %cond.true, label %cond.false, !dbg !116

cond.true:                                        ; preds = %entry
  br label %cond.end, !dbg !116

cond.false:                                       ; preds = %entry
  %15 = load i32, i32* %.omp.comb.ub, align 4, !dbg !116, !tbaa !29
  br label %cond.end, !dbg !116

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ 4999, %cond.true ], [ %15, %cond.false ], !dbg !116
  store i32 %cond, i32* %.omp.comb.ub, align 4, !dbg !116, !tbaa !29
  %16 = load i32, i32* %.omp.comb.lb, align 4, !dbg !116, !tbaa !29
  store i32 %16, i32* %.omp.iv, align 4, !dbg !116, !tbaa !29
  br label %omp.inner.for.cond, !dbg !115

omp.inner.for.cond:                               ; preds = %omp.inner.for.inc, %cond.end
  %17 = load i32, i32* %.omp.iv, align 4, !dbg !116, !tbaa !29
  %18 = load i32, i32* %.omp.comb.ub, align 4, !dbg !116, !tbaa !29
  %cmp1 = icmp sle i32 %17, %18, !dbg !115
  br i1 %cmp1, label %omp.inner.for.body, label %omp.inner.for.cond.cleanup, !dbg !115

omp.inner.for.cond.cleanup:                       ; preds = %omp.inner.for.cond
  br label %omp.inner.for.end, !dbg !115

omp.inner.for.body:                               ; preds = %omp.inner.for.cond
  %19 = load i32, i32* %.omp.comb.lb, align 4, !dbg !117
  %20 = zext i32 %19 to i64, !dbg !117
  %21 = load i32, i32* %.omp.comb.ub, align 4, !dbg !117
  %22 = zext i32 %21 to i64, !dbg !117
  %23 = getelementptr inbounds %struct.ident_t, %struct.ident_t* %.kmpc_loc.addr, i32 0, i32 4, !dbg !117
  store i8* getelementptr inbounds ([51 x i8], [51 x i8]* @1, i32 0, i32 0), i8** %23, align 8, !dbg !117, !tbaa !88
  call void (%struct.ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%struct.ident_t* %.kmpc_loc.addr, i32 5, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, i64, i64, i32**, i32**, i32**)* @.omp_outlined. to void (i32*, i32*, ...)*), i64 %20, i64 %22, i32** %2, i32** %3, i32** %4), !dbg !117
  br label %omp.inner.for.inc, !dbg !118

omp.inner.for.inc:                                ; preds = %omp.inner.for.body
  %24 = load i32, i32* %.omp.iv, align 4, !dbg !116, !tbaa !29
  %25 = load i32, i32* %.omp.stride, align 4, !dbg !116, !tbaa !29
  %add = add nsw i32 %24, %25, !dbg !115
  store i32 %add, i32* %.omp.iv, align 4, !dbg !115, !tbaa !29
  br label %omp.inner.for.cond, !dbg !118, !llvm.loop !120

omp.inner.for.end:                                ; preds = %omp.inner.for.cond.cleanup
  br label %omp.loop.exit, !dbg !118

omp.loop.exit:                                    ; preds = %omp.inner.for.end
  %26 = getelementptr inbounds %struct.ident_t, %struct.ident_t* %.kmpc_loc.addr, i32 0, i32 4, !dbg !118
  store i8* getelementptr inbounds ([51 x i8], [51 x i8]* @1, i32 0, i32 0), i8** %26, align 8, !dbg !118, !tbaa !88
  call void @__kmpc_for_static_fini(%struct.ident_t* %.kmpc_loc.addr, i32 %13), !dbg !118
  %27 = bitcast i32* %i to i8*, !dbg !118
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %27) #6, !dbg !118
  %28 = bitcast i32* %.omp.is_last to i8*, !dbg !118
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %28) #6, !dbg !118
  %29 = bitcast i32* %.omp.stride to i8*, !dbg !118
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %29) #6, !dbg !118
  %30 = bitcast i32* %.omp.comb.ub to i8*, !dbg !118
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %30) #6, !dbg !118
  %31 = bitcast i32* %.omp.comb.lb to i8*, !dbg !118
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %31) #6, !dbg !118
  %32 = bitcast i32* %.omp.iv to i8*, !dbg !118
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %32) #6, !dbg !118
  ret void, !dbg !122
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1 immarg) #1

declare dso_local void @__kmpc_for_static_init_4(%struct.ident_t*, i32, i32, i32*, i32*, i32*, i32*, i32, i32)

; Function Attrs: norecurse nounwind uwtable
define internal void @.omp_outlined._debug__.1(i32* noalias %.global_tid., i32* noalias %.bound_tid., i64 %.previous.lb., i64 %.previous.ub., i32** dereferenceable(8) %c, i32** dereferenceable(8) %b, i32** dereferenceable(8) %a) #3 !dbg !123 {
entry:
  %.global_tid..addr = alloca i32*, align 8
  %.bound_tid..addr = alloca i32*, align 8
  %.previous.lb..addr = alloca i64, align 8
  %.previous.ub..addr = alloca i64, align 8
  %c.addr = alloca i32**, align 8
  %b.addr = alloca i32**, align 8
  %a.addr = alloca i32**, align 8
  %.omp.iv = alloca i32, align 4
  %tmp = alloca i32, align 4
  %.omp.lb = alloca i32, align 4
  %.omp.ub = alloca i32, align 4
  %.omp.stride = alloca i32, align 4
  %.omp.is_last = alloca i32, align 4
  %i = alloca i32, align 4
  %.kmpc_loc.addr = alloca %struct.ident_t, align 8
  %j = alloca i32, align 4
  %0 = bitcast %struct.ident_t* %.kmpc_loc.addr to i8*
  %1 = bitcast %struct.ident_t* @2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %0, i8* align 8 %1, i64 24, i1 false)
  store i32* %.global_tid., i32** %.global_tid..addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32** %.global_tid..addr, metadata !129, metadata !DIExpression()), !dbg !145
  store i32* %.bound_tid., i32** %.bound_tid..addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32** %.bound_tid..addr, metadata !130, metadata !DIExpression()), !dbg !145
  store i64 %.previous.lb., i64* %.previous.lb..addr, align 8, !tbaa !146
  call void @llvm.dbg.declare(metadata i64* %.previous.lb..addr, metadata !131, metadata !DIExpression()), !dbg !145
  store i64 %.previous.ub., i64* %.previous.ub..addr, align 8, !tbaa !146
  call void @llvm.dbg.declare(metadata i64* %.previous.ub..addr, metadata !132, metadata !DIExpression()), !dbg !145
  store i32** %c, i32*** %c.addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32*** %c.addr, metadata !133, metadata !DIExpression()), !dbg !148
  store i32** %b, i32*** %b.addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32*** %b.addr, metadata !134, metadata !DIExpression()), !dbg !149
  store i32** %a, i32*** %a.addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32*** %a.addr, metadata !135, metadata !DIExpression()), !dbg !150
  %2 = load i32**, i32*** %c.addr, align 8, !dbg !151, !tbaa !46
  %3 = load i32**, i32*** %b.addr, align 8, !dbg !151, !tbaa !46
  %4 = load i32**, i32*** %a.addr, align 8, !dbg !151, !tbaa !46
  %5 = bitcast i32* %.omp.iv to i8*, !dbg !151
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %5) #6, !dbg !151
  call void @llvm.dbg.declare(metadata i32* %.omp.iv, metadata !136, metadata !DIExpression()), !dbg !145
  %6 = bitcast i32* %.omp.lb to i8*, !dbg !151
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %6) #6, !dbg !151
  call void @llvm.dbg.declare(metadata i32* %.omp.lb, metadata !137, metadata !DIExpression()), !dbg !145
  store i32 0, i32* %.omp.lb, align 4, !dbg !152, !tbaa !29
  %7 = bitcast i32* %.omp.ub to i8*, !dbg !151
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %7) #6, !dbg !151
  call void @llvm.dbg.declare(metadata i32* %.omp.ub, metadata !138, metadata !DIExpression()), !dbg !145
  store i32 4999, i32* %.omp.ub, align 4, !dbg !152, !tbaa !29
  %8 = load i64, i64* %.previous.lb..addr, align 8, !dbg !151, !tbaa !146
  %conv = trunc i64 %8 to i32, !dbg !151
  %9 = load i64, i64* %.previous.ub..addr, align 8, !dbg !151, !tbaa !146
  %conv1 = trunc i64 %9 to i32, !dbg !151
  store i32 %conv, i32* %.omp.lb, align 4, !dbg !151, !tbaa !29
  store i32 %conv1, i32* %.omp.ub, align 4, !dbg !151, !tbaa !29
  %10 = bitcast i32* %.omp.stride to i8*, !dbg !151
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %10) #6, !dbg !151
  call void @llvm.dbg.declare(metadata i32* %.omp.stride, metadata !139, metadata !DIExpression()), !dbg !145
  store i32 1, i32* %.omp.stride, align 4, !dbg !152, !tbaa !29
  %11 = bitcast i32* %.omp.is_last to i8*, !dbg !151
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %11) #6, !dbg !151
  call void @llvm.dbg.declare(metadata i32* %.omp.is_last, metadata !140, metadata !DIExpression()), !dbg !145
  store i32 0, i32* %.omp.is_last, align 4, !dbg !152, !tbaa !29
  %12 = bitcast i32* %i to i8*, !dbg !151
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %12) #6, !dbg !151
  call void @llvm.dbg.declare(metadata i32* %i, metadata !141, metadata !DIExpression()), !dbg !145
  %13 = getelementptr inbounds %struct.ident_t, %struct.ident_t* %.kmpc_loc.addr, i32 0, i32 4, !dbg !151
  store i8* getelementptr inbounds ([51 x i8], [51 x i8]* @1, i32 0, i32 0), i8** %13, align 8, !dbg !151, !tbaa !88
  %14 = load i32*, i32** %.global_tid..addr, align 8, !dbg !151
  %15 = load i32, i32* %14, align 4, !dbg !151, !tbaa !29
  call void @__kmpc_for_static_init_4(%struct.ident_t* %.kmpc_loc.addr, i32 %15, i32 34, i32* %.omp.is_last, i32* %.omp.lb, i32* %.omp.ub, i32* %.omp.stride, i32 1, i32 1), !dbg !151
  %16 = load i32, i32* %.omp.ub, align 4, !dbg !152, !tbaa !29
  %cmp = icmp sgt i32 %16, 4999, !dbg !152
  br i1 %cmp, label %cond.true, label %cond.false, !dbg !152

cond.true:                                        ; preds = %entry
  br label %cond.end, !dbg !152

cond.false:                                       ; preds = %entry
  %17 = load i32, i32* %.omp.ub, align 4, !dbg !152, !tbaa !29
  br label %cond.end, !dbg !152

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ 4999, %cond.true ], [ %17, %cond.false ], !dbg !152
  store i32 %cond, i32* %.omp.ub, align 4, !dbg !152, !tbaa !29
  %18 = load i32, i32* %.omp.lb, align 4, !dbg !152, !tbaa !29
  store i32 %18, i32* %.omp.iv, align 4, !dbg !152, !tbaa !29
  br label %omp.inner.for.cond, !dbg !151

omp.inner.for.cond:                               ; preds = %omp.inner.for.inc, %cond.end
  %19 = load i32, i32* %.omp.iv, align 4, !dbg !152, !tbaa !29
  %20 = load i32, i32* %.omp.ub, align 4, !dbg !152, !tbaa !29
  %cmp3 = icmp sle i32 %19, %20, !dbg !151
  br i1 %cmp3, label %omp.inner.for.body, label %omp.inner.for.cond.cleanup, !dbg !151

omp.inner.for.cond.cleanup:                       ; preds = %omp.inner.for.cond
  br label %omp.inner.for.end, !dbg !151

omp.inner.for.body:                               ; preds = %omp.inner.for.cond
  %21 = load i32, i32* %.omp.iv, align 4, !dbg !152, !tbaa !29
  %mul = mul nsw i32 %21, 1, !dbg !153
  %add = add nsw i32 0, %mul, !dbg !153
  store i32 %add, i32* %i, align 4, !dbg !153, !tbaa !29
  %22 = bitcast i32* %j to i8*, !dbg !154
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %22) #6, !dbg !154
  call void @llvm.dbg.declare(metadata i32* %j, metadata !142, metadata !DIExpression()), !dbg !155
  store i32 0, i32* %j, align 4, !dbg !155, !tbaa !29
  br label %for.cond, !dbg !154

for.cond:                                         ; preds = %for.inc, %omp.inner.for.body
  %23 = load i32, i32* %j, align 4, !dbg !156, !tbaa !29
  %cmp5 = icmp slt i32 %23, 5000, !dbg !158
  br i1 %cmp5, label %for.body, label %for.cond.cleanup, !dbg !159

for.cond.cleanup:                                 ; preds = %for.cond
  %24 = bitcast i32* %j to i8*, !dbg !160
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %24) #6, !dbg !160
  br label %for.end

for.body:                                         ; preds = %for.cond
  %25 = load i32*, i32** %3, align 8, !dbg !161, !tbaa !46
  %26 = load i32, i32* %j, align 4, !dbg !163, !tbaa !29
  %27 = load i32, i32* %i, align 4, !dbg !164, !tbaa !29
  %mul7 = mul nsw i32 %27, 5000, !dbg !165
  %add8 = add nsw i32 %26, %mul7, !dbg !166
  %idxprom = sext i32 %add8 to i64, !dbg !161
  %arrayidx = getelementptr inbounds i32, i32* %25, i64 %idxprom, !dbg !161
  %28 = load i32, i32* %arrayidx, align 4, !dbg !161, !tbaa !29
  %29 = load i32*, i32** %4, align 8, !dbg !167, !tbaa !46
  %30 = load i32, i32* %j, align 4, !dbg !168, !tbaa !29
  %idxprom9 = sext i32 %30 to i64, !dbg !167
  %arrayidx10 = getelementptr inbounds i32, i32* %29, i64 %idxprom9, !dbg !167
  %31 = load i32, i32* %arrayidx10, align 4, !dbg !167, !tbaa !29
  %mul11 = mul nsw i32 %28, %31, !dbg !169
  %32 = load i32*, i32** %2, align 8, !dbg !170, !tbaa !46
  %33 = load i32, i32* %i, align 4, !dbg !171, !tbaa !29
  %idxprom12 = sext i32 %33 to i64, !dbg !170
  %arrayidx13 = getelementptr inbounds i32, i32* %32, i64 %idxprom12, !dbg !170
  %34 = load i32, i32* %arrayidx13, align 4, !dbg !172, !tbaa !29
  %add14 = add nsw i32 %34, %mul11, !dbg !172
  store i32 %add14, i32* %arrayidx13, align 4, !dbg !172, !tbaa !29
  br label %for.inc, !dbg !173

for.inc:                                          ; preds = %for.body
  %35 = load i32, i32* %j, align 4, !dbg !174, !tbaa !29
  %inc = add nsw i32 %35, 1, !dbg !174
  store i32 %inc, i32* %j, align 4, !dbg !174, !tbaa !29
  br label %for.cond, !dbg !160, !llvm.loop !175

for.end:                                          ; preds = %for.cond.cleanup
  br label %omp.body.continue, !dbg !177

omp.body.continue:                                ; preds = %for.end
  br label %omp.inner.for.inc, !dbg !178

omp.inner.for.inc:                                ; preds = %omp.body.continue
  %36 = load i32, i32* %.omp.iv, align 4, !dbg !152, !tbaa !29
  %add15 = add nsw i32 %36, 1, !dbg !151
  store i32 %add15, i32* %.omp.iv, align 4, !dbg !151, !tbaa !29
  br label %omp.inner.for.cond, !dbg !178, !llvm.loop !179

omp.inner.for.end:                                ; preds = %omp.inner.for.cond.cleanup
  br label %omp.loop.exit, !dbg !178

omp.loop.exit:                                    ; preds = %omp.inner.for.end
  %37 = getelementptr inbounds %struct.ident_t, %struct.ident_t* %.kmpc_loc.addr, i32 0, i32 4, !dbg !178
  store i8* getelementptr inbounds ([51 x i8], [51 x i8]* @3, i32 0, i32 0), i8** %37, align 8, !dbg !178, !tbaa !88
  call void @__kmpc_for_static_fini(%struct.ident_t* %.kmpc_loc.addr, i32 %15), !dbg !178
  %38 = bitcast i32* %i to i8*, !dbg !178
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %38) #6, !dbg !178
  %39 = bitcast i32* %.omp.is_last to i8*, !dbg !178
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %39) #6, !dbg !178
  %40 = bitcast i32* %.omp.stride to i8*, !dbg !178
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %40) #6, !dbg !178
  %41 = bitcast i32* %.omp.ub to i8*, !dbg !178
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %41) #6, !dbg !178
  %42 = bitcast i32* %.omp.lb to i8*, !dbg !178
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %42) #6, !dbg !178
  %43 = bitcast i32* %.omp.iv to i8*, !dbg !178
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %43) #6, !dbg !178
  ret void, !dbg !181
}

declare dso_local void @__kmpc_for_static_fini(%struct.ident_t*, i32)

; Function Attrs: norecurse nounwind uwtable
define internal void @.omp_outlined.(i32* noalias %.global_tid., i32* noalias %.bound_tid., i64 %.previous.lb., i64 %.previous.ub., i32** dereferenceable(8) %c, i32** dereferenceable(8) %b, i32** dereferenceable(8) %a) #3 !dbg !182 {
entry:
  %.global_tid..addr = alloca i32*, align 8
  %.bound_tid..addr = alloca i32*, align 8
  %.previous.lb..addr = alloca i64, align 8
  %.previous.ub..addr = alloca i64, align 8
  %c.addr = alloca i32**, align 8
  %b.addr = alloca i32**, align 8
  %a.addr = alloca i32**, align 8
  store i32* %.global_tid., i32** %.global_tid..addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32** %.global_tid..addr, metadata !184, metadata !DIExpression()), !dbg !191
  store i32* %.bound_tid., i32** %.bound_tid..addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32** %.bound_tid..addr, metadata !185, metadata !DIExpression()), !dbg !191
  store i64 %.previous.lb., i64* %.previous.lb..addr, align 8, !tbaa !146
  call void @llvm.dbg.declare(metadata i64* %.previous.lb..addr, metadata !186, metadata !DIExpression()), !dbg !191
  store i64 %.previous.ub., i64* %.previous.ub..addr, align 8, !tbaa !146
  call void @llvm.dbg.declare(metadata i64* %.previous.ub..addr, metadata !187, metadata !DIExpression()), !dbg !191
  store i32** %c, i32*** %c.addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32*** %c.addr, metadata !188, metadata !DIExpression()), !dbg !191
  store i32** %b, i32*** %b.addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32*** %b.addr, metadata !189, metadata !DIExpression()), !dbg !191
  store i32** %a, i32*** %a.addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32*** %a.addr, metadata !190, metadata !DIExpression()), !dbg !191
  %0 = load i32**, i32*** %c.addr, align 8, !dbg !192, !tbaa !46
  %1 = load i32**, i32*** %b.addr, align 8, !dbg !192, !tbaa !46
  %2 = load i32**, i32*** %a.addr, align 8, !dbg !192, !tbaa !46
  %3 = load i32*, i32** %.global_tid..addr, align 8, !dbg !192, !tbaa !46
  %4 = load i32*, i32** %.bound_tid..addr, align 8, !dbg !192, !tbaa !46
  %5 = load i64, i64* %.previous.lb..addr, align 8, !dbg !192, !tbaa !146
  %6 = load i64, i64* %.previous.ub..addr, align 8, !dbg !192, !tbaa !146
  %7 = load i32**, i32*** %c.addr, align 8, !dbg !192, !tbaa !46
  %8 = load i32**, i32*** %b.addr, align 8, !dbg !192, !tbaa !46
  %9 = load i32**, i32*** %a.addr, align 8, !dbg !192, !tbaa !46
  call void @.omp_outlined._debug__.1(i32* %3, i32* %4, i64 %5, i64 %6, i32** %7, i32** %8, i32** %9) #6, !dbg !192
  ret void, !dbg !192
}

declare !callback !193 dso_local void @__kmpc_fork_call(%struct.ident_t*, i32, void (i32*, i32*, ...)*, ...)

; Function Attrs: norecurse nounwind uwtable
define internal void @.omp_outlined..2(i32* noalias %.global_tid., i32* noalias %.bound_tid., i32** dereferenceable(8) %c, i32** dereferenceable(8) %b, i32** dereferenceable(8) %a) #3 !dbg !195 {
entry:
  %.global_tid..addr = alloca i32*, align 8
  %.bound_tid..addr = alloca i32*, align 8
  %c.addr = alloca i32**, align 8
  %b.addr = alloca i32**, align 8
  %a.addr = alloca i32**, align 8
  store i32* %.global_tid., i32** %.global_tid..addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32** %.global_tid..addr, metadata !197, metadata !DIExpression()), !dbg !202
  store i32* %.bound_tid., i32** %.bound_tid..addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32** %.bound_tid..addr, metadata !198, metadata !DIExpression()), !dbg !202
  store i32** %c, i32*** %c.addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32*** %c.addr, metadata !199, metadata !DIExpression()), !dbg !202
  store i32** %b, i32*** %b.addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32*** %b.addr, metadata !200, metadata !DIExpression()), !dbg !202
  store i32** %a, i32*** %a.addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32*** %a.addr, metadata !201, metadata !DIExpression()), !dbg !202
  %0 = load i32**, i32*** %c.addr, align 8, !dbg !203, !tbaa !46
  %1 = load i32**, i32*** %b.addr, align 8, !dbg !203, !tbaa !46
  %2 = load i32**, i32*** %a.addr, align 8, !dbg !203, !tbaa !46
  %3 = load i32*, i32** %.global_tid..addr, align 8, !dbg !203, !tbaa !46
  %4 = load i32*, i32** %.bound_tid..addr, align 8, !dbg !203, !tbaa !46
  %5 = load i32**, i32*** %c.addr, align 8, !dbg !203, !tbaa !46
  %6 = load i32**, i32*** %b.addr, align 8, !dbg !203, !tbaa !46
  %7 = load i32**, i32*** %a.addr, align 8, !dbg !203, !tbaa !46
  call void @.omp_outlined._debug__(i32* %3, i32* %4, i32** %5, i32** %6, i32** %7) #6, !dbg !203
  ret void, !dbg !203
}

declare !callback !193 dso_local void @__kmpc_fork_teams(%struct.ident_t*, i32, void (i32*, i32*, ...)*, ...)

; Function Attrs: norecurse nounwind uwtable
define internal void @__omp_offloading_801_15a4794_Mult_l29(i32* %c, i32* %b, i32* %a) #3 !dbg !204 {
entry:
  %c.addr = alloca i32*, align 8
  %b.addr = alloca i32*, align 8
  %a.addr = alloca i32*, align 8
  store i32* %c, i32** %c.addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32** %c.addr, metadata !206, metadata !DIExpression()), !dbg !209
  store i32* %b, i32** %b.addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32** %b.addr, metadata !207, metadata !DIExpression()), !dbg !209
  store i32* %a, i32** %a.addr, align 8, !tbaa !46
  call void @llvm.dbg.declare(metadata i32** %a.addr, metadata !208, metadata !DIExpression()), !dbg !209
  %0 = load i32*, i32** %c.addr, align 8, !dbg !210, !tbaa !46
  %1 = load i32*, i32** %b.addr, align 8, !dbg !210, !tbaa !46
  %2 = load i32*, i32** %a.addr, align 8, !dbg !210, !tbaa !46
  call void @__omp_offloading_801_15a4794_Mult_l29_debug__(i32* %0, i32* %1, i32* %2) #6, !dbg !210
  ret void, !dbg !210
}

declare dso_local void @__kmpc_push_target_tripcount(i64, i64)

declare dso_local i32 @__tgt_target_teams(i64, i8*, i32, i8**, i8**, i64*, i64*, i32, i32)

; Function Attrs: nounwind uwtable
define dso_local i32 @check() #0 !dbg !211 {
entry:
  %test = alloca i8, align 1
  %i = alloca i32, align 4
  call void @llvm.lifetime.start.p0i8(i64 1, i8* %test) #6, !dbg !217
  call void @llvm.dbg.declare(metadata i8* %test, metadata !213, metadata !DIExpression()), !dbg !218
  store i8 0, i8* %test, align 1, !dbg !218, !tbaa !219
  %0 = bitcast i32* %i to i8*, !dbg !221
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %0) #6, !dbg !221
  call void @llvm.dbg.declare(metadata i32* %i, metadata !215, metadata !DIExpression()), !dbg !222
  store i32 0, i32* %i, align 4, !dbg !222, !tbaa !29
  br label %for.cond, !dbg !221

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i32, i32* %i, align 4, !dbg !223, !tbaa !29
  %cmp = icmp slt i32 %1, 5000, !dbg !225
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !dbg !226

for.cond.cleanup:                                 ; preds = %for.cond
  %2 = bitcast i32* %i to i8*, !dbg !227
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %2) #6, !dbg !227
  br label %for.end

for.body:                                         ; preds = %for.cond
  %3 = load i32*, i32** @c, align 8, !dbg !228, !tbaa !46
  %4 = load i32, i32* %i, align 4, !dbg !231, !tbaa !29
  %idxprom = sext i32 %4 to i64, !dbg !228
  %arrayidx = getelementptr inbounds i32, i32* %3, i64 %idxprom, !dbg !228
  %5 = load i32, i32* %arrayidx, align 4, !dbg !228, !tbaa !29
  %cmp1 = icmp ne i32 %5, 5000, !dbg !232
  br i1 %cmp1, label %if.then, label %if.end, !dbg !233

if.then:                                          ; preds = %for.body
  store i8 1, i8* %test, align 1, !dbg !234, !tbaa !219
  br label %if.end, !dbg !236

if.end:                                           ; preds = %if.then, %for.body
  br label %for.inc, !dbg !237

for.inc:                                          ; preds = %if.end
  %6 = load i32, i32* %i, align 4, !dbg !238, !tbaa !29
  %inc = add nsw i32 %6, 1, !dbg !238
  store i32 %inc, i32* %i, align 4, !dbg !238, !tbaa !29
  br label %for.cond, !dbg !227, !llvm.loop !239

for.end:                                          ; preds = %for.cond.cleanup
  %7 = load i8, i8* %test, align 1, !dbg !241, !tbaa !219, !range !242
  %tobool = trunc i8 %7 to i1, !dbg !241
  %8 = zext i1 %tobool to i64, !dbg !241
  %cond = select i1 %tobool, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.4, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i64 0, i64 0), !dbg !241
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.3, i64 0, i64 0), i8* %cond), !dbg !243
  call void @llvm.lifetime.end.p0i8(i64 1, i8* %test) #6, !dbg !244
  ret i32 0, !dbg !245
}

declare dso_local i32 @printf(i8*, ...) #4

; Function Attrs: nounwind uwtable
define dso_local i32 @main() #0 !dbg !246 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %call = call noalias i8* @malloc(i64 20000) #6, !dbg !247
  %0 = bitcast i8* %call to i32*, !dbg !247
  store i32* %0, i32** @a, align 8, !dbg !248, !tbaa !46
  %call1 = call noalias i8* @malloc(i64 100000000) #6, !dbg !249
  %1 = bitcast i8* %call1 to i32*, !dbg !249
  store i32* %1, i32** @b, align 8, !dbg !250, !tbaa !46
  %call2 = call noalias i8* @malloc(i64 20000) #6, !dbg !251
  %2 = bitcast i8* %call2 to i32*, !dbg !251
  store i32* %2, i32** @c, align 8, !dbg !252, !tbaa !46
  %call3 = call i32 @init(), !dbg !253
  %call4 = call i32 @Mult(), !dbg !254
  %call5 = call i32 @check(), !dbg !255
  %3 = load i32*, i32** @a, align 8, !dbg !256, !tbaa !46
  %4 = bitcast i32* %3 to i8*, !dbg !256
  call void @free(i8* %4) #6, !dbg !257
  %5 = load i32*, i32** @b, align 8, !dbg !258, !tbaa !46
  %6 = bitcast i32* %5 to i8*, !dbg !258
  call void @free(i8* %6) #6, !dbg !259
  %7 = load i32*, i32** @c, align 8, !dbg !260, !tbaa !46
  %8 = bitcast i32* %7 to i8*, !dbg !260
  call void @free(i8* %8) #6, !dbg !261
  ret i32 0, !dbg !262
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #5

; Function Attrs: nounwind
declare dso_local void @free(i8*) #5

; Function Attrs: nounwind uwtable
define internal void @.omp_offloading.descriptor_unreg(i8*) #0 section ".text.startup" comdat($.omp_offloading.descriptor_reg.nvptx64-nvidia-cuda) {
entry:
  %.addr = alloca i8*, align 8
  store i8* %0, i8** %.addr, align 8, !tbaa !46
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
!27 = !DILocation(line: 16, column: 9, scope: !22)
!28 = !DILocation(line: 16, column: 13, scope: !22)
!29 = !{!30, !30, i64 0}
!30 = !{!"int", !31, i64 0}
!31 = !{!"omnipotent char", !32, i64 0}
!32 = !{!"Simple C/C++ TBAA"}
!33 = !DILocation(line: 16, column: 18, scope: !26)
!34 = !DILocation(line: 16, column: 19, scope: !26)
!35 = !DILocation(line: 16, column: 5, scope: !22)
!36 = !DILocation(line: 16, column: 5, scope: !26)
!37 = !DILocation(line: 17, column: 13, scope: !24)
!38 = !DILocation(line: 17, column: 17, scope: !24)
!39 = !DILocation(line: 17, column: 22, scope: !40)
!40 = distinct !DILexicalBlock(scope: !24, file: !3, line: 17, column: 9)
!41 = !DILocation(line: 17, column: 23, scope: !40)
!42 = !DILocation(line: 17, column: 9, scope: !24)
!43 = !DILocation(line: 17, column: 9, scope: !40)
!44 = !DILocation(line: 18, column: 13, scope: !45)
!45 = distinct !DILexicalBlock(scope: !40, file: !3, line: 17, column: 31)
!46 = !{!47, !47, i64 0}
!47 = !{!"any pointer", !31, i64 0}
!48 = !DILocation(line: 18, column: 15, scope: !45)
!49 = !DILocation(line: 18, column: 17, scope: !45)
!50 = !DILocation(line: 18, column: 18, scope: !45)
!51 = !DILocation(line: 18, column: 16, scope: !45)
!52 = !DILocation(line: 18, column: 21, scope: !45)
!53 = !DILocation(line: 19, column: 9, scope: !45)
!54 = !DILocation(line: 17, column: 28, scope: !40)
!55 = distinct !{!55, !42, !56}
!56 = !DILocation(line: 19, column: 9, scope: !24)
!57 = !DILocation(line: 20, column: 9, scope: !25)
!58 = !DILocation(line: 20, column: 11, scope: !25)
!59 = !DILocation(line: 20, column: 13, scope: !25)
!60 = !DILocation(line: 21, column: 9, scope: !25)
!61 = !DILocation(line: 21, column: 11, scope: !25)
!62 = !DILocation(line: 21, column: 13, scope: !25)
!63 = !DILocation(line: 22, column: 5, scope: !25)
!64 = !DILocation(line: 16, column: 24, scope: !26)
!65 = distinct !{!65, !35, !66}
!66 = !DILocation(line: 22, column: 5, scope: !22)
!67 = !DILocation(line: 23, column: 9, scope: !17)
!68 = distinct !DISubprogram(name: "Mult", scope: !3, file: !3, line: 27, type: !18, scopeLine: 27, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !4)
!69 = !DILocation(line: 29, column: 13, scope: !68)
!70 = !DILocation(line: 29, column: 50, scope: !71)
!71 = distinct !DILexicalBlock(scope: !68, file: !3, line: 29, column: 13)
!72 = !DILocation(line: 29, column: 68, scope: !71)
!73 = !DILocation(line: 29, column: 31, scope: !71)
!74 = !DILocation(line: 29, column: 13, scope: !71)
!75 = !DILocation(line: 39, column: 5, scope: !68)
!76 = distinct !DISubprogram(name: "__omp_offloading_801_15a4794_Mult_l29_debug__", scope: !3, file: !3, line: 30, type: !77, scopeLine: 30, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !79)
!77 = !DISubroutineType(types: !78)
!78 = !{null, !8, !8, !8}
!79 = !{!80, !81, !82}
!80 = !DILocalVariable(name: "c", arg: 1, scope: !76, file: !3, line: 12, type: !8)
!81 = !DILocalVariable(name: "b", arg: 2, scope: !76, file: !3, line: 11, type: !8)
!82 = !DILocalVariable(name: "a", arg: 3, scope: !76, file: !3, line: 10, type: !8)
!83 = !DILocation(line: 12, column: 6, scope: !76)
!84 = !DILocation(line: 11, column: 6, scope: !76)
!85 = !DILocation(line: 10, column: 6, scope: !76)
!86 = !DILocation(line: 31, column: 17, scope: !87)
!87 = distinct !DILexicalBlock(scope: !76, file: !3, line: 30, column: 5)
!88 = !{!89, !47, i64 16}
!89 = !{!"ident_t", !30, i64 0, !30, i64 4, !30, i64 8, !30, i64 12, !47, i64 16}
!90 = !DILocation(line: 37, column: 5, scope: !76)
!91 = distinct !DISubprogram(name: ".omp_outlined._debug__", scope: !3, file: !3, line: 32, type: !92, scopeLine: 32, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !99)
!92 = !DISubroutineType(types: !93)
!93 = !{null, !94, !94, !98, !98, !98}
!94 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !95)
!95 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !96)
!96 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !97, size: 64)
!97 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !9)
!98 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !8, size: 64)
!99 = !{!100, !101, !102, !103, !104, !105, !106, !107, !108, !109, !110}
!100 = !DILocalVariable(name: ".global_tid.", arg: 1, scope: !91, type: !94, flags: DIFlagArtificial)
!101 = !DILocalVariable(name: ".bound_tid.", arg: 2, scope: !91, type: !94, flags: DIFlagArtificial)
!102 = !DILocalVariable(name: "c", arg: 3, scope: !91, file: !3, line: 12, type: !98)
!103 = !DILocalVariable(name: "b", arg: 4, scope: !91, file: !3, line: 11, type: !98)
!104 = !DILocalVariable(name: "a", arg: 5, scope: !91, file: !3, line: 10, type: !98)
!105 = !DILocalVariable(name: ".omp.iv", scope: !91, type: !9, flags: DIFlagArtificial)
!106 = !DILocalVariable(name: ".omp.comb.lb", scope: !91, type: !9, flags: DIFlagArtificial)
!107 = !DILocalVariable(name: ".omp.comb.ub", scope: !91, type: !9, flags: DIFlagArtificial)
!108 = !DILocalVariable(name: ".omp.stride", scope: !91, type: !9, flags: DIFlagArtificial)
!109 = !DILocalVariable(name: ".omp.is_last", scope: !91, type: !9, flags: DIFlagArtificial)
!110 = !DILocalVariable(name: "i", scope: !91, type: !9, flags: DIFlagArtificial)
!111 = !DILocation(line: 0, scope: !91)
!112 = !DILocation(line: 12, column: 6, scope: !91)
!113 = !DILocation(line: 11, column: 6, scope: !91)
!114 = !DILocation(line: 10, column: 6, scope: !91)
!115 = !DILocation(line: 32, column: 9, scope: !91)
!116 = !DILocation(line: 32, column: 13, scope: !91)
!117 = !DILocation(line: 31, column: 17, scope: !91)
!118 = !DILocation(line: 31, column: 50, scope: !119)
!119 = distinct !DILexicalBlock(scope: !91, file: !3, line: 31, column: 17)
!120 = distinct !{!120, !117, !121}
!121 = !DILocation(line: 31, column: 50, scope: !91)
!122 = !DILocation(line: 36, column: 9, scope: !91)
!123 = distinct !DISubprogram(name: ".omp_outlined._debug__.1", scope: !3, file: !3, line: 32, type: !124, scopeLine: 32, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !128)
!124 = !DISubroutineType(types: !125)
!125 = !{null, !94, !94, !126, !126, !98, !98, !98}
!126 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !127)
!127 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!128 = !{!129, !130, !131, !132, !133, !134, !135, !136, !137, !138, !139, !140, !141, !142}
!129 = !DILocalVariable(name: ".global_tid.", arg: 1, scope: !123, type: !94, flags: DIFlagArtificial)
!130 = !DILocalVariable(name: ".bound_tid.", arg: 2, scope: !123, type: !94, flags: DIFlagArtificial)
!131 = !DILocalVariable(name: ".previous.lb.", arg: 3, scope: !123, type: !126, flags: DIFlagArtificial)
!132 = !DILocalVariable(name: ".previous.ub.", arg: 4, scope: !123, type: !126, flags: DIFlagArtificial)
!133 = !DILocalVariable(name: "c", arg: 5, scope: !123, file: !3, line: 12, type: !98)
!134 = !DILocalVariable(name: "b", arg: 6, scope: !123, file: !3, line: 11, type: !98)
!135 = !DILocalVariable(name: "a", arg: 7, scope: !123, file: !3, line: 10, type: !98)
!136 = !DILocalVariable(name: ".omp.iv", scope: !123, type: !9, flags: DIFlagArtificial)
!137 = !DILocalVariable(name: ".omp.lb", scope: !123, type: !9, flags: DIFlagArtificial)
!138 = !DILocalVariable(name: ".omp.ub", scope: !123, type: !9, flags: DIFlagArtificial)
!139 = !DILocalVariable(name: ".omp.stride", scope: !123, type: !9, flags: DIFlagArtificial)
!140 = !DILocalVariable(name: ".omp.is_last", scope: !123, type: !9, flags: DIFlagArtificial)
!141 = !DILocalVariable(name: "i", scope: !123, type: !9, flags: DIFlagArtificial)
!142 = !DILocalVariable(name: "j", scope: !143, file: !3, line: 33, type: !9)
!143 = distinct !DILexicalBlock(scope: !144, file: !3, line: 33, column: 13)
!144 = distinct !DILexicalBlock(scope: !123, file: !3, line: 32, column: 31)
!145 = !DILocation(line: 0, scope: !123)
!146 = !{!147, !147, i64 0}
!147 = !{!"long", !31, i64 0}
!148 = !DILocation(line: 12, column: 6, scope: !123)
!149 = !DILocation(line: 11, column: 6, scope: !123)
!150 = !DILocation(line: 10, column: 6, scope: !123)
!151 = !DILocation(line: 32, column: 9, scope: !123)
!152 = !DILocation(line: 32, column: 13, scope: !123)
!153 = !DILocation(line: 32, column: 27, scope: !123)
!154 = !DILocation(line: 33, column: 17, scope: !143)
!155 = !DILocation(line: 33, column: 21, scope: !143)
!156 = !DILocation(line: 33, column: 26, scope: !157)
!157 = distinct !DILexicalBlock(scope: !143, file: !3, line: 33, column: 13)
!158 = !DILocation(line: 33, column: 27, scope: !157)
!159 = !DILocation(line: 33, column: 13, scope: !143)
!160 = !DILocation(line: 33, column: 13, scope: !157)
!161 = !DILocation(line: 34, column: 23, scope: !162)
!162 = distinct !DILexicalBlock(scope: !157, file: !3, line: 33, column: 35)
!163 = !DILocation(line: 34, column: 25, scope: !162)
!164 = !DILocation(line: 34, column: 27, scope: !162)
!165 = !DILocation(line: 34, column: 28, scope: !162)
!166 = !DILocation(line: 34, column: 26, scope: !162)
!167 = !DILocation(line: 34, column: 32, scope: !162)
!168 = !DILocation(line: 34, column: 34, scope: !162)
!169 = !DILocation(line: 34, column: 31, scope: !162)
!170 = !DILocation(line: 34, column: 17, scope: !162)
!171 = !DILocation(line: 34, column: 19, scope: !162)
!172 = !DILocation(line: 34, column: 21, scope: !162)
!173 = !DILocation(line: 35, column: 13, scope: !162)
!174 = !DILocation(line: 33, column: 32, scope: !157)
!175 = distinct !{!175, !159, !176}
!176 = !DILocation(line: 35, column: 13, scope: !143)
!177 = !DILocation(line: 36, column: 9, scope: !144)
!178 = !DILocation(line: 31, column: 17, scope: !123)
!179 = distinct !{!179, !178, !180}
!180 = !DILocation(line: 31, column: 50, scope: !123)
!181 = !DILocation(line: 36, column: 9, scope: !123)
!182 = distinct !DISubprogram(name: ".omp_outlined.", scope: !3, file: !3, line: 32, type: !124, scopeLine: 32, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !183)
!183 = !{!184, !185, !186, !187, !188, !189, !190}
!184 = !DILocalVariable(name: ".global_tid.", arg: 1, scope: !182, type: !94, flags: DIFlagArtificial)
!185 = !DILocalVariable(name: ".bound_tid.", arg: 2, scope: !182, type: !94, flags: DIFlagArtificial)
!186 = !DILocalVariable(name: ".previous.lb.", arg: 3, scope: !182, type: !126, flags: DIFlagArtificial)
!187 = !DILocalVariable(name: ".previous.ub.", arg: 4, scope: !182, type: !126, flags: DIFlagArtificial)
!188 = !DILocalVariable(name: "c", arg: 5, scope: !182, type: !98, flags: DIFlagArtificial)
!189 = !DILocalVariable(name: "b", arg: 6, scope: !182, type: !98, flags: DIFlagArtificial)
!190 = !DILocalVariable(name: "a", arg: 7, scope: !182, type: !98, flags: DIFlagArtificial)
!191 = !DILocation(line: 0, scope: !182)
!192 = !DILocation(line: 32, column: 9, scope: !182)
!193 = !{!194}
!194 = !{i64 2, i64 -1, i64 -1, i1 true}
!195 = distinct !DISubprogram(name: ".omp_outlined..2", scope: !3, file: !3, line: 32, type: !92, scopeLine: 32, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !196)
!196 = !{!197, !198, !199, !200, !201}
!197 = !DILocalVariable(name: ".global_tid.", arg: 1, scope: !195, type: !94, flags: DIFlagArtificial)
!198 = !DILocalVariable(name: ".bound_tid.", arg: 2, scope: !195, type: !94, flags: DIFlagArtificial)
!199 = !DILocalVariable(name: "c", arg: 3, scope: !195, type: !98, flags: DIFlagArtificial)
!200 = !DILocalVariable(name: "b", arg: 4, scope: !195, type: !98, flags: DIFlagArtificial)
!201 = !DILocalVariable(name: "a", arg: 5, scope: !195, type: !98, flags: DIFlagArtificial)
!202 = !DILocation(line: 0, scope: !195)
!203 = !DILocation(line: 32, column: 9, scope: !195)
!204 = distinct !DISubprogram(name: "__omp_offloading_801_15a4794_Mult_l29", scope: !3, file: !3, line: 30, type: !77, scopeLine: 30, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !205)
!205 = !{!206, !207, !208}
!206 = !DILocalVariable(name: "c", arg: 1, scope: !204, type: !8, flags: DIFlagArtificial)
!207 = !DILocalVariable(name: "b", arg: 2, scope: !204, type: !8, flags: DIFlagArtificial)
!208 = !DILocalVariable(name: "a", arg: 3, scope: !204, type: !8, flags: DIFlagArtificial)
!209 = !DILocation(line: 0, scope: !204)
!210 = !DILocation(line: 30, column: 5, scope: !204)
!211 = distinct !DISubprogram(name: "check", scope: !3, file: !3, line: 42, type: !18, scopeLine: 42, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !212)
!212 = !{!213, !215}
!213 = !DILocalVariable(name: "test", scope: !211, file: !3, line: 43, type: !214)
!214 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!215 = !DILocalVariable(name: "i", scope: !216, file: !3, line: 44, type: !9)
!216 = distinct !DILexicalBlock(scope: !211, file: !3, line: 44, column: 5)
!217 = !DILocation(line: 43, column: 5, scope: !211)
!218 = !DILocation(line: 43, column: 10, scope: !211)
!219 = !{!220, !220, i64 0}
!220 = !{!"_Bool", !31, i64 0}
!221 = !DILocation(line: 44, column: 9, scope: !216)
!222 = !DILocation(line: 44, column: 13, scope: !216)
!223 = !DILocation(line: 44, column: 18, scope: !224)
!224 = distinct !DILexicalBlock(scope: !216, file: !3, line: 44, column: 5)
!225 = !DILocation(line: 44, column: 19, scope: !224)
!226 = !DILocation(line: 44, column: 5, scope: !216)
!227 = !DILocation(line: 44, column: 5, scope: !224)
!228 = !DILocation(line: 45, column: 12, scope: !229)
!229 = distinct !DILexicalBlock(scope: !230, file: !3, line: 45, column: 12)
!230 = distinct !DILexicalBlock(scope: !224, file: !3, line: 44, column: 27)
!231 = !DILocation(line: 45, column: 14, scope: !229)
!232 = !DILocation(line: 45, column: 16, scope: !229)
!233 = !DILocation(line: 45, column: 12, scope: !230)
!234 = !DILocation(line: 46, column: 18, scope: !235)
!235 = distinct !DILexicalBlock(scope: !229, file: !3, line: 45, column: 20)
!236 = !DILocation(line: 47, column: 9, scope: !235)
!237 = !DILocation(line: 48, column: 5, scope: !230)
!238 = !DILocation(line: 44, column: 24, scope: !224)
!239 = distinct !{!239, !226, !240}
!240 = !DILocation(line: 48, column: 5, scope: !216)
!241 = !DILocation(line: 49, column: 38, scope: !211)
!242 = !{i8 0, i8 2}
!243 = !DILocation(line: 49, column: 5, scope: !211)
!244 = !DILocation(line: 53, column: 1, scope: !211)
!245 = !DILocation(line: 50, column: 5, scope: !211)
!246 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 56, type: !18, scopeLine: 56, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !4)
!247 = !DILocation(line: 57, column: 9, scope: !246)
!248 = !DILocation(line: 57, column: 7, scope: !246)
!249 = !DILocation(line: 58, column: 9, scope: !246)
!250 = !DILocation(line: 58, column: 7, scope: !246)
!251 = !DILocation(line: 59, column: 9, scope: !246)
!252 = !DILocation(line: 59, column: 7, scope: !246)
!253 = !DILocation(line: 60, column: 5, scope: !246)
!254 = !DILocation(line: 61, column: 5, scope: !246)
!255 = !DILocation(line: 62, column: 5, scope: !246)
!256 = !DILocation(line: 63, column: 10, scope: !246)
!257 = !DILocation(line: 63, column: 5, scope: !246)
!258 = !DILocation(line: 64, column: 10, scope: !246)
!259 = !DILocation(line: 64, column: 5, scope: !246)
!260 = !DILocation(line: 65, column: 10, scope: !246)
!261 = !DILocation(line: 65, column: 5, scope: !246)
!262 = !DILocation(line: 66, column: 5, scope: !246)
