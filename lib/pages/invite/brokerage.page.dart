import 'package:flutter/material.dart';

import 'package:leekbox_sdk/log.dart';
///
class BrokeragePage extends StatefulWidget {
  @override
  _BrokeragePageState createState() => _BrokeragePageState();
}

class _BrokeragePageState extends State<BrokeragePage> {

  @override
  Widget build(BuildContext context) {
    // super.build(context);

    Log.debug('BrokeragePage build');
    return Scaffold(
      body: Center(
        child: Text("BrokeragePage"),
      ),
    );
  }

// @override
// bool get wantKeepAlive => true;
}
