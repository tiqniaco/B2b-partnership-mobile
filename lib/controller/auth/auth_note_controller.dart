// ignore_for_file: avoid_print

import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:get/get.dart';

class AuthNoteController extends GetxController {
  String? code;
  StatusRequest statusRequest = StatusRequest.loading;

  @override
  void onInit() {
    code = Get.arguments['code'];
    // getVerifyCode();
    super.onInit();
  }

  Future<void> getVerifyCode() async {
    statusRequest = StatusRequest.loading;
    final result = await CustomRequest<Map<String, dynamic>>(
        path: ApiConstance.getVerifyCode,
        fromJson: (json) {
          return json;
        },
        data: {
          "provider_id": Get.find<AppPreferences>().getUserRoleId(),
        }).sendPostRequest();

    result.fold((l) {
      statusRequest = StatusRequest.error;
      update();
    }, (r) {
      statusRequest = StatusRequest.success;
      code = r['verified_code'];
      update();
    });
  }
}
