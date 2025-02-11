import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/models/provider_model.dart';
import 'package:b2b_partenership/models/services_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ProviderProfileController extends GetxController {
  bool isAbout = false;
  bool isServices = true;
  bool isWork = false;
  ProviderModel? providerModel;
  late String provId;
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestReview = StatusRequest.loading;
  StatusRequest statusRequestServices = StatusRequest.loading;
  List<ServiceModelData> providerServices = [];

  @override
  onInit() {
    super.onInit();
    provId = Get.arguments['id'];
    getProvider();
    getServices();
  }

  Future<void> getProvider() async {
    statusRequest = StatusRequest.loading;
    final result = await CustomRequest<ProviderModel>(
      path: ApiConstance.getProviderProfileDetails(provId),
      fromJson: (json) {
        return ProviderModel.fromJson(json['data']);
      },
    ).sendGetRequest();
    result.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
      update();
    }, (r) {
      providerModel = r;
      //print(r);
      statusRequest = StatusRequest.success;
      update();
    });
  }

  Future<void> getServices() async {
    statusRequestServices = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getProviderServices(provId),
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

  onTapAbout() {
    isAbout = true;
    isServices = false;
    isWork = false;
    update();
  }

  onTapService() {
    isAbout = false;
    isServices = true;
    isWork = false;
    update();
  }

  onTapWork() {
    isAbout = false;
    isServices = false;
    isWork = true;
    update();
  }
}
