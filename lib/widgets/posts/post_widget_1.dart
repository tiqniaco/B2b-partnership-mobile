import 'package:b2b_partenership/controller/posts/add_post_controller.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/posts/build_text_form.dart';
import 'package:b2b_partenership/widgets/select_city_widget.dart';
import 'package:b2b_partenership/widgets/select_country_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PostWidget1 extends StatelessWidget {
  const PostWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPostController>(builder: (controller) {
      return Column(
        children: [
          Center(
            child: GestureDetector(
              onTap: controller.galleryImage,
              child: controller.imageFile != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.file(controller.imageFile!,
                          height: 150.h,
                          width: double.infinity,
                          fit: BoxFit.cover),
                    )
                  : Container(
                      height: 150.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: lightPrimaryColor.withAlpha(160),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.photo,
                              size: 60.r, color: primaryColor),
                          Gap(10),
                          Text(
                            "upload image is (optional)".tr,
                            style: getRegularStyle(context).copyWith(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.r),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
          Gap(24),
          buildTextField(controller.titleController, 'Name'.tr, Icons.title,
              "enter service name".tr, (val) {
            return controller.validUserData(val);
          }),
          Gap(16),
          buildTextField(controller.descriptionController, 'Description'.tr,
              Icons.description, "enter service description".tr, (val) {
            return controller.validUserData(val);
          }),
          Gap(16),
          buildTextField(controller.addressController, 'Address'.tr,
              Icons.location_on, "enter service address".tr, (val) {
            return controller.validUserData(val);
          }),
          Gap(16),
          SelectCountryWidget(
            enabled: false,
            value: controller.selectedCountry,
            models: controller.countries,
            onChanged: (val) {
              controller.onCountryChanged(val);
            },
          ),
          Gap(16),
          SelectCityWidget(
            value: controller.selectedCity,
            models: controller.cities,
            onChanged: (val) {
              controller.onCityChanged(val);
            },
          ),
          Gap(20.h),
        ],
      );
    });
  }
}
