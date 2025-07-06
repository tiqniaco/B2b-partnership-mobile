import 'package:b2b_partenership/controller/settings/provider/my_services/add_provider_service_controller.dart';
import 'package:b2b_partenership/widgets/select_city_widget.dart';
import 'package:b2b_partenership/widgets/select_country_widget.dart';
import 'package:b2b_partenership/widgets/select_specialization_widget.dart';
import 'package:b2b_partenership/widgets/select_sup_specialization_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
