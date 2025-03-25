import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix_campus/infrastructure/theme/app_colors.dart';
import 'package:matrix_campus/infrastructure/theme/app_text_styles.dart';

class CustomDropdown extends StatelessWidget {
  final double? height;
  final double? width;
  final String label;
  final bool isRequired;
  final double? borderRadius;
  final Widget? dropdownIcon;
  final Color? borderColor;
  final VoidCallback onTap;
  final TextStyle? labelStyle;
  const CustomDropdown({
    required this.label,
    required this.onTap,
    this.height,
    this.width,
    this.isRequired = true,
    this.dropdownIcon,
    this.borderRadius,
    this.borderColor,
    this.labelStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 36.h,
        width: width ?? double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.5.h),
        decoration: BoxDecoration(
          color: AppColors.extra08,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 24.r)),
          border: Border.all(color: borderColor ?? AppColors.extra07),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style:
                  labelStyle ??
                  AppTextStyles.body4Regular12(color: AppColors.text03),
            ),
            if (isRequired)
              Text(
                '*',
                style: AppTextStyles.body4Regular12(color: AppColors.extra04),
              ),
            const Spacer(),
            dropdownIcon ??
                Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.text03.withOpacity(0.6),
                  size: 28,
                ),
          ],
        ),
      ),
    );
  }
}
