import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matrix_campus/infrastructure/shared_ui/appbar/dashboard_app_bar.dart';
import 'package:matrix_campus/infrastructure/shared_ui/button/custom_button.dart';
import 'package:matrix_campus/infrastructure/shared_ui/textfield/gradient_border_pin_field.dart';
import 'package:matrix_campus/infrastructure/theme/app_colors.dart';
import 'package:matrix_campus/infrastructure/theme/app_text_styles.dart';
import 'package:matrix_campus/infrastructure/utils/constants/assets/assets_path.dart';
import 'package:matrix_campus/infrastructure/utils/constants/string_constants.dart';
import 'package:matrix_campus/infrastructure/utils/enums/app_enums.dart';
import 'package:matrix_campus/infrastructure/utils/helpers/image_loader.dart';
import 'package:matrix_campus/modules/authentication/domain/authentication_controller.dart';
import 'package:matrix_campus/modules/authentication/presentation/widgets/welcome_text.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late AuthenticationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<AuthenticationController>();
    _controller.startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(hideActions: true, hideLeading: true),
      body: Stack(
        alignment: Alignment.center,
        children: [
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                WelcomeText(),
                44.verticalSpace,

                Text(
                  '${StringConstants.enterTheCode} ${(_controller.loginType.value == LoginType.email) ? StringConstants.email : StringConstants.sms}',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body3Regular14(color: AppColors.text01),
                ),
                Text(
                  _controller.loginType.value == LoginType.mobile
                      ? '+91 ${_controller.textEditingController.text}'
                      : _controller.textEditingController.text,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body3Regular14(color: AppColors.text01),
                ),
                44.verticalSpace,

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: GradientBorderPinField(),
                ),
                50.verticalSpace,

                Obx(() {
                  return CustomButton(
                    width: double.infinity,
                    verticalPadding: 9,
                    wantBorder: false,
                    borderRadius: 24,
                    onPressed: () {
                      _controller.verifyOTP();
                    },
                    child: Text(
                      _controller.loginType.value == LoginType.email
                          ? StringConstants.verifyEmail
                          : StringConstants.verifyNumber,
                      style: AppTextStyles.body3Bold14(color: AppColors.text06),
                    ),
                  );
                }),
                24.verticalSpace,

                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${StringConstants.didntReceiveOTP} ',
                        style: AppTextStyles.body3SemiBoldItalic14(
                          color: AppColors.text01,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_controller.resendTime.value == 0) {
                            _controller.resendOTP();
                          }
                        },
                        child: Text(
                          StringConstants.resend,
                          style: AppTextStyles.body3SemiBoldItalic14(
                            color: AppColors.primary06,
                          ),
                        ),
                      ),
                      if (_controller.resendTime.value != 0) ...[
                        Text(
                          ' in 0:',
                          style: AppTextStyles.body3SemiBoldItalic14(
                            color: AppColors.primary06,
                          ),
                        ),
                        Text(
                          _controller.resendTime.value.toString(),
                          style: AppTextStyles.body3SemiBoldItalic14(
                            color: AppColors.primary06,
                          ),
                        ),
                        Text(
                          'sec',
                          style: AppTextStyles.body3SemiBoldItalic14(
                            color: AppColors.primary06,
                          ),
                        ),
                      ],
                    ],
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
