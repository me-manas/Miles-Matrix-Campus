import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matrix_campus/infrastructure/shared_ui/button/custom_button.dart';
import 'package:matrix_campus/infrastructure/theme/app_colors.dart';
import 'package:matrix_campus/infrastructure/theme/app_text_styles.dart';
import 'package:matrix_campus/infrastructure/utils/constants/assets/assets_path.dart';
import 'package:matrix_campus/infrastructure/utils/constants/string_constants.dart';
import 'package:matrix_campus/infrastructure/utils/helpers/image_loader.dart';

class SuccessBottomsheet extends StatelessWidget {
  const SuccessBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: ImageLoader.assetSvg(AssetsPath.svg.cancel),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ImageLoader.asset(
              AssetsPath.png.success,
              height: 202,
              width: 202,
              fit: BoxFit.scaleDown,
            ),
          ),
          6.verticalSpace,
          Text(
            StringConstants.thankYou,
            style: AppTextStyles.body2Bold16(color: AppColors.text01),
          ),
          Text(
            StringConstants.concernRaised,
            textAlign: TextAlign.center,
            style: AppTextStyles.body2Regular16(color: AppColors.text01),
          ),
          24.verticalSpace,
          CustomButton(
            width: 156,
            disableElevation: true,
            wantBorder: false,
            borderRadius: 24,
            child: Text(
              StringConstants.done,
              style: AppTextStyles.body3Bold14(color: AppColors.primary01),
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
