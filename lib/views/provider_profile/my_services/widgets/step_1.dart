import 'package:b2b_partenership/controller/settings/provider/my_services/add_provider_service_controller.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/posts/build_text_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProviderServiceStep1 extends StatelessWidget {
  const ProviderServiceStep1({
    super.key,
    required this.controller,
  });
  final AddProviderServiceController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: GestureDetector(
            onTap: controller.galleryImage,
            child: controller.imageFile != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.file(
                      controller.imageFile!,
                      height: 160.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    height: 160.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: lightPrimaryColor.withAlpha(160),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.photo,
                          size: 60.r,
                          color: primaryColor,
                        ),
                        Gap(8),
                        Text(
                          "Add Service Image".tr,
                          style: getRegularStyle(context).copyWith(
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.r),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        Gap(16),
        buildTextField(
          controller.titleEnController,
          'Title'.tr,
          Icons.title,
          "enter title".tr,
          (val) {
            return controller.validUserData(val);
          },
        ),
        Gap(4),
        buildTextField(
          controller.descriptionController,
          'Description'.tr,
          Icons.description,
          "enter service description".tr,
          (val) {
            return controller.validUserData(val);
          },
        ),
        Gap(4),
        buildTextField(
          controller.addressController,
          'Address'.tr,
          Icons.location_on,
          "enter address".tr,
          (val) {
            return controller.validUserData(val);
          },
        ),
        Gap(4),
        buildTextField(
          controller.overviewController,
          'Overview'.tr,
          Icons.location_on,
          "enter service overview".tr,
          (val) {
            return controller.validUserData(val);
          },
        ),
        Gap(4),
        buildTextField(
          controller.videoController,
          'Video Link'.tr,
          Icons.location_on,
          "enter service video (optional)".tr,
          (val) {
            return controller.validUserData(val);
          },
          hasValidation: false,
        ),
        Gap(16),
      ],
    );
  }
}
