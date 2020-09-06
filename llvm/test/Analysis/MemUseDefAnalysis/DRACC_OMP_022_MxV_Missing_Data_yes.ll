; ModuleID = 'omp-host.ll'
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
@0 = private unnamed_addr constant %struct.ident_t { i32 0, i32 2050, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@1 = private unnamed_addr constant [51 x i8] c";DRACC_OMP_022_MxV_Missing_Data_yes.c;Mult;31;17;;\00"
@2 = private unnamed_addr constant %struct.ident_t { i32 0, i32 514, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@3 = private unnamed_addr constant [51 x i8] c";DRACC_OMP_022_MxV_Missing_Data_yes.c;Mult;31;50;;\00"
@4 = private unnamed_addr constant %struct.ident_t { i32 0, i32 2, i32 0, i32 0, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i32 0, i32 0) }, align 8
@.__omp_offloading_801_20a8bc_Mult_l29.region_id = weak constant i8 0
@.offload_sizes = private unnamed_addr constant [3 x i64] [i64 20000, i64 100000000, i64 20000]
@.offload_maptypes = private unnamed_addr constant [3 x i64] [i64 35, i64 32, i64 33]
@.str.3 = private unnamed_addr constant [23 x i8] c"Data Race occured: %s\0A\00", align 1
@.str.4 = private unnamed_addr constant [5 x i8] c"true\00", align 1
@.str.5 = private unnamed_addr constant [6 x i8] c"false\00", align 1
@.omp_offloading.entry_name = internal unnamed_addr constant [37 x i8] c"__omp_offloading_801_20a8bc_Mult_l29\00"
@.omp_offloading.entry.__omp_offloading_801_20a8bc_Mult_l29 = weak constant %struct.__tgt_offload_entry { i8* @.__omp_offloading_801_20a8bc_Mult_l29.region_id, i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.omp_offloading.entry_name, i32 0, i32 0), i64 0, i32 0, i32 0 }, section ".omp_offloading.entries", align 1
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
  %i.0 = phi i32 [ 0, %entry ], [ %inc10, %for.inc9 ], !dbg !29
  call void @llvm.dbg.value(metadata i32 %i.0, metadata !21, metadata !DIExpression()), !dbg !27
  %cmp = icmp slt i32 %i.0, 5000, !dbg !30
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !dbg !31

for.cond.cleanup:                                 ; preds = %for.cond
  br label %for.end11

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.value(metadata i32 0, metadata !23, metadata !DIExpression()), !dbg !32
  br label %for.cond1, !dbg !33

for.cond1:                                        ; preds = %for.inc, %for.body
  %j.0 = phi i32 [ 0, %for.body ], [ %inc, %for.inc ], !dbg !34
  call void @llvm.dbg.value(metadata i32 %j.0, metadata !23, metadata !DIExpression()), !dbg !32
  %cmp2 = icmp slt i32 %j.0, 5000, !dbg !35
  br i1 %cmp2, label %for.body4, label %for.cond.cleanup3, !dbg !37

for.cond.cleanup3:                                ; preds = %for.cond1
  br label %for.end

for.body4:                                        ; preds = %for.cond1
  %0 = load i32*, i32** @b, align 8, !dbg !38, !tbaa !40
  %mul = mul nsw i32 %i.0, 5000, !dbg !44
  %add = add nsw i32 %j.0, %mul, !dbg !45
  %idxprom = sext i32 %add to i64, !dbg !38
  %arrayidx = getelementptr inbounds i32, i32* %0, i64 %idxprom, !dbg !38
  store i32 1, i32* %arrayidx, align 4, !dbg !46, !tbaa !47
  br label %for.inc, !dbg !49

for.inc:                                          ; preds = %for.body4
  %inc = add nsw i32 %j.0, 1, !dbg !50
  call void @llvm.dbg.value(metadata i32 %inc, metadata !23, metadata !DIExpression()), !dbg !32
  br label %for.cond1, !dbg !51, !llvm.loop !52

for.end:                                          ; preds = %for.cond.cleanup3
  %1 = load i32*, i32** @a, align 8, !dbg !54, !tbaa !40
  %idxprom5 = sext i32 %i.0 to i64, !dbg !54
  %arrayidx6 = getelementptr inbounds i32, i32* %1, i64 %idxprom5, !dbg !54
  store i32 1, i32* %arrayidx6, align 4, !dbg !55, !tbaa !47
  %2 = load i32*, i32** @c, align 8, !dbg !56, !tbaa !40
  %idxprom7 = sext i32 %i.0 to i64, !dbg !56
  %arrayidx8 = getelementptr inbounds i32, i32* %2, i64 %idxprom7, !dbg !56
  store i32 0, i32* %arrayidx8, align 4, !dbg !57, !tbaa !47
  br label %for.inc9, !dbg !58

for.inc9:                                         ; preds = %for.end
  %inc10 = add nsw i32 %i.0, 1, !dbg !59
  call void @llvm.dbg.value(metadata i32 %inc10, metadata !21, metadata !DIExpression()), !dbg !27
  br label %for.cond, !dbg !60, !llvm.loop !61

for.end11:                                        ; preds = %for.cond.cleanup
  ret i32 0, !dbg !63
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #1

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define dso_local i32 @Mult() #0 !dbg !64 {
entry:
  %.offload_baseptrs = alloca [3 x i8*], align 8
  %.offload_ptrs = alloca [3 x i8*], align 8
  %0 = load i32*, i32** @c, align 8, !dbg !65, !tbaa !40
  %1 = load i32*, i32** @b, align 8, !dbg !65, !tbaa !40
  %2 = load i32*, i32** @a, align 8, !dbg !65, !tbaa !40
  %3 = load i32*, i32** @c, align 8, !dbg !65
  %4 = load i32*, i32** @c, align 8, !dbg !66, !tbaa !40
  %arrayidx = getelementptr inbounds i32, i32* %4, i64 0, !dbg !66
  %5 = load i32*, i32** @b, align 8, !dbg !65
  %6 = load i32*, i32** @b, align 8, !dbg !68, !tbaa !40
  %arrayidx1 = getelementptr inbounds i32, i32* %6, i64 0, !dbg !68
  %7 = load i32*, i32** @a, align 8, !dbg !65
  %8 = load i32*, i32** @a, align 8, !dbg !69, !tbaa !40
  %arrayidx2 = getelementptr inbounds i32, i32* %8, i64 0, !dbg !69
  %9 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_baseptrs, i32 0, i32 0, !dbg !65
  %10 = bitcast i8** %9 to i32**, !dbg !65
  store i32* %3, i32** %10, align 8, !dbg !65
  %11 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_ptrs, i32 0, i32 0, !dbg !65
  %12 = bitcast i8** %11 to i32**, !dbg !65
  store i32* %arrayidx, i32** %12, align 8, !dbg !65
  %13 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_baseptrs, i32 0, i32 1, !dbg !65
  %14 = bitcast i8** %13 to i32**, !dbg !65
  store i32* %5, i32** %14, align 8, !dbg !65
  %15 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_ptrs, i32 0, i32 1, !dbg !65
  %16 = bitcast i8** %15 to i32**, !dbg !65
  store i32* %arrayidx1, i32** %16, align 8, !dbg !65
  %17 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_baseptrs, i32 0, i32 2, !dbg !65
  %18 = bitcast i8** %17 to i32**, !dbg !65
  store i32* %7, i32** %18, align 8, !dbg !65
  %19 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_ptrs, i32 0, i32 2, !dbg !65
  %20 = bitcast i8** %19 to i32**, !dbg !65
  store i32* %arrayidx2, i32** %20, align 8, !dbg !65
  %21 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_baseptrs, i32 0, i32 0, !dbg !65
  %22 = getelementptr inbounds [3 x i8*], [3 x i8*]* %.offload_ptrs, i32 0, i32 0, !dbg !65
  %23 = call i32 @__tgt_target_teams(i64 0, i8* @.__omp_offloading_801_20a8bc_Mult_l29.region_id, i32 3, i8** %21, i8** %22, i64* getelementptr inbounds ([3 x i64], [3 x i64]* @.offload_sizes, i32 0, i32 0), i64* getelementptr inbounds ([3 x i64], [3 x i64]* @.offload_maptypes, i32 0, i32 0), i32 0, i32 0), !dbg !65
  %24 = icmp ne i32 %23, 0, !dbg !65
  br i1 %24, label %omp_offload.failed, label %omp_offload.cont, !dbg !65

