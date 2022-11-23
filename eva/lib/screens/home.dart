import 'package:eva/main.dart';
import 'package:eva/screens/reports.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<HomeScreen> {
  void _goToReportsPage() {
    debugPrint("Sending to reports page!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.center,
              child: Image(
                image:
                    AssetImage('assets/chart.png'), //TODO: pull image from pi
              ),
            ),
          ), // TODO: Make this rich with a identifying title
          const Padding(
              padding: EdgeInsets.only(bottom: 16, right: 16, left: 16),
              child: Text(
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                "Your Report for November 10th, 2022",
              )),
          const Text(
            "NAME has NUMBER medications",
          ),
          const Text("NAME has NOT taken QUANTITY of their medications"),
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
      ),
    );
  }
}
