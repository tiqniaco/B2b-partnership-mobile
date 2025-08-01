import 'package:b2b_partenership/controller/settings/provider/my_services/edit_provider_service_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/widgets/posts/build_text_form.dart';
import 'package:b2b_partenership/widgets/select_city_widget.dart';
import 'package:b2b_partenership/widgets/select_country_widget.dart';
import 'package:b2b_partenership/widgets/select_specialization_widget.dart';
import 'package:b2b_partenership/widgets/select_sup_specialization_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class EditProviderServiceDetailsWidget extends StatelessWidget {
  const EditProviderServiceDetailsWidget({
    super.key,
    required this.controller,
  });

  final EditProviderServiceController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.selectedCity == null ||
        controller.selectedCountry == null ||
        controller.selectedSpecialization == null ||
        controller.selectedSubSpecialization == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: controller.galleryImage,
                      child: controller.imageFile != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.file(
                                controller.imageFile!,
                                height: 130.h,
                                width: 180.h,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              height: 130.h,
                              width: 180.h,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: CustomNetworkImage(
                                imageUrl: controller.image,
                              ),
                            ),
                    ),
                  ),
                  Gap(20),
                  buildTextField(
                    controller.titleEnController,
                    'Title'.tr,
                    Icons.title,
                    "enter title".tr,
                    (val) {
                      return controller.validUserData(val);
                    },
                  ),
                  //Gap(8),
                  buildTextField(
                    controller.descriptionController,
                    'Description'.tr,
                    Icons.description,
                    "enter service description".tr,
                    (val) {
                      return controller.validUserData(val);
                    },
                  ),
                  //Gap(8),
                  buildTextField(
                    controller.addressController,
                    'Address'.tr,
                    Icons.location_on,
                    "enter address".tr,
                    (val) {
                      return controller.validUserData(val);
                    },
                  ),
                  //Gap(8),
                  buildTextField(
                    controller.overviewController,
                    'Overview'.tr,
                    Icons.location_on,
                    "enter service overview".tr,
                    (val) {
                      return controller.validUserData(val);
                    },
                  ),
                  // Gap(8),
                  buildTextField(
                    controller.videoController,
                    'Video Link'.tr,
                    Icons.location_on,
                    "enter service video (optional)".tr,
                    (val) {
                      return controller.validUserData(val);
                    },
                  ),
                  //Gap(8),
                  SelectCountryWidget(
                    enabled: false,
                    value: controller.selectedCountry!,
                    models: controller.countries,
                    onChanged: (val) {
                      controller.onCountryChanged(val);
                    },
                  ),
                  Gap(8),
                  SelectCityWidget(
                    value: controller.selectedCity!,
                    models: controller.cities,
                    onChanged: (val) {
                      controller.onCityChanged(val);
                    },
                  ),
                  Gap(8),
                  SelectSpecializationWidget(
                    value: controller.selectedSpecialization!,
                    models: controller.specializations,
                    onChanged: (val) {
                      controller.onSpecializeChanged(val);
                    },
                  ),
                  Gap(8),
                  SelectSupSpecializationWidget(
                    value: controller.selectedSubSpecialization!,
                    models: controller.subSpecializations,
                    onChanged: (val) {
                      controller.onSubSpecializeChanged(val);
                    },
                  ),
                  Gap(8),
                  CustomLoadingButton(
                    onPressed: () {
                      return controller.updateServices();
                    },
                    text: "Edit".tr,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
