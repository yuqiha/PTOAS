; ModuleID = 'ptoas.hivm.official'
source_filename = "ptoas.hivm.official"

declare { <256 x i1>, i32 } @llvm.hivm.plt.b32.v300(i32)

declare <64 x float> @llvm.hivm.vldsx1.v64f32(ptr addrspace(6), i32, i32, i32)

declare <256 x i1> @llvm.hivm.vcmps.ne.f32.z(<64 x float>, float, <256 x i1>)

declare <64 x float> @llvm.hivm.vdups.v64f32.z(float, <256 x i1>, i32)

declare <64 x float> @llvm.hivm.vsel.v64f32(<64 x float>, <64 x float>, <256 x i1>)

declare void @llvm.hivm.vstsx1.v64f32(<64 x float>, ptr addrspace(6), i32, i32, i32, <256 x i1>)

define void @TSELS_test() #0 {
  br label %1

1:                                                ; preds = %aivscope.latch, %0
  %2 = phi i64 [ %23, %aivscope.latch ], [ 0, %0 ]
  %3 = icmp slt i64 %2, 1
  br i1 %3, label %4, label %24

4:                                                ; preds = %1
  br label %5

5:                                                ; preds = %8, %4
  %6 = phi i64 [ %21, %8 ], [ 0, %4 ]
  %7 = icmp slt i64 %6, 16
  br i1 %7, label %8, label %22

8:                                                ; preds = %5
  %9 = call { <256 x i1>, i32 } @llvm.hivm.plt.b32.v300(i32 64)
  %10 = extractvalue { <256 x i1>, i32 } %9, 0
  %11 = extractvalue { <256 x i1>, i32 } %9, 1
  %12 = mul i64 %6, 64
  %13 = getelementptr float, ptr addrspace(6) inttoptr (i64 8192 to ptr addrspace(6)), i64 %12
  %14 = call <64 x float> @llvm.hivm.vldsx1.v64f32(ptr addrspace(6) %13, i32 0, i32 0, i32 0)
  %15 = call <256 x i1> @llvm.hivm.vcmps.ne.f32.z(<64 x float> %14, float 0.000000e+00, <256 x i1> %10)
  %16 = getelementptr float, ptr addrspace(6) inttoptr (i64 4096 to ptr addrspace(6)), i64 %12
  %17 = call <64 x float> @llvm.hivm.vldsx1.v64f32(ptr addrspace(6) %16, i32 0, i32 0, i32 0)
  %18 = call <64 x float> @llvm.hivm.vdups.v64f32.z(float 4.200000e+01, <256 x i1> %10, i32 1)
  %19 = call <64 x float> @llvm.hivm.vsel.v64f32(<64 x float> %17, <64 x float> %18, <256 x i1> %15)
  %20 = getelementptr float, ptr addrspace(6) null, i64 %12
  call void @llvm.hivm.vstsx1.v64f32(<64 x float> %19, ptr addrspace(6) %20, i32 0, i32 2, i32 0, <256 x i1> %10)
  %21 = add i64 %6, 1
  br label %5

22:                                               ; preds = %5
  br label %aivscope.latch

aivscope.latch:                                   ; preds = %22
  %23 = add i64 %2, 1
  br label %1, !llvm.loop !3

24:                                               ; preds = %1
  ret void
}

attributes #0 = { "target-cpu"="dav-c310-vec" "target-features"="+ATOMIC,+ArchV130,+AregRedefinable,+ArithmeticBf16,+AtomicForB8 ,+F8e4m3,+F8e5m2,+F8e8m0,+FFTSBlk,+Fp4e1m2x2,+Fp4e2m1x2,+LDExtRefine,+MOVX8,+MSTX,+SPR7bits,+SyncV,+dav-c310-vec" }

!llvm.module.flags = !{!0}
!hivm.annotations = !{!1, !2}

!0 = !{i32 2, !"Debug Info Version", i32 3}
!1 = !{ptr @TSELS_test, !"kernel", i32 1}
!2 = !{ptr @TSELS_test, !"kernel_with_simd", i32 1}
!3 = distinct !{!3, !4}
!4 = !{!"llvm.loop.aivector_scope"}