omp_offload.failed:                               ; preds = %entry
  call void @__omp_offloading_801_20a8bc_Mult_l29(i32* %0, i32* %1, i32* %2) #6, !dbg !70
  br label %omp_offload.cont, !dbg !65

omp_offload.cont:                                 ; preds = %omp_offload.failed, %entry
  ret i32 0, !dbg !71
}

; Function Attrs: norecurse nounwind uwtable
define internal void @__omp_offloading_801_20a8bc_Mult_l29_debug__(i32* %c, i32* %b, i32* %a) #3 !dbg !72 {
entry:
  %c.addr = alloca i32*, align 8
  %b.addr = alloca i32*, align 8
  %a.addr = alloca i32*, align 8
  %.kmpc_loc.addr = alloca %struct.ident_t, align 8
  %0 = bitcast %struct.ident_t* %.kmpc_loc.addr to i8*
  %1 = bitcast %struct.ident_t* @4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %0, i8* align 8 %1, i64 24, i1 false)
  store i32* %c, i32** %c.addr, align 8, !tbaa !40
  call void @llvm.dbg.declare(metadata i32** %c.addr, metadata !76, metadata !DIExpression()), !dbg !79
  store i32* %b, i32** %b.addr, align 8, !tbaa !40
  call void @llvm.dbg.declare(metadata i32** %b.addr, metadata !77, metadata !DIExpression()), !dbg !80
  store i32* %a, i32** %a.addr, align 8, !tbaa !40
  call void @llvm.dbg.declare(metadata i32** %a.addr, metadata !78, metadata !DIExpression()), !dbg !81
  %2 = getelementptr inbounds %struct.ident_t, %struct.ident_t* %.kmpc_loc.addr, i32 0, i32 4, !dbg !82
  store i8* getelementptr inbounds ([51 x i8], [51 x i8]* @1, i32 0, i32 0), i8** %2, align 8, !dbg !82, !tbaa !84
  call void (%struct.ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_teams(%struct.ident_t* %.kmpc_loc.addr, i32 3, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, i32**, i32**, i32**)* @.omp_outlined..2 to void (i32*, i32*, ...)*), i32** %c.addr, i32** %b.addr, i32** %a.addr), !dbg !82
  ret void, !dbg !86
}

; Function Attrs: norecurse nounwind uwtable
define internal void @.omp_outlined._debug__(i32* noalias %.global_tid., i32* noalias %.bound_tid., i32** dereferenceable(8) %c, i32** dereferenceable(8) %b, i32** dereferenceable(8) %a) #3 !dbg !87 {
entry:
  %.omp.comb.lb = alloca i32, align 4
  %.omp.comb.ub = alloca i32, align 4
  %.omp.stride = alloca i32, align 4
  %.omp.is_last = alloca i32, align 4
  %.kmpc_loc.addr = alloca %struct.ident_t, align 8
  %0 = bitcast %struct.ident_t* %.kmpc_loc.addr to i8*
  %1 = bitcast %struct.ident_t* @0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %0, i8* align 8 %1, i64 24, i1 false)
  call void @llvm.dbg.value(metadata i32* %.global_tid., metadata !96, metadata !DIExpression()), !dbg !107
  call void @llvm.dbg.value(metadata i32* %.bound_tid., metadata !97, metadata !DIExpression()), !dbg !107
  call void @llvm.dbg.value(metadata i32** %c, metadata !98, metadata !DIExpression()), !dbg !108
  call void @llvm.dbg.value(metadata i32** %b, metadata !99, metadata !DIExpression()), !dbg !109
  call void @llvm.dbg.value(metadata i32** %a, metadata !100, metadata !DIExpression()), !dbg !110
  %2 = bitcast i32* %.omp.comb.lb to i8*, !dbg !111
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %2) #6, !dbg !111
  call void @llvm.dbg.declare(metadata i32* %.omp.comb.lb, metadata !102, metadata !DIExpression()), !dbg !107
  store i32 0, i32* %.omp.comb.lb, align 4, !dbg !112, !tbaa !47
  %3 = bitcast i32* %.omp.comb.ub to i8*, !dbg !111
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %3) #6, !dbg !111
  call void @llvm.dbg.declare(metadata i32* %.omp.comb.ub, metadata !103, metadata !DIExpression()), !dbg !107
  store i32 4999, i32* %.omp.comb.ub, align 4, !dbg !112, !tbaa !47
  %4 = bitcast i32* %.omp.stride to i8*, !dbg !111
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %4) #6, !dbg !111
  call void @llvm.dbg.declare(metadata i32* %.omp.stride, metadata !104, metadata !DIExpression()), !dbg !107
  store i32 1, i32* %.omp.stride, align 4, !dbg !112, !tbaa !47
  %5 = bitcast i32* %.omp.is_last to i8*, !dbg !111
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %5) #6, !dbg !111
  call void @llvm.dbg.declare(metadata i32* %.omp.is_last, metadata !105, metadata !DIExpression()), !dbg !107
  store i32 0, i32* %.omp.is_last, align 4, !dbg !112, !tbaa !47
  call void @llvm.dbg.declare(metadata !4, metadata !106, metadata !DIExpression()), !dbg !107
  %6 = getelementptr inbounds %struct.ident_t, %struct.ident_t* %.kmpc_loc.addr, i32 0, i32 4, !dbg !111
  store i8* getelementptr inbounds ([51 x i8], [51 x i8]* @1, i32 0, i32 0), i8** %6, align 8, !dbg !111, !tbaa !84
  %7 = load i32, i32* %.global_tid., align 4, !dbg !111, !tbaa !47
  call void @__kmpc_for_static_init_4(%struct.ident_t* %.kmpc_loc.addr, i32 %7, i32 92, i32* %.omp.is_last, i32* %.omp.comb.lb, i32* %.omp.comb.ub, i32* %.omp.stride, i32 1, i32 1), !dbg !111
  %8 = load i32, i32* %.omp.comb.ub, align 4, !dbg !112, !tbaa !47
  %cmp = icmp sgt i32 %8, 4999, !dbg !112
  br i1 %cmp, label %cond.true, label %cond.false, !dbg !112

