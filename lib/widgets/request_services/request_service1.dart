import 'package:b2b_partenership/controller/request_services/add_request_service_controller.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/request_services/build_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class RequestService1 extends StatelessWidget {
  const RequestService1({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddRequestServiceController>(builder: (controller) {
      return Column(
        children: [
          Center(
            child: GestureDetector(
              onTap: controller.galleryImage,
              child: controller.imageFile != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.file(controller.imageFile!,
                          height: 130.h, width: 180.h, fit: BoxFit.cover),
                    )
                  : Container(
                      height: 130.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image,
                              size: 50.r, color: Colors.grey.shade700),
                          Gap(10),
                          Text(
                            "upload image is (optional)".tr,
                            style: getRegularStyle(context),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
          Gap(40),
          buildTextField(controller.titleEnController, 'Name'.tr, Icons.title,
              "enter service name".tr, (val) {
            return controller.validUserData(val);
          }),
          Gap(20.h),
          buildTextField(controller.descriptionController, 'Description'.tr,
              Icons.description, "enter service description".tr, (val) {
            return controller.validUserData(val);
          }),
          Gap(20.h),
          buildTextField(controller.addressController, 'Address'.tr,
              Icons.location_on, "enter service address".tr, (val) {
            return controller.validUserData(val);
          }),
          Gap(20.h),
        ],
      );
    });
  }
}
