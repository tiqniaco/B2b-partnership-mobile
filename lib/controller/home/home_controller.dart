// ignore_for_file: avoid_print

import 'package:b2b_partenership/controller/save/saved_controller.dart';
import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/functions/internet_check.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/models/provider_model.dart';
import 'package:b2b_partenership/models/specialize_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../core/enums/status_request.dart';

class HomeController extends GetxController {
  int currentPage = 0;

  List<SpecializeModel> specializations = [];
  List<ProviderModel> topProviders = [];
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestProviders = StatusRequest.loading;
  StatusRequest statusRequestSpecialization = StatusRequest.loading;

  @override
  Future<void> onInit() async {
    getSpecialization();
    getProviders();
    super.onInit();
  }

  changeSlider(int index) {
    print(index);
    currentPage = index;
    update(["slider"]);
  }

  Future<void> getProviders() async {
    statusRequestProviders = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getTopProviders,
        data: {
          if (Get.find<AppPreferences>().getUserId() != "")
            "user_id": Get.find<AppPreferences>().getUserId()
        },
        fromJson: (json) {
          return json["data"]
              .map<ProviderModel>((service) => ProviderModel.fromJson(service))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      if (isConnectionError(l)) {
        statusRequestSpecialization = StatusRequest.noConnection;
      } else {
        statusRequestSpecialization = StatusRequest.error;
      }
    }, (r) {
      topProviders.clear();
      topProviders = r;
      if (r.isEmpty) {
        statusRequestProviders = StatusRequest.noData;
      } else {
        statusRequestProviders = StatusRequest.success;
      }
    });
    update();
  }

  toggleFavorites(String provId) async {
    final savedController = SavedController();
    await savedController.onTapFavorite(provId);
    getProviders();

    update();
  }

  Future<void> getSpecialization() async {
    statusRequestSpecialization = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getSpecialization,
        fromJson: (json) {
          return json['data']
              .map<SpecializeModel>((e) => SpecializeModel.fromJson(e))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      if (isConnectionError(l)) {
        statusRequestSpecialization = StatusRequest.noConnection;
      } else {
        statusRequestSpecialization = StatusRequest.error;
      }

      Logger().e(l.errMsg);
    }, (r) {
      specializations.clear();
      specializations = r;
      if (r.isEmpty) {
        statusRequestSpecialization = StatusRequest.noData;
      } else {
        statusRequestSpecialization = StatusRequest.success;
      }
    });
    update();
  }
}
