; ModuleID = 'input_for_div.ll'
source_filename = "inputs/input_for_div.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @foo(i32 noundef %arg, i32 noundef %arg13) #0 {
bb:
  br label %bb14

bb14:                                             ; preds = %bb31, %bb
  %.03 = phi i32 [ 0, %bb ], [ %i32, %bb31 ]
  %.02 = phi i32 [ 0, %bb ], [ %.1, %bb31 ]
  %i = icmp slt i32 %.03, %arg
  br i1 %i, label %bb15, label %bb33

bb15:                                             ; preds = %bb14
  %i16 = mul nsw i32 3, %.03
  %i17 = add nsw i32 %i16, 7
  %i18 = mul nsw i32 4, %.03
  %i19 = sub nsw i32 100, %i18
  br label %bb20

bb20:                                             ; preds = %bb28, %bb15
  %.08 = phi i32 [ 0, %bb15 ], [ %i29, %bb28 ]
  %.07 = phi i32 [ %i19, %bb15 ], [ %i24, %bb28 ]
  %.06 = phi i32 [ %i17, %bb15 ], [ %i23, %bb28 ]
  %.1 = phi i32 [ %.02, %bb15 ], [ %i27, %bb28 ]
  %i21 = icmp slt i32 %.08, %arg13
  br i1 %i21, label %bb22, label %bb30

bb22:                                             ; preds = %bb20
  %i23 = add nsw i32 %.06, 2
  %i24 = add nsw i32 %.07, 1
  %i25 = xor i32 %i23, %i24
  %i26 = add nsw i32 %i25, %.08
  %i27 = add nsw i32 %.1, %i26
  br label %bb28

bb28:                                             ; preds = %bb22
  %i29 = add nsw i32 %.08, 1
  br label %bb20, !llvm.loop !6

bb30:                                             ; preds = %bb20
  br label %bb31

bb31:                                             ; preds = %bb30
  %i32 = add nsw i32 %.03, 1
  br label %bb14, !llvm.loop !8

bb33:                                             ; preds = %bb14
  br label %bb34

bb34:                                             ; preds = %bb50, %bb33
  %.09 = phi i32 [ 0, %bb33 ], [ %i51, %bb50 ]
  %.2 = phi i32 [ %.02, %bb33 ], [ %.3, %bb50 ]
  %i35 = icmp slt i32 %.09, %arg
  br i1 %i35, label %bb36, label %bb52

bb36:                                             ; preds = %bb34
  %i37 = mul nsw i32 5, %.09
  %i38 = sub nsw i32 %.09, 10
  br label %bb39

bb39:                                             ; preds = %bb47, %bb36
  %.012 = phi i32 [ 0, %bb36 ], [ %i48, %bb47 ]
  %.011 = phi i32 [ %i38, %bb36 ], [ %i43, %bb47 ]
  %.010 = phi i32 [ %i37, %bb36 ], [ %i42, %bb47 ]
  %.3 = phi i32 [ %.2, %bb36 ], [ %i46, %bb47 ]
  %i40 = icmp slt i32 %.012, %arg13
  br i1 %i40, label %bb41, label %bb49

bb41:                                             ; preds = %bb39
  %i42 = add nsw i32 %.010, 5
  %i43 = add nsw i32 %.011, -3
  %i44 = sub nsw i32 %i42, %i43
  %i45 = add nsw i32 %i44, %.012
  %i46 = add nsw i32 %.3, %i45
  br label %bb47

bb47:                                             ; preds = %bb41
  %i48 = add nsw i32 %.012, 1
  br label %bb39, !llvm.loop !9

bb49:                                             ; preds = %bb39
  br label %bb50

bb50:                                             ; preds = %bb49
  %i51 = add nsw i32 %.09, 1
  br label %bb34, !llvm.loop !10

bb52:                                             ; preds = %bb34
  br label %bb53

bb53:                                             ; preds = %bb69, %bb52
  %.05 = phi i32 [ 0, %bb52 ], [ %i70, %bb69 ]
  %.4 = phi i32 [ %.2, %bb52 ], [ %.5, %bb69 ]
  %i54 = icmp slt i32 %.05, %arg
  br i1 %i54, label %bb55, label %bb71

