import 'package:b2b_partenership/controller/previous_work/provider_profile_controller.dart';
import 'package:b2b_partenership/core/functions/get_text_direction.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/app_pdf_view.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/about_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AboutWidget extends StatelessWidget {
  const AboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProviderProfileController());
    return GetBuilder<ProviderProfileController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleWidget("Country".tr, icon: Icons.location_on),
                      Gap(4),
                      valueWidget(translateDatabase(
                          arabic: controller.providerModel!.countryNameAr,
                          english: controller.providerModel!.countryNameEn)),
                      Gap(24),
                      titleWidget("Email".tr, icon: Icons.email),
                      Gap(4),
                      valueWidget(controller.providerModel!.email),
                      if (controller.providerModel!.commercialRegisterNumber !=
                          "") ...[
                        Gap(20.h),
                        titleWidget("Commercial No.".tr),
                        Gap(4),
                        valueWidget(controller
                            .providerModel!.commercialRegisterNumber
                            .toString()),
                        Gap(24),
                        titleWidget("VAT No.".tr),
                        Gap(4),
                        valueWidget(controller.providerModel!.vat.toString())
                      ],
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleWidget("City".tr, icon: Icons.location_on),
                      Gap(4),
                      valueWidget(translateDatabase(
                          arabic: controller.providerModel!.governmentNameAr,
                          english: controller.providerModel!.governmentNameEn)),
                      Gap(24),
                      titleWidget("Phone".tr, icon: Icons.phone),
                      Gap(4),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Row(
                          children: [
                            Text(
                              "+${controller.providerModel!.countryCode}",
                              style: getRegularStyle(Get.context!).copyWith(
                                color: blackColor,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Gap(4),
                            Text(
                              controller.providerModel!.phone,
                              style: getRegularStyle(Get.context!).copyWith(
                                color: blackColor,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      if (controller.providerModel!.commercialRegisterNumber !=
                          "") ...[
                        Gap(24),
                        titleWidget("Tax No.".tr),
                        Gap(4),
                        valueWidget(controller.providerModel!.taxCardNumber),
                        Gap(24),
                        titleWidget("".tr),
                        Gap(4),
                        valueWidget("")
                      ],
                    ],
                  ),
                ],
              ),
              Gap(24),
              Text(
                "Provider Type".tr,
                style: getRegularStyle(Get.context!).copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gap(4),
              Text(
                translateDatabase(
                    arabic: controller.providerModel!.providerTypeNameAr,
                    english: controller.providerModel!.providerTypeNameEn),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: context.isTablet ? 8.sp : 14.sp,
                  color: Colors.black,
                ),
              ),
              Gap(24),
              Text(
                "Bio".tr,
                style: getRegularStyle(Get.context!).copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gap(4),
              Text(
                controller.providerModel!.bio,
                textDirection: containsArabic(controller.providerModel!.bio)
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: context.isTablet ? 8.r : 14.r,
                  color: Colors.black,
                ),
              ),
              Gap(15.h),
              if (controller.providerModel!.commercialRegisterNumber != "") ...[
                Row(
                  children: [
                    Text(
                      "${"Commercial Papers".tr}: ",
                      style: getRegularStyle(Get.context!).copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => AppPdfView(
                            url: controller.providerModel!.commercialRegister,
                          ),
                        );
                      },
                      child: Text(
                        "View".tr,
                        style: getRegularStyle(context).copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 250,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: PDF().cachedFromUrl(
                      controller.providerModel!.commercialRegister,
                      placeholder: (progress) =>
                          Center(child: Text('loading...'.tr)),
                      errorWidget: (error) =>
                          Center(child: Text(error.toString())),
                    ),
                  ),
                ),
                Gap(40),
                Row(
                  children: [
                    Gap(10),
                    Text(
                      "${"Tax Papers".tr}: ",
                      style: getRegularStyle(Get.context!).copyWith(
                        color: blackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => AppPdfView(
                            url: controller.providerModel!.taxCard,
                          ),
                        );
                      },
                      child: Text(
                        "View".tr,
                        style: getRegularStyle(context).copyWith(
                            color: primaryColor, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                Gap(20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 200.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: PDF().cachedFromUrl(
                      controller.providerModel!.taxCard,
                      placeholder: (progress) =>
                          Center(child: Text('loading...')),
                      errorWidget: (error) =>
                          Center(child: Text(error.toString())),
                    ),
                  ),
                ),
                Gap(40),
              ]
            ],
          ),
        ),
      );
    });
  }
}
