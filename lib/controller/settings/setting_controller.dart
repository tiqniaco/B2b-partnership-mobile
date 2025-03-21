// ignore_for_file: avoid_print

import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/functions/subscripe_topics.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/utils/app_snack_bars.dart';
import 'package:b2b_partenership/models/client_menu_model.dart';
import 'package:b2b_partenership/models/provider_model.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

class SettingController extends GetxController {
  ClientMenuModel? menuModel;
  StatusRequest statusRequest = StatusRequest.loading;
  bool removeAccountLoading = false;
  late ProviderModel providerModel;
  StatusRequest statusRequestSwitch = StatusRequest.loading;
  late String token;

  @override
  void onInit() {
    getMenuModel();
    super.onInit();
  }

  Future<void> getMenuModel() async {
    if (ApiConstance.token.isEmpty) {
      return;
    }
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

  switchAccount() async {
    // print("get details .........");
    //  var id = Get.find<AppPreferences>().getUserRoleId();
    statusRequestSwitch = StatusRequest.loading;
    final result = await CustomRequest<Map<String, dynamic>>(
      path: ApiConstance.clientSwitchAccount,
      data: {"client_id": Get.find<AppPreferences>().getUserRoleId()},
      fromJson: (json) {
        return json;
      },
    ).sendPostRequest();
    result.fold((l) {
      //statusRequestSwitch = StatusRequest.error;

      Logger().e(l.errMsg);
      AppSnackBars.error(message: l.errMsg);
      update();
    }, (r) {
      providerModel = ProviderModel.fromJson(r['data']);
      token = r['token'];
      Get.find<AppPreferences>().clear();
      subscribeTopics(
        userId: (providerModel.userId!),
        role: "provider",
      );
      Get.find<AppPreferences>().setToken(r['token']);
      Get.find<AppPreferences>().setUserId(providerModel.userId!);
      Get.find<AppPreferences>().setUserRoleId(providerModel.providerId!);
      Get.find<AppPreferences>().setUserRole("provider");
      ApiConstance.token = r['token'];
      Get.offAllNamed(AppRoutes.providerHomeLayout);
      statusRequestSwitch = StatusRequest.success;
      update();
    });
  }
}
