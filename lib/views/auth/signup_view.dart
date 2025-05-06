import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/auth/signup_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

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
                                      size: 26.r,
                                    ),
                                  )
                                : IconButton(
                                    onPressed: controller.previousStep,
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      size: 26.r,
                                    ),
                                  ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.asset(
                            "assets/images/logo.png",
                            height: 55.h,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    Gap(20),
                    Text(
                      "Create a New Account".tr,
                      style: getSemiBoldStyle(context).copyWith(
                        fontWeight: FontWeight.w500,
                        color: blackColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(
                            '${"Step".tr} ${controller.currentStep + 1} ${"of".tr} ${controller.providerSteps.length}  ',
                            style: getLightStyle(context).copyWith(
                              fontWeight: FontManager.regularFontWeight,
                            ),
                          ),
                          Expanded(
                            child: LinearProgressIndicator(
                              minHeight: 8.h,
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
                    Row(
                      children: [
                        Checkbox(
                          value: controller.isCheckbox,
                          onChanged: (value) {
                            controller.checkBox(value);
                          },
                          activeColor: Colors.white,
                          checkColor: primaryColor,
                          fillColor: WidgetStatePropertyAll(
                              Colors.grey.withOpacity(0.2)),
                        ),
                        Text("I Accept".tr,
                            style: TextStyle(
                                color: blackColor,
                                fontSize: 14.r,
                                fontWeight: FontWeight.normal)),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.termsAndConditions);
                          },
                          child: Text("Terms & Conditions".tr,
                              style: TextStyle(
                                  color: blackColor,
                                  fontSize: 14.r,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.normal)),
                        )
                      ],
                    ),
                    CustomLoadingButton(
                      onPressed: () => controller.goToOtp(),
                      width: 0.75.sw,
                      text: controller.currentStep ==
                              controller.providerSteps.length - 1
                          ? 'Finish'.tr
                          : 'Next'.tr,
                    ),
                    Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?".tr,
                          style: context.isTablet
                              ? getRegularStyle(context).copyWith(
                                  color: greyColor, fontWeight: FontWeight.bold)
                              : getLightStyle(context).copyWith(
                                  color: greyColor,
                                  fontWeight: FontWeight.bold,
                                ),
                        ),
                        Gap(5.w),
                        InkWell(
                          onTap: () {
                            Get.offNamed(AppRoutes.login);
                          },
                          child: Text(
                            "Login".tr,
                            style: context.isTablet
                                ? getMediumStyle(context).copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  )
                                : getRegularStyle(context).copyWith(
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
