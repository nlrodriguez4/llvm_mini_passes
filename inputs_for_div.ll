; ModuleID = 'inputs/input_for_div.c'
source_filename = "inputs/input_for_div.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @foo(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  store i32 0, ptr %5, align 4
  store i32 0, ptr %6, align 4
  br label %23

23:                                               ; preds = %56, %2
  %24 = load i32, ptr %6, align 4
  %25 = load i32, ptr %3, align 4
  %26 = icmp slt i32 %24, %25
  br i1 %26, label %27, label %59

27:                                               ; preds = %23
  %28 = load i32, ptr %6, align 4
  %29 = mul nsw i32 3, %28
  %30 = add nsw i32 %29, 7
  store i32 %30, ptr %7, align 4
  %31 = load i32, ptr %6, align 4
  %32 = mul nsw i32 4, %31
  %33 = sub nsw i32 100, %32
  store i32 %33, ptr %8, align 4
  store i32 0, ptr %9, align 4
  br label %34

34:                                               ; preds = %52, %27
  %35 = load i32, ptr %9, align 4
  %36 = load i32, ptr %4, align 4
  %37 = icmp slt i32 %35, %36
  br i1 %37, label %38, label %55

38:                                               ; preds = %34
  %39 = load i32, ptr %7, align 4
  store i32 %39, ptr %10, align 4
  %40 = load i32, ptr %8, align 4
  store i32 %40, ptr %11, align 4
  %41 = load i32, ptr %10, align 4
  %42 = add nsw i32 %41, 2
  store i32 %42, ptr %10, align 4
  %43 = load i32, ptr %11, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, ptr %11, align 4
  %45 = load i32, ptr %10, align 4
  %46 = load i32, ptr %11, align 4
  %47 = xor i32 %45, %46
  %48 = load i32, ptr %9, align 4
  %49 = add nsw i32 %47, %48
  %50 = load i32, ptr %5, align 4
  %51 = add nsw i32 %50, %49
  store i32 %51, ptr %5, align 4
  br label %52

52:                                               ; preds = %38
  %53 = load i32, ptr %9, align 4
  %54 = add nsw i32 %53, 1
  store i32 %54, ptr %9, align 4
  br label %34, !llvm.loop !6

55:                                               ; preds = %34
  br label %56

56:                                               ; preds = %55
  %57 = load i32, ptr %6, align 4
  %58 = add nsw i32 %57, 1
  store i32 %58, ptr %6, align 4
  br label %23, !llvm.loop !8

59:                                               ; preds = %23
  store i32 0, ptr %12, align 4
  br label %60

60:                                               ; preds = %91, %59
  %61 = load i32, ptr %12, align 4
  %62 = load i32, ptr %3, align 4
  %63 = icmp slt i32 %61, %62
  br i1 %63, label %64, label %94

64:                                               ; preds = %60
  %65 = load i32, ptr %12, align 4
  %66 = mul nsw i32 5, %65
  store i32 %66, ptr %13, align 4
  %67 = load i32, ptr %12, align 4
  %68 = sub nsw i32 %67, 10
  store i32 %68, ptr %14, align 4
  store i32 0, ptr %15, align 4
  br label %69

69:                                               ; preds = %87, %64
  %70 = load i32, ptr %15, align 4
  %71 = load i32, ptr %4, align 4
  %72 = icmp slt i32 %70, %71
  br i1 %72, label %73, label %90

73:                                               ; preds = %69
  %74 = load i32, ptr %13, align 4
  store i32 %74, ptr %16, align 4
  %75 = load i32, ptr %14, align 4
  store i32 %75, ptr %17, align 4
  %76 = load i32, ptr %16, align 4
  %77 = add nsw i32 %76, 5
  store i32 %77, ptr %16, align 4
  %78 = load i32, ptr %17, align 4
  %79 = add nsw i32 %78, -3
  store i32 %79, ptr %17, align 4
  %80 = load i32, ptr %16, align 4
  %81 = load i32, ptr %17, align 4
  %82 = sub nsw i32 %80, %81
  %83 = load i32, ptr %15, align 4
  %84 = add nsw i32 %82, %83
  %85 = load i32, ptr %5, align 4
  %86 = add nsw i32 %85, %84
  store i32 %86, ptr %5, align 4
  br label %87

87:                                               ; preds = %73
  %88 = load i32, ptr %15, align 4
  %89 = add nsw i32 %88, 1
  store i32 %89, ptr %15, align 4
  br label %69, !llvm.loop !9

90:                                               ; preds = %69
  br label %91

91:                                               ; preds = %90
  %92 = load i32, ptr %12, align 4
  %93 = add nsw i32 %92, 1
  store i32 %93, ptr %12, align 4
  br label %60, !llvm.loop !10

94:                                               ; preds = %60
  store i32 0, ptr %18, align 4
  br label %95

95:                                               ; preds = %124, %94
  %96 = load i32, ptr %18, align 4
  %97 = load i32, ptr %3, align 4
  %98 = icmp slt i32 %96, %97
  br i1 %98, label %99, label %127

