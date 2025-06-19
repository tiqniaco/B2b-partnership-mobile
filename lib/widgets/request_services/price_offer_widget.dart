import 'dart:developer';

import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/request_services/service_request_details_controller.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
import 'package:b2b_partenership/models/price_offer_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PriceOfferWidget extends GetView<ServiceRequestDetailsController> {
  const PriceOfferWidget({super.key, required this.model});
  final PriceOfferModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          backgroundColor: backgroundColor,
          titlePadding: EdgeInsets.symmetric(vertical: 10),
          title: "Offer Details".tr,
          titleStyle: TextStyle(
              fontSize: 13.sp, color: blackColor, fontWeight: FontWeight.bold),
          content: SizedBox(
            height: 500.h,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildRow("Price", model.requestOfferPrice,
                      Icons.payments_outlined),
                  Gap(16),
                  buildRow("Duration", model.requestOfferDuration,
                      Icons.watch_later_outlined),
                  Gap(16),
                  buildRow("Description", model.offerDescription,
                      Icons.note_alt_outlined),
                  Gap(24),
                  InkWell(
                    onTap: () {
                      Get.toNamed(
                          model.userRole == "provider"
                              ? AppRoutes.providerProfile
                              : AppRoutes.clientProfile,
                          arguments: {"id": model.roleId});
                    },
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: customBorderRadius,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "View Applicant Profile".tr,
                          style: TextStyle(
                            fontSize: 14.r,
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: lightPrimaryColor.withAlpha(170),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Container(
              height: 46.h,
              width: 46.h,
              decoration: BoxDecoration(),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(imageUrl: model.userImage)),
            ),
            Gap(15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.userName,
                    style: getBoldStyle(context)
                        .copyWith(fontSize: 14.r, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        "Price".tr,
                        style: getMediumStyle(context).copyWith(fontSize: 14.r),
                      ),
                      Gap(4),
                      Text(
                        model.requestOfferPrice,
                        style: getMediumStyle(context).copyWith(fontSize: 14.r),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(10),
            Get.find<AppPreferences>().getUserId() != model.userId &&
                    Get.find<AppPreferences>().getUserId() ==
                        controller.model.userId
                ? model.requestOfferStatus == 'accepted'
                    ? Container(
                        width: 90.w,
                        height: 26.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: customBorderRadius,
                          color: primaryColor,
                        ),
                        child: Text(
                          "Accepted".tr,
                          style: getLightStyle(context).copyWith(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : SizedBox(
                        width: 90.w,
                        height: 27.h,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              padding: WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(horizontal: 10)),
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.r)))),
                          onPressed: () {
                            log(Get.find<AppPreferences>().getUserId());
                            controller.acceptPriceOffers(model.requestOfferId);
                          },
                          child: Text(
                            "Accept".tr,
                            style: getLightStyle(context).copyWith(
                              color: whiteColor,
                              fontWeight: FontManager.semiBoldFontWeight,
                            ),
                          ),
                        ),
                      )
                : Row(
                    children: [
                      Container(
                        width: 74.w,
                        height: 26.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: customBorderRadius,
                          color: primaryColor,
                        ),
                        child: Text(
                          model.requestOfferStatus.tr,
                          style: getLightStyle(context).copyWith(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      controller.model.status != "Closed"
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  controller.deleteOffer(model.requestOfferId);
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 20.r,
                                ),
                              ),
                            )
                          : Gap(8)
                    ],
                  )
          ],
        ),
      ),
    );
  }

  Widget buildRow(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: customBorderRadius,
      ),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 15.r),
          Gap(10),
          Text(
            "${title.tr}:",
            style: TextStyle(
                fontSize: 13.sp,
                color: blackColor,
                fontWeight: FontWeight.bold),
          ),
          Gap(8),
          // Spacer(),
          Text(
            value,
            style: TextStyle(
                fontSize: 13.sp,
                color: blackColor,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
