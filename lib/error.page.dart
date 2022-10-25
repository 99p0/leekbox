import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leekbox_sdk/log.dart';


class ErrorPage extends StatefulWidget {
  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    Log.debug('ErrorPage build');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go back to home page'),
            ),
          ],
        ),
      ),
    );
  }
}