bb55:                                             ; preds = %bb53
  %i56 = add nsw i32 %.05, 1
  %i57 = mul nsw i32 2, %.05
  %i58 = add nsw i32 42, %i57
  br label %bb59

bb59:                                             ; preds = %bb66, %bb55
  %.04 = phi i32 [ %i56, %bb55 ], [ %i62, %bb66 ]
  %.5 = phi i32 [ %.4, %bb55 ], [ %i65, %bb66 ]
  %.01 = phi i32 [ %i58, %bb55 ], [ %i63, %bb66 ]
  %.0 = phi i32 [ 0, %bb55 ], [ %i67, %bb66 ]
  %i60 = icmp slt i32 %.0, %arg13
  br i1 %i60, label %bb61, label %bb68

bb61:                                             ; preds = %bb59
  %i62 = mul nsw i32 %.04, 2
  %i63 = add nsw i32 %.01, 4
  %i64 = and i32 %i62, %i63
  %i65 = add nsw i32 %.5, %i64
  br label %bb66

bb66:                                             ; preds = %bb61
  %i67 = add nsw i32 %.0, 1
  br label %bb59, !llvm.loop !11

bb68:                                             ; preds = %bb59
  br label %bb69

bb69:                                             ; preds = %bb68
  %i70 = add nsw i32 %.05, 1
  br label %bb53, !llvm.loop !12

bb71:                                             ; preds = %bb53
  ret i32 %.4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @bar(i32 noundef %arg, i32 noundef %arg6, i32 noundef %arg7) #0 {
bb:
  br label %bb8

bb8:                                              ; preds = %bb31, %bb
  %.04 = phi i32 [ 0, %bb ], [ %i32, %bb31 ]
  %.03 = phi i32 [ 0, %bb ], [ %.1, %bb31 ]
  %i = icmp slt i32 %.04, %arg
  br i1 %i, label %bb9, label %bb33

bb9:                                              ; preds = %bb8
  br label %bb10

bb10:                                             ; preds = %bb28, %bb9
  %.05 = phi i32 [ 1, %bb9 ], [ %i29, %bb28 ]
  %.1 = phi i32 [ %.03, %bb9 ], [ %.2, %bb28 ]
  %i11 = icmp slt i32 %.05, %arg6
  br i1 %i11, label %bb12, label %bb30

bb12:                                             ; preds = %bb10
  %i13 = mul nsw i32 2, %.04
  %i14 = add nsw i32 %i13, %.05
  %i15 = mul nsw i32 10, %.05
  %i16 = sub nsw i32 %i15, %.04
  br label %bb17

bb17:                                             ; preds = %bb25, %bb12
  %.2 = phi i32 [ %.1, %bb12 ], [ %i24, %bb25 ]
  %.02 = phi i32 [ %i14, %bb12 ], [ %i20, %bb25 ]
  %.01 = phi i32 [ %i16, %bb12 ], [ %i21, %bb25 ]
  %.0 = phi i32 [ 0, %bb12 ], [ %i26, %bb25 ]
  %i18 = icmp slt i32 %.0, %arg7
  br i1 %i18, label %bb19, label %bb27

bb19:                                             ; preds = %bb17
  %i20 = add nsw i32 %.02, 2
  %i21 = add nsw i32 %.01, -1
  %i22 = xor i32 %i20, %i21
  %i23 = xor i32 %i22, %.0
  %i24 = add nsw i32 %.2, %i23
  br label %bb25

bb25:                                             ; preds = %bb19
  %i26 = add nsw i32 %.0, 1
  br label %bb17, !llvm.loop !13

bb27:                                             ; preds = %bb17
  br label %bb28

bb28:                                             ; preds = %bb27
  %i29 = add nsw i32 %.05, 1
  br label %bb10, !llvm.loop !14

bb30:                                             ; preds = %bb10
  br label %bb31

bb31:                                             ; preds = %bb30
  %i32 = add nsw i32 %.04, 1
  br label %bb8, !llvm.loop !15

bb33:                                             ; preds = %bb8
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