cond.true:                                        ; preds = %entry
  br label %cond.end, !dbg !112

cond.false:                                       ; preds = %entry
  %9 = load i32, i32* %.omp.comb.ub, align 4, !dbg !112, !tbaa !47
  br label %cond.end, !dbg !112

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ 4999, %cond.true ], [ %9, %cond.false ], !dbg !112
  store i32 %cond, i32* %.omp.comb.ub, align 4, !dbg !112, !tbaa !47
  %10 = load i32, i32* %.omp.comb.lb, align 4, !dbg !112, !tbaa !47
  call void @llvm.dbg.value(metadata i32 %10, metadata !101, metadata !DIExpression()), !dbg !107
  br label %omp.inner.for.cond, !dbg !111

omp.inner.for.cond:                               ; preds = %omp.inner.for.inc, %cond.end
  %.omp.iv.0 = phi i32 [ %10, %cond.end ], [ %add, %omp.inner.for.inc ], !dbg !107
  call void @llvm.dbg.value(metadata i32 %.omp.iv.0, metadata !101, metadata !DIExpression()), !dbg !107
  %11 = load i32, i32* %.omp.comb.ub, align 4, !dbg !112, !tbaa !47
  %cmp1 = icmp sle i32 %.omp.iv.0, %11, !dbg !111
  br i1 %cmp1, label %omp.inner.for.body, label %omp.inner.for.cond.cleanup, !dbg !111

omp.inner.for.cond.cleanup:                       ; preds = %omp.inner.for.cond
  br label %omp.inner.for.end, !dbg !111

omp.inner.for.body:                               ; preds = %omp.inner.for.cond
  %12 = load i32, i32* %.omp.comb.lb, align 4, !dbg !113
  %13 = zext i32 %12 to i64, !dbg !113
  %14 = load i32, i32* %.omp.comb.ub, align 4, !dbg !113
  %15 = zext i32 %14 to i64, !dbg !113
  %16 = getelementptr inbounds %struct.ident_t, %struct.ident_t* %.kmpc_loc.addr, i32 0, i32 4, !dbg !113
  store i8* getelementptr inbounds ([51 x i8], [51 x i8]* @1, i32 0, i32 0), i8** %16, align 8, !dbg !113, !tbaa !84
  call void (%struct.ident_t*, i32, void (i32*, i32*, ...)*, ...) @__kmpc_fork_call(%struct.ident_t* %.kmpc_loc.addr, i32 5, void (i32*, i32*, ...)* bitcast (void (i32*, i32*, i64, i64, i32**, i32**, i32**)* @.omp_outlined. to void (i32*, i32*, ...)*), i64 %13, i64 %15, i32** %c, i32** %b, i32** %a), !dbg !113
  br label %omp.inner.for.inc, !dbg !114

omp.inner.for.inc:                                ; preds = %omp.inner.for.body
  %17 = load i32, i32* %.omp.stride, align 4, !dbg !112, !tbaa !47
  %add = add nsw i32 %.omp.iv.0, %17, !dbg !111
  call void @llvm.dbg.value(metadata i32 %add, metadata !101, metadata !DIExpression()), !dbg !107
  br label %omp.inner.for.cond, !dbg !114, !llvm.loop !116

omp.inner.for.end:                                ; preds = %omp.inner.for.cond.cleanup
  br label %omp.loop.exit, !dbg !114

omp.loop.exit:                                    ; preds = %omp.inner.for.end
  %18 = getelementptr inbounds %struct.ident_t, %struct.ident_t* %.kmpc_loc.addr, i32 0, i32 4, !dbg !114
  store i8* getelementptr inbounds ([51 x i8], [51 x i8]* @1, i32 0, i32 0), i8** %18, align 8, !dbg !114, !tbaa !84
  call void @__kmpc_for_static_fini(%struct.ident_t* %.kmpc_loc.addr, i32 %7), !dbg !114
  %19 = bitcast i32* %.omp.is_last to i8*, !dbg !114
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %19) #6, !dbg !114
  %20 = bitcast i32* %.omp.stride to i8*, !dbg !114
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %20) #6, !dbg !114
  %21 = bitcast i32* %.omp.comb.ub to i8*, !dbg !114
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %21) #6, !dbg !114
  %22 = bitcast i32* %.omp.comb.lb to i8*, !dbg !114
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %22) #6, !dbg !114
  ret void, !dbg !118
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1) #1

declare dso_local void @__kmpc_for_static_init_4(%struct.ident_t*, i32, i32, i32*, i32*, i32*, i32*, i32, i32)

; Function Attrs: norecurse nounwind uwtable
define internal void @.omp_outlined._debug__.1(i32* noalias %.global_tid., i32* noalias %.bound_tid., i64 %.previous.lb., i64 %.previous.ub., i32** dereferenceable(8) %c, i32** dereferenceable(8) %b, i32** dereferenceable(8) %a) #3 !dbg !119 {
entry:
  %.omp.lb = alloca i32, align 4
  %.omp.ub = alloca i32, align 4
  %.omp.stride = alloca i32, align 4
  %.omp.is_last = alloca i32, align 4
  %.kmpc_loc.addr = alloca %struct.ident_t, align 8
  %0 = bitcast %struct.ident_t* %.kmpc_loc.addr to i8*
  %1 = bitcast %struct.ident_t* @2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %0, i8* align 8 %1, i64 24, i1 false)
  call void @llvm.dbg.value(metadata i32* %.global_tid., metadata !125, metadata !DIExpression()), !dbg !141
  call void @llvm.dbg.value(metadata i32* %.bound_tid., metadata !126, metadata !DIExpression()), !dbg !141
  call void @llvm.dbg.value(metadata i64 %.previous.lb., metadata !127, metadata !DIExpression()), !dbg !141
  call void @llvm.dbg.value(metadata i64 %.previous.ub., metadata !128, metadata !DIExpression()), !dbg !141
  call void @llvm.dbg.value(metadata i32** %c, metadata !129, metadata !DIExpression()), !dbg !142
  call void @llvm.dbg.value(metadata i32** %b, metadata !130, metadata !DIExpression()), !dbg !143
  call void @llvm.dbg.value(metadata i32** %a, metadata !131, metadata !DIExpression()), !dbg !144
  %2 = bitcast i32* %.omp.lb to i8*, !dbg !145
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %2) #6, !dbg !145
  call void @llvm.dbg.declare(metadata i32* %.omp.lb, metadata !133, metadata !DIExpression()), !dbg !141
  store i32 0, i32* %.omp.lb, align 4, !dbg !146, !tbaa !47
  %3 = bitcast i32* %.omp.ub to i8*, !dbg !145
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %3) #6, !dbg !145
  call void @llvm.dbg.declare(metadata i32* %.omp.ub, metadata !134, metadata !DIExpression()), !dbg !141
  store i32 4999, i32* %.omp.ub, align 4, !dbg !146, !tbaa !47
  %conv = trunc i64 %.previous.lb. to i32, !dbg !145
  %conv1 = trunc i64 %.previous.ub. to i32, !dbg !145
  store i32 %conv, i32* %.omp.lb, align 4, !dbg !145, !tbaa !47
  store i32 %conv1, i32* %.omp.ub, align 4, !dbg !145, !tbaa !47
  %4 = bitcast i32* %.omp.stride to i8*, !dbg !145
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %4) #6, !dbg !145
  call void @llvm.dbg.declare(metadata i32* %.omp.stride, metadata !135, metadata !DIExpression()), !dbg !141
  store i32 1, i32* %.omp.stride, align 4, !dbg !146, !tbaa !47
  %5 = bitcast i32* %.omp.is_last to i8*, !dbg !145
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %5) #6, !dbg !145
  call void @llvm.dbg.declare(metadata i32* %.omp.is_last, metadata !136, metadata !DIExpression()), !dbg !141
  store i32 0, i32* %.omp.is_last, align 4, !dbg !146, !tbaa !47
  %6 = getelementptr inbounds %struct.ident_t, %struct.ident_t* %.kmpc_loc.addr, i32 0, i32 4, !dbg !145
  store i8* getelementptr inbounds ([51 x i8], [51 x i8]* @1, i32 0, i32 0), i8** %6, align 8, !dbg !145, !tbaa !84
  %7 = load i32, i32* %.global_tid., align 4, !dbg !145, !tbaa !47
  call void @__kmpc_for_static_init_4(%struct.ident_t* %.kmpc_loc.addr, i32 %7, i32 34, i32* %.omp.is_last, i32* %.omp.lb, i32* %.omp.ub, i32* %.omp.stride, i32 1, i32 1), !dbg !145
  %8 = load i32, i32* %.omp.ub, align 4, !dbg !146, !tbaa !47
  %cmp = icmp sgt i32 %8, 4999, !dbg !146
  br i1 %cmp, label %cond.true, label %cond.false, !dbg !146

