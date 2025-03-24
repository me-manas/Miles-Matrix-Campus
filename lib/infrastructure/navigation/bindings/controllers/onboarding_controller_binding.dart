import 'package:get/get.dart';
import 'package:matrix_campus/modules/onboarding/domain/onboarding_controller.dart';

class OnboardingControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(() => OnboardingController());
  }
}
