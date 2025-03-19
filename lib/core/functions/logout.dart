// import 'package:firebase_messaging/firebase_messaging.dart';

// import 'dart:developer';

import 'dart:developer';

import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../app_routes.dart';
import 'package:get/get.dart';
import '../constants/app_constants.dart';
import '/core/network/api_constance.dart';
import '/core/services/app_prefs.dart';

Future<void> logoutDialog() async {
  Get.defaultDialog<bool>(
    title: 'Logout?'.tr,
    middleText: 'Are you sure you want to logout?'.tr,
    textConfirm: 'Yes'.tr,
    confirmTextColor: whiteColor,
    textCancel: 'No'.tr,
    onConfirm: () {
      logout();
    },
  );
}

Future<void> logout() async {
  /// Clear all shared preferences
  await Get.find<AppPreferences>().clear();
  Get.offAllNamed(AppRoutes.initial);

  /// Reset all global variables
  kFirstTime = true;
  ApiConstance.token = '';

  /// Unsubscribe from all topics
  String userId = Get.find<AppPreferences>().getUserId();
  String role = Get.find<AppPreferences>().getUserRole();
  if (role == "provider") {
    await FirebaseMessaging.instance.unsubscribeFromTopic('all');
    await FirebaseMessaging.instance.unsubscribeFromTopic('providers');
    await FirebaseMessaging.instance.unsubscribeFromTopic('user$userId');
  } else if (role == "client") {
    await FirebaseMessaging.instance.unsubscribeFromTopic('all');
    await FirebaseMessaging.instance.unsubscribeFromTopic('clients');
    await FirebaseMessaging.instance.unsubscribeFromTopic('user$userId');
    log('client$userId', name: 'subscribeTopics');
  } else if (role == "admin") {
    await FirebaseMessaging.instance.unsubscribeFromTopic('all');
    await FirebaseMessaging.instance.unsubscribeFromTopic('admins');
    await FirebaseMessaging.instance.unsubscribeFromTopic('user$userId');
    log('admin$userId', name: 'subscribeTopics');
  }
}
