import 'package:b2b_partenership/controller/request_services/add_request_service_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/request_services/request_service1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

const primaryColor = Color(0xffbe0000);

class AddServiceRequest extends StatelessWidget {
  AddServiceRequest({super.key});
  final controller = Get.put(AddRequestServiceController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddRequestServiceController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            toolbarHeight: context.isTablet ? 45.h : null,
            title: Text(
              'Add Service'.tr,
              style: getSemiBoldStyle(context).copyWith(
                color: blackColor,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   children: [
                  //     Text(
                  //       '${"Step".tr} ${controller.currentStep + 1} ${"of".tr} ${controller.steps.length}  ',
                  //       style: getRegularStyle(context),
                  //     ),
                  //     Expanded(
                  //       child: LinearProgressIndicator(
                  //         borderRadius: BorderRadius.circular(30),
                  //         minHeight: 8.h,
                  //         value: (controller.currentStep + 1) /
                  //             controller.steps.length,
                  //         backgroundColor: Colors.grey[200],
                  //         color: primaryColor,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Gap(25),
                  Form(
                    key: controller.formKey,
                    child: const RequestService1(),
                  ),
                  CustomLoadingButton(
                      borderRadius: 12.r,
                      onPressed: () {
                        return controller.addServices();
                      },
                      text: 'Add'.tr),
                  Gap(300)
                ],
              ),
            ),
          ));
    });
  }
}
