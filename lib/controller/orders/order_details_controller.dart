import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/utils/app_snack_bars.dart';
import 'package:b2b_partenership/models/order_details_model.dart';
import 'package:get/get.dart';

class OrderDetailsController extends GetxController {
  String orderId = "";
  StatusRequest statusRequest = StatusRequest.loading;
  OrderDetailsModel? model;

  @override
  void onInit() {
    orderId = Get.arguments["id"] ?? "";
    getOrderDetails();
    super.onInit();
  }

  Future<void> getOrderDetails() async {
    statusRequest = StatusRequest.loading;
    update();
    final result = await CustomRequest<OrderDetailsModel>(
      path: ApiConstance.getOrderDetails(orderId),
      fromJson: (json) {
        return OrderDetailsModel.fromJson(json);
      },
    ).sendGetRequest();
    result.fold((l) {
      statusRequest = StatusRequest.error;
      AppSnackBars.error(message: l.errMsg);
      update();
    }, (r) {
      model = r;
      statusRequest = StatusRequest.success;
      update();
    });
  }
}
