import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';

class NotificationHandler {
  late FirebaseMessaging _firebaseMessaging;

  Future<void> init() async {
    _firebaseMessaging = FirebaseMessaging.instance;

    var androidInfo = await DeviceInfoPlugin().androidInfo;

    // Request notification permissions for Android API 33+
    if (androidInfo.version.sdkInt >= 33) {
      await _firebaseMessaging.requestPermission();
    }

    // Configure Firebase Messaging
    _configureFirebaseListeners();
  }

  Future<String> getToken() async {
    if (kDebugMode) {
      print('Web platform? $kIsWeb');
    }
    if (kIsWeb) {
      return await _firebaseMessaging.getToken(
              vapidKey:
                  "BGX2kch3adNm9yS8nSYJajdBcfrBOZa7HBWXAUJFgAWd1trham-gEp8RaqsVeCiRrH91GpVL-NR3qA0w3GuCboY") ??
          'None';
    }
    return await _firebaseMessaging.getToken() ?? 'None';
  }

  void _configureFirebaseListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
  print('Printing Data: ${message.data}');
}
