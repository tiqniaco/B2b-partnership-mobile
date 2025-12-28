import 'package:b2b_partenership/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void pleaseLoginDialog() {
  Get.defaultDialog(
    title: "Login".tr,
    titleStyle: TextStyle(fontSize: 16.r, fontWeight: FontWeight.bold),
    titlePadding: EdgeInsets.only(top: 24, bottom: 8),
    contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
    content: Text(
      "Please login to continue".tr,
      style: TextStyle(
        fontSize: 12.r,
      ),
    ),
    textCancel: "No".tr,
    textConfirm: "Yes".tr,
    onConfirm: () {
      Get.back();
      Get.toNamed(AppRoutes.login);
    },
  );
}
