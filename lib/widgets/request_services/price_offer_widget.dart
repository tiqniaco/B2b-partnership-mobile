import 'dart:developer';

import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/request_services/service_request_details_controller.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
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
          backgroundColor: const Color.fromARGB(255, 238, 169, 176),
          titlePadding: EdgeInsets.symmetric(vertical: 10),
          title: "Offer Details".tr,
          titleStyle: TextStyle(
              fontSize: 13.sp, color: whiteColor, fontWeight: FontWeight.bold),
          content: SizedBox(
            height: 500.h,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildRow("Price:", model.requestOfferPrice,
                      Icons.payments_outlined),
                  buildRow("Duration:", model.requestOfferDuration,
                      Icons.watch_later_outlined),
                  buildRow("Description:", "", Icons.note_alt_outlined),
                  Text(
                    model.offerDescription,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(10),
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
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "View Applicant Profile".tr,
                          style: TextStyle(
                            fontSize: 15.r,
                            color: blackColor,
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
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: greyCart,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              height: 60.h,
              width: 60.h,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(imageUrl: model.userImage)),
            ),
            Gap(15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.userName,
                    style: getMediumStyle(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    model.requestOfferPrice,
                    style: getMediumStyle(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
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
                          borderRadius: BorderRadius.circular(5),
                          color: greyColor,
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
                        width: 90.w,
                        height: 26.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: greyColor,
                        ),
                        child: Text(
                          model.requestOfferStatus.tr,
                          style: getLightStyle(context).copyWith(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (controller.model.status != "Closed")
                        IconButton(
                          onPressed: () {
                            controller.deleteOffer(model.requestOfferId);
                          },
                          icon: Icon(
                            Icons.close,
                            size: 20.r,
                          ),
                        )
                    ],
                  )
          ],
        ),
      ),
    );
  }

  Widget buildRow(String title, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: blackColor, size: 15.r),
        Gap(10),
        Text(
          title.tr,
          style: TextStyle(
              fontSize: 13.sp, color: whiteColor, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Text(
          value,
          style: TextStyle(
              fontSize: 13.sp, color: blackColor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
