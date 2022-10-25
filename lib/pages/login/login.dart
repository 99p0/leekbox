import 'package:flutter/material.dart';
import 'package:leekbox_sdk/log.dart';

///
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    Log.debug('Login build');
    return Scaffold(
      body: Center(
        child: Text("Login"),
      ),
    );
  }
}
