import 'package:b2b_partenership/controller/request_services/service_request_details_controller.dart';
import 'package:b2b_partenership/core/constants/app_constants.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/services/date_time_convertor.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
import 'package:b2b_partenership/widgets/request_services/price_offer_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ServiceRequestDetails extends StatelessWidget {
  const ServiceRequestDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ServiceRequestDetailsController());
    return Scaffold(
      body: GetBuilder<ServiceRequestDetailsController>(
        builder: (controller) => ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    if (controller.model.image != null) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(18.r),
                          bottomLeft: Radius.circular(18.r),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: "$kBaseImageUrl${controller.model.image}",
                          height: 160.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                    SizedBox.shrink(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 25.r,
                                color: blackColor,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: context.isTablet ? 150 : 100,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 9),
                            decoration: BoxDecoration(
                                borderRadius: customBorderRadius,
                                color: primaryColor),
                            child: Text(controller.model.status!.tr,
                                style: TextStyle(
                                  fontSize: 12.r,
                                  color: whiteColor,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gap(15),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50.r),
                              child: CachedNetworkImage(
                                imageUrl: controller.model.clientImage!,
                                height: 40.r,
                                width: 40.r,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    CircleAvatar(
                                  child: Icon(CupertinoIcons.person),
                                ),
                              ),
                            ),
                            Gap(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.model.name!,
                                  style: getMediumStyle(context).copyWith(
                                    color: Colors.black,
                                    fontSize: 14.r,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  DateTimeConvertor.timeAgo(
                                      controller.model.createdAt!),
                                  style: getLightStyle(context).copyWith(
                                    color: Colors.black,
                                    fontWeight: FontManager.regularFontWeight,
                                    fontSize: 8.r,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: primaryColor,
                                    size: 16.r,
                                  ),
                                  Text(
                                    translateDatabase(
                                        arabic: controller.model.countryNameAr!,
                                        english:
                                            controller.model.countryNameEn!),
                                    style: getMediumStyle(context).copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.r,
                                    ),
                                  ),
                                  Text(
                                    "-",
                                    style: getBoldStyle(context),
                                  ),
                                  Text(
                                    translateDatabase(
                                        arabic:
                                            controller.model.governmentNameAr!,
                                        english:
                                            controller.model.governmentNameEn!),
                                    style: getRegularStyle(context).copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.r,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Gap(10),
                        Text(
                          controller.model.description!,
                          style: TextStyle(
                            fontSize: 15.r,
                            color: blackColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Gap(24),
                        Text(
                          "Price Offers".tr,
                          style: TextStyle(
                            fontSize: 15.r,
                            color: blackColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gap(16),
                        Get.find<AppPreferences>().getUserId() !=
                                controller.model.userId
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomServerStatusWidget(
                                    statusRequest: controller.statusRequest,
                                    child: ListView.separated(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) =>
                                            PriceOfferWidget(
                                              model: controller
                                                  .providerOffers[index],
                                            ),
                                        separatorBuilder: (context, index) =>
                                            Gap(15),
                                        itemCount:
                                            controller.providerOffers.length),
                                  ),
                                  Gap(24),
                                  if (controller.model.status != "Closed")
                                    SizedBox(
                                      width: 250.w,
                                      height: 35.h,
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              shape: WidgetStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          customBorderRadius)),
                                              padding: WidgetStatePropertyAll(
                                                  EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5))),
                                          onPressed: () {
                                            controller.addPriceDialog();
                                          },
                                          child: Text(
                                            "${"Add Price Offer".tr}   +".tr,
                                            style: TextStyle(
                                                fontSize: 15.r,
                                                fontWeight: FontWeight.w600),
                                          )),
                                    ),
                                ],
                              )
                            : Column(
                                children: [
                                  Text(
                                    "Price Offers".tr,
                                    style: getMediumStyle(context).copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Divider(),
                                  CustomServerStatusWidget(
                                    statusRequest: controller.statusRequest,
                                    child: ListView.separated(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) =>
                                            PriceOfferWidget(
                                              model:
                                                  controller.priceOffers[index],
                                            ),
                                        separatorBuilder: (context, index) =>
                                            Gap(15),
                                        itemCount:
                                            controller.priceOffers.length),
                                  )
                                ],
                              )
                      ],
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
