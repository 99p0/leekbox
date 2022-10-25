import 'package:flutter/material.dart';
import 'package:leekbox_sdk/log.dart';

///
class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    // super.build(context);

    Log.debug('SettingPage build');
    return Scaffold(
      body: Center(
        child: Text("SettingPage"),
      ),
    );
  }

// @override
// bool get wantKeepAlive => true;
}
