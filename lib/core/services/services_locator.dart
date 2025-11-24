import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notifications_service.dart';

class ServicesLocator extends GetxService {
  late SharedPreferences sharedPreferences;
  Future<ServicesLocator> init() async {
    
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }
}

initialServices() async {
  await Get.putAsync(() => ServicesLocator().init());
  Get.put(NotificationsService());
}
