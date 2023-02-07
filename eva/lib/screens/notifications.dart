import 'dart:convert';

import 'package:eva/screens/individualReports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../utilities/cutomRectTween.dart';
import '../utilities/heroDialogueRoute.dart';
import '../utilities/styles.dart';

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

  bool? completed;

  User(
      {this.id = 0,
      this.userId = 0,
      this.title = '',
      this.body = '',
      this.completed = false});
}

class _NotifCard extends StatelessWidget {
  /// {@macro todo_card}
  const _NotifCard({
    Key? key,
    required this.index,
    required this.notifList,
  }) : super(key: key);

  final List<User> notifList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          debugPrint("$index");
          debugPrint(notifList[index].id.toString());
          Navigator.of(context).push(
            HeroDialogRoute(
              builder: (context) => Center(
                child: _NotifPopupCard(notif: notifList[index]),
              ),
            ),
          );
        },
        child: Hero(
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          tag: notifList[index].id,
          child: Card(
            color: Colors.red,
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              // onTap: () {
              //   debugPrint("Ticked");
              //   // _incrementCounter();
              //   // debugPrint(index.toString());
              // },
              child: ListTile(
                  minLeadingWidth: 12,
                  leading: Transform.translate(
                    offset: const Offset(-8, 0),
                    child: const Icon(
                      Icons.info_outline,
                      color: Colors.white,
                    ),
                  ),
                  trailing: Transform.translate(
                      offset: const Offset(8, 0),
                      child: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            debugPrint("Deleting $index");
                            notifList.removeAt(index);
                          })),
                  // leading: const Icon(Icons.copy_sharp),
                  title: Transform.translate(
                    offset: const Offset(-4, 0),
                    child: Text(
                      notifList[index].title,
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                  // contentPadding: const EdgeInsets.only(bottom: 20.0),
                  ),
            ),
          ),
        ));
  }
}

class _NotifTitle extends StatelessWidget {
  const _NotifTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
    );
  }
}

class _NotifPopupCard extends StatelessWidget {
  const _NotifPopupCard({Key? key, required this.notif}) : super(key: key);
  final User notif;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: notif.id,
      createRectTween: (begin, end) {
        return CustomRectTween(begin: begin, end: end);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          color: Colors.red,
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  _NotifTitle(title: notif.title),
                  const SizedBox(
                    height: 8,
                  ),
                  if (notif.body != '') ...[
                    const Divider(
                      color: Colors.white,
                    ),
                    _NotifBodyContent(notif: notif),
                  ],
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NotifBodyContent extends StatelessWidget {
  const _NotifBodyContent({
    Key? key,
    required this.notif,
  }) : super(key: key);

  final User notif;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TitleAndBody(item: notif),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black)),
                onPressed: () {
                  debugPrint("Close Button!");
                  Navigator.pop(context);
                },
                child: const Text("Close")),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                onPressed: () {
                  debugPrint("Delete Button!");
                  Navigator.pop(context);
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.black),
                ))
          ],
        )
      ],
    );
  }
}

class _TitleAndBody extends StatefulWidget {
  const _TitleAndBody({
    Key? key,
    required this.item,
  }) : super(key: key);

  final User item;

  @override
  _TitleAndBodyState createState() => _TitleAndBodyState();
}

class _TitleAndBodyState extends State<_TitleAndBody> {
  void _onChanged(bool? val) {
    setState(() {
      widget.item.completed = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.item.body,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

// class _ConfirmDelete extends StatefulWidget {
//   const _ConfirmDelete({
//     required Key key,
//   })

// }

class _MyNotificationScreenState extends State<NotificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Future<List<User>> _myData;
  int _counter = 0;
  String? filterString;

  // @override
  // void initState() {
  //   _myData = getRequest();
  // }

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
    // setState(() {
    // _myData = users;
    // });
    return users;
  }

  Stream<List<User>> users() async* {
    debugPrint("Getting data!");
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
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
              future: getRequest(),
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data.length == 0) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(32),
                        child: Image(
                            image: AssetImage('assets/evaFace4HomeRed.png')),
                      ),
                      Text("No new notifications!")
                    ],
                  ));
                } else {
                  return Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      // scrollDirection: Axis.vertical,
                      // shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) => Dismissible(
                        direction: DismissDirection.startToEnd,
                        key: ValueKey<int>(index),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.endToStart) {
                            Navigator.of(context).push(
                              HeroDialogRoute(
                                builder: (context) => Center(
                                  child: _NotifPopupCard(
                                      notif: snapshot.data[index]),
                                ),
                              ),
                            );
                          }
                          // setState(() {
                          //   _myData.removeAt(index);
                          // });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: const Duration(seconds: 2),
                              content: Text(
                                  'Deleted $index: ${snapshot.data[index].title}')));
                        },
                        child: _NotifCard(
                          notifList: snapshot.data,
                          index: index,
                        ),
                      ),
                    ),
                  ));
                }
              },
            ),
          ]),
    );
  }
}
