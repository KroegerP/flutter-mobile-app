import 'dart:convert';

import 'package:eva/screens/individualReports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _MyReportsScreenState();
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

class _MyReportsScreenState extends State<ReportsScreen> {
  int _counter = 0;

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

  // Local method of gathering JSON data
  Future<List<User>> readJson() async {
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
      users.add(user);
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
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: getRequest,
        tooltip: 'Refresh Reports Data',
        label: const Text("Get Reports"),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.black,
        hoverColor: Colors.black12,
      ), // This trailing comma makes auto-formatting nicer for build methods.
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: readJson(),
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => Card(
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      _incrementCounter();
                      debugPrint(index.toString());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IndividualReport(
                                    reportId: index.toString(),
                                  )));
                    },
                    child: ListTile(
                      leading: Transform.translate(
                        offset: const Offset(8, 0),
                        child: Container(
                          height: 32,
                          width: 32,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            color: Colors.white,
                          ),
                          child: const Icon(Icons.copy),
                        ),
                      ),
                      // leading: const Icon(Icons.copy_sharp),
                      title: Text(snapshot.data[index].title),
                      subtitle: Text(snapshot.data[index].body),
                      contentPadding: const EdgeInsets.only(bottom: 20.0),
                    ),
                  ),
                ),
                // itemBuilder: (ctx, index) => ListTile(
                //   title: Text(snapshot.data[index].title),
                //   subtitle: Text(snapshot.data[index].body),
                //   contentPadding: const EdgeInsets.only(bottom: 20.0),
                // ),
              );
            }
          },
        ),
      ),
      // body: Align(
      //   alignment: Alignment.center,
      //   child: Column(
      //     // Column is also a layout widget. It takes a list of children and
      //     // arranges them vertically. By default, it sizes itself to fit its
      //     // children horizontally, and tries to be as tall as its parent.
      //     //
      //     // Invoke "debug painting" (press "p" in the console, choose the
      //     // "Toggle Debug Paint" action from the Flutter Inspector in Android
      //     // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
      //     // to see the wireframe for each widget.
      //     //
      //     // Column has various properties to control how it sizes itself and
      //     // how it positions its children. Here we use mainAxisAlignment to
      //     // center the children vertically; the main axis here is the vertical
      //     // axis because Columns are vertical (the cross axis would be
      //     // horizontal).
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Card(
      //         // clipBehavior is necessary because, without it, the InkWell's animation
      //         // will extend beyond the rounded edges of the [Card] (see https://github.com/flutter/flutter/issues/109776)
      //         // This comes with a small performance cost, and you should not set [clipBehavior]
      //         // unless you need it.
      //         clipBehavior: Clip.hardEdge,
      //         child: InkWell(
      //           splashColor: Colors.blue.withAlpha(30),
      //           onTap: () {
      //             _incrementCounter();
      //             debugPrint('Card tapped.');
      //           },
      //           child: const SizedBox(
      //             width: 300,
      //             height: 100,
      //             child: Center(child: Text('View Past Reports')),
      //           ),
      //         ),
      //       ),
      //       Card(
      //         clipBehavior: Clip.hardEdge,
      //         child: InkWell(
      //           splashColor: Colors.blue.withAlpha(30),
      //           onTap: () {
      //             _incrementCounter();
      //             debugPrint('Card tapped.');
      //           },
      //           child: const SizedBox(
      //             width: 300,
      //             height: 100,
      //             child:
      //                 Center(child: Text('View Individual Medicine Reports')),
      //           ),
      //         ),
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headline4,
      //       ),
      //     ],
      //   ),
      // )
    );
  }
}
