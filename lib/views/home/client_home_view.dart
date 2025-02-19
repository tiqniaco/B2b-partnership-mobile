import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/home/home_client_controller.dart';
import 'package:b2b_partenership/controller/home/home_client_layout_controller.dart';
import 'package:b2b_partenership/controller/settings/setting_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/widgets/home/category_widget.dart';
import 'package:b2b_partenership/widgets/home/home_row_widget.dart';
import 'package:b2b_partenership/widgets/home/home_slider.dart';
import 'package:b2b_partenership/widgets/home/job_banner_widget.dart';
import 'package:b2b_partenership/widgets/home/provider_widget.dart';
import 'package:b2b_partenership/widgets/home/search_widget.dart';
import 'package:b2b_partenership/widgets/home/service_banner_widget.dart';
import 'package:b2b_partenership/widgets/home/shop_banner_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ClientHomeView extends StatefulWidget {
  const ClientHomeView({super.key});

  @override
  State<ClientHomeView> createState() => _ClientHomeViewState();
}

class _ClientHomeViewState extends State<ClientHomeView>
    with TickerProviderStateMixin {
  final settingController = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    Get.put(HomeClientController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        titleSpacing: 20,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome!",
              style: TextStyle(fontSize: 13.sp, color: greyColor),
            ),
            Text(
              settingController.menuModel!.data!.name!,
              style: TextStyle(fontSize: 16.sp),
            ),
          ],
        ),
        actions: [
          Container(
            height: 42.h,
            width: 42.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: settingController.menuModel!.data!.image!,
                errorWidget: (context, url, error) =>
                    Icon(CupertinoIcons.person),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Gap(20)
        ],
      ),
      body: GetBuilder<HomeClientController>(
        builder: (controller) => ListView(
          children: [
            Gap(25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SearchWidget(
                onTap: () {
                  Get.put(HomeClintLayoutController(this)).onBNavPressed(2);
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
                title: "Browse categories",
                onTap: () {
                  Get.toNamed(AppRoutes.seeAllCategories,
                      arguments: {"categories": controller.specializations});
                },
              ),
            ),
            Gap(18),
            SizedBox(
                height: 120.h,
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
                title: "Top Rated Providers",
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
                    ))),
            Gap(10),
            FractionallySizedBox(
              widthFactor: 1,
              child: Divider(),
            ),
            Gap(25),
            ServiceBannerWidget(),
            Gap(15),
            FractionallySizedBox(
              widthFactor: 1,
              child: Divider(),
            ),
            Gap(45),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: HomeRowWidget(
                title: "Egypt Top Rated",
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
            Gap(15),
            FractionallySizedBox(
              widthFactor: 1,
              child: Divider(),
            ),
            Gap(25),
            JobBannerWidget(),
            Gap(55),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: HomeRowWidget(
                title: "Saudi Arabia Top Rated",
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
            Gap(35),
            FractionallySizedBox(
              widthFactor: 1,
              child: Divider(),
            ),
            Gap(25),
            ShopBannerWidget(),
            Gap(45),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: HomeRowWidget(
                title: "UAE Top Rated",
                onTap: () {
                  Get.toNamed(AppRoutes.seeAll, arguments: {
                    "providers": controller.topUAE,
                    "title": "UAE Top Rated"
                  });
                },
              ),
            ),
            Gap(20),
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
      ),
    );
  }

  containerWidget(Color bgColor, String title) {
    return Container(
      // margin: EdgeInsets.all(5),
      height: 130.h,
      width: 94.h,
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: whiteColor, // const Color.fromARGB(255, 239, 229, 229),
                shape: BoxShape.circle),
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
                color: blackColor),
          )
        ],
      ),
    );
  }
}
