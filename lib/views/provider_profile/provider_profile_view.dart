import 'package:b2b_partenership/controller/previous_work/provider_profile_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_error_widget.dart';
import 'package:b2b_partenership/core/global/widgets/custom_no_connection_widget.dart';
import 'package:b2b_partenership/core/global/widgets/global_server_status_widget.dart';
import 'package:b2b_partenership/core/global/widgets/place_holder.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:b2b_partenership/widgets/provider_profile/provider_profile_loading_widget.dart';
import 'package:b2b_partenership/widgets/provider_profile/service_loading_widget.dart';
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
                  ? ProviderProfileLoadingWidget()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(20),
                        _buildHeader(controller),
                        Gap(24),
                        SizedBox(height: 35.h, child: _buildTabs(controller)),
                        Gap(8.h),
                        Expanded(
                          child: PageView(
                            controller: controller.pageController,
                            onPageChanged: controller.onPageChanged,
                            children: [
                              GlobalServerStatusWidget(
                                statusRequest: controller.statusRequestServices,
                                errorChild: CustomErrorWidget(),
                                noConnectionChild: CustomNoConnectionWidget(
                                  onTap: () => controller.getServices(),
                                ),
                                noDataChild: PlaceHolderWidget(
                                    icon: Image.asset(
                                        "assets/images/no_services.png"),
                                    title: "No services founded now",
                                    subTitle: "try again later"),
                                loadingChild: ServiceLoadingWidget(),
                                successChild: ServiceWidgetVertical(
                                  services: controller.providerServices,
                                ),
                              ),
                              AboutWidget(),
                              GlobalServerStatusWidget(
                                //emptyMessage: "No Previous work\nhere now".tr,
                                statusRequest:
                                    controller.statusRequestPerviousWork,
                                errorChild: CustomErrorWidget(),

                                noConnectionChild: CustomNoConnectionWidget(
                                  onTap: () => controller.getPreviousWork(),
                                ),
                                noDataChild: PlaceHolderWidget(
                                    icon: Image.asset(
                                        "assets/images/no_work.png"),
                                    title: "No Previous work now",
                                    subTitle: "try again later"),
                                loadingChild: ServiceLoadingWidget(),
                                successChild: Padding(
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
                              GlobalServerStatusWidget(
                                  statusRequest: controller.statusRequestReview,
                                  errorChild: CustomErrorWidget(),
                                  noConnectionChild: CustomNoConnectionWidget(
                                    onTap: () => controller.getPreviousWork(),
                                  ),
                                  noDataChild: PlaceHolderWidget(
                                      icon: Image.asset(
                                          "assets/images/no_review.png"),
                                      title: "No reviews now",
                                      subTitle: "try again later or add one"),
                                  loadingChild: ServiceLoadingWidget(),
                                  successChild: ReviewWidget())
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
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTab("Services", 0, 4, controller),
          Gap(8),
          _buildTab("About", 1, 3, controller),
          Gap(8),
          _buildTab("Previous work", 2, 6, controller),
          Gap(8),
          _buildTab("Reviews", 3, 4, controller),
        ],
      ),
    );
  }

  Widget _buildTab(
      String title, int index, int flex, ProviderProfileController controller) {
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: () => controller.onTabTapped(index),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 7),
          decoration: BoxDecoration(
              borderRadius: customBorderRadius,
              color: controller.selectedIndex == index
                  ? primaryColor
                  : Colors.transparent,
              border: Border.all(color: primaryColor)),
          child: Text(title.tr,
              style: getMediumStyle(Get.context!).copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 12.r,
                color: controller.selectedIndex == index
                    ? whiteColor
                    : primaryColor,
              )),
        ),
      ),
    );
  }
}
