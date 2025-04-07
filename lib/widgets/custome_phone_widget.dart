import 'package:b2b_partenership/controller/auth/signup_controller.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CustomPhoneWidget extends StatelessWidget {
  const CustomPhoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());
    return GetBuilder<SignupController>(builder: (controller) {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: TextFormField(
          keyboardType: TextInputType.phone,
          controller: controller.phoneController,
          maxLength: int.parse(controller.selectedCountry.phoneLength!),
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Text(
              "Phone".tr,
              style: getMediumStyle(context).copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
            prefixIcon: SizedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Gap(5),
                  Icon(
                    Icons.arrow_drop_down_sharp,
                    color: blackColor,
                    size: 20.r,
                  ),
                  Gap(5),
                  Text(
                    controller.selectedCountry.flag!,
                    style: getMediumStyle(context),
                  ),
                  Gap(6),
                  Text(
                    "+${controller.selectedCountry.code}",
                    style: getRegularStyle(context),
                  ),
                  Gap(8),
                  Container(
                    width: 2,
                    height: 25.h,
                    color: pageColor,
                  ),
                  Gap(10)
                ],
              ),
            ),
            hintText: "Without country code".tr,
            hintStyle: getLightStyle(context).copyWith(
              color: greyColor.withAlpha(160),
              fontWeight: FontWeight.w500,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: blackColor,
              ),
            ),
          ),
        ),
      );
    });
  }
}
