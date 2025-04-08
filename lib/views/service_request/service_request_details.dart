import 'package:b2b_partenership/controller/request_services/service_request_details_controller.dart';
import 'package:b2b_partenership/core/constants/app_constants.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/request_services/price_offer_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
        builder: (controller) => SingleChildScrollView(
          controller: controller.scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  if (controller.model.image != null) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18.r),
                        topRight: Radius.circular(18.r),
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
                  PositionedDirectional(
                    top: 30.h,
                    start: 10.h,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 25.r,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (controller.model.image == null) Gap(50),
              Gap(15),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (controller.model.image == null)
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 20.r,
                              ),
                            ),
                          Gap(10),
                          Text(
                            controller.model.titleEn!,
                            style: getSemiBoldStyle(context).copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Gap(10),
                      Text(
                        controller.model.description!,
                        style: getMediumStyle(context),
                      ),
                      Gap(15),
                      Row(
                        children: [
                          Text(
                            translateDatabase(
                                arabic: controller.model.specializationNameAr!,
                                english:
                                    controller.model.specializationNameEn!),
                            style: getRegularStyle(context).copyWith(
                              color: greyColor,
                            ),
                          ),
                          Gap(10),
                          Icon(
                            Icons.remove,
                            size: 15.r,
                            color: greyColor,
                          ),
                          Gap(10),
                          Text(
                            translateDatabase(
                                arabic:
                                    controller.model.subSpecializationNameAr!,
                                english:
                                    controller.model.subSpecializationNameEn!),
                            style: getRegularStyle(context).copyWith(
                              color: greyColor,
                            ),
                          ),
                        ],
                      ),
                      Gap(10),
                      Center(
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 15,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // CachedNetworkImage(
                                //   imageUrl: controller.model.countryFlag!,
                                //   height: 20.h,
                                // ),
                                Text(
                                  controller.model.countryFlag!,
                                  style: getMediumStyle(context),
                                ),
                                Gap(10),
                                Text(
                                  translateDatabase(
                                      arabic: controller.model.countryNameAr!,
                                      english: controller.model.countryNameEn!),
                                  style: getMediumStyle(context),
                                ),
                                Gap(15),
                                Icon(
                                  Icons.remove,
                                  size: 15.r,
                                ),
                                Gap(15),
                                Text(
                                  translateDatabase(
                                      arabic:
                                          controller.model.governmentNameAr!,
                                      english:
                                          controller.model.governmentNameEn!),
                                  style: getRegularStyle(context),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Gap(20),
                      Get.find<AppPreferences>().getUserRole() == "client"
                          ? Column(
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
                                      itemCount: controller.priceOffers.length),
                                )
                              ],
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  width: 158.w,
                                  height: 35.h,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          padding: WidgetStatePropertyAll(
                                              EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 5))),
                                      onPressed: () {
                                        controller.addPriceDialog();
                                      },
                                      child: Text(
                                        "Add price offer".tr,
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500),
                                      )),
                                ),
                                Gap(10),
                                CustomServerStatusWidget(
                                  statusRequest: controller.statusRequest,
                                  child: ListView.separated(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
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
                                )
                              ],
                            )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
