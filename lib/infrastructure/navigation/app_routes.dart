import 'package:get/get.dart';
import 'package:matrix_campus/modules/authentication/presentation/authentication_screen.dart';
import 'package:matrix_campus/modules/authentication/presentation/otp_verification_screen.dart';
import 'package:matrix_campus/modules/onboarding/presentation/onboarding_screen.dart';
import 'package:matrix_campus/modules/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';

class AppRoutes {
  AppRoutes._();

  static List<GetPage> routes = [
    GetPage(
      name: Routes.dashboard,
      page: () => Dashboard(),
      binding: DashboardControllerBinding(),
    ),
    GetPage(
      name: Routes.authentication,
      page: () => AuthenticationScreen(),
      binding: AuthenticationControllerBinding(),
    ),
    GetPage(
      name: Routes.otpVerification,
      page: () => OtpVerificationScreen(),
      binding: AuthenticationControllerBinding(),
    ),
    GetPage(
      name: Routes.onboarding,
      page: () => OnboardingScreen(),
      binding: OnboardingControllerBinding(),
    ),
  ];
}
