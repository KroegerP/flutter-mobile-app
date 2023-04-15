import 'package:eva/screens/notifications/notifications.dart';
import 'package:eva/utilities/firebase/auth.dart';
import 'package:flutter/material.dart';
import 'package:eva/screens/home/home.dart';
import 'package:eva/screens/reports/reports.dart';

class Navigation extends StatefulWidget {
  const Navigation({
    super.key,
  });

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentPageIndex = 1;
  final List<String> _titleList = [
    'Single Reports',
    'Elderly Virtual Assistant',
    'Notifications'
  ];
  PageController pageController = PageController(initialPage: 1);

  final AuthService _auth = AuthService();

  void _goToSettingsPage() {
    debugPrint("Opening Settings Page!");
  }

  void _openNotifsTray() {
    debugPrint("Opening Tray!");
    _auth.signOut();
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
          title: Text(_titleList[_currentPageIndex]),
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
