// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool obscureText = true;
  //final _authRepo = Get.find<AuthRepo>();
  bool obscurePassword = true;
  bool isLoading = false;

  @override
  void onInit() {
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  ontapSupfix() {
    obscureText = !obscureText;
    update();
  }

  validUserData(val) {
    if (val.isEmpty) {
      return "can't be empty";
    }
  }

  // Future<void> login() async {
  //   if (passwordController.text.isNotEmpty) {
  //     if (passwordController.text.length < 6) {
  //       AppSnackBars.warning(
  //         message: "Password must be at least 6 characters".tr,
  //       );
  //     } else {
  //       isLoading = true;
  //       update();
  //       final result = await _authRepo.login(
  //           phoneController.text, passwordController.text);
  //       result.fold(
  //         (error) {
  //           Get.defaultDialog(
  //             title: "note",
  //             content: Text(
  //               "Because you create B2B account, please wait admin approval to login the application "
  //                   .tr,
  //               textAlign: TextAlign.center,
  //             ),
  //           );
  //           isLoading = false;
  //           update();
  //         },
  //         (data) {
  //           isLoading = false;
  //           update();
  //           log(data.toString(), name: "login response");
  //           Get.find<AppPreferences>().setToken(data.token);
  //           Get.find<AppPreferences>().setUserId(data.user.id.toString());
  //           Get.find<AppPreferences>().setUserRole(data.user.role.toString());
  //           kUserId = data.user.id.toString();
  //           ApiConstance.token = data.token;
  //           subscribeTopics(int.parse(kUserId));
  //           if (data.hasLocation ?? true) {
  //             if (data.user.role == "super_admin") {
  //               Get.offAllNamed(AppRoutes.mainAdmin);
  //             } else if (data.user.role == "operation") {
  //               Get.offAllNamed(AppRoutes.mainOperation);
  //             } else if (Get.find<AppPreferences>().getUserRole() == "admin") {
  //               Get.offAllNamed(AppRoutes.mainDelivery);
  //             } else {
  //               Get.offAllNamed(AppRoutes.main);
  //             }
  //           } else {
  //             Get.offAllNamed(AppRoutes.addlocations, arguments: {
  //               "fromPage": "signup",
  //               "token": data.token,
  //             });
  //           }
  //         },
  //       );
  //     }
  //   }
  // }
}
