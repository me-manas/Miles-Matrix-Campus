import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matrix_campus/infrastructure/shared_ui/bottomsheet/custom_dropdown_items_bottomsheet.dart';
import 'package:matrix_campus/infrastructure/shared_ui/button/custom_button.dart';
import 'package:matrix_campus/infrastructure/shared_ui/dropdown/custom_dropdown.dart';
import 'package:matrix_campus/infrastructure/shared_ui/textfield/custom_textfield_with_label.dart';
import 'package:matrix_campus/infrastructure/theme/app_colors.dart';
import 'package:matrix_campus/infrastructure/theme/app_text_styles.dart';
import 'package:matrix_campus/infrastructure/utils/constants/string_constants.dart';
import 'package:matrix_campus/infrastructure/utils/extensions/string_extensions.dart';
import 'package:matrix_campus/infrastructure/utils/helpers/dev_logger.dart';
import 'package:matrix_campus/modules/onboarding/domain/onboarding_controller.dart';

class OnboardingStage1 extends StatelessWidget {
  OnboardingStage1({super.key});

  final _controller = Get.find<OnboardingController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomTextfieldWithLabel(
          controller: _controller.nameController,
          isRequired: true,
          labelText: StringConstants.name,
          hintText: StringConstants.typeHere,
          showRequiredWithHint: true,
          hintStyle: AppTextStyles.body4Regular12(color: AppColors.text03),
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
          ],
        ),
        20.verticalSpace,

        CustomTextfieldWithLabel(
          controller: _controller.emailController,
          hintText: StringConstants.typeHere,
          isRequired: true,
          labelText: StringConstants.email.toPascalCase(),
          hintStyle: AppTextStyles.body4Regular12(color: AppColors.text03),
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.emailAddress,
        ),
        20.verticalSpace,

        Obx(() {
          return CustomDropdown(
            label: _controller.selectedGender ?? StringConstants.gender,
            isRequired: _controller.selectedGender == null,
            labelStyle:
                _controller.selectedGender != null
                    ? AppTextStyles.body3Regular14(color: AppColors.text01)
                    : null,
            onTap: () {
              Get.bottomSheet(
                CustomDropdownItemsBottomsheet(
                  label: 'Select your gender',
                  height: 240.h,
                  onSelectItem: (selectedItem) {
                    devLogger(
                      message: 'Selected Item: ${selectedItem.toString()}',
                    );
                    _controller.selectGender(selectedItem.title);
                    Get.back();
                  },
                  items: [
                    BottomSheetItemModel(title: 'Male'),
                    BottomSheetItemModel(title: 'Female'),
                  ],
                ),
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                isScrollControlled: true,
              );
            },
          );
        }),
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
            StringConstants.keepGoing,
            style: AppTextStyles.body3Bold14(color: AppColors.text06),
          ),
        ),
      ],
    );
  }
}
