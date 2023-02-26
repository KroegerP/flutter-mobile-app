import 'package:flutter/material.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _MyUserSettingsState();
}

class _MyUserSettingsState extends State<UserSettings> {
  bool _toggleAlerts = false;
  bool _toggleAlerts2 = false;
  String _buttonText = "Hello";
  double _alertFrequncy = 5;

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
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("Settings"),
          actions: [
            IconButton(
                onPressed: () => debugPrint("Hi"),
                icon: const Icon(Icons.notifications)),
            IconButton(
                onPressed: () => debugPrint("Hi"),
                icon: const Icon(Icons.settings))
          ],
        ),
        backgroundColor: Colors.white,
        body: Column(
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
            TextButton(
                onPressed: _toggleAlertsFunction, child: Text(_buttonText)),
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
        ));
  }
}
