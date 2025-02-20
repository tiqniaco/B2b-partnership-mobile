import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/utils/app_snack_bars.dart';
import 'package:get/get.dart';

class OTPController extends GetxController {
  String otp = "";
  String email = "";

  @override
  void onInit() {
    email = Get.arguments['email'] ?? "";
    super.onInit();
  }

  void onCodeChange(String code) {
    otp = code;
    update();
  }

  void onCodeSubmit(String verificationCode) {
    otp = verificationCode;
    update();
    if (otp == "") {
      AppSnackBars.warning(message: "OTP must not be empty".tr);
      return;
    } else if (otp.length != 6) {
      AppSnackBars.warning(message: "OTP must be 6 digits".tr);
      return;
    } else {
      verifyOTP();
    }
  }

  Future<void> verifyOTP() async {
    final result = await CustomRequest<String>(
      path: ApiConstance.verifyOTP,
      data: {
        "email": email,
        "otp": otp,
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
          message: "OTP Verified Successfully".tr,
        );
        Get.offNamed(
          AppRoutes.forgetPasswordReset,
          arguments: {
            "email": email,
          },
        );
      },
    );
  }
}
