import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matrix_campus/infrastructure/shared_ui/button/custom_button.dart';
import 'package:matrix_campus/infrastructure/shared_ui/chip/custom_chip.dart';
import 'package:matrix_campus/infrastructure/shared_ui/dropdown/custom_dropdown.dart';
import 'package:matrix_campus/infrastructure/theme/app_colors.dart';
import 'package:matrix_campus/infrastructure/theme/app_text_styles.dart';
import 'package:matrix_campus/infrastructure/utils/constants/string_constants.dart';
import 'package:matrix_campus/infrastructure/utils/enums/app_enums.dart';
import 'package:matrix_campus/modules/onboarding/domain/onboarding_controller.dart';

class OnboardingStage2 extends StatelessWidget {
  OnboardingStage2({super.key});

  final _controller = Get.find<OnboardingController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          StringConstants.partOfUniversitySquad,
          style: AppTextStyles.body3Regular14(color: AppColors.text01),
        ),
        24.verticalSpace,

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child: Obx(() {
            final bool isEnrolled =
                _controller.universityEnrollmentType.value ==
                UniversityEnrollmentType.enrolled;
            return Row(
              children: [
                Expanded(
                  child: SlideTransition(
                    position: _controller.offsetAnimation[0],
                    child: CustomChip(
                      text:
                          isEnrolled
                              ? StringConstants.enrolled
                              : StringConstants.yetToEnroll,
                      backgroundColor: AppColors.extra06,
                      isSelected: isEnrolled,
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: SlideTransition(
                    position: _controller.offsetAnimation[1],
                    child: CustomChip(
                      text:
                          isEnrolled
                              ? StringConstants.yetToEnroll
                              : StringConstants.enrolled,
                      backgroundColor: AppColors.primary01,
                      isSelected: !isEnrolled,
                      borderColor: AppColors.transparent,
                      blurRadius: 2,
                      spreadRadius: 1,
                      onTap: () {
                        _controller.changeEnrollmentType(
                          !isEnrolled
                              ? UniversityEnrollmentType.enrolled
                              : UniversityEnrollmentType.yetToEnroll,
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
        24.verticalSpace,

        Obx(() {
          return _controller.universityEnrollmentType.value ==
                  UniversityEnrollmentType.yetToEnroll
              ? Padding(
                padding: EdgeInsets.only(bottom: 24.h),
                child: Text(
                  StringConstants.whichUniversity,
                  style: AppTextStyles.body3Regular14(color: AppColors.text01),
                ),
              )
              : const SizedBox.shrink();
        }),

        CustomDropdown(label: StringConstants.selectUniversity, onTap: () {}),
        24.verticalSpace,

        CustomDropdown(label: StringConstants.selectCampus, onTap: () {}),
        48.verticalSpace,

        CustomButton(
          width: double.infinity,
          verticalPadding: 8.h,
          wantBorder: false,
          borderRadius: 24.r,
          onPressed: () {
            _controller.proceedToNextStep();
          },
          child: Text(
            StringConstants.stepIntoTheMatrix,
            style: AppTextStyles.body3Bold14(color: AppColors.text06),
          ),
        ),
      ],
    );
  }
}
