// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCxpwunzk3UdpPbein3qJcCKJ8dUVJYLLQ',
    appId: '1:471507208434:web:1ef2182d7e613116f9286b',
    messagingSenderId: '471507208434',
    projectId: 'elderly-virtual-assistant-2',
    authDomain: 'elderly-virtual-assistant-2.firebaseapp.com',
    storageBucket: 'elderly-virtual-assistant-2.appspot.com',
    measurementId: 'G-18J07Q2E4S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBLHmWb7LSu8_L_wMsdzfIHK_wH7pOH3bM',
    appId: '1:471507208434:android:3718d063d2de7eb2f9286b',
    messagingSenderId: '471507208434',
    projectId: 'elderly-virtual-assistant-2',
    storageBucket: 'elderly-virtual-assistant-2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA4aTO8RA2VxWsuUYyieObsZKwq9qJ77iM',
    appId: '1:471507208434:ios:4adb392f9e27317bf9286b',
    messagingSenderId: '471507208434',
    projectId: 'elderly-virtual-assistant-2',
    storageBucket: 'elderly-virtual-assistant-2.appspot.com',
    iosClientId: '471507208434-v19ic84qhv21ash8ahjbch45jdk0u07k.apps.googleusercontent.com',
    iosBundleId: 'com.example.eva',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA4aTO8RA2VxWsuUYyieObsZKwq9qJ77iM',
    appId: '1:471507208434:ios:4adb392f9e27317bf9286b',
    messagingSenderId: '471507208434',
    projectId: 'elderly-virtual-assistant-2',
    storageBucket: 'elderly-virtual-assistant-2.appspot.com',
    iosClientId: '471507208434-v19ic84qhv21ash8ahjbch45jdk0u07k.apps.googleusercontent.com',
    iosBundleId: 'com.example.eva',
  );
}