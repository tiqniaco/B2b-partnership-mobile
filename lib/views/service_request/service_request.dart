import 'package:b2b_partenership/controller/request_services/request_service_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

const primaryColor = Color(0xffbe0000);

class ServiceRequest extends StatelessWidget {
  const ServiceRequest({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RequestServiceController());
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: blackColor),
        title: Text('Add Service',
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: blackColor)),
        backgroundColor: whiteColor,
        elevation: 0,
      ),
      body: GetBuilder<RequestServiceController>(builder: (controller) {
        return Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Text(
                                'Step ${controller.currentStep + 1} of ${controller.steps.length}  '),
                            Expanded(
                              child: LinearProgressIndicator(
                                borderRadius: BorderRadius.circular(30),
                                value: (controller.currentStep + 1) /
                                    controller.steps.length,
                                backgroundColor: Colors.grey[300],
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    child: controller.steps[controller.currentStep],
                  ),
                  //SizedBox(height: 20),
                  CustomLoadingButton(
                      onPressed: () {
                        Logger().f(controller.currentStep);
                        if (controller.currentStep ==
                            controller.steps.length - 1) {
                          return () {};
                        } else {
                          return controller.nextStep;
                        }
                      },
                      text:
                          controller.currentStep == controller.steps.length - 1
                              ? 'Submit'
                              : 'Next'),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
