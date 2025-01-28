// ignore_for_file: avoid_print

import 'package:get/get.dart';


class AuthNoteController extends GetxController {
 late int code;

  @override
  void onInit() {
     code = Get.arguments["code"];
    super.onInit();
  }



}
