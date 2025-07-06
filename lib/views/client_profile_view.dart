import 'package:b2b_partenership/controller/client_profile_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:flutter/cupertino.dart';

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
        centerTitle: true,
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
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: 70,
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                      color: primaryColor, borderRadius: customBorderRadius),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CustomNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: controller.clientModel!.image!,
                            )),
                      ),
                      Gap(8),
                      Text(
                        controller.clientModel!.name!,
                        style: getBoldStyle(context).copyWith(
                          color: Colors.black,
                          fontSize: 16.r,
                        ),
                      ),
                      Gap(15),
                      titleWidget(
                        Icons.phone_in_talk,
                        '(+${controller.clientModel!.countryCode!}) ${controller.clientModel!.phone!}',
                      ),
                      Gap(15),
                      titleWidget(
                        Icons.email,
                        controller.clientModel!.email!,
                      ),
                      Gap(15),
                      titleWidget(
                        CupertinoIcons.location_fill,
                        "${translateDatabase(arabic: controller.clientModel!.countryNameAr!, english: controller.clientModel!.countryNameEn!)}",
                      ),
                      Gap(15),
                      titleWidget(
                        Icons.location_on,
                        "${translateDatabase(arabic: controller.clientModel!.governmentNameAr!, english: controller.clientModel!.governmentNameEn!)}",
                      ),
                    ],
                  ),
                );
        }),
      ),
    );
  }

  Widget titleWidget(IconData icon, String value) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 20.r,
          ),
          Gap(8),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.r,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
