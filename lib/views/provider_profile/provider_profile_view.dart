import 'package:b2b_partenership/controller/previous_work/provider_profile_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/in_category/service_widget_vertical.dart';
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
                        Gap(15),
                        _buildTabs(controller),
                        Expanded(
                          child: PageView(
                            controller: controller.pageController,
                            onPageChanged: controller.onPageChanged,
                            children: [
                              CustomServerStatusWidget(
                                emptyMessage:
                                    "No services founded\ntry again later",
                                statusRequest: controller.statusRequestServices,
                                child: ServiceWidgetVertical(
                                  services: controller.providerServices,
                                ),
                              ),
                              AboutWidget(),
                              PreviousWork(),
                              CustomServerStatusWidget(
                                  emptyMessage: "No Reviews now\nlet's add one",
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
            radius: 30.r,
            backgroundColor: Colors.grey[200],
            backgroundImage:
                CachedNetworkImageProvider(controller.providerModel!.image!),
          ),
          Gap(8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.providerModel!.name!,
                style: getMediumStyle(Get.context!).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    controller.providerModel!.rating!,
                    style: getMediumStyle(Get.context!).copyWith(
                      color: greyColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(5),
                  Icon(Icons.circle, size: 4.r, color: greyColor),
                  Gap(5),
                  RatingBar.builder(
                    ignoreGestures: true,
                    itemSize: 17.r,
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
        padding: EdgeInsets.only(left: 10, bottom: 10, right: 10),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 2,
                    color: controller.selectedIndex == index
                        ? primaryColor
                        : whiteColor))),
        child: Text(
          title.tr,
          style: TextStyle(
            fontSize: 14.sp,
            color:
                controller.selectedIndex == index ? primaryColor : blackColor,
          ),
        ),
      ),
    );
  }
}
