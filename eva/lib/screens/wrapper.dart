import 'package:eva/classes/data_types.dart';
import 'package:eva/navigation.dart';
import 'package:eva/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    UserType? user = Provider.of<UserType?>(context);

    if (user == null || user.isAnonymous) {
      return const LoginScreen(title: 'Sign In');
    } else {
      return const Navigation();
    }
  }
}
