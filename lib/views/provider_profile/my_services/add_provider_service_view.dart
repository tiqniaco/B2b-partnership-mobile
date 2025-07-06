import 'package:b2b_partenership/controller/settings/provider/my_services/add_provider_service_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/views/provider_profile/my_services/widgets/step_1.dart';
import 'package:b2b_partenership/views/provider_profile/my_services/widgets/step_2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AddProviderServiceView extends StatelessWidget {
  const AddProviderServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddProviderServiceController>(
      init: AddProviderServiceController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: context.isTablet ? 45.h : null,
            iconTheme: IconThemeData(color: blackColor),
            title: Text(
              'Add Service'.tr,
              style: getSemiBoldStyle(context),
            ),
          ),
          body: controller.selectedCity == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: controller.formKey,
                  child: Stepper(
                    currentStep: controller.currentStep,
                    onStepContinue: controller.onStepContinue,
                    onStepCancel: controller.onStepCancel,
                    onStepTapped: controller.onStepTaped,
                    controlsBuilder: (_, controls) {
                      return Row(
                        children: [
                          controller.currentStep > 0
                              ? TextButton(
                                  onPressed: controls.onStepCancel,
                                  child: Text(
                                    'Previous'.tr,
                                    style: getRegularStyle(context),
                                  ),
                                )
                              : SizedBox.shrink(),
                          Gap(10.w),
                          if (controller.currentStep != 2)
                            CustomLoadingButton(
                              borderRadius: 10.r,
                              height: 30.h,
                              width: 0.23.sw,
                              onPressed: controller.onStepContinue,
                              text: "Next".tr,
                            )
                          else
                            CustomLoadingButton(
                              borderRadius: 10.r,
                              height: 30.h,
                              width: 0.3.sw,
                              onPressed: () {
                                return controller.addServices();
                              },
                              text: "Add".tr,
                            ),
                        ],
                      );
                    },
                    steps: [
                      /// Step 1
                      Step(
                        isActive: controller.currentStep == 0,
                        state: controller.getStepStats(
                          controller.currentStep == 0,
                        ),
                        title: Text('Service Details'.tr),
                        content: ProviderServiceStep1(
                          controller: controller,
                        ),
                      ),

                      /// Step 2
                      Step(
                        title: Text('Location'.tr),
                        state: controller.getStepStats(
                          controller.currentStep == 1,
                        ),
                        content: ProviderServiceStep2(
                          controller: controller,
                        ),
                        isActive: controller.currentStep == 1,
                      ),

                      /// Step 3
                      Step(
                        state: controller.getStepStats(
                          controller.currentStep == 2,
                        ),
                        title: Text('Service Features'.tr),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int index = 0;
                                index < controller.features.length;
                                index++)
                              Column(
                                children: [
                                  controller.features[index].widget,
                                  if (controller.features.length != 1)
                                    Align(
                                      alignment: AlignmentDirectional.centerEnd,
                                      child: TextButton(
                                        onPressed: () {
                                          controller.removeFeatures(index);
                                        },
                                        child: Text("- Remove".tr),
                                      ),
                                    ),
                                ],
                              ),
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: TextButton(
                                onPressed: () {
                                  controller.increaseFeatures();
                                },
                                child: Text("+ Add More".tr),
                              ),
                            ),
                          ],
                        ),
                        isActive: controller.currentStep == 2,
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
