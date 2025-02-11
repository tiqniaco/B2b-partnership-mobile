// ignore_for_file: avoid_print

import 'package:b2b_partenership/app_routes.dart';
import 'package:get/get.dart';

class ChooseAccountController extends GetxController {
  bool isClient = true;
  bool isProvider = false;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  onTapClient() {
    isClient = true;
    isProvider = false;
    update();
  }

  onTapProvider() {
    isClient = false;
    isProvider = true;
    update();
  }

  goOnTap() {
    if (isClient) {
      Get.toNamed(AppRoutes.providerSignup, arguments: {"role": "client"});
    } else {
      Get.toNamed(AppRoutes.providerSignup, arguments: {"role": "provider"});
    }
  }
}
