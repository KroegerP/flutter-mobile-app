import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva/screens/reports/individual_report.dart';
import 'package:eva/utilities/firebase/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../classes/data_types.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _MyReportsScreenState();
}

class _MyReportsScreenState extends State<ReportsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? filterString;
  FirestoreService userReports = FirestoreService();

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
    debugPrint(filterString);
    final String response =
        await rootBundle.loadString('assets/sampleData/alertSample.json');
    final data = await json.decode(response);
    // var responseData = [];

    //Creating a list to store input data;
    List<AlertType> users = [];
    for (var singleUser in data) {
      AlertType user = AlertType(
          id: singleUser["id"],
          firstName: singleUser["firstName"],
          medicationName: singleUser["medicationName"],
          lastName: singleUser["lastName"]);

      //Adding user to the list.
      if (_matchRegExp(user.medicationName, filterString ?? '')) {
        users.add(user);
      }
    }
    return users;
  }

  // Future<List<ReportType>> getReports() async {
  //   print('Getting report data...');
  //   final reportData =
  //       await FirestoreService().getDocumentById('BMzcY66MlmwygVrdDgvh');
  //   // print(reportData);
  //   if (reportData != null) {
  //     return reportData;
  //   }

  //   return ReportType();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          readJson();
        },
        tooltip: 'Refresh Reports Data',
        label: const Text("Get Reports"),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.black,
        hoverColor: Colors.black12,
      ), // This trailing comma makes auto-formatting nicer for build methods.
      body: Column(children: <Widget>[
        Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    hintText: "Filter for report",
                    hintStyle: TextStyle(color: Colors.white)),
                onChanged: (value) {
                  setState(() {
                    filterString = value;
                  });
                  // readJson();
                },
              ),
            )),
        FutureBuilder(
          future: FirestoreService().getDocumentById('BMzcY66MlmwygVrdDgvh'),
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
                        image: AssetImage('assets/evaFace4HomeRedSad.png')),
                  ),
                  Text("No data to show!")
                ],
              ));
            } else {
              print(snapshot.data);
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
                          debugPrint(index.toString());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => IndividualReport(
                                        reportId: snapshot.data[index],
                                      )));
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
                          // leading: const Icon(Icons.copy_sharp),
                          title: Text(snapshot.data[index].medicationName),
                          subtitle: Text(snapshot.data[index].medicationName),
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
