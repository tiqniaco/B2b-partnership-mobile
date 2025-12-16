import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/home/home_controller.dart';
import 'package:b2b_partenership/controller/settings/setting_controller.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/global/widgets/custom_error_widget.dart';
import 'package:b2b_partenership/core/global/widgets/custom_no_connection_widget.dart';

import 'package:b2b_partenership/core/global/widgets/global_server_status_widget.dart';
import 'package:b2b_partenership/core/global/widgets/place_holder.dart';
import 'package:b2b_partenership/core/services/responsive_helper.dart';

import 'package:b2b_partenership/widgets/home/category_widget.dart';
import 'package:b2b_partenership/widgets/home/home_row_widget.dart';
import 'package:b2b_partenership/widgets/home/home_slider.dart';
import 'package:b2b_partenership/widgets/home/provider_loading_widget.dart';
import 'package:b2b_partenership/widgets/home/provider_widget.dart';
import 'package:b2b_partenership/widgets/home/search_widget.dart';
import 'package:b2b_partenership/widgets/home/work_category_loading.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final settingController = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (HomeController controller) {
        return Scaffold(
          body: controller.statusRequestSpecialization ==
                      StatusRequest.noConnection ||
                  controller.statusRequestProviders ==
                      StatusRequest.noConnection
              ? CustomNoConnectionWidget(
                  onTap: () {
                    controller.getSpecialization();
                    controller.getProviders();
                  },
                )
              : ListView(
                  children: [
                    Gap(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SearchWidget(
                        title: "Search for service, job, bags".tr,
                        onTap: () {
                          Get.toNamed(AppRoutes.search);
                        },
                      ),
                    ),
                    Gap(24),
                    HomeSliders(),
                    Gap(16),
                    HomeRowWidget(
                      title: "Browse Categories".tr,
                      onTap: () {
                        Get.toNamed(AppRoutes.seeAllCategories, arguments: {
                          "categories": controller.specializations
                        });
                      },
                    ),
                    Gap(18),
                    SizedBox(
                      height: context.isTablet ? 124.h : 116.h,
                      child: controller.statusRequestSpecialization ==
                              StatusRequest.loading
                          ? ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              separatorBuilder: (context, index) => Gap(6),
                              itemBuilder: (context, index) =>
                                  WorkCategoryShimmer(),
                            )
                          : CategoryWidget(
                              specializations: controller.specializations),
                    ),
                    Gap(8),
                    HomeRowWidget(
                      title: "Top Rated Providers".tr,
                      onTap: () {
                        Get.toNamed(AppRoutes.seeAll, arguments: {
                          "providers": controller.topProviders,
                          "title": "Top Rated Provider"
                        });
                      },
                    ),
                    Gap(16),
                    SizedBox(
                        height: 410.h, //Platform.isIOS ? 420.h : 440.h,
                        child: GlobalServerStatusWidget(
                            statusRequest: controller.statusRequestProviders,
                            noDataChild: PlaceHolderWidget(
                                icon: Image.asset(
                                    "assets/images/no_providers.png"),
                                title: "No Providers Now".tr,
                                subTitle:
                                    "No Providers Available Now, Please\ntry again later"
                                        .tr),
                            noConnectionChild: CustomNoConnectionWidget(
                              onTap: () {
                                controller.getSpecialization();
                                controller.getProviders();
                              },
                            ),
                            errorChild: CustomErrorWidget(),
                            loadingChild: ProviderLoadingWidget(),
                            successChild: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 16,
                                      childAspectRatio:
                                          ResponsiveHelper.getValue(
                                              thinValue: 1.44,
                                              extraSmallValue: 1.59,
                                              smallValue: 1.35,
                                              mediumValue: 1.55,
                                              largeValue: 1.1,
                                              extraLargeValue: 1.1)),
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.topProviders.length,
                              itemBuilder: (context, index) => ProviderWidget(
                                provider: controller.topProviders[index],
                                toggleFavorite: () {
                                  controller.toggleFavorites(controller
                                      .topProviders[index].providerId
                                      .toString());
                                },
                              ),
                            ))),
                    Gap(20),
                  ],
                ),
        );
      },
    );
  }
}