cond.true:                                        ; preds = %entry
  br label %cond.end, !dbg !146

cond.false:                                       ; preds = %entry
  %9 = load i32, i32* %.omp.ub, align 4, !dbg !146, !tbaa !47
  br label %cond.end, !dbg !146

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ 4999, %cond.true ], [ %9, %cond.false ], !dbg !146
  store i32 %cond, i32* %.omp.ub, align 4, !dbg !146, !tbaa !47
  %10 = load i32, i32* %.omp.lb, align 4, !dbg !146, !tbaa !47
  call void @llvm.dbg.value(metadata i32 %10, metadata !132, metadata !DIExpression()), !dbg !141
  br label %omp.inner.for.cond, !dbg !145

omp.inner.for.cond:                               ; preds = %omp.inner.for.inc, %cond.end
  %.omp.iv.0 = phi i32 [ %10, %cond.end ], [ %add15, %omp.inner.for.inc ], !dbg !141
  call void @llvm.dbg.value(metadata i32 %.omp.iv.0, metadata !132, metadata !DIExpression()), !dbg !141
  %11 = load i32, i32* %.omp.ub, align 4, !dbg !146, !tbaa !47
  %cmp3 = icmp sle i32 %.omp.iv.0, %11, !dbg !145
  br i1 %cmp3, label %omp.inner.for.body, label %omp.inner.for.cond.cleanup, !dbg !145

omp.inner.for.cond.cleanup:                       ; preds = %omp.inner.for.cond
  br label %omp.inner.for.end, !dbg !145

omp.inner.for.body:                               ; preds = %omp.inner.for.cond
  %mul = mul nsw i32 %.omp.iv.0, 1, !dbg !147
  %add = add nsw i32 0, %mul, !dbg !147
  call void @llvm.dbg.value(metadata i32 %add, metadata !137, metadata !DIExpression()), !dbg !141
  call void @llvm.dbg.value(metadata i32 0, metadata !138, metadata !DIExpression()), !dbg !148
  br label %for.cond, !dbg !149

for.cond:                                         ; preds = %for.inc, %omp.inner.for.body
  %j.0 = phi i32 [ 0, %omp.inner.for.body ], [ %inc, %for.inc ], !dbg !150
  call void @llvm.dbg.value(metadata i32 %j.0, metadata !138, metadata !DIExpression()), !dbg !148
  %cmp5 = icmp slt i32 %j.0, 5000, !dbg !151
  br i1 %cmp5, label %for.body, label %for.cond.cleanup, !dbg !153

for.cond.cleanup:                                 ; preds = %for.cond
  br label %for.end

for.body:                                         ; preds = %for.cond
  %12 = load i32*, i32** %b, align 8, !dbg !154, !tbaa !40
  %mul7 = mul nsw i32 %add, 5000, !dbg !156
  %add8 = add nsw i32 %j.0, %mul7, !dbg !157
  %idxprom = sext i32 %add8 to i64, !dbg !154
  %arrayidx = getelementptr inbounds i32, i32* %12, i64 %idxprom, !dbg !154
  %13 = load i32, i32* %arrayidx, align 4, !dbg !154, !tbaa !47
  %14 = load i32*, i32** %a, align 8, !dbg !158, !tbaa !40
  %idxprom9 = sext i32 %j.0 to i64, !dbg !158
  %arrayidx10 = getelementptr inbounds i32, i32* %14, i64 %idxprom9, !dbg !158
  %15 = load i32, i32* %arrayidx10, align 4, !dbg !158, !tbaa !47
  %mul11 = mul nsw i32 %13, %15, !dbg !159
  %16 = load i32*, i32** %c, align 8, !dbg !160, !tbaa !40
  %idxprom12 = sext i32 %add to i64, !dbg !160
  %arrayidx13 = getelementptr inbounds i32, i32* %16, i64 %idxprom12, !dbg !160
  %17 = load i32, i32* %arrayidx13, align 4, !dbg !161, !tbaa !47
  %add14 = add nsw i32 %17, %mul11, !dbg !161
  store i32 %add14, i32* %arrayidx13, align 4, !dbg !161, !tbaa !47
  br label %for.inc, !dbg !162

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %j.0, 1, !dbg !163
  call void @llvm.dbg.value(metadata i32 %inc, metadata !138, metadata !DIExpression()), !dbg !148
  br label %for.cond, !dbg !164, !llvm.loop !165

for.end:                                          ; preds = %for.cond.cleanup
  br label %omp.body.continue, !dbg !167

omp.body.continue:                                ; preds = %for.end
  br label %omp.inner.for.inc, !dbg !168

omp.inner.for.inc:                                ; preds = %omp.body.continue
  %add15 = add nsw i32 %.omp.iv.0, 1, !dbg !145
  call void @llvm.dbg.value(metadata i32 %add15, metadata !132, metadata !DIExpression()), !dbg !141
  br label %omp.inner.for.cond, !dbg !168, !llvm.loop !169

omp.inner.for.end:                                ; preds = %omp.inner.for.cond.cleanup
  br label %omp.loop.exit, !dbg !168

omp.loop.exit:                                    ; preds = %omp.inner.for.end
  %18 = getelementptr inbounds %struct.ident_t, %struct.ident_t* %.kmpc_loc.addr, i32 0, i32 4, !dbg !168
  store i8* getelementptr inbounds ([51 x i8], [51 x i8]* @3, i32 0, i32 0), i8** %18, align 8, !dbg !168, !tbaa !84
  call void @__kmpc_for_static_fini(%struct.ident_t* %.kmpc_loc.addr, i32 %7), !dbg !168
  %19 = bitcast i32* %.omp.is_last to i8*, !dbg !168
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %19) #6, !dbg !168
  %20 = bitcast i32* %.omp.stride to i8*, !dbg !168
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %20) #6, !dbg !168
  %21 = bitcast i32* %.omp.ub to i8*, !dbg !168
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %21) #6, !dbg !168
  %22 = bitcast i32* %.omp.lb to i8*, !dbg !168
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %22) #6, !dbg !168
  ret void, !dbg !171
}

