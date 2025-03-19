// ignore_for_file: avoid_print

import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/functions/subscripe_topics.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/utils/app_snack_bars.dart';
import 'package:b2b_partenership/models/client_model.dart';
import 'package:b2b_partenership/models/provider_menu_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ProviderSettingController extends GetxController {
  ProviderMenuModel? menuModel;
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestSwitch = StatusRequest.loading;
  bool removeAccountLoading = false;
  late ClientModel clientModel;
  late String token;

  @override
  void onInit() {
    getMenuModel();
    super.onInit();
  }

  Future<void> getMenuModel() async {
    print("get details .........");
    var id = Get.find<AppPreferences>().getUserRoleId();
    statusRequest = StatusRequest.loading;
    final result = await CustomRequest<ProviderMenuModel>(
      path: ApiConstance.getProviderMenu(id),
      fromJson: (json) {
        return ProviderMenuModel.fromJson(json);
      },
    ).sendGetRequest();
    result.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
      update();
    }, (r) {
      menuModel = r;
      statusRequest = StatusRequest.success;
      update();
    });
  }

  switchAccount() async {
    // print("get details .........");
    //  var id = Get.find<AppPreferences>().getUserRoleId();
    statusRequestSwitch = StatusRequest.loading;
    final result = await CustomRequest<Map<String, dynamic>>(
      path: ApiConstance.providerSwitchAccount,
      data: {"provider_id": Get.find<AppPreferences>().getUserRoleId()},
      fromJson: (json) {
        return json;
      },
    ).sendPostRequest();
    result.fold((l) {
      //statusRequestSwitch = StatusRequest.error;
      // print(l.errMsg);
      if (l.errMsg == 'no client') {
        Get.defaultDialog(
          title: "Switch Account",
          titleStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp),
          middleText: "You don't have any client Account",
          onConfirm: () {
            Get.toNamed(AppRoutes.providerSignup,
                arguments: {"role": "client"});
          },
          textConfirm: "Create Account",
          onCancel: () {},
        );
      } else {
        AppSnackBars.error(message: l.errMsg);
      }
      Logger().e(l.errMsg);

      update();
    }, (r) {
      clientModel = ClientModel.fromJson(r['data']);
      token = r['token'];
      Get.find<AppPreferences>().clear();
      subscribeTopics(
        userId: (clientModel.userId!),
        role: "client",
      );
      Get.find<AppPreferences>().setToken(r['token']);
      Get.find<AppPreferences>().setUserId(clientModel.userId!);
      Get.find<AppPreferences>().setUserRoleId(clientModel.clientId!);
      Get.find<AppPreferences>().setUserRole("client");
      ApiConstance.token = r['token'];
      Get.offAllNamed(AppRoutes.clientHomeLayout);
      statusRequestSwitch = StatusRequest.success;
      update();
    });
  }
}
