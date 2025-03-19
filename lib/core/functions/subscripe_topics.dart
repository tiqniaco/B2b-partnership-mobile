import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> subscribeTopics({
  required String role,
  required String userId,
}) async {
  if (role == "provider") {
    await FirebaseMessaging.instance.subscribeToTopic('all');
    await FirebaseMessaging.instance.subscribeToTopic('providers');
    await FirebaseMessaging.instance.subscribeToTopic('user$userId');
    log('provider$userId', name: 'subscribeTopics');
  } else if (role == "client") {
    await FirebaseMessaging.instance.subscribeToTopic('all');
    await FirebaseMessaging.instance.subscribeToTopic('clients');
    await FirebaseMessaging.instance.subscribeToTopic('user$userId');
    log('client$userId', name: 'subscribeTopics');
  } else if (role == "admin") {
    await FirebaseMessaging.instance.subscribeToTopic('all');
    await FirebaseMessaging.instance.subscribeToTopic('admins');
    await FirebaseMessaging.instance.subscribeToTopic('user$userId');
    log('admin$userId', name: 'subscribeTopics');
  }
}
