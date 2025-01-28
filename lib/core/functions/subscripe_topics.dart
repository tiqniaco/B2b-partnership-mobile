import 'dart:developer';

import 'package:b2b_partenership/core/constants/app_constants.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

Future<void> subscribeTopics(int id, String role) async {
  kUserId = id.toString();
  Get.find<AppPreferences>().setUserId(id.toString());
  if (role == "patient") {
    await FirebaseMessaging.instance.subscribeToTopic('all');
    await FirebaseMessaging.instance.subscribeToTopic('patients');
    await FirebaseMessaging.instance.subscribeToTopic('patient$id');
    log('patient$id', name: 'subscribeTopics');
  } else if (role == "doctor") {
    await FirebaseMessaging.instance.subscribeToTopic('all');
    await FirebaseMessaging.instance.subscribeToTopic('doctors');
    await FirebaseMessaging.instance.subscribeToTopic('doctor$id');
    log('doctor$id', name: 'subscribeTopics');
  } else if (role == "admin") {
    await FirebaseMessaging.instance.subscribeToTopic('all');
    await FirebaseMessaging.instance.subscribeToTopic('admins');
    await FirebaseMessaging.instance.subscribeToTopic('admin$id');
    log('admin$id', name: 'subscribeTopics');
  }
}
