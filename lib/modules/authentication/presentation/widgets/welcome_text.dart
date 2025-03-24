import 'package:flutter/material.dart';
import 'package:matrix_campus/infrastructure/theme/app_colors.dart';
import 'package:matrix_campus/infrastructure/theme/app_text_styles.dart';
import 'package:matrix_campus/infrastructure/utils/constants/string_constants.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          StringConstants.welcome.toUpperCase(),
          style: AppTextStyles.heading1ExtraBold42(
            color: AppColors.text01,
            shadows: [
              Shadow(
                color: AppColors.secondary02,
                blurRadius: 60.0,
                offset: Offset(0, 0),
              ),
              Shadow(
                color: AppColors.secondary02,
                blurRadius: 80.0,
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),
        ShaderMask(
          shaderCallback:
              (bounds) => LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.secondary02,
                  AppColors.secondary03,
                  AppColors.primary06,
                ],
              ).createShader(bounds),
          child: Text(
            StringConstants.toMatrixCampus,
            style: AppTextStyles.heading2SemiBoldItalic28(
              color: AppColors.text01,
            ),
          ),
        ),
      ],
    );
  }
}
