import 'package:flutter/material.dart';
import 'package:leekbox_sdk/log.dart';


/// 闪屏 + 介绍页
class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  @override
  Widget build(BuildContext context) {
    Log.debug('SplashScreen build');
    return Scaffold(
      body: Center(
        child: Text("SplashScreen"),
      ),
    );
  }
}