99:                                               ; preds = %95
  %100 = load i32, ptr %18, align 4
  %101 = mul nsw i32 2, %100
  %102 = add nsw i32 42, %101
  store i32 %102, ptr %19, align 4
  store i32 0, ptr %20, align 4
  br label %103

103:                                              ; preds = %120, %99
  %104 = load i32, ptr %20, align 4
  %105 = load i32, ptr %4, align 4
  %106 = icmp slt i32 %104, %105
  br i1 %106, label %107, label %123

107:                                              ; preds = %103
  %108 = load i32, ptr %18, align 4
  %109 = add nsw i32 %108, 1
  store i32 %109, ptr %21, align 4
  %110 = load i32, ptr %19, align 4
  store i32 %110, ptr %22, align 4
  %111 = load i32, ptr %21, align 4
  %112 = mul nsw i32 %111, 2
  store i32 %112, ptr %21, align 4
  %113 = load i32, ptr %22, align 4
  %114 = add nsw i32 %113, 4
  store i32 %114, ptr %22, align 4
  %115 = load i32, ptr %21, align 4
  %116 = load i32, ptr %22, align 4
  %117 = and i32 %115, %116
  %118 = load i32, ptr %5, align 4
  %119 = add nsw i32 %118, %117
  store i32 %119, ptr %5, align 4
  br label %120

120:                                              ; preds = %107
  %121 = load i32, ptr %20, align 4
  %122 = add nsw i32 %121, 1
  store i32 %122, ptr %20, align 4
  br label %103, !llvm.loop !11

123:                                              ; preds = %103
  br label %124

124:                                              ; preds = %123
  %125 = load i32, ptr %18, align 4
  %126 = add nsw i32 %125, 1
  store i32 %126, ptr %18, align 4
  br label %95, !llvm.loop !12

127:                                              ; preds = %95
  %128 = load i32, ptr %5, align 4
  ret i32 %128
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @bar(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  store i32 0, ptr %7, align 4
  store i32 0, ptr %8, align 4
  br label %15

15:                                               ; preds = %59, %3
  %16 = load i32, ptr %8, align 4
  %17 = load i32, ptr %4, align 4
  %18 = icmp slt i32 %16, %17
  br i1 %18, label %19, label %62

19:                                               ; preds = %15
  store i32 1, ptr %9, align 4
  br label %20

20:                                               ; preds = %55, %19
  %21 = load i32, ptr %9, align 4
  %22 = load i32, ptr %5, align 4
  %23 = icmp slt i32 %21, %22
  br i1 %23, label %24, label %58

24:                                               ; preds = %20
  %25 = load i32, ptr %8, align 4
  %26 = mul nsw i32 2, %25
  %27 = load i32, ptr %9, align 4
  %28 = add nsw i32 %26, %27
  store i32 %28, ptr %10, align 4
  %29 = load i32, ptr %9, align 4
  %30 = mul nsw i32 10, %29
  %31 = load i32, ptr %8, align 4
  %32 = sub nsw i32 %30, %31
  store i32 %32, ptr %11, align 4
  store i32 0, ptr %12, align 4
  br label %33

33:                                               ; preds = %51, %24
  %34 = load i32, ptr %12, align 4
  %35 = load i32, ptr %6, align 4
  %36 = icmp slt i32 %34, %35
  br i1 %36, label %37, label %54

37:                                               ; preds = %33
  %38 = load i32, ptr %10, align 4
  store i32 %38, ptr %13, align 4
  %39 = load i32, ptr %13, align 4
  %40 = add nsw i32 %39, 2
  store i32 %40, ptr %13, align 4
  %41 = load i32, ptr %11, align 4
  store i32 %41, ptr %14, align 4
  %42 = load i32, ptr %14, align 4
  %43 = add nsw i32 %42, -1
  store i32 %43, ptr %14, align 4
  %44 = load i32, ptr %13, align 4
  %45 = load i32, ptr %14, align 4
  %46 = xor i32 %44, %45
  %47 = load i32, ptr %12, align 4
  %48 = xor i32 %46, %47
  %49 = load i32, ptr %7, align 4
  %50 = add nsw i32 %49, %48
  store i32 %50, ptr %7, align 4
  br label %51

51:                                               ; preds = %37
  %52 = load i32, ptr %12, align 4
  %53 = add nsw i32 %52, 1
  store i32 %53, ptr %12, align 4
  br label %33, !llvm.loop !13

54:                                               ; preds = %33
  br label %55

55:                                               ; preds = %54
  %56 = load i32, ptr %9, align 4
  %57 = add nsw i32 %56, 1
  store i32 %57, ptr %9, align 4
  br label %20, !llvm.loop !14

58:                                               ; preds = %20
  br label %59

59:                                               ; preds = %58
  %60 = load i32, ptr %8, align 4
  %61 = add nsw i32 %60, 1
  store i32 %61, ptr %8, align 4
  br label %15, !llvm.loop !15

62:                                               ; preds = %15
  %63 = load i32, ptr %7, align 4
  ret i32 %63
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
