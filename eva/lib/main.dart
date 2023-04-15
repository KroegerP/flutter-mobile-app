import 'package:eva/classes/data_types.dart';
import 'package:eva/firebase_options.dart';
import 'package:eva/screens/wrapper.dart';
import 'package:eva/utilities/firebase/auth.dart';
import 'package:eva/utilities/firebase/notif_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  debugPrint('Starting!');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (defaultTargetPlatform == TargetPlatform.android) {
    NotificationHandler notificationHandler = NotificationHandler();
    await notificationHandler.init();
    String token = await notificationHandler.getToken();
    debugPrint('FCM Token: $token');
  }

  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<UserType>(context);

//     // print("Is user anon? ${user.isAnonymous}");

//     if (user) {
//       return const LoginScreen(title: 'Sign In');
//     } else {
//       return const HomeScreen();
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'notification_handler.dart'; // Imported from notifHandler.dart

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   NotificationHandler notificationHandler = NotificationHandler();
//   await notificationHandler.init();
//   String token = await notificationHandler.getToken();
//   print('FCM Token: $token');
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Build your app UI
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('My App'),
//         ),
//         body: Center(
//           child: Text('My App'),
//         ),
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserType?>.value(
      key: key,
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        title: 'EVAA',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.red,
        ),
        // home: const Navigation(title: 'Elderly Virtual Assistant'),
        home: const Wrapper(),
      ),
    );
  }
}
