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
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  store i32 0, ptr %5, align 4
  store i32 0, ptr %6, align 4
  br label %20

20:                                               ; preds = %53, %2
  %21 = load i32, ptr %6, align 4
  %22 = load i32, ptr %3, align 4
  %23 = icmp slt i32 %21, %22
  br i1 %23, label %24, label %56

24:                                               ; preds = %20
  %25 = load i32, ptr %6, align 4
  %26 = mul nsw i32 3, %25
  %27 = add nsw i32 %26, 7
  store i32 %27, ptr %7, align 4
  %28 = load i32, ptr %6, align 4
  %29 = mul nsw i32 4, %28
  %30 = sub nsw i32 100, %29
  store i32 %30, ptr %8, align 4
  %31 = load i32, ptr %7, align 4
  store i32 %31, ptr %9, align 4
  %32 = load i32, ptr %8, align 4
  store i32 %32, ptr %10, align 4
  store i32 0, ptr %11, align 4
  br label %33

33:                                               ; preds = %49, %24
  %34 = load i32, ptr %11, align 4
  %35 = load i32, ptr %4, align 4
  %36 = icmp slt i32 %34, %35
  br i1 %36, label %37, label %52

37:                                               ; preds = %33
  %38 = load i32, ptr %9, align 4
  %39 = add nsw i32 %38, 2
  store i32 %39, ptr %9, align 4
  %40 = load i32, ptr %10, align 4
  %41 = add nsw i32 %40, 1
  store i32 %41, ptr %10, align 4
  %42 = load i32, ptr %9, align 4
  %43 = load i32, ptr %10, align 4
  %44 = xor i32 %42, %43
  %45 = load i32, ptr %11, align 4
  %46 = add nsw i32 %44, %45
  %47 = load i32, ptr %5, align 4
  %48 = add nsw i32 %47, %46
  store i32 %48, ptr %5, align 4
  br label %49

49:                                               ; preds = %37
  %50 = load i32, ptr %11, align 4
  %51 = add nsw i32 %50, 1
  store i32 %51, ptr %11, align 4
  br label %33, !llvm.loop !6

52:                                               ; preds = %33
  br label %53

53:                                               ; preds = %52
  %54 = load i32, ptr %6, align 4
  %55 = add nsw i32 %54, 1
  store i32 %55, ptr %6, align 4
  br label %20, !llvm.loop !8

56:                                               ; preds = %20
  store i32 0, ptr %12, align 4
  br label %57

57:                                               ; preds = %86, %56
  %58 = load i32, ptr %12, align 4
  %59 = load i32, ptr %3, align 4
  %60 = icmp slt i32 %58, %59
  br i1 %60, label %61, label %89

61:                                               ; preds = %57
  %62 = load i32, ptr %12, align 4
  %63 = mul nsw i32 5, %62
  store i32 %63, ptr %13, align 4
  %64 = load i32, ptr %12, align 4
  %65 = sub nsw i32 %64, 10
  store i32 %65, ptr %14, align 4
  store i32 0, ptr %15, align 4
  br label %66

66:                                               ; preds = %82, %61
  %67 = load i32, ptr %15, align 4
  %68 = load i32, ptr %4, align 4
  %69 = icmp slt i32 %67, %68
  br i1 %69, label %70, label %85

70:                                               ; preds = %66
  %71 = load i32, ptr %13, align 4
  %72 = add nsw i32 %71, 5
  store i32 %72, ptr %13, align 4
  %73 = load i32, ptr %14, align 4
  %74 = add nsw i32 %73, -3
  store i32 %74, ptr %14, align 4
  %75 = load i32, ptr %13, align 4
  %76 = load i32, ptr %14, align 4
  %77 = sub nsw i32 %75, %76
  %78 = load i32, ptr %15, align 4
  %79 = add nsw i32 %77, %78
  %80 = load i32, ptr %5, align 4
  %81 = add nsw i32 %80, %79
  store i32 %81, ptr %5, align 4
  br label %82

82:                                               ; preds = %70
  %83 = load i32, ptr %15, align 4
  %84 = add nsw i32 %83, 1
  store i32 %84, ptr %15, align 4
  br label %66, !llvm.loop !9

85:                                               ; preds = %66
  br label %86

86:                                               ; preds = %85
  %87 = load i32, ptr %12, align 4
  %88 = add nsw i32 %87, 1
  store i32 %88, ptr %12, align 4
  br label %57, !llvm.loop !10

89:                                               ; preds = %57
  store i32 0, ptr %16, align 4
  br label %90

90:                                               ; preds = %118, %89
  %91 = load i32, ptr %16, align 4
  %92 = load i32, ptr %3, align 4
  %93 = icmp slt i32 %91, %92
  br i1 %93, label %94, label %121

