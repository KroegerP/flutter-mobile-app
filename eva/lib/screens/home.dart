import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:eva/classes/data_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<HomeScreen> {
  UserType _user = UserType();

  void _goToReportsPage() {
    debugPrint("Sending to reports page!");
    Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
  }

// TODO: MOVE TO UTILS FUNCTION
  String _formatDate(DateTime dateObject) {
    final curDay = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(dateObject);
    debugPrint(formatted); // something like 2013-04-20

    // final String formattedDate = curDay.weekday

    return formatted;
  }

  // Local method of gathering JSON data
  Future<UserType> readJson() async {
    // debugPrint(filterString);
    final String response =
        await rootBundle.loadString('assets/sampleData/userInfoSample.json');
    final userInfo = await jsonDecode(response);
    // var responseData = [];
    debugPrint("DATA: ${userInfo.toString()}");

    // debugPrint(userInfo.runtimeType.toString());

    debugPrint(userInfo.toString());
    // debugPrint(userInfo["id"].toString());

    UserType user = UserType(
        uuid: userInfo["uuid"] ?? '',
        firstName: userInfo["firstName"] ?? '',
        lastName: userInfo["lastName"] ?? '',
        numMedications: userInfo["numMedications"] ?? -1,
        numHighPriority: userInfo["numHighPriority"] ?? -1,
        numNotTaken: userInfo["numNotTaken"] ?? -1,
        percentTaken: userInfo["percentTaken"] ?? -1,
        timeStamp: DateTime.parse(userInfo["timeStamp"]));
    debugPrint("creating user ${userInfo["timeStamp"]}");
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: FutureBuilder(
          future: readJson(),
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            } else if (snapshot.hasData) {
              UserType user = snapshot.data;
              debugPrint("TIMESTAMP: ${snapshot.data.timeStamp.toString()}");
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Align(
                      alignment: Alignment.center,
                      child: Image(
                        image: AssetImage(
                            'assets/chart.png'), //TODO: pull image from pi
                      ),
                    ),
                  ), // TODO: Make this rich with a identifying title
                  Padding(
                      padding: const EdgeInsets.only(
                          bottom: 16, right: 16, left: 16),
                      child: Text(
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        "Your Report for ${_formatDate(user.timeStamp ?? DateTime.now())}",
                      )),
                  Text(
                    "${user.firstName} ${user.lastName} has NUMBER medications",
                  ),
                  const Text(
                      "NAME has NOT taken QUANTITY of their medications"),
                  const Text("NUMBER are high priority medications"),
                  TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(16.0),
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      onPressed: _goToReportsPage,
                      child: const Text("Click here to view detailed reports")),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
          }),
    );
  }
}
