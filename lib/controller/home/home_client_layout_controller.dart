import 'package:b2b_partenership/views/home/client_home_view.dart';
import 'package:b2b_partenership/views/orders/orders_view.dart';
import 'package:b2b_partenership/views/save/save_view.dart';
import 'package:b2b_partenership/views/search/search_view.dart';
import 'package:b2b_partenership/views/settings/settings_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '/core/localization/app_strings.dart';
import 'package:get/get.dart';

class HomeClintLayoutController extends GetxController {
  late TabController convexController;

  HomeClintLayoutController(
    TickerProvider vsync,
  ) : convexController = TabController(
          length: 5,
          vsync: vsync,
        );

  int currentIndex = 0;
  final bottomNavItems = [
    HomeBottomNavModel(
      icon: "assets/svgs/home.svg",
      label: AppStrings.home.tr,
      index: 0,
    ),
    HomeBottomNavModel(
      icon: "assets/svgs/bag2.svg",
      label: "Orders".tr,
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
    const OrdersView(),
    const SearchView(),
    const SaveView(),
    const SettingsView(),
  ];

  onBNavPressed(int index) {
    currentIndex = index;
    convexController.animateTo(index);
    update();
  }

  @override
  void onInit() {
    currentIndex = 0;
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
