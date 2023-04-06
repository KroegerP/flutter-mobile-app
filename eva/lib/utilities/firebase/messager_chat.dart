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

    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('FCM Token: $_fcmToken'),
    );
  }
}
