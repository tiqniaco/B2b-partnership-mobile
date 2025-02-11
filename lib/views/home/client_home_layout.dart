// // ignore_for_file: deprecated_member_use

// import 'package:b2b_partenership/controller/home/home_client_layout_controller.dart';
// import 'package:b2b_partenership/core/theme/app_color.dart';
// import 'package:b2b_partenership/core/theme/text_style.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';

// class ClientHomeLayout extends StatelessWidget {
//   const ClientHomeLayout({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeClintLayoutController>(
//       init: HomeClintLayoutController(),
//       builder: (controller) => Scaffold(
//         backgroundColor: backgroundColor,
//         body: controller.screens[controller.currentIndex],
//         floatingActionButton: Container(
//           padding: EdgeInsets.all(5),
//           decoration:
//               BoxDecoration(shape: BoxShape.circle, color: primaryColor),
//           child: FloatingActionButton(
//             elevation: 0,
//             shape: const CircleBorder(),
//             onPressed: () {
//               controller.onBNavPressed(2);
//             },
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 5.0, right: 5),
//               child: SvgPicture.asset(
//                 "assets/svgs/search.svg",
//                 color: whiteColor,
//                 height: 24.sp,
//               ),
//             ),
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         bottomNavigationBar: BottomAppBar(
//           notchMargin: 10,
//           height: 75.h,
//           shape: const CircularNotchedRectangle(),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               for (int i = 0; i < controller.bottomNavItems.length; i++)
//                 InkWell(
//                   onTap: () {
//                     controller.onBNavPressed(i);
//                   },
//                   child: Container(
//                     height: 0.14.sh,
//                     width: 0.15.sw,
//                     padding: EdgeInsets.symmetric(
//                       vertical: 10.h,
//                     ),
//                     child: Column(
//                       children: [
//                         Center(
//                           child: SvgPicture.asset(
//                             controller.bottomNavItems[i].icon,
//                             color: i == controller.currentIndex
//                                 ? primaryColor
//                                 : unSelectedBNavColor,
//                             height: 20.sp,
//                           ),
//                         ),
//                         Gap(5.h),
//                         Text(
//                           controller.bottomNavItems[i].label,
//                           style: getRegularStyle.copyWith(
//                             fontSize: 10.sp,
//                             color: i == controller.currentIndex
//                                 ? primaryColor
//                                 : unSelectedBNavColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: deprecated_member_use

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:b2b_partenership/controller/home/home_client_layout_controller.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientHomeLayout extends StatelessWidget {
  const ClientHomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeClintLayoutController>(
      init: HomeClintLayoutController(),
      builder: (controller) => Scaffold(
        backgroundColor: backgroundColor,
        body: controller.screens[controller.currentIndex],
        bottomNavigationBar: ConvexAppBar(
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
              title: "Home",
            ),
            TabItem(
              icon: SvgPicture.asset("assets/svgs/bag2.svg",
                  height: 20.sp,
                  color: controller.currentIndex == 1
                      ? primaryColor
                      : unSelectedBNavColor),
              title: "Orders",
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
              title: "Search",
            ),
            TabItem(
              icon: SvgPicture.asset("assets/svgs/save.svg",
                  height: 20.sp,
                  color: controller.currentIndex == 3
                      ? primaryColor
                      : unSelectedBNavColor),
              title: "Saved",
            ),
            TabItem(
              icon: SvgPicture.asset("assets/svgs/setting.svg",
                  height: 20.sp,
                  color: controller.currentIndex == 4
                      ? primaryColor
                      : unSelectedBNavColor),
              title: "Menu",
            ),
          ],
          initialActiveIndex: controller.currentIndex,
          onTap: (index) => controller.onBNavPressed(index),
        ),
      ),
    );
  }
}
