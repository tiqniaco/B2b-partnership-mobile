import 'package:b2b_partenership/core/crud/custom_request.dart';
import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/models/notification_model.dart';
import 'package:get/get.dart';

class NotifyController extends GetxController {
  int selectedIndex = 0;
  StatusRequest statusRequest = StatusRequest.loading;
  List<NotificationModel> notifications = [];

  @override
  onInit() async {
    await getNotifications();
    super.onInit();
  }

  Future<void> getNotifications() async {
    notifications.clear();
    statusRequest = StatusRequest.loading;
    update();
    final result = await CustomRequest<List<NotificationModel>>(
      path: ApiConstance.getNotifications,
      fromJson: (json) {
        return List<NotificationModel>.from(
          json['data'].map(
            (x) => NotificationModel.fromJson(x),
          ),
        );
      },
    ).sendGetRequest();
    result.fold(
      (error) {
        statusRequest = StatusRequest.error;
        update();
      },
      (data) {
        if (data.isEmpty) {
          statusRequest = StatusRequest.noData;
        } else {
          statusRequest = StatusRequest.success;
          notifications = data;
        }
        update();
      },
    );
  }
}
