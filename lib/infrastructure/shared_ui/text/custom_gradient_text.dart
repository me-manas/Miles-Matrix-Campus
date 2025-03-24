import 'package:flutter/material.dart';
import 'package:matrix_campus/infrastructure/theme/app_colors.dart';
import 'package:matrix_campus/infrastructure/theme/app_text_styles.dart';

class CustomGradientText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Gradient? gradient;
  const CustomGradientText({
    required this.text,
    this.gradient,
    this.textStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback:
          (bounds) => (gradient ??
                  LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.secondary02,
                      AppColors.secondary03,
                      AppColors.primary06,
                    ],
                  ))
              .createShader(bounds),
      child: Text(
        text,
        style:
            textStyle ??
            AppTextStyles.heading2SemiBoldItalic28(color: AppColors.text01),
      ),
    );
  }
}
