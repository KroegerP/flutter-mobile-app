import 'package:eva/main.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<LoginScreen> {
  _goToHomeScreen() {
    Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text("This is the login screen"),
        TextButton(onPressed: _goToHomeScreen, child: const Text("LOGIN"))
      ],
    );
  }
}