declare dso_local void @__kmpc_for_static_fini(%struct.ident_t*, i32)

; Function Attrs: norecurse nounwind uwtable
define internal void @.omp_outlined.(i32* noalias %.global_tid., i32* noalias %.bound_tid., i64 %.previous.lb., i64 %.previous.ub., i32** dereferenceable(8) %c, i32** dereferenceable(8) %b, i32** dereferenceable(8) %a) #3 !dbg !172 {
entry:
  call void @llvm.dbg.value(metadata i32* %.global_tid., metadata !174, metadata !DIExpression()), !dbg !181
  call void @llvm.dbg.value(metadata i32* %.bound_tid., metadata !175, metadata !DIExpression()), !dbg !181
  call void @llvm.dbg.value(metadata i64 %.previous.lb., metadata !176, metadata !DIExpression()), !dbg !181
  call void @llvm.dbg.value(metadata i64 %.previous.ub., metadata !177, metadata !DIExpression()), !dbg !181
  call void @llvm.dbg.value(metadata i32** %c, metadata !178, metadata !DIExpression()), !dbg !181
  call void @llvm.dbg.value(metadata i32** %b, metadata !179, metadata !DIExpression()), !dbg !181
  call void @llvm.dbg.value(metadata i32** %a, metadata !180, metadata !DIExpression()), !dbg !181
  call void @.omp_outlined._debug__.1(i32* %.global_tid., i32* %.bound_tid., i64 %.previous.lb., i64 %.previous.ub., i32** %c, i32** %b, i32** %a) #6, !dbg !182
  ret void, !dbg !182
}

declare dso_local void @__kmpc_fork_call(%struct.ident_t*, i32, void (i32*, i32*, ...)*, ...)

; Function Attrs: norecurse nounwind uwtable
define internal void @.omp_outlined..2(i32* noalias %.global_tid., i32* noalias %.bound_tid., i32** dereferenceable(8) %c, i32** dereferenceable(8) %b, i32** dereferenceable(8) %a) #3 !dbg !183 {
entry:
  call void @llvm.dbg.value(metadata i32* %.global_tid., metadata !185, metadata !DIExpression()), !dbg !190
  call void @llvm.dbg.value(metadata i32* %.bound_tid., metadata !186, metadata !DIExpression()), !dbg !190
  call void @llvm.dbg.value(metadata i32** %c, metadata !187, metadata !DIExpression()), !dbg !190
  call void @llvm.dbg.value(metadata i32** %b, metadata !188, metadata !DIExpression()), !dbg !190
  call void @llvm.dbg.value(metadata i32** %a, metadata !189, metadata !DIExpression()), !dbg !190
  call void @.omp_outlined._debug__(i32* %.global_tid., i32* %.bound_tid., i32** %c, i32** %b, i32** %a) #6, !dbg !191
  ret void, !dbg !191
}

declare dso_local void @__kmpc_fork_teams(%struct.ident_t*, i32, void (i32*, i32*, ...)*, ...)

; Function Attrs: norecurse nounwind uwtable
define internal void @__omp_offloading_801_20a8bc_Mult_l29(i32* %c, i32* %b, i32* %a) #3 !dbg !192 {
entry:
  call void @llvm.dbg.value(metadata i32* %c, metadata !194, metadata !DIExpression()), !dbg !197
  call void @llvm.dbg.value(metadata i32* %b, metadata !195, metadata !DIExpression()), !dbg !197
  call void @llvm.dbg.value(metadata i32* %a, metadata !196, metadata !DIExpression()), !dbg !197
  call void @__omp_offloading_801_20a8bc_Mult_l29_debug__(i32* %c, i32* %b, i32* %a) #6, !dbg !198
  ret void, !dbg !198
}

declare dso_local i32 @__tgt_target_teams(i64, i8*, i32, i8**, i8**, i64*, i64*, i32, i32)

; Function Attrs: nounwind uwtable
define dso_local i32 @check() #0 !dbg !199 {
entry:
  call void @llvm.dbg.value(metadata i8 0, metadata !201, metadata !DIExpression()), !dbg !205
  call void @llvm.dbg.value(metadata i32 0, metadata !203, metadata !DIExpression()), !dbg !206
  br label %for.cond, !dbg !207

for.cond:                                         ; preds = %for.inc, %entry
  %test.0 = phi i8 [ 0, %entry ], [ %test.1, %for.inc ], !dbg !208
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ], !dbg !209
  call void @llvm.dbg.value(metadata i32 %i.0, metadata !203, metadata !DIExpression()), !dbg !206
  call void @llvm.dbg.value(metadata i8 %test.0, metadata !201, metadata !DIExpression()), !dbg !205
  %cmp = icmp slt i32 %i.0, 5000, !dbg !210
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !dbg !212

for.cond.cleanup:                                 ; preds = %for.cond
  br label %for.end

for.body:                                         ; preds = %for.cond
  %0 = load i32*, i32** @c, align 8, !dbg !213, !tbaa !40
  %idxprom = sext i32 %i.0 to i64, !dbg !213
  %arrayidx = getelementptr inbounds i32, i32* %0, i64 %idxprom, !dbg !213
  %1 = load i32, i32* %arrayidx, align 4, !dbg !213, !tbaa !47
  %cmp1 = icmp ne i32 %1, 5000, !dbg !216
  br i1 %cmp1, label %if.then, label %if.end, !dbg !217

if.then:                                          ; preds = %for.body
  call void @llvm.dbg.value(metadata i8 1, metadata !201, metadata !DIExpression()), !dbg !205
  br label %if.end, !dbg !218

if.end:                                           ; preds = %if.then, %for.body
  %test.1 = phi i8 [ 1, %if.then ], [ %test.0, %for.body ], !dbg !208
  call void @llvm.dbg.value(metadata i8 %test.1, metadata !201, metadata !DIExpression()), !dbg !205
  br label %for.inc, !dbg !220

for.inc:                                          ; preds = %if.end
  %inc = add nsw i32 %i.0, 1, !dbg !221
  call void @llvm.dbg.value(metadata i32 %inc, metadata !203, metadata !DIExpression()), !dbg !206
  br label %for.cond, !dbg !222, !llvm.loop !223

for.end:                                          ; preds = %for.cond.cleanup
  %tobool = trunc i8 %test.0 to i1, !dbg !225
  %2 = zext i1 %tobool to i64, !dbg !225
  %cond = select i1 %tobool, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.4, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.5, i32 0, i32 0), !dbg !225
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.3, i32 0, i32 0), i8* %cond), !dbg !226
  ret i32 0, !dbg !227
}

declare dso_local i32 @printf(i8*, ...) #4

