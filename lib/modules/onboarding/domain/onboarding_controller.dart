import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrix_campus/infrastructure/navigation/routes.dart';
import 'package:matrix_campus/infrastructure/utils/enums/app_enums.dart';
import 'package:matrix_campus/infrastructure/utils/helpers/dev_logger.dart';

class OnboardingController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final PageController pageController = PageController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final RxInt currentIndex = 0.obs;
  final Rx<UniversityEnrollmentType> universityEnrollmentType =
      UniversityEnrollmentType.enrolled.obs;

  //---------Animation-related
  late AnimationController _animationController;
  late List<Animation<Offset>> offsetAnimation;

  @override
  void onInit() {
    super.onInit();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    offsetAnimation = List.generate(
      2,
      (index) => Tween<Offset>(
        begin: const Offset(0.0, 0.0),
        end: Offset(index == 0 ? 1.1 : -1.1, 0.0),
      ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void onClose() {
    _animationController.dispose();
    nameController.dispose();
    emailController.dispose();
    pageController.dispose();
  }

  void _animate() {
    _animationController.status == AnimationStatus.completed
        ? _animationController.reverse()
        : _animationController.forward();
  }

  void proceedToNextStep() {
    if (currentIndex.value == 1) {
      Get.offAllNamed(Routes.dashboard);
    } else {
      if (checkStage1Details()) {
        currentIndex.value = currentIndex.value + 1;
        pageController.jumpToPage(currentIndex.value);
      } else {
        Utils.showToast(message: 'Please provide a valid name and email!');
      }
    }
  }

  void changeEnrollmentType(UniversityEnrollmentType enrollmentType) {
    if (enrollmentType != universityEnrollmentType.value) {
      universityEnrollmentType.value = enrollmentType;
      _animate();
    }
  }

  bool checkStage1Details() {
    if (nameController.text.isNotEmpty && emailController.text.isNotEmpty) {
      return true;
    }
    return false;
  }
}
