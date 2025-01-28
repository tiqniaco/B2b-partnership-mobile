import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/auth/signup_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProviderSignupView extends StatelessWidget {
  const ProviderSignupView({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   Get.put(SignupController());
  //   return Scaffold(
  //     body: GetBuilder<SignupController>(
  //       builder: (controller) => Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //         child: SafeArea(
  //             bottom: false,
  //             child: SingleChildScrollView(
  //               child: GetBuilder<SignupController>(
  //                 builder: (controller) => CustomServerStatusWidget(
  //                   statusRequest: controller.statusRequest,
  //                   child: Form(
  //                     key: controller.formKeyCustomer,
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       children: [
  //                         Row(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Column(
  //                               children: [
  //                                 Gap(30),
  //                                 IconButton(
  //                                     onPressed: () {},
  //                                     icon: Icon(Icons.arrow_back_ios)),
  //                               ],
  //                             ),
  //                             Image.asset(
  //                               "assets/images/logo.png",
  //                               height: 150.h,
  //                               // width: 100,
  //                               fit: BoxFit.fill,
  //                             ),
  //                           ],
  //                         ),
  //                         Text(
  //                           "Create a New Account".tr,
  //                           style: TextStyle(
  //                               fontSize: 20.sp,
  //                               color: blackColor,
  //                               fontWeight: FontWeight.bold),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.all(16.0),
  //                           child: Row(
  //                             children: [
  //                               Text(
  //                                   'Step ${controller.currentStep + 1} of ${controller.providerSteps.length}  '),
  //                               Expanded(
  //                                 child: LinearProgressIndicator(
  //                                   value: (controller.currentStep + 1) /
  //                                       controller.providerSteps.length,
  //                                   backgroundColor: Colors.grey[300],
  //                                   color: primaryColor,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           child: controller
  //                               .providerSteps[controller.currentStep],
  //                         ),
  //                         Gap(20.h),
  //                         CustomLoadingButton(
  //                           text: controller.currentStep ==
  //                                   controller.providerSteps.length - 1
  //                               ? 'Finish'.tr
  //                               : 'Next'.tr,
  //                           onPressed: controller.nextStep,
  //                           backgroundColor: primaryColor,
  //                         ),
  //                         Gap(10.h),
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             Text(
  //                               "Already have account?".tr,
  //                               style: TextStyle(
  //                                 fontSize: 12.sp,
  //                                 color: Colors.black54,
  //                               ),
  //                             ),
  //                             Gap(5.w),
  //                             InkWell(
  //                               onTap: () {
  //                                 Get.offNamed(AppRoutes.login);
  //                               },
  //                               child: Text(
  //                                 "Login".tr,
  //                                 style: TextStyle(
  //                                   fontSize: 13.sp,
  //                                   fontWeight: FontWeight.w600,
  //                                   color: primaryColor,
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             )),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());
    return GetBuilder<SignupController>(
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                        // width: 100,
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
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0), // X and Y offset
                          blurRadius: 4.0, // How blurry the shadow is
                          color: Colors.grey, // Shadow color
                        ),
                      ],
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
                        return controller.nextStep;
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
    );
  }
}
