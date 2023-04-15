import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin _flutterLocalNotifsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationHandler {
  late FirebaseMessaging _firebaseMessaging;

  Future<void> init() async {
    _firebaseMessaging = FirebaseMessaging.instance;

    var androidInfo = await DeviceInfoPlugin().androidInfo;

    // Request notification permissions for Android API 33+
    if (androidInfo.version.sdkInt >= 33) {
      await _firebaseMessaging.requestPermission();
    }

    // Configure notifications
    _configureLocalNotifications();

    // Configure Firebase Messaging
    _configureFirebaseListeners();
  }

  Future<String> getToken() async {
    if (kDebugMode) {
      debugPrint('Web platform? $kIsWeb');
    }
    if (kIsWeb) {
      return await _firebaseMessaging.getToken(
              vapidKey:
                  "BGX2kch3adNm9yS8nSYJajdBcfrBOZa7HBWXAUJFgAWd1trham-gEp8RaqsVeCiRrH91GpVL-NR3qA0w3GuCboY") ??
          'None';
    }
    return await _firebaseMessaging.getToken() ?? 'None';
  }

  Future<void> _configureLocalNotifications() async {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/eva_mobile'),
    );
    await _flutterLocalNotifsPlugin.initialize(initializationSettings);
  }

  void _configureFirebaseListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}');
      if (message.notification != null) {
        debugPrint(
            'Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('A new onMessageOpenedApp event was published!');
      debugPrint('Message data: ${message.data}');
      if (message.notification != null) {
        debugPrint(
            'Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message: ${message.messageId}');
  debugPrint('Printing Data: ${message.data}');

  final notification = message.notification;
  debugPrint('NOTIF: $notification');
  // ignore: prefer_const_declarations
  final android = const AndroidNotificationDetails('channel_id', 'channel_name',
      priority: Priority.high, importance: Importance.max);
  final platform = NotificationDetails(android: android);
  await _flutterLocalNotifsPlugin.show(
    notification.hashCode,
    notification?.title,
    notification?.body,
    platform,
    payload: message.data['testing'],
  );
}
