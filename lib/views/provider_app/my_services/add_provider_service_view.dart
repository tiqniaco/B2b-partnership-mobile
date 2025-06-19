import 'package:b2b_partenership/controller/provider/my_services/add_provider_service_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/request_services/build_text_form.dart';
import 'package:b2b_partenership/widgets/select_city_widget.dart';
import 'package:b2b_partenership/widgets/select_country_widget.dart';
import 'package:b2b_partenership/widgets/select_specialization_widget.dart';
import 'package:b2b_partenership/widgets/select_sup_specialization_widget.dart';
import 'package:flutter/cupertino.dart';
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
                                        child: Text("- Remove"),
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

class ProviderServiceStep2 extends StatelessWidget {
  const ProviderServiceStep2({
    super.key,
    required this.controller,
  });
  final AddProviderServiceController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(8),
        SelectCountryWidget(
          enabled: false,
          value: controller.selectedCountry,
          models: controller.countries,
          onChanged: (val) {
            controller.onCountryChanged(val);
          },
        ),
        Gap(16),
        SelectCityWidget(
          value: controller.selectedCity!,
          models: controller.cities,
          onChanged: (val) {
            controller.onCityChanged(val);
          },
        ),
        Gap(16),
        SelectSpecializationWidget(
          value: controller.selectedSpecialization,
          models: controller.specializations,
          onChanged: (val) {
            controller.onSpecializeChanged(val);
          },
        ),
        Gap(16),
        SelectSupSpecializationWidget(
          value: controller.selectedSubSpecialization,
          models: controller.subSpecializations,
          onChanged: (val) {
            controller.onSubSpecializeChanged(val);
          },
        ),
        Gap(30),
      ],
    );
  }
}

class ProviderServiceStep1 extends StatelessWidget {
  const ProviderServiceStep1({
    super.key,
    required this.controller,
  });
  final AddProviderServiceController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: GestureDetector(
            onTap: controller.galleryImage,
            child: controller.imageFile != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.file(
                      controller.imageFile!,
                      height: 160.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    height: 160.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: lightPrimaryColor.withAlpha(160),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.photo,
                          size: 60.r,
                          color: primaryColor,
                        ),
                        Gap(8),
                        Text(
                          "Add Service Image".tr,
                          style: getRegularStyle(context).copyWith(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.r),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        Gap(16),
        buildTextField(
          controller.titleEnController,
          'Title'.tr,
          Icons.title,
          "enter title".tr,
          (val) {
            return controller.validUserData(val);
          },
        ),
        Gap(4),
        buildTextField(
          controller.descriptionController,
          'Description'.tr,
          Icons.description,
          "enter service description".tr,
          (val) {
            return controller.validUserData(val);
          },
        ),
        Gap(4),
        buildTextField(
          controller.addressController,
          'Address'.tr,
          Icons.location_on,
          "enter address".tr,
          (val) {
            return controller.validUserData(val);
          },
        ),
        Gap(4),
        buildTextField(
          controller.overviewController,
          'Overview'.tr,
          Icons.location_on,
          "enter service overview".tr,
          (val) {
            return controller.validUserData(val);
          },
        ),
        Gap(4),
        buildTextField(
          controller.videoController,
          'Video Link'.tr,
          Icons.location_on,
          "enter service video (optional)".tr,
          (val) {
            return controller.validUserData(val);
          },
          hasValidation: false,
        ),
        Gap(16),
      ],
    );
  }
}
