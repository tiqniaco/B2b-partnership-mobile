// ignore_for_file: avoid_print

import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/functions/logout.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/utils/app_snack_bars.dart';
import 'package:b2b_partenership/models/client_menu_model.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

class SettingController extends GetxController {
  ClientMenuModel? menuModel;
  StatusRequest statusRequest = StatusRequest.loading;
  bool removeAccountLoading = false;

  @override
  void onInit() {
    getMenuModel();
    super.onInit();
  }

  Future<void> getMenuModel() async {
    print("get details .........");
    var id = Get.find<AppPreferences>().getUserRoleId();
    statusRequest = StatusRequest.loading;
    final result = await CustomRequest<ClientMenuModel>(
      path: ApiConstance.getClientMenu(id),
      fromJson: (json) {
        return ClientMenuModel.fromJson(json);
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

  void removeAccountDialog() {
    Get.defaultDialog(
      title: "Remove Account".tr,
      middleText: "Are you sure you want to remove your account?".tr,
      textCancel: "No".tr,
      textConfirm: "Yes".tr,
      onConfirm: () {
        Get.back();
        _removeAccount();
      },
    );
  }

  Future<void> _removeAccount() async {
    removeAccountLoading = true;
    update();
    final result = await CustomRequest<String>(
      path: ApiConstance.deleteAccount,
      fromJson: (json) {
        return json['message'];
      },
    ).sendPostRequest();
    result.fold((l) {
      statusRequest = StatusRequest.error;
      AppSnackBars.error(message: l.errMsg);
      removeAccountLoading = false;
      update();
    }, (r) {
      AppSnackBars.success(message: r);
      removeAccountLoading = false;
      logout();
      update();
    });
  }
}
