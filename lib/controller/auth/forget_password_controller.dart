import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/utils/app_snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  //final _repo = Get.find<ForgetPasswordRepo>();
  late TextEditingController emailController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    emailController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  Future<void> sendOtp() async {
    if (formKey.currentState?.validate() ?? false) {
      final result = await CustomRequest<String>(
        path: ApiConstance.sendOTP,
        data: {
          "email": emailController.text,
        },
        fromJson: (json) {
          return json['message'];
        },
      ).sendPostRequest();

      result.fold(
        (error) {
          AppSnackBars.error(message: error.errMsg);
        },
        (data) {
          AppSnackBars.success(
            message: "OTP Send Successfully, please check your mail!".tr,
          );
          Get.toNamed(
            AppRoutes.otp,
            arguments: {
              "email": emailController.text,
            },
          );
        },
      );
    }
  }
}
