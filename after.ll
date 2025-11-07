; ModuleID = 'input_for_div.ll'
source_filename = "inputs/input_for_div.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @foo(i32 noundef %arg, i32 noundef %arg21) #0 {
bb:
  br label %bb22

bb22:                                             ; preds = %bb43, %bb
  %.03 = phi i32 [ 0, %bb ], [ %i44, %bb43 ]
  %.02 = phi i32 [ 0, %bb ], [ %.1, %bb43 ]
  %i = mul i32 %.03, 3
  %i23 = add i32 %i, 7
  %i24 = mul i32 %.03, -4
  %i25 = add i32 %i24, 100
  %i26 = icmp slt i32 %.03, %arg
  br i1 %i26, label %bb27, label %bb45

bb27:                                             ; preds = %bb22
  %i28 = mul nsw i32 3, %.03
  %i29 = add nsw i32 %i28, 7
  %i30 = mul nsw i32 4, %.03
  %i31 = sub nsw i32 100, %i30
  br label %bb32

bb32:                                             ; preds = %bb40, %bb27
  %.08 = phi i32 [ 0, %bb27 ], [ %i41, %bb40 ]
  %.1 = phi i32 [ %.02, %bb27 ], [ %i39, %bb40 ]
  %i33 = icmp slt i32 %.08, %arg21
  br i1 %i33, label %bb34, label %bb42

bb34:                                             ; preds = %bb32
  %iv.mul19 = mul i32 2, %.08
  %iv.lin20 = add i32 %i23, %iv.mul19
  %i35 = add nsw i32 %iv.lin20, 2
  %iv.mul17 = mul i32 1, %.08
  %iv.lin18 = add i32 %i25, %iv.mul17
  %i36 = add nsw i32 %iv.lin18, 1
  %i37 = xor i32 %i35, %i36
  %i38 = add nsw i32 %i37, %.08
  %i39 = add nsw i32 %.1, %i38
  br label %bb40

bb40:                                             ; preds = %bb34
  %i41 = add nsw i32 %.08, 1
  br label %bb32, !llvm.loop !6

bb42:                                             ; preds = %bb32
  br label %bb43

bb43:                                             ; preds = %bb42
  %i44 = add nsw i32 %.03, 1
  br label %bb22, !llvm.loop !8

bb45:                                             ; preds = %bb22
  br label %bb46

bb46:                                             ; preds = %bb64, %bb45
  %.09 = phi i32 [ 0, %bb45 ], [ %i65, %bb64 ]
  %.2 = phi i32 [ %.02, %bb45 ], [ %.3, %bb64 ]
  %i47 = mul i32 %.09, 5
  %i48 = add i32 %.09, -10
  %i49 = icmp slt i32 %.09, %arg
  br i1 %i49, label %bb50, label %bb66

bb50:                                             ; preds = %bb46
  %i51 = mul nsw i32 5, %.09
  %i52 = sub nsw i32 %.09, 10
  br label %bb53

bb53:                                             ; preds = %bb61, %bb50
  %.012 = phi i32 [ 0, %bb50 ], [ %i62, %bb61 ]
  %.3 = phi i32 [ %.2, %bb50 ], [ %i60, %bb61 ]
  %i54 = icmp slt i32 %.012, %arg21
  br i1 %i54, label %bb55, label %bb63

bb55:                                             ; preds = %bb53
  %iv.mul15 = mul i32 5, %.012
  %iv.lin16 = add i32 %i47, %iv.mul15
  %i56 = add nsw i32 %iv.lin16, 5
  %iv.mul13 = mul i32 -3, %.012
  %iv.lin14 = add i32 %i48, %iv.mul13
  %i57 = add nsw i32 %iv.lin14, -3
  %i58 = sub nsw i32 %i56, %i57
  %i59 = add nsw i32 %i58, %.012
  %i60 = add nsw i32 %.3, %i59
  br label %bb61

bb61:                                             ; preds = %bb55
  %i62 = add nsw i32 %.012, 1
  br label %bb53, !llvm.loop !9

bb63:                                             ; preds = %bb53
  br label %bb64

bb64:                                             ; preds = %bb63
  %i65 = add nsw i32 %.09, 1
  br label %bb46, !llvm.loop !10

bb66:                                             ; preds = %bb46
  br label %bb67

bb67:                                             ; preds = %bb85, %bb66
  %.05 = phi i32 [ 0, %bb66 ], [ %i86, %bb85 ]
  %.4 = phi i32 [ %.2, %bb66 ], [ %.5, %bb85 ]
  %i68 = shl nuw i32 %.05, 1
  %i69 = add i32 %i68, 42
  %i70 = icmp slt i32 %.05, %arg
  br i1 %i70, label %bb71, label %bb87

