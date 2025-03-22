// ignore_for_file: deprecated_member_use

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:b2b_partenership/controller/home/home_client_layout_controller.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientHomeLayout extends StatefulWidget {
  const ClientHomeLayout({super.key});

  @override
  State<ClientHomeLayout> createState() => _ClientHomeLayoutState();
}

class _ClientHomeLayoutState extends State<ClientHomeLayout>
    with TickerProviderStateMixin {
  @override
  void initState() {
    Get.put(HomeClintLayoutController()).convexController = TabController(
      length: 5,
      vsync: this,
    );

    ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeClintLayoutController>(
      init: HomeClintLayoutController(),
      builder: (controller) => Scaffold(
        backgroundColor: backgroundColor,
        body: TabBarView(
          controller: controller.convexController,
          children: [
            ...controller.screens,
          ],
        ),
        bottomNavigationBar: ConvexAppBar(
          controller: controller.convexController,
          top: -30,
          height: 60.h,
          style: TabStyle.fixedCircle,
          backgroundColor: whiteColor,
          color: unSelectedBNavColor,
          activeColor: primaryColor,
          curveSize: 140,
          items: [
            TabItem(
              icon: SvgPicture.asset("assets/svgs/home.svg",
                  height: 20.sp,
                  color: controller.currentIndex == 0
                      ? primaryColor
                      : unSelectedBNavColor),
              title: "Home".tr,
            ),
            TabItem(
              icon: SvgPicture.asset("assets/svgs/shop.svg",
                  height: 20.sp,
                  color: controller.currentIndex == 1
                      ? primaryColor
                      : unSelectedBNavColor),
              title: "Shop".tr,
            ),
            TabItem(
              icon: Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: primaryColor),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 6.0, right: 7),
                    child: SvgPicture.asset("assets/svgs/search.svg",
                        height: 20.sp, color: Colors.white),
                  ),
                ),
              ),
              title: "Search".tr,
            ),
            TabItem(
              icon: SvgPicture.asset("assets/svgs/job.svg",
                  height: 20.sp,
                  color: controller.currentIndex == 3
                      ? primaryColor
                      : unSelectedBNavColor),
              title: "Jobs".tr,
            ),
            TabItem(
              icon: SvgPicture.asset("assets/svgs/setting.svg",
                  height: 20.sp,
                  color: controller.currentIndex == 4
                      ? primaryColor
                      : unSelectedBNavColor),
              title: "Menu".tr,
            ),
          ],
          initialActiveIndex: controller.currentIndex,
          onTap: (index) => controller.onBNavPressed(index),
        ),
      ),
    );
  }
}
