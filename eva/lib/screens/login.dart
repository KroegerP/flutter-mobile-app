import 'dart:html';

import 'package:eva/main.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});

  final String title;

  @override
  State<LoginScreen> createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _counter = 0;
  _goToHomeScreen() {
    if (_formKey.currentState!.validate()) {
      // Process data.
      Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Form(
            key: _formKey,
            child: Padding(
                padding: const EdgeInsets.only(left: 100, right: 100),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text("LOGIN SCREEN"),
                      const Text("Username"),
                      TextFormField(
                        decoration:
                            const InputDecoration(hintText: "Enter your email"),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid username';
                          }
                          return null;
                        },
                      ),
                      const Text("Password"),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: "Enter your password"),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid username';
                          }
                          return null;
                        },
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: TextButton(
                              onPressed: _goToHomeScreen,
                              child: const Text("LOGIN")))
                    ],
                  ),
                ))));
  }
}
