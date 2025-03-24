import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrix_campus/infrastructure/navigation/routes.dart';
import 'package:matrix_campus/infrastructure/utils/enums/app_enums.dart';
import 'package:matrix_campus/infrastructure/utils/helpers/dev_logger.dart';

class AuthenticationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final loginType = LoginType.mobile.obs;
  RxInt resendTime = 60.obs;
  final TextEditingController _textEditingController = TextEditingController();

  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (resendTime.value >= 1) {
        resendTime.value = resendTime.value - 1;
      } else {
        timer.cancel();
      }
    });
  }

  void updateLoginType() {
    if (loginType.value == LoginType.mobile) {
      loginType.value = LoginType.email;
      animationController.forward();
    } else {
      loginType.value = LoginType.mobile;
      animationController.reverse();
    }
    _textEditingController.clear();
  }

  @override
  void onClose() {
    animationController.dispose();
    textEditingController.dispose();
    super.onClose();
  }

  // Getter
  TextEditingController get textEditingController => _textEditingController;

  void getOTP() {
    if (_textEditingController.text.isNotEmpty) {
      Get.toNamed(Routes.otpVerification);
    } else {
      Utils.showToast(message: 'Please fill all the fields');
    }
  }

  void resendOTP() {
    resendTime.value = 60;
    startTimer();
  }

  void verifyOTP() {
    Get.offAllNamed(Routes.onboarding);
  }
}
