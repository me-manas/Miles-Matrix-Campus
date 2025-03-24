import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matrix_campus/infrastructure/shared_ui/appbar/dashboard_app_bar.dart';
import 'package:matrix_campus/infrastructure/shared_ui/page_indicator/custom_page_indicator.dart';
import 'package:matrix_campus/infrastructure/shared_ui/text/custom_gradient_text.dart';
import 'package:matrix_campus/infrastructure/theme/app_colors.dart';
import 'package:matrix_campus/infrastructure/theme/app_text_styles.dart';
import 'package:matrix_campus/infrastructure/utils/constants/assets/assets_path.dart';
import 'package:matrix_campus/infrastructure/utils/constants/string_constants.dart';
import 'package:matrix_campus/infrastructure/utils/helpers/image_loader.dart';
import 'package:matrix_campus/modules/onboarding/domain/onboarding_controller.dart';
import 'package:matrix_campus/modules/onboarding/presentation/widgets/onboarding_stage_1.dart';
import 'package:matrix_campus/modules/onboarding/presentation/widgets/onboarding_stage_2.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late OnboardingController _controller;
  final _onboardingStages = [OnboardingStage1(), OnboardingStage2()];

  @override
  void initState() {
    super.initState();
    _controller = Get.find<OnboardingController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(hideLeading: true, hideActions: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.23,
                width: double.infinity,
                child: ImageLoader.asset(AssetsPath.gif.onboardingBackground),
              ),
              Positioned(
                bottom: 52.h,
                left: 16.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${StringConstants.hey} ',
                          style: AppTextStyles.heading1Bold24(
                            color: AppColors.text01,
                          ),
                        ),
                        CustomGradientText(
                          text: '${StringConstants.matrixian},',
                          textStyle: AppTextStyles.heading1BoldItalic24(
                            color: AppColors.text01,
                          ),
                        ),
                      ],
                    ),
                    8.verticalSpace,
                    Obx(() {
                      return Text(
                        _controller.currentIndex.value == 1
                            ? StringConstants.collegeJourneyProgress
                            : StringConstants.timeToIntroduce,
                        textAlign: TextAlign.left,
                        style: AppTextStyles.body3Regular14(
                          color: AppColors.text01,
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 20.w,
                top: 18.h,
                child: ImageLoader.asset(AssetsPath.png.onboardingDoodle),
              ),
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary01,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.r),
                  topRight: Radius.circular(32.r),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.2, 1.0],
                  colors: [
                    AppColors.secondary02.withOpacity(0.1),
                    AppColors.secondary03.withOpacity(0.15),
                    AppColors.primary06.withOpacity(0.1),
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _controller.pageController,
                        children: _onboardingStages,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: 0.h),
                      child: Obx(() {
                        return CustomPageIndicator(
                          currentIndex: _controller.currentIndex.value,
                        );
                      }),
                    ),
                    40.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
