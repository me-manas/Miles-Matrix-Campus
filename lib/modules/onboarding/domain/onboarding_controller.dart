import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrix_campus/infrastructure/navigation/routes.dart';
import 'package:matrix_campus/infrastructure/utils/enums/app_enums.dart';
import 'package:matrix_campus/infrastructure/utils/helpers/dev_logger.dart';

class OnboardingController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final RxInt _currentIndex = 0.obs;
  final Rx<String?> _selectedGender = Rx<String?>(null);
  final Rx<String?> _selectedUniversity = Rx<String?>(null);
  final Rx<String?> _selectedCampus = Rx<String?>(null);
  final Rx<UniversityEnrollmentType> _universityEnrollmentType =
      UniversityEnrollmentType.enrolled.obs;

  // Getters
  PageController get pageController => _pageController;
  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;

  int get currentIndex => _currentIndex.value;
  String? get selectedGender => _selectedGender.value;
  String? get selectedUniversity => _selectedUniversity.value;
  String? get selectedCampus => _selectedCampus.value;
  UniversityEnrollmentType get universityEnrollmentType =>
      _universityEnrollmentType.value;

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
    if (_currentIndex.value == 1) {
      if (checkStage2Details()) {
        Get.offAllNamed(Routes.dashboard);
      } else {
        Utils.showToast(message: 'Please provide all the details!');
      }
    } else {
      if (checkStage1Details()) {
        _currentIndex.value = _currentIndex.value + 1;
        pageController.jumpToPage(_currentIndex.value);
      } else {
        Utils.showToast(message: 'Please provide all the details!');
      }
    }
  }

  void changeEnrollmentType(UniversityEnrollmentType enrollmentType) {
    if (enrollmentType != _universityEnrollmentType.value) {
      _universityEnrollmentType.value = enrollmentType;
      _animate();
    }
  }

  void selectGender(String gender) {
    if (gender != _selectedGender.value) {
      _selectedGender.value = gender;
    }
  }

  void selectUniversity(String university) {
    if (university != _selectedUniversity.value) {
      _selectedUniversity.value = university;
    }
  }

  void selectCampus(String campus) {
    if (campus != _selectedCampus.value) {
      _selectedCampus.value = campus;
    }
  }

  bool checkStage1Details() {
    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _selectedGender.value != null) {
      return true;
    }
    return false;
  }

  bool checkStage2Details() {
    if (_selectedUniversity.value != null && _selectedCampus.value != null) {
      return true;
    }
    return false;
  }
}
