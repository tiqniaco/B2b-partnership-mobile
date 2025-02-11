import 'package:b2b_partenership/controller/request_services/request_service_controller.dart';
import 'package:b2b_partenership/widgets/request_services/build_text_form.dart';
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
          buildTextField(controller.governmentIdController, 'Government',
              Icons.location_city),
          Gap(30),
          buildTextField(controller.subSpecializationIdController,
              'Sub Specialization', Icons.work),
          Gap(30),
          buildTextField(controller.subSpecializationIdController,
              'Sub Specialization', Icons.work),
          Gap(30),
        ],
      );
    });
  }
}
