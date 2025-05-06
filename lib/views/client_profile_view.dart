import 'package:b2b_partenership/controller/client_profile_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '/core/functions/translate_database.dart';
import '/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ClientProfileView extends StatelessWidget {
   ClientProfileView({super.key});
final controller = Get.put(ClientProfileController());
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Client Profile'.tr,
          style: getSemiBoldStyle(context).copyWith(color: Colors.black),
        ),
      ),
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
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: CustomLoadingButton(
                    onPressed: () {
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
      body: SafeArea(
        child: GetBuilder<ClientProfileController>(builder: (controller) {
          return controller.clientModel == null
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 110.h,
                        width: 110.h,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: controller.clientModel!.image!,
                            )),
                      ),
                      Gap(10),
                      titleWidget(
                        "Name".tr,
                        controller.clientModel!.name!,
                      ),
                      Gap(15),
                      titleWidget(
                        "Phone".tr,
                        '+${controller.clientModel!.countryCode!}${controller.clientModel!.phone!}',
                      ),
                      Gap(15),
                      titleWidget(
                        "Email".tr,
                        controller.clientModel!.email!,
                      ),
                      Gap(15),
                      titleWidget(
                        "From".tr,
                        "${translateDatabase(arabic: controller.clientModel!.countryNameAr!, english: controller.clientModel!.countryNameEn!)}",
                      ),
                      Gap(15),
                      titleWidget(
                        "City".tr,
                        "${translateDatabase(arabic: controller.clientModel!.governmentNameAr!, english: controller.clientModel!.governmentNameEn!)}",
                      ),
                    ],
                  ),
                );
        }),
      ),
    );
  }

  Widget titleWidget(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Gap(10),
              Text(
                "$title: ",
                style: TextStyle(
                    fontSize: 16.r,
                    color: blackColor,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        //Gap(10.w),
        Expanded(
          flex: 4,
          child: Row(
            children: [
              Gap(30.w),
              Text(
                value,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.r,
                    color: Colors.black54),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        )
      ],
    );
  }
}
