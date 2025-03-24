// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrix_campus/infrastructure/utils/constants/assets/assets_path.dart';

class DashboardController extends GetxController {
  RxInt currentIndex = 0.obs;

  final PageController pageController = PageController();

  final Map<String, String> bottomAppBarItems = {
    'Home': AssetsPath.svg.homeIcon,
    'Help': AssetsPath.svg.helpIcon,
    'Services': AssetsPath.svg.servicesIcon,
    'Events': AssetsPath.svg.eventsIcon,
    'Profile': AssetsPath.svg.profileIcon,
  };

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void selectTab(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }
}
