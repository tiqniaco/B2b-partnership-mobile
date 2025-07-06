import 'package:b2b_partenership/controller/home/home_controller.dart';
import 'package:b2b_partenership/controller/settings/setting_controller.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/views/home/home_view.dart';
import 'package:b2b_partenership/views/jobs/all_jobs_view.dart';
import 'package:b2b_partenership/views/posts/get_all_posts.dart';
import 'package:b2b_partenership/views/settings/provider/provider_setting_view.dart';

import 'package:b2b_partenership/views/settings/settings_view.dart';
import 'package:b2b_partenership/views/shop/shop_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeLayoutController extends GetxController {
  late TabController convexController;

  // HomeClintLayoutController();

  int get currentIndex => convexController.index;

  final screens = [
    HomeView(),
    const ShopView(),
    GetAllPosts(),
    const AllJobsView(),
    Get.find<AppPreferences>().getUserRole() == "provider"
        ? ProviderSettingView()
        : const SettingsView(),
  ];

  onBNavPressed(int index) {
    convexController.animateTo(index);
    update();
  }

  @override
  Future<void> onInit() async {
    await Get.put(SettingController()).getMenuModel().then((value) {
      Get.put(HomeController()).update();
    });
    convexController.addListener(() {
      onBNavPressed(convexController.index);
    });
    update();
    super.onInit();
  }
}
