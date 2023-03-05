import 'dart:convert';

import 'package:eva/screens/login/login.dart';
import 'package:eva/screens/notifications/notifications.dart';
import 'package:eva/screens/settings/settings.dart';
import 'package:eva/utilities/firebase/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:eva/screens/home/home.dart';
import 'package:eva/screens/alerts.dart';
import 'package:eva/screens/reports/reports.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'classes/data_types.dart';

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

  // GET request via http package, what will actually be used
  Future<List<UserType>> getRequest() async {
    debugPrint("Getting data!");
    //replace your restFull API here.
    String url = "https://jsonplaceholder.typicode.com/posts";
    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);
    // var responseData = [];

    //Creating a list to store input data;
    List<UserType> users = [];
    for (var userInfo in responseData) {
      UserType user = UserType(
          uuid: userInfo["uuid"] ?? '',
          firstName: userInfo["firstName"] ?? '',
          lastName: userInfo["lastName"] ?? '',
          numMedications: userInfo["numMedications"] ?? -1,
          numHighPriority: userInfo["numHighPriority"] ?? -1,
          numNotTaken: userInfo["numNotTaken"] ?? -1,
          percentTaken: userInfo["percentTaken"] ?? -1,
          timeStamp: DateTime.parse(userInfo["timeStamp"]));

      //Adding user to the list.
      // if (_matchRegExp(user.title, filterString ?? '')) {
      //   users.add(user);
      // }
    }
    return users;
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
