import 'package:b2b_partenership/controller/auth/login_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../app_routes.dart';
import '../../widgets/auth/auth_text_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      backgroundColor: whiteColor,
      // appBar: AppBar(
      //   title: const Text('LoginView'),
      // ),
      body: SafeArea(
        bottom: false,
        child: GetBuilder<LoginController>(
          init: LoginController(),
          builder: (controller) => Column(
            children: [
              Expanded(
                flex: 2,
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 150.h,
                  // width: 100,
                  fit: BoxFit.fill,
                ), //AuthLogoWidget(),
              ),
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      // vertical: 25.h,
                    ),
                    //width: double.infinity,
                    height: 0.7.sh,
                    decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Gap(10.h),
                        Text(
                          "Welcome Back!".tr,
                          style: TextStyle(
                              fontSize: 17.sp,
                              color: blackColor,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Login with your phone and password".tr,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.black54,
                          ),
                        ),
                        Gap(0.03.sh),
                        AuthTextForm(
                          validator: (val) {
                            return controller.validUserData(val);
                          },
                          textFormController: controller.phoneController,
                          lable: "Email".tr,
                          preicon: CupertinoIcons.phone,
                          hintText: "Enter your email".tr,
                          //formBorderColor: blackColor,
                        ),
                        Gap(20.h),
                        AuthTextForm(
                          validator: (val) {
                            return controller.validUserData(val);
                          },
                          textFormController: controller.passwordController,
                          onTapIconsuf: () {
                            controller.ontapSupfix();
                          },
                          obscureText: controller.obscureText,
                          lable: "Password".tr,
                          sufcolor: Colors.black54,
                          suficon: controller.obscureText
                              ? Icons.remove_red_eye_outlined
                              : Icons.visibility_off_outlined,
                          preicon: CupertinoIcons.lock,
                          // formBorderColor: blackColor,
                          hintText: "Enter password".tr,
                        ),
                        Gap(10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(AppRoutes.forgetPassword);
                              },
                              child: Text(
                                "Forget Password?".tr,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: blackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(0.03.sh),
                        SizedBox(
                          height: 38.h,
                          child: CustomLoadingButton(
                            text: "Login".tr,
                            onPressed: () {
                              //controller.login();
                            },
                            backgroundColor: primaryColor,
                            height: 0.06.sh,
                          ),
                        ),
                        Gap(0.02.sh),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have account?".tr,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.black54,
                              ),
                            ),
                            Gap(5.w),
                            InkWell(
                              onTap: () {
                                Get.toNamed(AppRoutes.chooseAccount);
                              },
                              child: Text(
                                "Create New".tr,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: blackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
