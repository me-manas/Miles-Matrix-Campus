import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matrix_campus/infrastructure/shared_ui/appbar/dashboard_app_bar.dart';
import 'package:matrix_campus/infrastructure/theme/app_colors.dart';
import 'package:matrix_campus/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:matrix_campus/modules/dashboard/presentation/widgets/nav_bar_item.dart';
import 'package:matrix_campus/modules/events/presentation/events_screen.dart';
import 'package:matrix_campus/modules/help/presentation/help_screen.dart';
import 'package:matrix_campus/modules/home/presentation/home_screen.dart';
import 'package:matrix_campus/modules/profile/presentation/profile_screen.dart';
import 'package:matrix_campus/modules/services/presentation/services_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(),
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: (value) => controller.selectTab(value),
                children: [
                  HomeScreen(),
                  HelpScreen(),
                  ServicesScreen(),
                  EventsScreen(),
                  ProfileScreen(),
                ],
              ),
            ),

            //-----NAV-BAR-----
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.extra05,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 16,
                    offset: Offset(0, 8),
                    spreadRadius: 0,
                    color: AppColors.primary06,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 32.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  textBaseline: TextBaseline.alphabetic,
                  children: List.generate(
                    5,
                    (index) => GestureDetector(
                      onTap: () {
                        controller.selectTab(index);
                      },
                      child: NavBarItem(
                        assetPath: controller.bottomAppBarItems.values
                            .elementAt(index),
                        label: controller.bottomAppBarItems.keys.elementAt(
                          index,
                        ),
                        isSelected: controller.currentIndex.value == index,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
