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

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupController>(
      init: SignupController(),
      builder: (SignupController controller) => Form(
        key: controller.formKeyCustomer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.//,
          children: [
            Gap(0.02.sh),
            Text(
              "Welcome B2B!".tr,
              style: TextStyle(
                fontSize: 17.sp,
                color: green,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text(
                  "B2B Account".tr,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            Gap(12.h),
            AuthTextForm(
              lable: "Full Name".tr,
              preicon: CupertinoIcons.person,
              hintText: "Full Name".tr,
              validator: (val) {
                return controller.validUserData(val);
              },
              textFormController: controller.usernameController,
            ),
            Gap(10.h),
            AuthTextForm(
              lable: "phone".tr,
              preicon: CupertinoIcons.phone,
              hintText: 'phone'.tr,
              validator: (val) {
                return controller.validUserData(val);
              },
              textFormController: controller.phoneController,
            ),
            Gap(10.h),
            AuthTextForm(
              lable: "email".tr,
              preicon: CupertinoIcons.mail,
              hintText: 'email'.tr,
              validator: (val) {
                return controller.validUserData(val);
              },
              textFormController: controller.emailController,
            ),
            Gap(10.h),
            AuthTextForm(
              validator: (val) {
                return controller.validUserData(val);
              },
              lable: "password".tr,
              sufcolor: Colors.black54,
              obscureText: controller.customerObscureText,
              suficon: controller.customerObscureText
                  ? Icons.remove_red_eye_outlined
                  : Icons.visibility_off_outlined,
              onTapIconsuf: controller.changeCustomerPasswordVisibility,
              preicon: CupertinoIcons.lock,
              hintText: 'password'.tr,
              textFormController: controller.passwordController,
            ),
            Gap(20.h),
            CustomLoadingButton(
              text: "Signup".tr,
              onPressed: () {
                //return controller.singup();
              },
              backgroundColor: deepBaby,
            ),
            Gap(0.02.sh),
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
            Gap(20.h),
          ],
        ),
      ),
    );
  }
}
