// ignore_for_file: deprecated_member_use

import 'package:b2b_partenership/controller/service_details_controller.dart';
import 'package:b2b_partenership/core/functions/get_text_direction.dart';
import 'package:b2b_partenership/core/functions/please_login_dialog.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/services/date_time_convertor.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:b2b_partenership/widgets/service_details.dart/feature_widget.dart';
import 'package:b2b_partenership/widgets/service_details.dart/seller_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ServiceDetailsView extends StatelessWidget {
  ServiceDetailsView({super.key});
  final controller = Get.put(ServiceDetailsController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: borderColor),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 16.h,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45.h,
                    decoration: BoxDecoration(
                        color: primaryColor, borderRadius: customBorderRadius),
                    child: CustomLoadingButton(
                      onPressed: Get.find<AppPreferences>().getToken() == ''
                          ? () {
                              pleaseLoginDialog();
                            }
                          : () {
                              controller.contactMethods();
                            },
                      text: 'Book Appointment'.tr,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: GetBuilder<ServiceDetailsController>(
          builder: (controller) {
            return controller.service == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CachedNetworkImage(
                              width: double.infinity,
                              height: 265.h,
                              fit: BoxFit.cover,
                              imageUrl: controller.service!.data!.image!,
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/default.jpg',
                                width: double.infinity,
                                height: 265.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 265.h,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.7),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                            PositionedDirectional(
                              top: 50,
                              start: 16,
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 20.r,
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Text(
                                  "Service List".tr,
                                  style: getSemiBoldStyle(context).copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            if (Get.find<AppPreferences>().getUserRole() ==
                                    "provider" &&
                                Get.find<AppPreferences>().getUserRoleId() ==
                                    controller.service?.provider?.providerId)
                              PositionedDirectional(
                                top: 60,
                                end: 16,
                                child: InkWell(
                                  onTap: () {
                                    controller.deleteServiceDialog();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: customBorderRadius,
                                      color: whiteColor,
                                    ),
                                    child: Icon(
                                      CupertinoIcons.trash_fill,
                                      color: primaryColor,
                                      size: 20.r,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 24.r,
                                    backgroundColor: Colors.grey[200],
                                    backgroundImage: CachedNetworkImageProvider(
                                        controller.service!.provider!.image),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    controller.service!.provider!.name,
                                    style: getLightStyle(context).copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.r),
                                  ),
                                  Spacer(),
                                  if (controller.service?.data?.video != null)
                                    InkWell(
                                      onTap: () {
                                        launchUrlString(
                                          controller.service?.data?.video ?? "",
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 4),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade400),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.videocam_rounded,
                                              color: primaryColor,
                                              size: 24.r,
                                            ),
                                            Gap(8),
                                            Text(
                                              'Watch Video'.tr,
                                              style: getRegularStyle(context)
                                                  .copyWith(
                                                      color: blackColor,
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: 13),
                              Text(
                                translateDatabase(
                                    arabic: controller.service!.data!.nameAr!,
                                    english: controller.service!.data!.nameEn!),
                                style: getMediumStyle(context).copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 24),
                              FeatureWidget(),
                              Gap(20),
                              FractionallySizedBox(
                                widthFactor: 10,
                                child: Divider(
                                  color: primaryColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.watch_later,
                                          size: 20.r,
                                          color: primaryColor,
                                        ),
                                        Gap(8),
                                        Text(
                                          DateTimeConvertor.timeAgo(controller
                                                  .service!.data!.createdAt!)
                                              .toString(),
                                          style:
                                              getRegularStyle(context).copyWith(
                                            color: blackColor,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      color: primaryColor,
                                      height: 10.h,
                                      width: 1,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          controller.service!.data!.rating!,
                                          style:
                                              getMediumStyle(context).copyWith(
                                            color: starColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Gap(3),
                                        Icon(
                                          Icons.star,
                                          size: 18.r,
                                          color: starColor,
                                        ),
                                        Gap(7),
                                        Text(
                                          'Service Ratings'.tr,
                                          style: getRegularStyle(context),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: 10,
                                child: Divider(
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: 30),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: InkWell(
                                        onTap: () {
                                          controller.onTapOverView();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(bottom: 10),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              border: Border(
                                            bottom: BorderSide(
                                                width: 5,
                                                color: controller.isOverView
                                                    ? primaryColor
                                                    : Colors.white),
                                          )),
                                          child: Text(
                                            "Overview".tr,
                                            style: getRegularStyle(context)
                                                .copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: controller.isOverView
                                                  ? primaryColor
                                                  : blackColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Gap(16),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: InkWell(
                                        onTap: () {
                                          controller.onTapSeller();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(bottom: 10),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 3,
                                                      color: controller.isSeller
                                                          ? primaryColor
                                                          : Colors.white))),
                                          child: Text(
                                            "About Seller".tr,
                                            style: getRegularStyle(context)
                                                .copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: controller.isSeller
                                                  ? primaryColor
                                                  : blackColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50.0),
                                child: Divider(
                                  height: 0,
                                  color:
                                      const Color.fromARGB(255, 198, 137, 139),
                                ),
                              ),
                              Gap(8.h),
                              controller.isOverView
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Directionality(
                                        textDirection: containsArabic(controller
                                                .service!.data!.overview!)
                                            ? TextDirection.rtl
                                            : TextDirection.ltr,
                                        child: Text(
                                          controller.service!.data!.overview!,
                                          style:
                                              getMediumStyle(context).copyWith(
                                            fontWeight: FontWeight.w400,
                                          ),
                                          maxLines: 100,
                                        ),
                                      ),
                                    )
                                  : controller.isSeller
                                      ? SellerWidget()
                                      : SizedBox.shrink(),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
