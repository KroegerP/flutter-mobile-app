import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyFirebaseMessaging extends StatefulWidget {
  @override
  State<MyFirebaseMessaging> createState() => _MyFirebaseMessager();
}

class _MyFirebaseMessager extends State<MyFirebaseMessaging> {
  // late final String fcmToken = await getToken();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  // FirebaseConnection({this.fcmToken}) {
  //   fcmToken = getToken() ?? '';
  // }

  Future<NotificationSettings> getSettings() async {
    var settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (kDebugMode) {
      print('User granted permission: ${settings.authorizationStatus}');
    }
    return settings;
  }

  Future<String?> getToken() async {
    if (kDebugMode) {
      print('Web platform? $kIsWeb');
    }
    if (kIsWeb) {
      return await FirebaseMessaging.instance.getToken(
          vapidKey:
              "BGX2kch3adNm9yS8nSYJajdBcfrBOZa7HBWXAUJFgAWd1trham-gEp8RaqsVeCiRrH91GpVL-NR3qA0w3GuCboY");
    }
    return await FirebaseMessaging.instance.getToken();
  }

  void subscribeToRefresh() {
    return FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      // TODO: If necessary send token to application server.

      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    }).onError((err) {
      // Error getting token.
      return err;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
