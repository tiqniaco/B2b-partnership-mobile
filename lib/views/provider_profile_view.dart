import 'package:b2b_partenership/controller/provider_profile_controller.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/widgets/in_category/service_widget_vertical.dart';
import 'package:b2b_partenership/widgets/provider_profile/about_widget.dart';
import 'package:b2b_partenership/widgets/provider_profile/previous_work.dart';
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
    return Scaffold(
      body: GetBuilder<ProviderProfileController>(builder: (controller) {
        return SafeArea(
          child: Center(
            child: controller.providerModel == null
                ? CircularProgressIndicator()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  size: 23.sp,
                                  color: greyColor,
                                )),
                            CircleAvatar(
                              radius: 33.r,
                              backgroundColor: Colors.grey[200],
                              backgroundImage: CachedNetworkImageProvider(
                                  controller.providerModel!.image!),
                            ),
                            Gap(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller.providerModel!.name!,
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.providerModel!.rating!,
                                      style: TextStyle(
                                          color: greyColor,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Gap(5),
                                    Icon(
                                      Icons.circle,
                                      size: 4.sp,
                                      color: greyColor,
                                    ),
                                    Gap(5),
                                    RatingBar.builder(
                                      ignoreGestures: true,
                                      itemSize: 17.sp,
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: false,
                                      itemCount: 5,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 1.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Gap(15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 15),
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            // color: primaryColor
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    controller.onTapService();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10, bottom: 10, right: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 2,
                                                color: controller.isServices
                                                    ? primaryColor
                                                    : whiteColor))),
                                    child: Text(
                                      "Services".tr,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: controller.isServices
                                            ? primaryColor
                                            : blackColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    controller.onTapAbout();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10, bottom: 10, right: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                          width: 2,
                                          color: controller.isAbout
                                              ? primaryColor
                                              : whiteColor),
                                    )),
                                    child: Text(
                                      "About".tr,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        // fontWeight: FontWeight.w500,
                                        color: controller.isAbout
                                            ? primaryColor
                                            : blackColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    controller.onTapWork();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10, bottom: 10, right: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 2,
                                                color: controller.isWork
                                                    ? primaryColor
                                                    : whiteColor))),
                                    child: Text(
                                      "Previous work".tr,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: controller.isWork
                                            ? primaryColor
                                            : blackColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      controller.isServices
                          ? Expanded(
                              child: ServiceWidgetVertical(
                                  services: controller.providerServices))
                          : controller.isAbout
                              ? AboutWidget()
                              : PreviousWork()
                    ],
                  ),
          ),
        );
      }),
    );
  }
}
