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

  // Future<void> sendOtp() async {
  //   if (formKey.currentState?.validate() ?? false) {
  //     final result = await _repo.sendOTP(email: emailController.text);
  //     result.fold(
  //       (error) {
  //         errorLogger(error.errMsg);
  //         AppSnackBars.error(message: error.errMsg);
  //       },
  //       (data) {
  //         AppSnackBars.success(
  //           message: "OTP Send Successfully, please check your mail!".tr,
  //         );
  //         Get.toNamed(
  //           AppRoutes.otp,
  //           arguments: {
  //             "email": emailController.text,
  //           },
  //         );
  //       },
  //     );
  //   }
  // }
}
