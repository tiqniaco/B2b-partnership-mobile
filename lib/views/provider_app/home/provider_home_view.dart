import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/provider/home/provider_home_controller.dart';
import 'package:b2b_partenership/controller/provider/home/provider_home_layout_controller.dart';
import 'package:b2b_partenership/controller/provider/setting/provider_setting_controller.dart';

import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';

import 'package:b2b_partenership/widgets/home/body_banner_widget.dart';
import 'package:b2b_partenership/widgets/home/category_widget.dart';
import 'package:b2b_partenership/widgets/home/home_row_widget.dart';
import 'package:b2b_partenership/widgets/home/home_slider.dart';
import 'package:b2b_partenership/widgets/home/provider_widget.dart';
import 'package:b2b_partenership/widgets/home/search_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProviderHomeView extends StatefulWidget {
  const ProviderHomeView({super.key});

  @override
  State<ProviderHomeView> createState() => _ProviderHomeViewState();
}

class _ProviderHomeViewState extends State<ProviderHomeView>
    with TickerProviderStateMixin {
  final settingController = Get.put(ProviderSettingController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProviderHomeController>(
      init: ProviderHomeController(),
      builder: (ProviderHomeController controller) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              children: [
                Gap(20),
                SearchWidget(
                  title: "Search for service, job, training bags...",
                  onTap: () {
                    Get.put(ProviderHomeLayoutController(this))
                        .onBNavPressed(2);
                  },
                ),
                Gap(32),
                CustomServerStatusWidget(
                    statusRequest: controller.statusRequestBanner,
                    child: HomeSliders()),
                Gap(24),
                HomeRowWidget(
                  title: "Browse Categories".tr,
                  onTap: () {
                    Get.toNamed(AppRoutes.seeAllCategories,
                        arguments: {"categories": controller.specializations});
                  },
                ),
                Gap(14),
                SizedBox(
                    height: 110.h,
                    child: CustomServerStatusWidget(
                      statusRequest: controller.statusRequestSpecialization,
                      child: CategoryWidget(
                          specializations: controller.specializations),
                    )),
                Gap(20),
                HomeRowWidget(
                  title: "Top Rated Providers".tr,
                  onTap: () {
                    Get.toNamed(AppRoutes.seeAll, arguments: {
                      "providers": controller.topProviders,
                      "title": "Top Rated Provider"
                    });
                  },
                ),
                Gap(10),
                SizedBox(
                    height: 190.h,
                    child: CustomServerStatusWidget(
                        statusRequest: controller.statusRequestProviders,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.topProviders.length,
                          separatorBuilder: (context, index) => Gap(10),
                          itemBuilder: (context, index) => ProviderWidget(
                            provider: controller.topProviders[index],
                            toggleFavorite: () {
                              controller.toggleFavorites(
                                  controller.topProviders[index].providerId);
                            },
                          ),
                        ))),
                Gap(25),
                BodyBannerWidget(
                  image: "assets/images/banbody.png",
                  title: "Find your Suitable Job Now".tr,
                  onPressed: () {
                    Get.put(ProviderHomeLayoutController(this))
                        .onBNavPressed(1);
                  },
                  buttonTitle: 'Apply Now'.tr,
                ),
                Gap(24),
                HomeRowWidget(
                  title: "Egypt Top Rated".tr,
                  onTap: () {
                    Get.toNamed(AppRoutes.seeAll, arguments: {
                      "providers": controller.topEgypt,
                      "title": "Egypt Top Rated"
                    });
                  },
                ),
                Gap(16),
                SizedBox(
                    height: 190.h,
                    child: CustomServerStatusWidget(
                        statusRequest: controller.statusRequestProviders,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.topEgypt.length,
                          separatorBuilder: (context, index) => Gap(10),
                          itemBuilder: (context, index) => ProviderWidget(
                            provider: controller.topEgypt[index],
                            toggleFavorite: () {
                              controller.toggleFavorites(
                                  controller.topEgypt[index].providerId);
                            },
                          ),
                        ))),
                Gap(32),
                BodyBannerWidget(
                  image: "assets/images/banbody2.png",
                  title: "Now Purchasing Management\n Bag pdf, Audio, Video".tr,
                  onPressed: () {
                    Get.toNamed(AppRoutes.providerJobs);
                  },
                  buttonTitle: 'Shop Now'.tr,
                ),
                Gap(24),
                HomeRowWidget(
                  title: "Saudi Arabia Top Rated".tr,
                  onTap: () {
                    Get.toNamed(AppRoutes.seeAll, arguments: {
                      "providers": controller.topSaudi,
                      "title": "Saudi Arabia Top Rated"
                    });
                  },
                ),
                Gap(20),
                SizedBox(
                    height: 190.h,
                    child: CustomServerStatusWidget(
                        statusRequest: controller.statusRequestProviders,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.topSaudi.length,
                          separatorBuilder: (context, index) => Gap(10),
                          itemBuilder: (context, index) => ProviderWidget(
                            provider: controller.topSaudi[index],
                            toggleFavorite: () {
                              controller.toggleFavorites(
                                  controller.topSaudi[index].providerId);
                            },
                          ),
                        ))),
                Gap(32),
                HomeRowWidget(
                  title: "UAE Top Rated".tr,
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.seeAll,
                      arguments: {
                        "providers": controller.topUAE,
                        "title": "UAE Top Rated"
                      },
                    );
                  },
                ),
                Gap(20),
                SizedBox(
                  height: 190.h,
                  child: CustomServerStatusWidget(
                    statusRequest: controller.statusRequestProviders,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.topUAE.length,
                      separatorBuilder: (context, index) => Gap(10),
                      itemBuilder: (context, index) => ProviderWidget(
                          provider: controller.topUAE[index],
                          toggleFavorite: () {
                            controller.toggleFavorites(
                                controller.topUAE[index].providerId);
                          }),
                    ),
                  ),
                ),
                Gap(50)
              ],
            ),
          ),
        );
      },
    );
  }
}
