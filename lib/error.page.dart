import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

class ErrorPage extends StatefulWidget {
  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {

  final log = Logger('ErrorPage');
  @override
  Widget build(BuildContext context) {
    log.info('ErrorPage build');
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
