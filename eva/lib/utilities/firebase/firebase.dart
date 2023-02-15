import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseConnection {
  late final fcmToken = getToken();

  Future<String?> getToken() {
    return FirebaseMessaging.instance.getToken();
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
}
