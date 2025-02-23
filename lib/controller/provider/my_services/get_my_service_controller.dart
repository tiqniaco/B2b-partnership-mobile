import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/models/services_model.dart';
import 'package:get/get.dart';

class GetMyServiceController extends GetxController {
  List<ServiceModelData> providerServices = [];

  StatusRequest statusRequestServices = StatusRequest.loading;
  StatusRequest statusRequest = StatusRequest.loading;

  @override
  Future<void> onInit() async {
    getServices();

    super.onInit();
  }

  Future<void> getServices() async {
    print("*****************************");
    print(Get.find<AppPreferences>().getUserRoleId());
    print("*****************************");
    statusRequestServices = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getProviderServices(
            Get.find<AppPreferences>().getUserRoleId()),
        fromJson: (json) {
          return json["data"]
              .map<ServiceModelData>(
                  (service) => ServiceModelData.fromJson(service))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestServices = StatusRequest.error;
    }, (r) {
      providerServices.clear();
      providerServices = r;
      if (r.isEmpty) {
        statusRequestServices = StatusRequest.noData;
      } else {
        statusRequestServices = StatusRequest.success;
      }
    });
    update();
  }
}
