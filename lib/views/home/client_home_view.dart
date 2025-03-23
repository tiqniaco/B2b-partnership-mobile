import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/home/home_client_controller.dart';
import 'package:b2b_partenership/controller/home/home_client_layout_controller.dart';
import 'package:b2b_partenership/controller/settings/setting_controller.dart';
import 'package:b2b_partenership/core/enums/language_enum.dart';
import 'package:b2b_partenership/core/functions/change_app_lang.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/assets_data.dart';
import 'package:b2b_partenership/widgets/home/banner_widget.dart';
import 'package:b2b_partenership/widgets/home/category_widget.dart';
import 'package:b2b_partenership/widgets/home/home_row_widget.dart';
import 'package:b2b_partenership/widgets/home/home_slider.dart';
import 'package:b2b_partenership/widgets/home/provider_widget.dart';
import 'package:b2b_partenership/widgets/home/search_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ClientHomeView extends StatefulWidget {
  const ClientHomeView({super.key});

  @override
  State<ClientHomeView> createState() => _ClientHomeViewState();
}

class _ClientHomeViewState extends State<ClientHomeView>
    with TickerProviderStateMixin {
  final settingController = Get.put(SettingController())..getMenuModel();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeClientController>(
      init: HomeClientController(),
      builder: (HomeClientController controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: whiteColor,
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
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                    ),
                    // alignment: AlignmentDirectional.centerEnd,
                    child: InkWell(
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
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome!".tr,
                          style: TextStyle(
                            fontSize: context.isTablet ? 11.sp : 13.sp,
                            color: greyColor,
                          ),
                        ),
                        Text(
                          settingController.menuModel?.data?.name ?? "",
                          style: TextStyle(
                            fontSize: context.isTablet ? 14.sp : 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40.h,
                    width: 40.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl:
                            settingController.menuModel?.data?.image ?? "",
                        errorWidget: (context, url, error) => Icon(
                          CupertinoIcons.person,
                          size: 18.h,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Gap(12.w)
                ],
              ),
            ),
          ),
          body: ListView(
            children: [
              Gap(15.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.h),
                child: SearchWidget(
                  onTap: () {
                    Get.put(HomeClintLayoutController()).onBNavPressed(2);
                  },
                ),
              ),
              Gap(4.h),
              FractionallySizedBox(
                widthFactor: 1,
                child: Divider(),
              ),
              Gap(8.h),
              CustomServerStatusWidget(
                statusRequest: controller.statusRequestBanner,
                child: HomeSliders(),
              ),
              Gap(20.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: HomeRowWidget(
                  title: "Browse categories".tr,
                  onTap: () {
                    Get.toNamed(AppRoutes.seeAllCategories,
                        arguments: {"categories": controller.specializations});
                  },
                ),
              ),
              Gap(14.h),
              SizedBox(
                height: 130.h,
                child: CustomServerStatusWidget(
                  statusRequest: controller.statusRequestSpecialization,
                  child: CategoryWidget(
                    specializations: controller.specializations,
                  ),
                ),
              ),
              Gap(20.h),
              FractionallySizedBox(
                widthFactor: 1,
                child: Divider(),
              ),
              Gap(15.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: HomeRowWidget(
                  title: "Top Rated Providers".tr,
                  onTap: () {
                    Get.toNamed(AppRoutes.seeAll, arguments: {
                      "providers": controller.topProviders,
                      "title": "Top Rated Provider".tr
                    });
                  },
                ),
              ),
              Gap(10.h),
              SizedBox(
                height: 235.h,
                child: CustomServerStatusWidget(
                  statusRequest: controller.statusRequestProviders,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemCount: controller.topProviders.length,
                    separatorBuilder: (context, index) => Gap(20),
                    itemBuilder: (context, index) => ProviderWidget(
                      provider: controller.topProviders[index],
                      toggleFavorite: () {
                        controller.toggleFavorites(
                            controller.topProviders[index].providerId!);
                      },
                    ),
                  ),
                ),
              ),
              Gap(20.h),
              FractionallySizedBox(
                widthFactor: 1,
                child: Divider(),
              ),
              Gap(25),
              BannerWidget(
                image: Get.locale?.languageCode == "en"
                    ? "assets/images/man.jpeg"
                    : "assets/images/man_ar.png",
                title: "Need Custom Service?".tr,
                onPressed: () {
                  Get.toNamed(AppRoutes.getRequestServices);
                },
                description: "you can post your custom services\nrequest".tr,
                buttonTitle: 'Post Now'.tr,
              ),
              // ServiceBannerWidget(),
              Gap(20.h),
              FractionallySizedBox(
                widthFactor: 1,
                child: Divider(),
              ),
              Gap(15.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: HomeRowWidget(
                  title: "Egypt Top Rated".tr,
                  onTap: () {
                    Get.toNamed(AppRoutes.seeAll, arguments: {
                      "providers": controller.topEgypt,
                      "title": "Egypt Top Rated".tr
                    });
                  },
                ),
              ),
              Gap(20.h),
              SizedBox(
                  height: 235.h,
                  child: CustomServerStatusWidget(
                      statusRequest: controller.statusRequestProviders,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemCount: controller.topEgypt.length,
                        separatorBuilder: (context, index) => Gap(20),
                        itemBuilder: (context, index) => ProviderWidget(
                          provider: controller.topEgypt[index],
                          toggleFavorite: () {
                            controller.toggleFavorites(
                                controller.topEgypt[index].providerId!);
                          },
                        ),
                      ))),
              Gap(20.h),
              FractionallySizedBox(
                widthFactor: 1,
                child: Divider(),
              ),
              Gap(20.h),
              BannerWidget(
                image: Get.locale?.languageCode == "en"
                    ? "assets/images/job.jpeg"
                    : "assets/images/job_ar.png",
                title: "Are you looking for a job?".tr,
                onPressed: () {
                  // Get.toNamed(AppRoutes.jobs);
                  Get.put(HomeClintLayoutController()).onBNavPressed(3);
                },
                description: "See our Employment\nopportunities".tr,
                buttonTitle: 'View'.tr,
              ),
              Gap(20.h),
              FractionallySizedBox(
                widthFactor: 1,
                child: Divider(),
              ),
              //JobBannerWidget(),
              Gap(15.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: HomeRowWidget(
                  title: "Saudi Arabia Top Rated".tr,
                  onTap: () {
                    Get.toNamed(AppRoutes.seeAll, arguments: {
                      "providers": controller.topSaudi,
                      "title": "Saudi Arabia Top Rated".tr
                    });
                  },
                ),
              ),
              Gap(20.h),
              SizedBox(
                  height: 235.h,
                  child: CustomServerStatusWidget(
                      statusRequest: controller.statusRequestProviders,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemCount: controller.topSaudi.length,
                        separatorBuilder: (context, index) => Gap(20),
                        itemBuilder: (context, index) => ProviderWidget(
                          provider: controller.topSaudi[index],
                          toggleFavorite: () {
                            controller.toggleFavorites(
                                controller.topSaudi[index].providerId!);
                          },
                        ),
                      ))),
              Gap(20.h),
              FractionallySizedBox(
                widthFactor: 1,
                child: Divider(),
              ),
              Gap(20.h),
              BannerWidget(
                image: Get.locale?.languageCode == "en"
                    ? "assets/images/product.jpeg"
                    : "assets/images/product_ar.png",
                title: "Shopping?".tr,
                onPressed: () {
                  Get.put(HomeClintLayoutController()).onBNavPressed(1);
                },
                description: "Order whatever you need\nfrom the shop".tr,
                buttonTitle: 'Order Now'.tr,
              ),
              Gap(20.h),
              FractionallySizedBox(
                widthFactor: 1,
                child: Divider(),
              ),
              Gap(15.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: HomeRowWidget(
                  title: "UAE Top Rated".tr,
                  onTap: () {
                    Get.toNamed(AppRoutes.seeAll, arguments: {
                      "providers": controller.topUAE,
                      "title": "UAE Top Rated".tr
                    });
                  },
                ),
              ),
              Gap(20.h),
              SizedBox(
                  height: 235.h,
                  child: CustomServerStatusWidget(
                      statusRequest: controller.statusRequestProviders,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemCount: controller.topUAE.length,
                        separatorBuilder: (context, index) => Gap(20),
                        itemBuilder: (context, index) => ProviderWidget(
                            provider: controller.topUAE[index],
                            toggleFavorite: () {
                              controller.toggleFavorites(
                                  controller.topUAE[index].providerId!);
                            }),
                      ))),

              Gap(50)
            ],
          ),
        );
      },
    );
  }

  containerWidget(Color bgColor, String title) {
    return Container(
      height: 130.h,
      width: 94.h,
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration:
                BoxDecoration(color: whiteColor, shape: BoxShape.circle),
            child: Image.asset(
              "assets/images/job.png",
              height: 50.h,
              width: 50.h,
            ),
          ),
          Gap(10),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
              color: blackColor,
            ),
          )
        ],
      ),
    );
  }
}
