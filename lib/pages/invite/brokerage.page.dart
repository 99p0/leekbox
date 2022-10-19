import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

///
class BrokeragePage extends StatefulWidget {
  @override
  _BrokeragePageState createState() => _BrokeragePageState();
}

class _BrokeragePageState extends State<BrokeragePage> {
  final log = Logger('BrokeragePage');

  @override
  Widget build(BuildContext context) {
    // super.build(context);

    log.info('BrokeragePage build');
    return Scaffold(
      body: Center(
        child: Text("BrokeragePage"),
      ),
    );
  }

// @override
// bool get wantKeepAlive => true;
}
