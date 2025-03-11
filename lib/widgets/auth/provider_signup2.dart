import 'package:b2b_partenership/controller/auth/signup_controller.dart';
import 'package:b2b_partenership/widgets/custome_phone_widget.dart';
import 'package:b2b_partenership/widgets/select_city_widget.dart';
import 'package:b2b_partenership/widgets/select_country_widget.dart';
import 'package:b2b_partenership/widgets/auth/select_provider_widget.dart';
import 'package:b2b_partenership/widgets/select_specialization_widget.dart';
import 'package:b2b_partenership/widgets/select_sup_specialization_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProviderSignup2 extends StatelessWidget {
  const ProviderSignup2({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());
    return GetBuilder<SignupController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              if (controller.countries.isNotEmpty)
                Expanded(
                  child: SelectCountryWidget(
                    enabled: false,
                    value: controller.selectedCountry,
                    models: controller.countries,
                    onChanged: (val) {
                      controller.onCountryChanged(val);
                    },
                  ),
                ),
              Gap(10),
              if (controller.cities.isNotEmpty)
                Expanded(
                    child: SelectCityWidget(
                  value: controller.selectedCity,
                  models: controller.cities,
                  onChanged: (val) {
                    controller.onCityChanged(val);
                  },
                )),
            ],
          ),
          Gap(20.h),
          if (controller.countries.isNotEmpty) CustomPhoneWidget(),
          if (controller.role == "provider") ...[
            Gap(10.h),
            if (controller.providerTypes.isNotEmpty)
              SelectProviderWidget(
                providerTypes: controller.providerTypes,
                value: controller.selectedType,
                onChanged: (value) {
                  controller.onProviderTypeChanged(value);
                },
              ),
            Gap(20.h),
            if (controller.specializations.isNotEmpty)
              SelectSpecializationWidget(
                value: controller.selectedSpecialization,
                models: controller.specializations,
                onChanged: (val) {
                  controller.onSpecializeChanged(val);
                },
              ),
            Gap(20.h),
            if (controller.subSpecializations.isNotEmpty)
              SelectSupSpecializationWidget(
                value: controller.selectedSubSpecialization,
                models: controller.subSpecializations,
                onChanged: (val) {
                  controller.onSubSpecializeChanged(val);
                },
              )
          ],
          Gap(20.h),
        ],
      ),
    );
  }
}
