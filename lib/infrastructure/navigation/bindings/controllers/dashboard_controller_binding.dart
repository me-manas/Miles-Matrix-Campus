import 'package:get/get.dart';
import 'package:matrix_campus/modules/dashboard/controllers/dashboard_controller.dart';

class DashboardControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
