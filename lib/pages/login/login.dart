import 'package:flutter/material.dart';
import 'package:leekbox_infra/auth/stream_auth_scope.dart';
import 'package:leekbox_infra/log/log.dart';

///
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  bool loggingIn = false;
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Log.debug('LoginPage build...');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (loggingIn) CircularProgressIndicator(value: controller.value),
            if (!loggingIn)
              ElevatedButton(
                onPressed: () {
                  StreamAuthScope.of(context).signIn('test-user');
                  setState(() {
                    loggingIn = true;
                  });
                },
                child: const Text('Login'),
              ),
          ],
        ),
      ),
    );
  }
}
