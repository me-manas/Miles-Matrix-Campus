import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix_campus/infrastructure/theme/app_colors.dart';

class CustomOtpField extends StatelessWidget {
  const CustomOtpField({super.key});

  @override
  Widget build(BuildContext context) {
    return // Create a custom TextField with gradient border
    TextField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(4),
        FilteringTextInputFormatter.digitsOnly,
      ],
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        // Remove default borders
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(24.r),
        ),
        // Container with gradient border
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.extra07),
          borderRadius: BorderRadius.circular(24.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(24.r),
        ),
        // Use a prefix or suffix icon that's actually a container with gradient
        prefixIcon: Container(
          width: 58.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            gradient: LinearGradient(
              begin: Alignment(-1.0, -0.5),
              end: Alignment(1.0, 0.8),
              colors: [
                AppColors.secondary02,
                AppColors.secondary03,
                AppColors.primary06,
              ],
              stops: [0.0, 0.65, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}
