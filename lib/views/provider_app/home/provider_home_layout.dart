// ignore_for_file: deprecated_member_use

import 'package:b2b_partenership/controller/provider/home/provider_home_layout_controller.dart';
import 'package:b2b_partenership/controller/provider/setting/provider_setting_controller.dart';
import 'package:b2b_partenership/core/enums/language_enum.dart';
import 'package:b2b_partenership/core/functions/change_app_lang.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/assets_data.dart';
import 'package:b2b_partenership/views/home/client_home_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProviderHomeLayout extends StatefulWidget {
  const ProviderHomeLayout({super.key});

  @override
  State<ProviderHomeLayout> createState() => _ProviderHomeLayoutState();
}

class _ProviderHomeLayoutState extends State<ProviderHomeLayout>
    with TickerProviderStateMixin {
  final settingController = Get.put(ProviderSettingController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProviderHomeLayoutController>(
      init: ProviderHomeLayoutController(this),
      builder: (controller) => Scaffold(
          backgroundColor: backgroundColor,
          appBar: controller.currentIndex != 4
              ? AppBar(
                  automaticallyImplyLeading: false,
                  toolbarHeight: context.isTablet ? 70.h : 40.h,
                  flexibleSpace: Container(
                    alignment: AlignmentDirectional.center,
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                    ),
                    height: context.isTablet ? 70.h : null,
                    child: Row(
                      children: [
                        Gap(10.w),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[300]!)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl:
                                  settingController.menuModel?.data?.image ??
                                      "",
                              errorWidget: (context, url, error) => Icon(
                                CupertinoIcons.person,
                                size: 18.h,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Gap(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Welcome!".tr,
                                style: getBoldStyle(context).copyWith(
                                  fontSize: 15.r,
                                  color: greyColor,
                                ),
                              ),
                              Text(
                                settingController.menuModel?.data?.name ?? "",
                                style: getMediumStyle(context).copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.bottomSheet(Container(
                              height: 0.2.sh,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.r),
                                  topRight: Radius.circular(20.r),
                                ),
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.symmetric(
                                // horizontal: 10.w,
                                vertical: 10.h,
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      "English",
                                      style: getRegularStyle(context),
                                    ),
                                    leading: Image.asset(
                                      AssetsData.englishImage,
                                      width: 20.w,
                                    ),
                                    onTap: () {
                                      changeAppLang(
                                        context: Get.context!,
                                        lang: LanguageEnum.en,
                                      );
                                    },
                                  ),
                                  ListTile(
                                    title: Text(
                                      'العربية',
                                      style: getRegularStyle(context),
                                    ),
                                    leading: Image.asset(
                                      AssetsData.arabicImage,
                                      width: 20.w,
                                    ),
                                    onTap: () {
                                      changeAppLang(
                                        context: Get.context!,
                                        lang: LanguageEnum.ar,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ));
                          },
                          child: SvgPicture.asset(
                            AssetsData.languageSVG,
                            colorFilter: ColorFilter.mode(
                              primaryColor,
                              BlendMode.srcIn,
                            ),
                            height: 25.h,
                          ),
                        ),
                        Gap(12.w)
                      ],
                    ),
                  ),
                )
              : AppBar(
                  automaticallyImplyLeading: false,
                  title:
                      Text("Menu".tr, style: getBoldStyle(context).copyWith()),
                ),
          body: TabBarView(
            controller: controller.convexController,
            children: [
              ...controller.screens,
            ],
          ),
          bottomNavigationBar: StyleProvider(
            style: Style(),
            child: BottomNavigationBar(
                elevation: 0,
                onTap: (value) => controller.onBNavPressed(value),
                currentIndex: controller.currentIndex,
                backgroundColor: backgroundColor,
                selectedItemColor: primaryColor,
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset("assets/svgs/home.svg",
                        height: 20.sp,
                        color: controller.currentIndex == 0
                            ? primaryColor
                            : unSelectedBNavColor),
                    label: "Home".tr,
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset("assets/svgs/shop.svg",
                        height: 20.sp,
                        color: controller.currentIndex == 1
                            ? primaryColor
                            : unSelectedBNavColor),
                    label: "Shop".tr,
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                        CupertinoIcons.news,
                        size: 24.r,
                        color: controller.currentIndex == 2
                            ? primaryColor
                            : unSelectedBNavColor,
                      ),
                      label: "Posts".tr),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        "assets/svgs/job.svg",
                        height: 24.sp,
                        color: controller.currentIndex == 3
                            ? primaryColor
                            : unSelectedBNavColor,
                      ),
                      label: "Jobs".tr),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        "assets/svgs/setting.svg",
                        height: 24.sp,
                        color: controller.currentIndex == 4
                            ? primaryColor
                            : unSelectedBNavColor,
                      ),
                      label: "Menu".tr),
                ]),
          )),
    );
  }
}
