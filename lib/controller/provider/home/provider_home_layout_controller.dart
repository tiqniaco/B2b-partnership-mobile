import 'package:b2b_partenership/controller/home/home_client_controller.dart';
import 'package:b2b_partenership/controller/settings/setting_controller.dart';
import 'package:b2b_partenership/views/home/client_home_view.dart';
import 'package:b2b_partenership/views/provider_app/posts/get_service_request.dart';
import 'package:b2b_partenership/views/save/save_view.dart';
import 'package:b2b_partenership/views/search/search_view.dart';
import 'package:b2b_partenership/views/provider_app/setting/provider_setting_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '/core/localization/app_strings.dart';
import 'package:get/get.dart';

class ProviderHomeLayoutController extends GetxController {
  late TabController convexController;

  ProviderHomeLayoutController(
    TickerProvider vsync,
  ) : convexController = TabController(
          length: 5,
          vsync: vsync,
        );

  int get currentIndex => convexController.index;

  final bottomNavItems = [
    HomeBottomNavModel(
      icon: "assets/svgs/home.svg",
      label: AppStrings.home.tr,
      index: 0,
    ),
    HomeBottomNavModel(
      icon: "assets/svgs/bag2.svg",
      label: "Posts".tr,
      index: 1,
    ),
    HomeBottomNavModel(
      icon: "",
      label: "Search".tr,
      index: 2,
    ),
    HomeBottomNavModel(
      icon: "assets/svgs/save.svg",
      label: "Saved".tr,
      index: 2,
    ),
    HomeBottomNavModel(
      icon: "assets/svgs/setting.svg",
      label: "Menu".tr,
      index: 4,
    ),
  ];

  final screens = [
    ClientHomeView(),
    GetServiceRequest(),
    const SearchView(),
    const SaveView(),
    const ProviderSettingView(),
  ];

  onBNavPressed(int index) {
    convexController.animateTo(index);
    update();
  }

  @override
  Future<void> onInit() async {
    await Get.put(SettingController()).getMenuModel().then((value) {
      Get.put(HomeClientController()).update();
    });
    convexController.addListener(() {
      onBNavPressed(convexController.index);
    });
    update();
    super.onInit();
  }
}

class HomeBottomNavModel extends Equatable {
  final String label;
  final String icon;
  final int index;

  const HomeBottomNavModel({
    required this.label,
    required this.icon,
    required this.index,
  });

  @override
  List<Object?> get props => [label, icon, index];
}
