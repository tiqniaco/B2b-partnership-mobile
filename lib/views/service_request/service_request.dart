import 'package:b2b_partenership/controller/request_services/request_service_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

const primaryColor = Color(0xffbe0000);

class ServiceRequest extends StatelessWidget {
  ServiceRequest({super.key});
  final controller = Get.put(RequestServiceController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestServiceController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            leading: controller.currentStep == 0
                ? IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.close,
                      size: 20.sp,
                    ))
                : IconButton(
                    onPressed: controller.previousStep,
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 20.sp,
                    )),
            iconTheme: IconThemeData(color: blackColor),
            title: Text('Add Service',
                style: TextStyle(fontSize: 20.sp, color: blackColor)),
            backgroundColor: whiteColor,
            elevation: 0,
          ),
          body: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                            'Step ${controller.currentStep + 1} of ${controller.steps.length}  '),
                        Expanded(
                          child: LinearProgressIndicator(
                            borderRadius: BorderRadius.circular(30),
                            minHeight: 10,
                            value: (controller.currentStep + 1) /
                                controller.steps.length,
                            backgroundColor: Colors.grey[200],
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Gap(25),
                    SizedBox(
                      child: controller.steps[controller.currentStep],
                    ),
                    CustomLoadingButton(
                        borderRadius: 12,
                        onPressed: () {
                          if (controller.currentStep ==
                              controller.steps.length - 1) {
                            return controller.addServices();
                          } else {
                            return controller.nextStep;
                          }
                        },
                        text: controller.currentStep ==
                                controller.steps.length - 1
                            ? 'Submit'
                            : 'Next'),
                    Gap(300)
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
