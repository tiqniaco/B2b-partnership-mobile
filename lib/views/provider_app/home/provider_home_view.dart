import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/provider/home/provider_home_controller.dart';
import 'package:b2b_partenership/controller/provider/home/provider_home_layout_controller.dart';
import 'package:b2b_partenership/controller/provider/setting/provider_setting_controller.dart';
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
import 'package:flutter_svg/flutter_svg.dart';
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
    // Get.put(ProviderHomeController());
    return GetBuilder<ProviderHomeController>(
      init: ProviderHomeController(),
      builder: (ProviderHomeController controller) {
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
                  Gap(10.w),
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
                  Gap(10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome!".tr,
                          style: getRegularStyle(context).copyWith(
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
                      child:
                          // Icon(
                          //   Icons.language_outlined,
                          //   color: greyColor,
                          //   size: 25.sp,
                          // )
                          SvgPicture.asset(
                        AssetsData.languageSVG,
                        colorFilter: ColorFilter.mode(
                          const Color.fromARGB(255, 33, 52, 157),
                          BlendMode.srcIn,
                        ),
                        height: 25.h,
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
              Gap(25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SearchWidget(
                  onTap: () {
                    Get.put(ProviderHomeLayoutController(this))
                        .onBNavPressed(2);
                  },
                ),
              ),
              Gap(5),
              FractionallySizedBox(
                widthFactor: 1,
                child: Divider(),
              ),
              Gap(10),
              CustomServerStatusWidget(
                  statusRequest: controller.statusRequestBanner,
                  child: HomeSliders()),
              Gap(25),
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
              Gap(18),
              SizedBox(
                  height: 140.h,
                  child: CustomServerStatusWidget(
                    statusRequest: controller.statusRequestSpecialization,
                    child: CategoryWidget(
                        specializations: controller.specializations),
                  )),
              Gap(30),
              FractionallySizedBox(
                widthFactor: 1,
                child: Divider(),
              ),
              Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: HomeRowWidget(
                  title: "Top Rated Providers".tr,
                  onTap: () {
                    Get.toNamed(AppRoutes.seeAll, arguments: {
                      "providers": controller.topProviders,
                      "title": "Top Rated Provider"
                    });
                  },
                ),
              ),
              Gap(10),
              SizedBox(
                  height: 240.h,
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
                      ))),
              Gap(10),
              FractionallySizedBox(
                widthFactor: 1,
                child: Divider(),
              ),
              Gap(25),
              BannerWidget(
                image: Get.locale?.languageCode == "en"
                    ? "assets/images/man.jpeg"
                    : "assets/images/man_ar.png",
                title: "Freelance Services!!".tr,
                onPressed: () {
                  Get.put(ProviderHomeLayoutController(this)).onBNavPressed(1);
                },
                description:
                    "You can browse the services available \n for freelance work"
                        .tr,
                buttonTitle: 'View'.tr,
              ),
              Gap(15),
              FractionallySizedBox(
                widthFactor: 1,
                child: Divider(),
              ),
              Gap(45),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: HomeRowWidget(
                  title: "Egypt Top Rated".tr,
                  onTap: () {
                    Get.toNamed(AppRoutes.seeAll, arguments: {
                      "providers": controller.topEgypt,
                      "title": "Egypt Top Rated"
                    });
                  },
                ),
              ),
              Gap(15),
              SizedBox(
                  height: 240.h,
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
              Gap(15),
              FractionallySizedBox(
                widthFactor: 1,
                child: Divider(),
              ),
              Gap(25),
              BannerWidget(
                image: Get.locale?.languageCode == "en"
                    ? "assets/images/job.jpeg"
                    : "assets/images/job_ar.png",
                title: "Need employees?".tr,
                onPressed: () {
                  Get.toNamed(AppRoutes.providerJobs);
                },
                description:
                    "You can add the available\njob for recruitment".tr,
                buttonTitle: 'Add'.tr,
              ),
              //JobBannerWidget(),
              Gap(55),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: HomeRowWidget(
                  title: "Saudi Arabia Top Rated".tr,
                  onTap: () {
                    Get.toNamed(AppRoutes.seeAll, arguments: {
                      "providers": controller.topSaudi,
                      "title": "Saudi Arabia Top Rated"
                    });
                  },
                ),
              ),
              Gap(20),
              SizedBox(
                  height: 240.h,
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
              Gap(35),
              FractionallySizedBox(
                widthFactor: 1,
                child: Divider(),
              ),
              Gap(25),
              BannerWidget(
                image: Get.locale?.languageCode == "en"
                    ? "assets/images/product.jpeg"
                    : "assets/images/product_ar.png",
                title: "Shopping?".tr,
                onPressed: () {
                  Get.toNamed(AppRoutes.shop);
                },
                description: "Order whatever you need\nfrom the shop".tr,
                buttonTitle: 'Order Now'.tr,
              ),
              Gap(45),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: HomeRowWidget(
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
              ),
              Gap(20),
              SizedBox(
                height: 240.h,
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
                  ),
                ),
              ),

              Gap(50)
            ],
          ),
        );
      },
    );
  }
}
