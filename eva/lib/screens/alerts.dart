import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _MyAlertsScreenState();
}

class _MyAlertsScreenState extends State<AlertsScreen> {
  List<Map<String, dynamic>> _notifications = [];
  bool _toggleAlerts = false;
  bool _toggleAlerts2 = false;
  String _buttonText = "Hello";
  double _alertFrequncy = 5;

  @override
  void initState() {
    super.initState();

    // Retrieve the notifications from the Firebase Realtime Database
    DatabaseReference reference = FirebaseDatabase.instance.ref(
        'https://elderly-virtual-assistant-2-default-rtdb.firebaseio.com/');
    reference
        .child('notifications')
        .orderByChild('timestamp')
        .onValue
        .listen((event) {
      List<Map<String, dynamic>> notifications = [];
      DataSnapshot dataSnapshot = event.snapshot;
      if (dataSnapshot != null) {
        Map<dynamic, dynamic> data = Map<String, dynamic>.from(
            dataSnapshot.value as Map<Object?, Object?>);
        data.forEach((key, value) {
          notifications.add(Map<String, dynamic>.from(value));
        });
      }

      print('NOTIFICATIONS');
      print(notifications);

      // Update the UI with the retrieved notifications
      setState(() {
        _notifications = notifications;
      });
    });
  }

  void _toggleAlertsFunction() {
    setState(() {
      _toggleAlerts = !_toggleAlerts;
      _buttonText == "Hello" ? _buttonText = "Goodbye" : _buttonText = "Hello";
      debugPrint(_toggleAlerts.toString());
    });
  }

  void _toggleAlertsFunction2(bool? newVal) {
    setState(() {
      _toggleAlerts2 = newVal!;
      debugPrint(_toggleAlerts2.toString());
    });
  }

  void _updateAlertFrequency(value) {
    setState(() {
      _alertFrequncy = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Title(color: Colors.white, child: const Text("Configure Alerts")),
        const Text("This is the alerts screen"),
        const Text("This is the second text box"),
        Radio<bool>(
          value: _toggleAlerts,
          onChanged: (value) {
            setState(() {
              _toggleAlerts = value!;
            });
          },
          groupValue: _toggleAlerts,
        ),
        OutlinedButton(
            onPressed: _toggleAlertsFunction, child: Text(_buttonText)),
        TextButton(onPressed: _toggleAlertsFunction, child: Text(_buttonText)),
        ElevatedButton(
            onPressed: _toggleAlertsFunction, child: Text(_buttonText)),
        Checkbox(
            value: _toggleAlerts2,
            onChanged: (newVal) => _toggleAlertsFunction2(newVal)),
        Slider(
            value: _alertFrequncy,
            min: 1,
            max: 10,
            onChanged: (newValues) => _updateAlertFrequency(newValues))
      ],
    );
  }
}
