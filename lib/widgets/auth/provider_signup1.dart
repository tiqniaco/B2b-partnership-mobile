import 'package:b2b_partenership/controller/auth/signup_controller.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'auth_text_form.dart';

class ProviderSignup1 extends StatelessWidget {
  const ProviderSignup1({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());
    return GetBuilder<SignupController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              controller.imageFile == null
                  ? Container(
                      padding: EdgeInsets.all(35),
                      decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          shape: BoxShape.circle),
                      child: Icon(
                        CupertinoIcons.person_solid,
                        size: 50.sp,
                        color: greyColor,
                      ),
                    )
                  : CircleAvatar(
                      radius: 100.sp / 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(130),
                        child: Image.file(
                          height: 100.sp,
                          width: 100.sp,
                          fit: BoxFit.cover,
                          controller.imageFile!,
                        ),
                      ),
                    ),
              Positioned(
                bottom: 10,
                child: InkWell(
                  onTap: () {
                    controller.gallaryImage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        shape: BoxShape.circle),
                    child: CircleAvatar(
                      radius: 15.r,
                      backgroundColor: const Color.fromARGB(255, 241, 241, 242),
                      child: Icon(
                        CupertinoIcons.camera,
                        size: 15.r,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Gap(15),
          Text(
            "uploading image is optional".tr,
            style: TextStyle(fontSize: 13.sp, color: green),
          ),

          Gap(20.h),
          AuthTextForm(
            lable: "Full Name".tr,
            preicon: CupertinoIcons.person,
            hintText: "Enter your full name".tr,
            textFormController: controller.usernameController,
            validator: (val) {
              return controller.validUserData(val);
            },
          ),

          // Gap(20.h),
          // AuthTextForm(
          //   lable: "Phone".tr,
          //   preicon: CupertinoIcons.phone,
          //   hintText: "Enter your phone".tr,
          //   textFormController: controller.phoneController,
          //   validator: (val) {
          //     return controller.validUserData(val);
          //   },
          // ),

          Gap(20.h),
          AuthTextForm(
            lable: "Email".tr,
            preicon: CupertinoIcons.mail,
            hintText: 'Enter your email'.tr,
            textFormController: controller.emailController,
            validator: (val) {
              return controller.validUserData(val);
            },
          ),
         
          Gap(20.h),
          AuthTextForm(
            lable: "Password".tr,
            sufcolor: Colors.black54,
            preicon: CupertinoIcons.lock,
            hintText: '***********'.tr,
            validator: (val) {
              return controller.validUserData(val);
            },
            textFormController: controller.passwordController,
            obscureText: controller.customerObscureText,
            suficon: controller.customerObscureText
                ? Icons.remove_red_eye_outlined
                : Icons.visibility_off_outlined,
            onTapIconsuf: controller.changeCustomerPasswordVisibility,
          ),
          Gap(20.h),
        ],
      ),
    );
  }
}
