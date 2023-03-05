import 'package:eva/classes/data_types.dart';
import 'package:eva/screens/wrapper.dart';
import 'package:eva/utilities/firebase/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});

  final String title;

  @override
  State<LoginScreen> createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  final String _buttonText = "Login";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _errorText = '';

  final AuthService _auth = AuthService();

  _goToHomeScreen() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      print(email);
      print(password);
      // Process data.
      UserCredential? result =
          await _auth.signIn(email = email, password = password);

      if (result == null) {
        print('Error');
        setState(() {
          _errorText = "Unable to Authenticate!";
        });

        // await _auth.signInAnon();

        print("Signing in as anonymous user");
        // Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
      } else {
        print('Success logging in ${result.user?.email}!');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Wrapper()),
            (_) => false);

        // Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
      }
      print(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserType?>(context);

    print(user?.uuid);

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Form(
            key: _formKey,
            child: Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(top: 48.0, bottom: 24.0),
                        child: Image(
                            image: AssetImage('assets/evaFace4HomeRed.png')),
                      ),
                      const Text.rich(TextSpan(
                          text: "EVA Companion App",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 24))),
                      const Text.rich(TextSpan(
                          text: "Please Log In",
                          style: TextStyle(fontSize: 14))),
                      const Padding(
                        padding: EdgeInsets.only(top: 24),
                        child: Text.rich(TextSpan(
                            text: "Email",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(hintText: "Enter your email"),
                        validator: (String? value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          email = value.toString();
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 24),
                        child: Text.rich(TextSpan(
                            text: "Password",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: "Enter your password"),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid password';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          password = value.toString();
                        },
                        onFieldSubmitted: (value) {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            //               var result = await auth.sendPasswordResetEmail(_email);
                            //               print(result);
                            // print(_email);
                            // Navigator.of(context)
                            //     .pushNamedAndRemoveUntil('/home', (_) => false);
                            print(value);
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: ElevatedButton(
                            onPressed: _goToHomeScreen,
                            child: Text.rich(TextSpan(text: _buttonText))),
                      )
                    ],
                  ),
                ))));
  }
}