; Function Attrs: nounwind uwtable
define dso_local i32 @main() #0 !dbg !228 {
entry:
  %call = call noalias i8* @malloc(i64 20000) #6, !dbg !229
  %0 = bitcast i8* %call to i32*, !dbg !229
  store i32* %0, i32** @a, align 8, !dbg !230, !tbaa !40
  %call1 = call noalias i8* @malloc(i64 100000000) #6, !dbg !231
  %1 = bitcast i8* %call1 to i32*, !dbg !231
  store i32* %1, i32** @b, align 8, !dbg !232, !tbaa !40
  %call2 = call noalias i8* @malloc(i64 20000) #6, !dbg !233
  %2 = bitcast i8* %call2 to i32*, !dbg !233
  store i32* %2, i32** @c, align 8, !dbg !234, !tbaa !40
  %call3 = call i32 @init(), !dbg !235
  %call4 = call i32 @Mult(), !dbg !236
  %call5 = call i32 @check(), !dbg !237
  %3 = load i32*, i32** @a, align 8, !dbg !238, !tbaa !40
  %4 = bitcast i32* %3 to i8*, !dbg !238
  call void @free(i8* %4) #6, !dbg !239
  %5 = load i32*, i32** @b, align 8, !dbg !240, !tbaa !40
  %6 = bitcast i32* %5 to i8*, !dbg !240
  call void @free(i8* %6) #6, !dbg !241
  %7 = load i32*, i32** @c, align 8, !dbg !242, !tbaa !40
  %8 = bitcast i32* %7 to i8*, !dbg !242
  call void @free(i8* %8) #6, !dbg !243
  ret i32 0, !dbg !244
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

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind readnone speculatable }
attributes #3 = { norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!2}
!omp_offload.info = !{!12}
!llvm.module.flags = !{!13, !14, !15}
!llvm.ident = !{!16}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "b", scope: !2, file: !3, line: 11, type: !8, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 8.0.0 ", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, nameTableKind: None)
!3 = !DIFile(filename: "DRACC_OMP_022_MxV_Missing_Data_yes.c", directory: "/home/prithayan/openmp/llvm-mainline/llvm-project/llvm/test/Analysis/OmpDiagnosticsAnalysis")
!4 = !{}
!5 = !{!6, !0, !10}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "a", scope: !2, file: !3, line: 10, type: !8, isLocal: false, isDefinition: true)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DIGlobalVariableExpression(var: !11, expr: !DIExpression())
!11 = distinct !DIGlobalVariable(name: "c", scope: !2, file: !3, line: 12, type: !8, isLocal: false, isDefinition: true)
!12 = !{i32 0, i32 2049, i32 2140348, !"Mult", i32 29, i32 0}
!13 = !{i32 2, !"Dwarf Version", i32 4}
!14 = !{i32 2, !"Debug Info Version", i32 3}
!15 = !{i32 1, !"wchar_size", i32 4}
!16 = !{!"clang version 8.0.0 "}
!17 = distinct !DISubprogram(name: "init", scope: !3, file: !3, line: 15, type: !18, isLocal: false, isDefinition: true, scopeLine: 15, isOptimized: true, unit: !2, retainedNodes: !20)
!18 = !DISubroutineType(types: !19)
!19 = !{!9}
!20 = !{!21, !23}
!21 = !DILocalVariable(name: "i", scope: !22, file: !3, line: 16, type: !9)
!22 = distinct !DILexicalBlock(scope: !17, file: !3, line: 16, column: 5)
!23 = !DILocalVariable(name: "j", scope: !24, file: !3, line: 17, type: !9)
!24 = distinct !DILexicalBlock(scope: !25, file: !3, line: 17, column: 9)
!25 = distinct !DILexicalBlock(scope: !26, file: !3, line: 16, column: 27)
!26 = distinct !DILexicalBlock(scope: !22, file: !3, line: 16, column: 5)
!27 = !DILocation(line: 16, column: 13, scope: !22)
!28 = !DILocation(line: 16, column: 9, scope: !22)
!29 = !DILocation(line: 0, scope: !22)
!30 = !DILocation(line: 16, column: 19, scope: !26)
!31 = !DILocation(line: 16, column: 5, scope: !22)
!32 = !DILocation(line: 17, column: 17, scope: !24)
!33 = !DILocation(line: 17, column: 13, scope: !24)
!34 = !DILocation(line: 0, scope: !24)
!35 = !DILocation(line: 17, column: 23, scope: !36)
!36 = distinct !DILexicalBlock(scope: !24, file: !3, line: 17, column: 9)
!37 = !DILocation(line: 17, column: 9, scope: !24)
!38 = !DILocation(line: 18, column: 13, scope: !39)
!39 = distinct !DILexicalBlock(scope: !36, file: !3, line: 17, column: 31)
!40 = !{!41, !41, i64 0}
!41 = !{!"any pointer", !42, i64 0}
!42 = !{!"omnipotent char", !43, i64 0}
!43 = !{!"Simple C/C++ TBAA"}
!44 = !DILocation(line: 18, column: 18, scope: !39)
!45 = !DILocation(line: 18, column: 16, scope: !39)
!46 = !DILocation(line: 18, column: 21, scope: !39)
!47 = !{!48, !48, i64 0}
!48 = !{!"int", !42, i64 0}
!49 = !DILocation(line: 19, column: 9, scope: !39)
!50 = !DILocation(line: 17, column: 28, scope: !36)
!51 = !DILocation(line: 17, column: 9, scope: !36)
!52 = distinct !{!52, !37, !53}
!53 = !DILocation(line: 19, column: 9, scope: !24)
!54 = !DILocation(line: 20, column: 9, scope: !25)
!55 = !DILocation(line: 20, column: 13, scope: !25)
!56 = !DILocation(line: 21, column: 9, scope: !25)
!57 = !DILocation(line: 21, column: 13, scope: !25)
!58 = !DILocation(line: 22, column: 5, scope: !25)
!59 = !DILocation(line: 16, column: 24, scope: !26)
!60 = !DILocation(line: 16, column: 5, scope: !26)
!61 = distinct !{!61, !31, !62}
!62 = !DILocation(line: 22, column: 5, scope: !22)
!63 = !DILocation(line: 23, column: 9, scope: !17)
!64 = distinct !DISubprogram(name: "Mult", scope: !3, file: !3, line: 27, type: !18, isLocal: false, isDefinition: true, scopeLine: 27, isOptimized: true, unit: !2, retainedNodes: !4)
!65 = !DILocation(line: 29, column: 13, scope: !64)
!66 = !DILocation(line: 29, column: 50, scope: !67)
!67 = distinct !DILexicalBlock(scope: !64, file: !3, line: 29, column: 13)
!68 = !DILocation(line: 29, column: 68, scope: !67)
!69 = !DILocation(line: 29, column: 31, scope: !67)
!70 = !DILocation(line: 29, column: 13, scope: !67)
!71 = !DILocation(line: 39, column: 5, scope: !64)
!72 = distinct !DISubprogram(name: "__omp_offloading_801_20a8bc_Mult_l29_debug__", scope: !3, file: !3, line: 30, type: !73, isLocal: true, isDefinition: true, scopeLine: 30, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !75)
!73 = !DISubroutineType(types: !74)
!74 = !{null, !8, !8, !8}
!75 = !{!76, !77, !78}
!76 = !DILocalVariable(name: "c", arg: 1, scope: !72, file: !3, line: 12, type: !8)
!77 = !DILocalVariable(name: "b", arg: 2, scope: !72, file: !3, line: 11, type: !8)
!78 = !DILocalVariable(name: "a", arg: 3, scope: !72, file: !3, line: 10, type: !8)
!79 = !DILocation(line: 12, column: 6, scope: !72)
!80 = !DILocation(line: 11, column: 6, scope: !72)
!81 = !DILocation(line: 10, column: 6, scope: !72)
!82 = !DILocation(line: 31, column: 17, scope: !83)
!83 = distinct !DILexicalBlock(scope: !72, file: !3, line: 30, column: 5)
!84 = !{!85, !41, i64 16}
!85 = !{!"ident_t", !48, i64 0, !48, i64 4, !48, i64 8, !48, i64 12, !41, i64 16}
!86 = !DILocation(line: 37, column: 5, scope: !72)
!87 = distinct !DISubprogram(name: ".omp_outlined._debug__", scope: !3, file: !3, line: 32, type: !88, isLocal: true, isDefinition: true, scopeLine: 32, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !95)
!88 = !DISubroutineType(types: !89)
!89 = !{null, !90, !90, !94, !94, !94}
!90 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !91)
!91 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !92)
!92 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !93, size: 64)
!93 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !9)
!94 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !8, size: 64)
!95 = !{!96, !97, !98, !99, !100, !101, !102, !103, !104, !105, !106}
!96 = !DILocalVariable(name: ".global_tid.", arg: 1, scope: !87, type: !90, flags: DIFlagArtificial)
!97 = !DILocalVariable(name: ".bound_tid.", arg: 2, scope: !87, type: !90, flags: DIFlagArtificial)
!98 = !DILocalVariable(name: "c", arg: 3, scope: !87, file: !3, line: 12, type: !94)
!99 = !DILocalVariable(name: "b", arg: 4, scope: !87, file: !3, line: 11, type: !94)
!100 = !DILocalVariable(name: "a", arg: 5, scope: !87, file: !3, line: 10, type: !94)
!101 = !DILocalVariable(name: ".omp.iv", scope: !87, type: !9, flags: DIFlagArtificial)
!102 = !DILocalVariable(name: ".omp.comb.lb", scope: !87, type: !9, flags: DIFlagArtificial)
!103 = !DILocalVariable(name: ".omp.comb.ub", scope: !87, type: !9, flags: DIFlagArtificial)
!104 = !DILocalVariable(name: ".omp.stride", scope: !87, type: !9, flags: DIFlagArtificial)
!105 = !DILocalVariable(name: ".omp.is_last", scope: !87, type: !9, flags: DIFlagArtificial)
!106 = !DILocalVariable(name: "i", scope: !87, type: !9, flags: DIFlagArtificial)
!107 = !DILocation(line: 0, scope: !87)
!108 = !DILocation(line: 12, column: 6, scope: !87)
!109 = !DILocation(line: 11, column: 6, scope: !87)
!110 = !DILocation(line: 10, column: 6, scope: !87)
!111 = !DILocation(line: 32, column: 9, scope: !87)
!112 = !DILocation(line: 32, column: 13, scope: !87)
!113 = !DILocation(line: 31, column: 17, scope: !87)
!114 = !DILocation(line: 31, column: 50, scope: !115)
!115 = distinct !DILexicalBlock(scope: !87, file: !3, line: 31, column: 17)
!116 = distinct !{!116, !113, !117}
!117 = !DILocation(line: 31, column: 50, scope: !87)
!118 = !DILocation(line: 36, column: 9, scope: !87)
!119 = distinct !DISubprogram(name: ".omp_outlined._debug__.1", scope: !3, file: !3, line: 32, type: !120, isLocal: true, isDefinition: true, scopeLine: 32, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !124)
!120 = !DISubroutineType(types: !121)
!121 = !{null, !90, !90, !122, !122, !94, !94, !94}
!122 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !123)
!123 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!124 = !{!125, !126, !127, !128, !129, !130, !131, !132, !133, !134, !135, !136, !137, !138}
!125 = !DILocalVariable(name: ".global_tid.", arg: 1, scope: !119, type: !90, flags: DIFlagArtificial)
!126 = !DILocalVariable(name: ".bound_tid.", arg: 2, scope: !119, type: !90, flags: DIFlagArtificial)
!127 = !DILocalVariable(name: ".previous.lb.", arg: 3, scope: !119, type: !122, flags: DIFlagArtificial)
!128 = !DILocalVariable(name: ".previous.ub.", arg: 4, scope: !119, type: !122, flags: DIFlagArtificial)
!129 = !DILocalVariable(name: "c", arg: 5, scope: !119, file: !3, line: 12, type: !94)
!130 = !DILocalVariable(name: "b", arg: 6, scope: !119, file: !3, line: 11, type: !94)
!131 = !DILocalVariable(name: "a", arg: 7, scope: !119, file: !3, line: 10, type: !94)
!132 = !DILocalVariable(name: ".omp.iv", scope: !119, type: !9, flags: DIFlagArtificial)
!133 = !DILocalVariable(name: ".omp.lb", scope: !119, type: !9, flags: DIFlagArtificial)
!134 = !DILocalVariable(name: ".omp.ub", scope: !119, type: !9, flags: DIFlagArtificial)
!135 = !DILocalVariable(name: ".omp.stride", scope: !119, type: !9, flags: DIFlagArtificial)
!136 = !DILocalVariable(name: ".omp.is_last", scope: !119, type: !9, flags: DIFlagArtificial)
!137 = !DILocalVariable(name: "i", scope: !119, type: !9, flags: DIFlagArtificial)
!138 = !DILocalVariable(name: "j", scope: !139, file: !3, line: 33, type: !9)
!139 = distinct !DILexicalBlock(scope: !140, file: !3, line: 33, column: 13)
!140 = distinct !DILexicalBlock(scope: !119, file: !3, line: 32, column: 31)
!141 = !DILocation(line: 0, scope: !119)
!142 = !DILocation(line: 12, column: 6, scope: !119)
!143 = !DILocation(line: 11, column: 6, scope: !119)
!144 = !DILocation(line: 10, column: 6, scope: !119)
!145 = !DILocation(line: 32, column: 9, scope: !119)
!146 = !DILocation(line: 32, column: 13, scope: !119)
!147 = !DILocation(line: 32, column: 27, scope: !119)
!148 = !DILocation(line: 33, column: 21, scope: !139)
!149 = !DILocation(line: 33, column: 17, scope: !139)
!150 = !DILocation(line: 0, scope: !139)
!151 = !DILocation(line: 33, column: 27, scope: !152)
!152 = distinct !DILexicalBlock(scope: !139, file: !3, line: 33, column: 13)
!153 = !DILocation(line: 33, column: 13, scope: !139)
!154 = !DILocation(line: 34, column: 23, scope: !155)
!155 = distinct !DILexicalBlock(scope: !152, file: !3, line: 33, column: 35)
!156 = !DILocation(line: 34, column: 28, scope: !155)
!157 = !DILocation(line: 34, column: 26, scope: !155)
!158 = !DILocation(line: 34, column: 32, scope: !155)
!159 = !DILocation(line: 34, column: 31, scope: !155)
!160 = !DILocation(line: 34, column: 17, scope: !155)
!161 = !DILocation(line: 34, column: 21, scope: !155)
!162 = !DILocation(line: 35, column: 13, scope: !155)
!163 = !DILocation(line: 33, column: 32, scope: !152)
!164 = !DILocation(line: 33, column: 13, scope: !152)
!165 = distinct !{!165, !153, !166}
!166 = !DILocation(line: 35, column: 13, scope: !139)
!167 = !DILocation(line: 36, column: 9, scope: !140)
!168 = !DILocation(line: 31, column: 17, scope: !119)
!169 = distinct !{!169, !168, !170}
!170 = !DILocation(line: 31, column: 50, scope: !119)
!171 = !DILocation(line: 36, column: 9, scope: !119)
!172 = distinct !DISubprogram(name: ".omp_outlined.", scope: !3, file: !3, line: 32, type: !120, isLocal: true, isDefinition: true, scopeLine: 32, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !173)
!173 = !{!174, !175, !176, !177, !178, !179, !180}
!174 = !DILocalVariable(name: ".global_tid.", arg: 1, scope: !172, type: !90, flags: DIFlagArtificial)
!175 = !DILocalVariable(name: ".bound_tid.", arg: 2, scope: !172, type: !90, flags: DIFlagArtificial)
!176 = !DILocalVariable(name: ".previous.lb.", arg: 3, scope: !172, type: !122, flags: DIFlagArtificial)
!177 = !DILocalVariable(name: ".previous.ub.", arg: 4, scope: !172, type: !122, flags: DIFlagArtificial)
!178 = !DILocalVariable(name: "c", arg: 5, scope: !172, type: !94, flags: DIFlagArtificial)
!179 = !DILocalVariable(name: "b", arg: 6, scope: !172, type: !94, flags: DIFlagArtificial)
!180 = !DILocalVariable(name: "a", arg: 7, scope: !172, type: !94, flags: DIFlagArtificial)
!181 = !DILocation(line: 0, scope: !172)
!182 = !DILocation(line: 32, column: 9, scope: !172)
!183 = distinct !DISubprogram(name: ".omp_outlined..2", scope: !3, file: !3, line: 32, type: !88, isLocal: true, isDefinition: true, scopeLine: 32, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !184)
!184 = !{!185, !186, !187, !188, !189}
!185 = !DILocalVariable(name: ".global_tid.", arg: 1, scope: !183, type: !90, flags: DIFlagArtificial)
!186 = !DILocalVariable(name: ".bound_tid.", arg: 2, scope: !183, type: !90, flags: DIFlagArtificial)
!187 = !DILocalVariable(name: "c", arg: 3, scope: !183, type: !94, flags: DIFlagArtificial)
!188 = !DILocalVariable(name: "b", arg: 4, scope: !183, type: !94, flags: DIFlagArtificial)
!189 = !DILocalVariable(name: "a", arg: 5, scope: !183, type: !94, flags: DIFlagArtificial)
!190 = !DILocation(line: 0, scope: !183)
!191 = !DILocation(line: 32, column: 9, scope: !183)
!192 = distinct !DISubprogram(name: "__omp_offloading_801_20a8bc_Mult_l29", scope: !3, file: !3, line: 30, type: !73, isLocal: true, isDefinition: true, scopeLine: 30, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !193)
!193 = !{!194, !195, !196}
!194 = !DILocalVariable(name: "c", arg: 1, scope: !192, type: !8, flags: DIFlagArtificial)
!195 = !DILocalVariable(name: "b", arg: 2, scope: !192, type: !8, flags: DIFlagArtificial)
!196 = !DILocalVariable(name: "a", arg: 3, scope: !192, type: !8, flags: DIFlagArtificial)
!197 = !DILocation(line: 0, scope: !192)
!198 = !DILocation(line: 30, column: 5, scope: !192)
!199 = distinct !DISubprogram(name: "check", scope: !3, file: !3, line: 42, type: !18, isLocal: false, isDefinition: true, scopeLine: 42, isOptimized: true, unit: !2, retainedNodes: !200)
!200 = !{!201, !203}
!201 = !DILocalVariable(name: "test", scope: !199, file: !3, line: 43, type: !202)
!202 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!203 = !DILocalVariable(name: "i", scope: !204, file: !3, line: 44, type: !9)
!204 = distinct !DILexicalBlock(scope: !199, file: !3, line: 44, column: 5)
!205 = !DILocation(line: 43, column: 10, scope: !199)
!206 = !DILocation(line: 44, column: 13, scope: !204)
!207 = !DILocation(line: 44, column: 9, scope: !204)
!208 = !DILocation(line: 0, scope: !199)
!209 = !DILocation(line: 0, scope: !204)
!210 = !DILocation(line: 44, column: 19, scope: !211)
!211 = distinct !DILexicalBlock(scope: !204, file: !3, line: 44, column: 5)
!212 = !DILocation(line: 44, column: 5, scope: !204)
!213 = !DILocation(line: 45, column: 12, scope: !214)
!214 = distinct !DILexicalBlock(scope: !215, file: !3, line: 45, column: 12)
!215 = distinct !DILexicalBlock(scope: !211, file: !3, line: 44, column: 27)
!216 = !DILocation(line: 45, column: 16, scope: !214)
!217 = !DILocation(line: 45, column: 12, scope: !215)
!218 = !DILocation(line: 47, column: 9, scope: !219)
!219 = distinct !DILexicalBlock(scope: !214, file: !3, line: 45, column: 20)
!220 = !DILocation(line: 48, column: 5, scope: !215)
!221 = !DILocation(line: 44, column: 24, scope: !211)
!222 = !DILocation(line: 44, column: 5, scope: !211)
!223 = distinct !{!223, !212, !224}
!224 = !DILocation(line: 48, column: 5, scope: !204)
!225 = !DILocation(line: 49, column: 38, scope: !199)
!226 = !DILocation(line: 49, column: 5, scope: !199)
!227 = !DILocation(line: 50, column: 5, scope: !199)
!228 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 56, type: !18, isLocal: false, isDefinition: true, scopeLine: 56, isOptimized: true, unit: !2, retainedNodes: !4)
!229 = !DILocation(line: 57, column: 9, scope: !228)
!230 = !DILocation(line: 57, column: 7, scope: !228)
!231 = !DILocation(line: 58, column: 9, scope: !228)
!232 = !DILocation(line: 58, column: 7, scope: !228)
!233 = !DILocation(line: 59, column: 9, scope: !228)
!234 = !DILocation(line: 59, column: 7, scope: !228)
!235 = !DILocation(line: 60, column: 5, scope: !228)
!236 = !DILocation(line: 61, column: 5, scope: !228)
!237 = !DILocation(line: 62, column: 5, scope: !228)
!238 = !DILocation(line: 63, column: 10, scope: !228)
!239 = !DILocation(line: 63, column: 5, scope: !228)
!240 = !DILocation(line: 64, column: 10, scope: !228)
!241 = !DILocation(line: 64, column: 5, scope: !228)
!242 = !DILocation(line: 65, column: 10, scope: !228)
!243 = !DILocation(line: 65, column: 5, scope: !228)
!244 = !DILocation(line: 66, column: 5, scope: !228)
