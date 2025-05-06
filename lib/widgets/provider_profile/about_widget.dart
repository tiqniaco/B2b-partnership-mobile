import 'package:b2b_partenership/controller/previous_work/provider_profile_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/app_pdf_view.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:flutter/cupertino.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Gap(20),
              Divider(
                thickness: 3,
              ),
              Gap(10),
              titleWidget("Name".tr, controller.providerModel!.name,
                  CupertinoIcons.person),
              Gap(15),

              titleWidget("Phone".tr, controller.providerModel!.phone,
                  CupertinoIcons.phone),
              Gap(15),
              titleWidget(
                  "Department".tr,
                  "${translateDatabase(arabic: controller.providerModel!.specializationNameAr, english: controller.providerModel!.specializationNameEn)}",
                  CupertinoIcons.rectangle_3_offgrid),
              Gap(15),
              titleWidget(
                  "Specialization".tr,
                  "${translateDatabase(arabic: controller.providerModel!.subSpecializationNameAr, english: controller.providerModel!.subSpecializationNameEn)}",
                  Icons.account_tree_outlined),
              Gap(15),
              titleWidget("Email".tr, controller.providerModel!.email,
                  CupertinoIcons.mail),
              Gap(15),
              titleWidget(
                  "From".tr,
                  "${translateDatabase(arabic: controller.providerModel!.countryNameAr, english: controller.providerModel!.countryNameEn)}",
                  CupertinoIcons.map_pin_ellipse),
              Gap(15),
              titleWidget(
                  "City".tr,
                  "${translateDatabase(arabic: controller.providerModel!.governmentNameAr, english: controller.providerModel!.governmentNameEn)}",
                  Icons.location_city),
              Gap(20),
              Row(
                children: [
                  Gap(10),
                  Text(
                    "${"Commercial Papers".tr}: ",
                    style: getMediumStyle(context).copyWith(
                      color: blackColor,
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
                        fontWeight: FontWeight.w500,
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
                height: 230.h,
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
                    style: getMediumStyle(context).copyWith(
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
                          color: primaryColor, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              Gap(20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 300,
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
            ],
          ),
        ),
      );
    });
  }

  Widget titleWidget(String title, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Gap(10),
              Text(
                "$title: ",
                style: Get.context!.isTablet
                    ? getMediumStyle(Get.context!).copyWith(
                        color: blackColor,
                        fontWeight: FontWeight.w500,
                      )
                    : getRegularStyle(Get.context!).copyWith(
                        color: blackColor,
                        fontWeight: FontWeight.w500,
                      ),
              ),
            ],
          ),
        ),
        Gap(10.w),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: Get.context!.isTablet
                ? getMediumStyle(Get.context!).copyWith(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )
                : getRegularStyle(Get.context!).copyWith(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
