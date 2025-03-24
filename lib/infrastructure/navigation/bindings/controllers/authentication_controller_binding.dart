import 'package:get/get.dart';
import 'package:matrix_campus/modules/authentication/domain/authentication_controller.dart';

class AuthenticationControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthenticationController>(() => AuthenticationController());
  }
}
