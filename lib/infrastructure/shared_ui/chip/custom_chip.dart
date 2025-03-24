import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix_campus/infrastructure/theme/app_colors.dart';
import 'package:matrix_campus/infrastructure/theme/app_text_styles.dart';

class CustomChip extends StatelessWidget {
  final String text;
  final bool isTappable;
  final double borderRadius;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final Color backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final double height;
  final VoidCallback? onTap;
  final bool isSelected;
  final bool showGlow;
  final Color? glowColor;
  final double blurRadius;
  final double spreadRadius;

  const CustomChip({
    super.key,
    required this.backgroundColor,
    required this.text,
    this.isTappable = false,
    this.borderRadius = 16,
    this.leftIcon,
    this.rightIcon,
    this.borderColor,
    this.textColor = Colors.white,
    this.height = 20,
    this.onTap,
    this.isSelected = false,
    this.showGlow = true,
    this.glowColor,
    this.blurRadius = 8,
    this.spreadRadius = 1,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: height,
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor ?? AppColors.secondary04,
            width: 1,
          ),
          boxShadow:
              showGlow
                  ? [
                    BoxShadow(
                      color: (glowColor ?? AppColors.secondary04).withOpacity(
                        0.4,
                      ),
                      blurRadius: blurRadius,
                      spreadRadius: spreadRadius,
                    ),
                  ]
                  : null,
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              leftIcon ?? const SizedBox.shrink(),
              Text(
                text,
                style: AppTextStyles.body4Regular12(color: AppColors.text01),
              ),
              rightIcon ?? const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
