import 'package:flutter/material.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _MyAlertsScreenState();
}

class _MyAlertsScreenState extends State<AlertsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("This is the alerts screen"),
    );
  }
}
