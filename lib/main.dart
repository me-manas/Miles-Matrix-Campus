import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:matrix_campus/infrastructure/theme/app_colors.dart';
import 'infrastructure/navigation/app_routes.dart';
import 'infrastructure/navigation/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //-----sets up device orientations
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //-----sets up status bar orientation
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // transparent status bar
    ),
  );
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return OrientationBuilder(
              builder: (context, orientation) {
                // ScreenUtil.init(constraints, orientation);
                return GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  initialRoute: Routes.onboarding,
                  getPages: AppRoutes.routes,
                  theme: ThemeData(
                    scaffoldBackgroundColor: AppColors.primary01,
                    appBarTheme: AppBarTheme(
                      backgroundColor: AppColors.extra05,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

//-----used for setting logs
var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 10,
    colors: true,
    printEmojis: true,
  ),
);
