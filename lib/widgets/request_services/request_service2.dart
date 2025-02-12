import 'package:b2b_partenership/controller/request_services/request_service_controller.dart';
import 'package:b2b_partenership/widgets/request_services/select_city_service_request.dart';
import 'package:b2b_partenership/widgets/request_services/select_country_service_request.dart';
import 'package:b2b_partenership/widgets/request_services/select_specialization_service_request.dart';
import 'package:b2b_partenership/widgets/request_services/select_sup_specialization_service_request.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class RequestService2 extends StatelessWidget {
  const RequestService2({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestServiceController>(builder: (controller) {
      return Column(
        children: [
          Gap(50),
          SelectCountryServiceRequest(
            enabled: false,
          ),
          Gap(40),
          SelectCityServiceRequest(),
          Gap(40),
          SelectSpecializationServiceRequest(),
          Gap(40),
          SelectSupSpecializationServiceRequest(),
          Gap(30),
        ],
      );
    });
  }
}
