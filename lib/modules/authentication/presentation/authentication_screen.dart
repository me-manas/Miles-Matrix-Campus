import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matrix_campus/infrastructure/shared_ui/appbar/dashboard_app_bar.dart';
import 'package:matrix_campus/infrastructure/shared_ui/button/custom_button.dart';
import 'package:matrix_campus/infrastructure/shared_ui/textfield/custom_textfield_with_label.dart';
import 'package:matrix_campus/infrastructure/theme/app_colors.dart';
import 'package:matrix_campus/infrastructure/theme/app_text_styles.dart';
import 'package:matrix_campus/infrastructure/utils/constants/assets/assets_path.dart';
import 'package:matrix_campus/infrastructure/utils/constants/string_constants.dart';
import 'package:matrix_campus/infrastructure/utils/enums/app_enums.dart';
import 'package:matrix_campus/infrastructure/utils/helpers/image_loader.dart';
import 'package:matrix_campus/modules/authentication/domain/authentication_controller.dart';
import 'package:matrix_campus/modules/authentication/presentation/widgets/country_picker.dart';
import 'package:matrix_campus/modules/authentication/presentation/widgets/welcome_text.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  late AuthenticationController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<AuthenticationController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(hideActions: true, hideLeading: true),
      body: Stack(
        children: [
          //-------Bg-Image------
          ImageLoader.asset(
            AssetsPath.png.authBackground,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WelcomeText(),
                44.verticalSpace,

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48.w),
                  child: Obx(() {
                    return Text(
                      controller.loginType.value == LoginType.email
                          ? StringConstants.emailToContinue
                          : StringConstants.mobileToContinue,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body3Regular14(
                        color: AppColors.text01,
                      ),
                    );
                  }),
                ),
                44.verticalSpace,

                Obx(() {
                  final bool isEmail =
                      controller.loginType.value == LoginType.email;
                  return AnimatedBuilder(
                    animation: controller.animation,
                    builder: (context, child) {
                      double countryPickerWidth =
                          MediaQuery.sizeOf(context).width * 0.234;
                      return Row(
                        children: [
                          if (!isEmail || controller.animation.value < 1) ...[
                            if (!isEmail)
                              AnimatedContainer(
                                duration:
                                    Duration.zero, // Managed by AnimatedBuilder
                                width: countryPickerWidth,
                                height: 37.h,
                                child: CountryPicker(),
                              ),
                            AnimatedContainer(
                              duration:
                                  Duration.zero, // Managed by AnimatedBuilder
                              width:
                                  !isEmail
                                      ? 8.w
                                      : 24.w * (1 - controller.animation.value),
                            ),
                          ],
                          Expanded(
                            child: CustomTextfieldWithLabel(
                              controller: controller.textEditingController,
                              hintText:
                                  isEmail
                                      ? StringConstants.emailAddress
                                      : StringConstants.phoneNumber,
                              hintStyle: AppTextStyles.body4Regular12(
                                color: AppColors.text03,
                              ),
                              textInputAction: TextInputAction.done,
                              textInputType:
                                  isEmail
                                      ? TextInputType.emailAddress
                                      : TextInputType.phone,
                              inputFormatters:
                                  isEmail
                                      ? null
                                      : [
                                        LengthLimitingTextInputFormatter(10),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                            ),
                          ),
                        ],
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
                    controller.getOTP();
                  },
                  child: Text(
                    StringConstants.getOTP,
                    style: AppTextStyles.body3Bold14(color: AppColors.text06),
                  ),
                ),
                24.verticalSpace,

                Obx(() {
                  return GestureDetector(
                    onTap: () {
                      controller.updateLoginType();
                    },
                    child: Text(
                      controller.loginType.value == LoginType.email
                          ? StringConstants.usePhoneInstead
                          : StringConstants.useEmailInstead,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body3SemiBoldItalic14(
                        color: AppColors.text01,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
