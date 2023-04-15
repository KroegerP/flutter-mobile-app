import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FcmWidget extends StatefulWidget {
  const FcmWidget({super.key});

  @override
  State<FcmWidget> createState() => _FcmWidgetState();
}

class _FcmWidgetState extends State<FcmWidget> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String _fcmToken = '';

  @override
  void initState() {
    super.initState();
    _getFcmToken();
    _configureFirebaseListeners();
  }

  void _getFcmToken() async {
    String? token = await _firebaseMessaging.getToken();
    setState(() {
      _fcmToken = token ?? 'None';
    });
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

    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Future<void> _firebaseMessagingBackgroundHandler(
  //     RemoteMessage message) async {
  //   debugPrint('Handling a background message: ${message.messageId}');
  // }

  @override
  Widget build(BuildContext context) {
    return Text('FCM Token: $_fcmToken');
  }
}
