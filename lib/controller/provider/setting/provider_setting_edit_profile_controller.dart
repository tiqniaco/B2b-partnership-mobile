import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/models/provider_model.dart';

import 'package:get/get.dart';

class ProviderSettingEditProfileController extends GetxController {
  late ProviderModel model;
  StatusRequest statusRequest = StatusRequest.loading;
  bool removeAccountLoading = false;

  @override
  void onInit() {
    model = Get.arguments['model'] as ProviderModel;
    super.onInit();
  }
}
