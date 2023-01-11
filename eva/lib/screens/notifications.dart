import 'dart:convert';

import 'package:eva/screens/individualReports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _MyNotificationScreenState();
}

//Creating a class user to store the data;
class User {
  final int id;
  final int userId;
  final String title;
  final String body;

  User({
    this.id = 0,
    this.userId = 0,
    this.title = '',
    this.body = '',
  });
}

class _MyNotificationScreenState extends State<NotificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _counter = 0;
  String? filterString;

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

  void _removeNotification(int index) {
    print(index);
  }

  bool _matchRegExp(String strToTest, String? regString) {
    if (regString != null) {
      RegExp exp = RegExp(regString);
      var match = exp.hasMatch(strToTest);
      return match;
    } else {
      return true;
    }
  }

  // Local method of gathering JSON data
  Future<List<User>> readJson() async {
    debugPrint(filterString);
    final String response = await rootBundle.loadString('assets/sample.json');
    final data = await json.decode(response);
    // var responseData = [];

    //Creating a list to store input data;
    List<User> users = [];
    for (var singleUser in data) {
      User user = User(
          id: singleUser["id"],
          userId: singleUser["userId"],
          title: singleUser["title"],
          body: singleUser["body"]);

      //Adding user to the list.
      if (_matchRegExp(user.title, filterString ?? '')) {
        users.add(user);
      }
    }
    return users;
  }

  // GET request via http package, what will actually be used
  Future<List<User>> getRequest() async {
    debugPrint("Getting data!");
    //replace your restFull API here.
    String url = "https://jsonplaceholder.typicode.com/posts";
    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);
    // var responseData = [];

    //Creating a list to store input data;
    List<User> users = [];
    for (var singleUser in responseData) {
      User user = User(
          id: singleUser["id"],
          userId: singleUser["userId"],
          title: singleUser["title"],
          body: singleUser["body"]);

      //Adding user to the list.
      if (_matchRegExp(user.title, filterString ?? '')) {
        users.add(user);
      }
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: <Widget>[
        FutureBuilder(
          future: readJson(),
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    // scrollDirection: Axis.vertical,
                    // shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) => Card(
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          debugPrint("Ticked");
                          // _incrementCounter();
                          // debugPrint(index.toString());
                        },
                        child: ListTile(
                          leading: Transform.translate(
                            offset: const Offset(8, 0),
                            child: Container(
                              height: 32,
                              width: 32,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                color: Colors.white,
                              ),
                              child: const Icon(Icons.copy),
                            ),
                          ),
                          trailing: Container(
                            height: 32,
                            width: 32,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              color: Colors.white,
                            ),
                            child: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _removeNotification(index)),
                          ),
                          // leading: const Icon(Icons.copy_sharp),
                          title: Text(snapshot.data[index].title),
                          subtitle: Text(snapshot.data[index].body),
                          contentPadding: const EdgeInsets.only(bottom: 20.0),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ]),
    );
  }
}
