import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServicesLocator extends GetxService {
  late SharedPreferences sharedPreferences;
  Future<ServicesLocator> init() async {
    //await Firebase.initializeApp();
    //await AndroidAlarmManager.initialize();
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }
}

initialServices() async {
  await Get.putAsync(() => ServicesLocator().init());
  // await Get.putAsync(() => NotificationsService().initialize());
}