bb71:                                             ; preds = %bb67
  %i72 = add nsw i32 %.05, 1
  %i73 = mul nsw i32 2, %.05
  %i74 = add nsw i32 42, %i73
  br label %bb75

bb75:                                             ; preds = %bb82, %bb71
  %.04 = phi i32 [ %i72, %bb71 ], [ %i78, %bb82 ]
  %.5 = phi i32 [ %.4, %bb71 ], [ %i81, %bb82 ]
  %.0 = phi i32 [ 0, %bb71 ], [ %i83, %bb82 ]
  %i76 = icmp slt i32 %.0, %arg21
  br i1 %i76, label %bb77, label %bb84

bb77:                                             ; preds = %bb75
  %i78 = mul nsw i32 %.04, 2
  %iv.mul = mul i32 4, %.0
  %iv.lin = add i32 %i69, %iv.mul
  %i79 = add nsw i32 %iv.lin, 4
  %i80 = and i32 %i78, %i79
  %i81 = add nsw i32 %.5, %i80
  br label %bb82

bb82:                                             ; preds = %bb77
  %i83 = add nsw i32 %.0, 1
  br label %bb75, !llvm.loop !11

bb84:                                             ; preds = %bb75
  br label %bb85

bb85:                                             ; preds = %bb84
  %i86 = add nsw i32 %.05, 1
  br label %bb67, !llvm.loop !12

bb87:                                             ; preds = %bb67
  ret i32 %.4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @bar(i32 noundef %arg, i32 noundef %arg8, i32 noundef %arg9) #0 {
bb:
  br label %bb10

bb10:                                             ; preds = %bb40, %bb
  %.04 = phi i32 [ 0, %bb ], [ %i41, %bb40 ]
  %.03 = phi i32 [ 0, %bb ], [ %.1, %bb40 ]
  %i = mul nsw i32 %.04, -1
  %i11 = add i32 %i, 10
  %i12 = shl nuw i32 %.04, 1
  %i13 = add i32 %i12, 1
  %i14 = icmp slt i32 %.04, %arg
  br i1 %i14, label %bb15, label %bb42

bb15:                                             ; preds = %bb10
  br label %bb16

bb16:                                             ; preds = %bb37, %bb15
  %indvar = phi i32 [ %indvar.next, %bb37 ], [ 0, %bb15 ]
  %.05 = phi i32 [ 1, %bb15 ], [ %i38, %bb37 ]
  %.1 = phi i32 [ %.03, %bb15 ], [ %.2, %bb37 ]
  %i17 = mul i32 %indvar, 10
  %i18 = add i32 %i11, %i17
  %i19 = add i32 %i13, %indvar
  %i20 = icmp slt i32 %.05, %arg8
  br i1 %i20, label %bb21, label %bb39

bb21:                                             ; preds = %bb16
  %i22 = mul nsw i32 2, %.04
  %i23 = add nsw i32 %i22, %.05
  %i24 = mul nsw i32 10, %.05
  %i25 = sub nsw i32 %i24, %.04
  br label %bb26

bb26:                                             ; preds = %bb34, %bb21
  %.2 = phi i32 [ %.1, %bb21 ], [ %i33, %bb34 ]
  %.0 = phi i32 [ 0, %bb21 ], [ %i35, %bb34 ]
  %i27 = icmp slt i32 %.0, %arg9
  br i1 %i27, label %bb28, label %bb36

bb28:                                             ; preds = %bb26
  %iv.mul = mul i32 2, %.0
  %iv.lin = add i32 %i19, %iv.mul
  %i29 = add nsw i32 %iv.lin, 2
  %iv.mul6 = mul i32 -1, %.0
  %iv.lin7 = add i32 %i18, %iv.mul6
  %i30 = add nsw i32 %iv.lin7, -1
  %i31 = xor i32 %i29, %i30
  %i32 = xor i32 %i31, %.0
  %i33 = add nsw i32 %.2, %i32
  br label %bb34

bb34:                                             ; preds = %bb28
  %i35 = add nsw i32 %.0, 1
  br label %bb26, !llvm.loop !13

bb36:                                             ; preds = %bb26
  br label %bb37

bb37:                                             ; preds = %bb36
  %i38 = add nsw i32 %.05, 1
  %indvar.next = add i32 %indvar, 1
  br label %bb16, !llvm.loop !14

bb39:                                             ; preds = %bb16
  br label %bb40

bb40:                                             ; preds = %bb39
  %i41 = add nsw i32 %.04, 1
  br label %bb10, !llvm.loop !15

bb42:                                             ; preds = %bb10
  ret i32 %.03
}

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 21.1.5 (++20251023083255+45afac62e373-1~exp1~20251023083404.50)"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
!13 = distinct !{!13, !7}
!14 = distinct !{!14, !7}
!15 = distinct !{!15, !7}
