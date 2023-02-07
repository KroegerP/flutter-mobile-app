import 'package:eva/screens/login.dart';
import 'package:eva/screens/notifications.dart';
import 'package:eva/screens/userAppSettings.dart';
import 'package:flutter/material.dart';
import 'package:eva/screens/home.dart';
import 'package:eva/screens/alerts.dart';
import 'package:eva/screens/reports.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) {
          return const LoginScreen(
            title: 'Elderly Virtual Assistant',
          );
        },
        '/home': (BuildContext context) {
          return const Navigation(title: 'Elderly Virtual Assistant');
        },
        '/settings': (BuildContext context) {
          return const UserSettings();
        }
      },
    );
  }
}

class Navigation extends StatefulWidget {
  const Navigation({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  // '_' means it's only available in the library, see https://dart.dev/guides/language/language-tour#libraries-and-visibility
  int _counter = 0;
  int _currentPageIndex = 1;
  String _title = 'Elderly Virtual Assistant';
  PageController pageController = PageController();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _goToSettingsPage() {
    debugPrint("Opening Settings Page!");
    Navigator.pushNamed(context, '/settings');
  }

  void _openNotifsTray() {
    debugPrint("Opening Tray!");
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the Navigation object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: _openNotifsTray,
                icon: const Icon(Icons.notifications)),
            IconButton(
                onPressed: _goToSettingsPage, icon: const Icon(Icons.settings))
          ],
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 150),
              curve: Curves
                  .easeIn, //define the curve and duration of the transition
            );
            setState(() {
              _currentPageIndex = index;
            });
          },
          selectedIndex: _currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.file_copy),
              label: 'Reports',
            ),
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.notification_add),
              label: 'Notifications',
            ),
          ],
        ),
        body: PageView(
          controller: pageController,
          children: const <Widget>[
            ReportsScreen(),
            HomeScreen(),
            NotificationScreen(),
          ],
        ));
  }
}
