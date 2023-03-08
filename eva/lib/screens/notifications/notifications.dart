import 'dart:convert';

import 'package:eva/classes/data_types.dart';
import 'package:eva/screens/reports/individualReports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../utilities/cutomRectTween.dart';
import '../../utilities/heroDialogueRoute.dart';
import '../../utilities/styles.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _MyNotificationScreenState();
}

//Creating a class user to store the data;

class _NotifCard extends StatelessWidget {
  /// {@macro todo_card}
  const _NotifCard({
    Key? key,
    required this.index,
    required this.notifList,
  }) : super(key: key);

  final List<AlertType> notifList;
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
                      notifList[index].medicationName,
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
    required this.medicationName,
  }) : super(key: key);

  final String medicationName;

  @override
  Widget build(BuildContext context) {
    return Text(
      medicationName,
      style: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
    );
  }
}

class _NotifPopupCard extends StatelessWidget {
  const _NotifPopupCard({Key? key, required this.notif}) : super(key: key);
  final AlertType notif;

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
                  _NotifTitle(medicationName: notif.medicationName),
                  const SizedBox(
                    height: 8,
                  ),
                  if (notif.medicationPriority != '') ...[
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

  final AlertType notif;

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

  final AlertType item;

  @override
  _TitleAndBodyState createState() => _TitleAndBodyState();
}

class _TitleAndBodyState extends State<_TitleAndBody> {
  void _onChanged(bool? val) {
    setState(() {
      widget.item.cleared = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.item.medicationPriority.toString(),
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
  late Future<List<AlertType>> _myData;
  String? filterString;

  // @override
  // void initState() {
  //   _myData = getRequest();
  // }

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
  Future<List<AlertType>> readJson() async {
    final String response =
        await rootBundle.loadString('assets/sampleData/alertSample.json');
    final data = await jsonDecode(response);
    // var responseData = [];
    debugPrint("DATA: ${data.toString()}");

    //Creating a list to store input data;
    List<AlertType> alerts = [];

    for (var singleAlert in data) {
      AlertType alert = AlertType(
          id: singleAlert["id"],
          firstName: singleAlert["firstName"],
          lastName: singleAlert["lastName"],
          medicationName: singleAlert["medicationName"],
          medicationPriority: singleAlert["medicationPriority"],
          timeStamp: DateTime.parse(singleAlert["timeStamp"]));
      //Adding user to the list.
      // if (_matchRegExp(user.medicationName, filterString ?? '')) {
      //   users.add(user);
      // }
      alerts.add(alert);
    }
    // setState(() {
    // _myData = users;
    // });
    return alerts;
  }

  // GET request via http package, what will actually be used
  Future<List<AlertType>> getRequest() async {
    //replace your restFull API here.
    String url = "https://jsonplaceholder.typicode.com/posts";
    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);
    // var responseData = [];

    //Creating a list to store input data;
    List<AlertType> users = [];
    for (var singleUser in responseData) {
      AlertType user = AlertType(
          id: singleUser["id"],
          firstName: singleUser["firstName"],
          medicationName: singleUser["medicationName"],
          medicationPriority: singleUser["medicationPriority"]);

      //Adding user to the list.
      if (_matchRegExp(user.medicationName, filterString ?? '')) {
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
              future: readJson(),
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
                                  'Deleted $index: ${snapshot.data[index].medicationName}')));
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
