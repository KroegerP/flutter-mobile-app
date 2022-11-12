import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        children: const [
          Padding(
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.center,
              child: Image(
                image:
                    AssetImage('assets/chart.png'), //TODO: pull image from pi
              ),
            ),
          ), // TODO: Make this rich with a identifying title
          Padding(
              padding: EdgeInsets.only(bottom: 16, right: 16, left: 16),
              child: Text(
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                "Your Report for November 10th, 2022",
              ))
        ],
      ),
    );
  }
}
