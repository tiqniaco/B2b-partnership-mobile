import 'package:b2b_partenership/controller/auth/signup_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../core/theme/app_color.dart';
import '../../app_routes.dart';
import 'auth_text_form.dart';

class ProviderSignup3 extends StatelessWidget {
  const ProviderSignup3({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());
    return GetBuilder<SignupController>(
      builder: (controller) => Form(
        key: controller.formKeyCustomer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                controller.imageFile == null
                    ? Icon(
                        CupertinoIcons.person_alt_circle,
                        size: 100.sp,
                        color: babyBlueColor,
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
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(30),
                      child: CircleAvatar(
                        radius: 17.r,
                        backgroundColor: Colors.white,
                        child: Icon(
                          CupertinoIcons.camera,
                          size: 17.r,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "uploading image is optional".tr,
              style: TextStyle(fontSize: 13.sp, color: green),
            ),
            Gap(10.h),
            AuthTextForm(
              lable: "Full Name".tr,
              preicon: CupertinoIcons.person,
              hintText: "Full Name".tr,
              textFormController: controller.usernameController,
              validator: (val) {
                return controller.validUserData(val);
              },
            ),
            Gap(10.h),
            AuthTextForm(
              lable: "phone".tr,
              preicon: CupertinoIcons.phone,
              hintText: "phone".tr,
              textFormController: controller.phoneController,
              validator: (val) {
                return controller.validUserData(val);
              },
            ),
            Gap(10.h),
            AuthTextForm(
              lable: "email".tr,
              preicon: CupertinoIcons.mail,
              hintText: 'email'.tr,
              textFormController: controller.emailController,
              validator: (val) {
                return controller.validUserData(val);
              },
            ),
            Gap(10.h),
            AuthTextForm(
              lable: "password".tr,
              sufcolor: Colors.black54,
              preicon: CupertinoIcons.lock,
              hintText: 'password'.tr,
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
            CustomLoadingButton(
              text: "Signup".tr,
              onPressed: () {
                //return controller.singup();
              },
              backgroundColor: deepBaby,
            ),
            Gap(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have account?".tr,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black54,
                  ),
                ),
                Gap(5.w),
                InkWell(
                  onTap: () {
                    Get.offNamed(AppRoutes.login);
                  },
                  child: Text(
                    "Login".tr,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: green,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
