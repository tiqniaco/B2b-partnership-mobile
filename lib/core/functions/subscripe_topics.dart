import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> subscribeTopics({
  required String role,
  required String roleId,
}) async {
  if (role == "provider") {
    await FirebaseMessaging.instance.subscribeToTopic('all');
    await FirebaseMessaging.instance.subscribeToTopic('providers');
    await FirebaseMessaging.instance.subscribeToTopic('provider$roleId');
    log('provider$roleId', name: 'subscribeTopics');
  } else if (role == "client") {
    await FirebaseMessaging.instance.subscribeToTopic('all');
    await FirebaseMessaging.instance.subscribeToTopic('clients');
    await FirebaseMessaging.instance.subscribeToTopic('client$roleId');
    log('client$roleId', name: 'subscribeTopics');
  } else if (role == "admin") {
    await FirebaseMessaging.instance.subscribeToTopic('all');
    await FirebaseMessaging.instance.subscribeToTopic('admins');
    await FirebaseMessaging.instance.subscribeToTopic('admin$roleId');
    log('admin$roleId', name: 'subscribeTopics');
  }
}
