// ignore_for_file: avoid_print

import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/functions/subscripe_topics.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/utils/app_snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class LoginController extends GetxController {
  late TextEditingController loginController;
  late TextEditingController passwordController;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.loading;

  bool obscureText = true;
  bool obscurePassword = true;
  bool isLoading = false;

  @override
  void onInit() {
    loginController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  ontapSupfix() {
    obscureText = !obscureText;
    update();
  }

  validUserData(val) {
    if (val.isEmpty) {
      return "can't be empty";
    }
  }

  Future<void> login() async {
    if (loginFormKey.currentState!.validate()) {
      statusRequest = StatusRequest.loading;

      final result = await CustomRequest<Map<String, dynamic>>(
          path: ApiConstance.login,
          fromJson: (json) {
            return json;
          },
          data: {
            "login": loginController.text,
            "password": passwordController.text,
          }).sendPostRequest();
      result.fold((l) {
        statusRequest = StatusRequest.error;
        Logger().e(l.errMsg);
        AppSnackBars.error(message: l.errMsg);
        update();
      }, (r) {
        AppSnackBars.success(message: r['message']);
        statusRequest = StatusRequest.success;
        subscribeTopics(
          r['user_id'],
          r['role'],
        );
        Get.find<AppPreferences>().setToken(r['token']);
        Get.find<AppPreferences>().setUserId(r['user_id'].toString());
        Get.find<AppPreferences>().setUserRoleId(r['role_id'].toString());
        Get.find<AppPreferences>().setUserRole(r['role']);
        ApiConstance.token = r['token'];
        if (r['role'] == 'provider') {
          Get.offAllNamed(AppRoutes.providerHomeLayout);
        } else {
          Get.offAllNamed(AppRoutes.clientHomeLayout);
        }

        update();
      });
    }
  }





}
