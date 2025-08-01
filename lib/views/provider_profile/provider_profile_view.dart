import 'package:b2b_partenership/controller/previous_work/provider_profile_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:b2b_partenership/widgets/provider_profile/service_widget_vertical.dart';
import 'package:b2b_partenership/widgets/provider_profile/about_widget.dart';
import 'package:b2b_partenership/widgets/provider_profile/previous_work_widget.dart';
import 'package:b2b_partenership/widgets/provider_profile/review_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProviderProfileView extends StatelessWidget {
  const ProviderProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProviderProfileController());
    return GetBuilder<ProviderProfileController>(
      builder: (controller) {
        return Scaffold(
            floatingActionButton: controller.selectedIndex == 3 &&
                    Get.find<AppPreferences>().getUserRole() == "client"
                ? FloatingActionButton(
                    shape: CircleBorder(),
                    onPressed: () {
                      controller.addReviewDialog();
                    },
                    child: Icon(
                      Icons.add,
                      size: 20.sp,
                    ),
                  )
                : SizedBox.shrink(),
            body: SafeArea(
                child: Center(
              child: controller.providerModel == null
                  ? CircularProgressIndicator()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(20),
                        _buildHeader(controller),
                        Gap(24),
                        _buildTabs(controller),
                        Gap(8.h),
                        Expanded(
                          child: PageView(
                            controller: controller.pageController,
                            onPageChanged: controller.onPageChanged,
                            children: [
                              CustomServerStatusWidget(
                                emptyMessage:
                                    "No services founded\ntry again later".tr,
                                statusRequest: controller.statusRequestServices,
                                child: ServiceWidgetVertical(
                                  services: controller.providerServices,
                                ),
                              ),
                              AboutWidget(),
                              CustomServerStatusWidget(
                                emptyMessage: "No Previous work\nhere now".tr,
                                statusRequest:
                                    controller.statusRequestPerviousWork,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 16),
                                  child: ListView.separated(
                                    itemCount: controller.previousWork.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            Gap(14.h),
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            PreviousWork(
                                      model: controller.previousWork[index],
                                    ),
                                  ),
                                ),
                              ),
                              CustomServerStatusWidget(
                                  emptyMessage:
                                      "No Reviews now\nlet's add one".tr,
                                  statusRequest: controller.statusRequestReview,
                                  child: ReviewWidget())
                            ],
                          ),
                        ),
                      ],
                    ),
            )));
      },
    );
  }

  Widget _buildHeader(ProviderProfileController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              size: 23.r,
              color: greyColor,
            ),
          ),
          CircleAvatar(
            radius: 26.r,
            backgroundColor: Colors.grey[200],
            backgroundImage:
                CachedNetworkImageProvider(controller.providerModel!.image),
          ),
          Gap(8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.providerModel!.name,
                style: getMediumStyle(Get.context!).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              RatingBar.builder(
                ignoreGestures: true,
                itemSize: 20.r,
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemBuilder: (context, _) =>
                    Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (rating) {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(ProviderProfileController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTab("Services", 0, controller),
          _buildTab("About", 1, controller),
          _buildTab("Previous work", 2, controller),
          _buildTab("Reviews", 3, controller),
        ],
      ),
    );
  }

  Widget _buildTab(
      String title, int index, ProviderProfileController controller) {
    return GestureDetector(
      onTap: () => controller.onTabTapped(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
            borderRadius: customBorderRadius,
            color: controller.selectedIndex == index
                ? primaryColor
                : Colors.transparent,
            border: Border.all(color: primaryColor)),
        child: Text(title.tr,
            style: getMediumStyle(Get.context!).copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 13.r,
              color:
                  controller.selectedIndex == index ? whiteColor : primaryColor,
            )),
      ),
    );
  }
}
