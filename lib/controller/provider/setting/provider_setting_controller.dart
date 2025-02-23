// ignore_for_file: avoid_print

import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/models/provider_menu_model.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ProviderSettingController extends GetxController {
  ProviderMenuModel? menuModel;
  StatusRequest statusRequest = StatusRequest.loading;

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
}
