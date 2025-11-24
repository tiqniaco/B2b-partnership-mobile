// import 'package:firebase_messaging/firebase_messaging.dart';

// import 'dart:developer';

import 'dart:developer';

import 'package:b2b_partenership/core/enums/language_enum.dart';
import 'package:b2b_partenership/core/functions/change_app_lang.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import '../constants/app_constants.dart';
import '/core/network/api_constance.dart';
import '/core/services/app_prefs.dart';

Future<void> logoutDialog(BuildContext context) async {
  Get.defaultDialog<bool>(
    title: 'Logout?'.tr,
    middleText: 'Are you sure you want to logout?'.tr,
    textConfirm: 'Yes'.tr,
    confirmTextColor: whiteColor,
    textCancel: 'No'.tr,
    onConfirm: () {
      logout(context);
    },
  );
}

Future<void> logout(BuildContext context) async {
  kFirstTime = true;
  ApiConstance.token = '';
  // Get.offAllNamed(AppRoutes.initial);
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

  await Get.find<AppPreferences>().clear();

  changeAppLang(lang: LanguageEnum.en, context: context);
}