94:                                               ; preds = %90
  %95 = load i32, ptr %16, align 4
  %96 = add nsw i32 %95, 1
  store i32 %96, ptr %17, align 4
  %97 = load i32, ptr %16, align 4
  %98 = mul nsw i32 2, %97
  %99 = add nsw i32 42, %98
  store i32 %99, ptr %18, align 4
  store i32 0, ptr %19, align 4
  br label %100

100:                                              ; preds = %114, %94
  %101 = load i32, ptr %19, align 4
  %102 = load i32, ptr %4, align 4
  %103 = icmp slt i32 %101, %102
  br i1 %103, label %104, label %117

104:                                              ; preds = %100
  %105 = load i32, ptr %17, align 4
  %106 = mul nsw i32 %105, 2
  store i32 %106, ptr %17, align 4
  %107 = load i32, ptr %18, align 4
  %108 = add nsw i32 %107, 4
  store i32 %108, ptr %18, align 4
  %109 = load i32, ptr %17, align 4
  %110 = load i32, ptr %18, align 4
  %111 = and i32 %109, %110
  %112 = load i32, ptr %5, align 4
  %113 = add nsw i32 %112, %111
  store i32 %113, ptr %5, align 4
  br label %114

114:                                              ; preds = %104
  %115 = load i32, ptr %19, align 4
  %116 = add nsw i32 %115, 1
  store i32 %116, ptr %19, align 4
  br label %100, !llvm.loop !11

117:                                              ; preds = %100
  br label %118

118:                                              ; preds = %117
  %119 = load i32, ptr %16, align 4
  %120 = add nsw i32 %119, 1
  store i32 %120, ptr %16, align 4
  br label %90, !llvm.loop !12

121:                                              ; preds = %90
  %122 = load i32, ptr %5, align 4
  ret i32 %122
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
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  store i32 0, ptr %7, align 4
  store i32 0, ptr %8, align 4
  br label %13

13:                                               ; preds = %55, %3
  %14 = load i32, ptr %8, align 4
  %15 = load i32, ptr %4, align 4
  %16 = icmp slt i32 %14, %15
  br i1 %16, label %17, label %58

17:                                               ; preds = %13
  store i32 1, ptr %9, align 4
  br label %18

18:                                               ; preds = %51, %17
  %19 = load i32, ptr %9, align 4
  %20 = load i32, ptr %5, align 4
  %21 = icmp slt i32 %19, %20
  br i1 %21, label %22, label %54

22:                                               ; preds = %18
  %23 = load i32, ptr %8, align 4
  %24 = mul nsw i32 2, %23
  %25 = load i32, ptr %9, align 4
  %26 = add nsw i32 %24, %25
  store i32 %26, ptr %10, align 4
  %27 = load i32, ptr %9, align 4
  %28 = mul nsw i32 10, %27
  %29 = load i32, ptr %8, align 4
  %30 = sub nsw i32 %28, %29
  store i32 %30, ptr %11, align 4
  store i32 0, ptr %12, align 4
  br label %31

31:                                               ; preds = %47, %22
  %32 = load i32, ptr %12, align 4
  %33 = load i32, ptr %6, align 4
  %34 = icmp slt i32 %32, %33
  br i1 %34, label %35, label %50

35:                                               ; preds = %31
  %36 = load i32, ptr %10, align 4
  %37 = add nsw i32 %36, 2
  store i32 %37, ptr %10, align 4
  %38 = load i32, ptr %11, align 4
  %39 = add nsw i32 %38, -1
  store i32 %39, ptr %11, align 4
  %40 = load i32, ptr %10, align 4
  %41 = load i32, ptr %11, align 4
  %42 = xor i32 %40, %41
  %43 = load i32, ptr %12, align 4
  %44 = xor i32 %42, %43
  %45 = load i32, ptr %7, align 4
  %46 = add nsw i32 %45, %44
  store i32 %46, ptr %7, align 4
  br label %47

47:                                               ; preds = %35
  %48 = load i32, ptr %12, align 4
  %49 = add nsw i32 %48, 1
  store i32 %49, ptr %12, align 4
  br label %31, !llvm.loop !13

50:                                               ; preds = %31
  br label %51

51:                                               ; preds = %50
  %52 = load i32, ptr %9, align 4
  %53 = add nsw i32 %52, 1
  store i32 %53, ptr %9, align 4
  br label %18, !llvm.loop !14

54:                                               ; preds = %18
  br label %55

55:                                               ; preds = %54
  %56 = load i32, ptr %8, align 4
  %57 = add nsw i32 %56, 1
  store i32 %57, ptr %8, align 4
  br label %13, !llvm.loop !15

58:                                               ; preds = %13
  %59 = load i32, ptr %7, align 4
  ret i32 %59
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
