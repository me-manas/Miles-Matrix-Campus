import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix_campus/infrastructure/theme/app_colors.dart';
import 'package:matrix_campus/infrastructure/theme/app_text_styles.dart';
import 'package:matrix_campus/infrastructure/utils/helpers/image_loader.dart';

class NavBarItem extends StatelessWidget {
  final String assetPath;
  final String label;
  final bool isSelected;
  const NavBarItem({
    required this.assetPath,
    required this.label,
    this.isSelected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.transparent,
            BlendMode.saturation,
          ),
          child: ImageLoader.assetSvg(assetPath, grayscale: !isSelected),
        ),
        10.verticalSpace,
        Text(
          label,
          style:
              isSelected
                  ? AppTextStyles.body4Bold12(color: AppColors.primary06)
                  : AppTextStyles.body4Regular12(color: AppColors.text05),
        ),
      ],
    );
  }
}
