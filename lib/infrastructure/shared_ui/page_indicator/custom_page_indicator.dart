import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix_campus/infrastructure/theme/app_colors.dart';

class CustomPageIndicator extends StatelessWidget {
  final int totalIndicators;
  final int currentIndex;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? activeColor;
  final Color? disabledColor;
  const CustomPageIndicator({
    required this.currentIndex,
    this.totalIndicators = 2,
    this.height,
    this.width,
    this.borderRadius,
    this.activeColor,
    this.disabledColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(totalIndicators, (index) {
          return Container(
            height: height ?? 2.h,
            width: width ?? 32.w,
            margin:
                index < totalIndicators
                    ? EdgeInsets.only(right: 8.w)
                    : EdgeInsets.zero,
            decoration: BoxDecoration(
              color:
                  index == currentIndex
                      ? activeColor ?? AppColors.text01
                      : disabledColor ?? AppColors.text04,
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius ?? 8.r),
              ),
            ),
          );
        }),
      ],
    );
    // return ListView.separated(
    //   shrinkWrap: true,
    //   itemBuilder: (context, index) {
    //     return Container(
    //       height: height ?? 2.h,
    //       width: width ?? 2,
    //       decoration: BoxDecoration(
    //         color:
    //             index == currentIndex
    //                 ? activeColor ?? AppColors.text01
    //                 : disabledColor ?? AppColors.text04,
    //         borderRadius: BorderRadius.all(
    //           Radius.circular(borderRadius ?? 8.r),
    //         ),
    //       ),
    //     );
    //   },
    //   separatorBuilder: (context, index) {
    //     return 8.horizontalSpace;
    //   },
    //   itemCount: totalIndicators,
    // );
  }
}
