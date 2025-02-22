import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/auth/signup_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ProviderSignupView extends StatelessWidget {
  const ProviderSignupView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(SignupController());
    return GetBuilder<SignupController>(
      init: SignupController(),
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            controller.currentStep == 0
                                ? IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      size: 26.sp,
                                    ))
                                : IconButton(
                                    onPressed: controller.previousStep,
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      size: 26.sp,
                                    )),
                          ],
                        ),
                        Image.asset(
                          "assets/images/logo.png",
                          height: 70.h,
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                    Gap(20),
                    Text(
                      "Create a New Account",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: blackColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(
                              'Step ${controller.currentStep + 1} of ${controller.providerSteps.length}  '),
                          Expanded(
                            child: LinearProgressIndicator(
                              borderRadius: BorderRadius.circular(30),
                              value: (controller.currentStep + 1) /
                                  controller.providerSteps.length,
                              backgroundColor: Colors.grey[300],
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(30),
                    SizedBox(
                      child: controller.providerSteps[controller.currentStep],
                    ),
                    CustomLoadingButton(
                        onPressed: () {
                          Logger().f(controller.currentStep);
                          if (controller.currentStep ==
                              controller.providerSteps.length - 1) {
                            return Get.toNamed(
                              AppRoutes.otp,
                              arguments: {
                                'email': controller.emailController.text,
                                'fromAuth': true,
                                'role': controller.role,
                              },
                            );
                            // controller.role == "provider"
                            //     ? controller.signupProvider()
                            //     : controller.signupClient();
                          } else {
                            return controller.nextStep;
                          }
                        },
                        text: controller.currentStep ==
                                controller.providerSteps.length - 1
                            ? 'Finish'
                            : 'Next'),
                    Gap(10),
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
                              color: primaryColor,
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
        ),
      ),
    );
  }
}
