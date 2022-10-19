import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

///
class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final log = Logger('SettingPage');

  @override
  Widget build(BuildContext context) {
    // super.build(context);

    log.info('SettingPage build');
    return Scaffold(
      body: Center(
        child: Text("SettingPage"),
      ),
    );
  }

// @override
// bool get wantKeepAlive => true;
}
