import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

///
class IndexSecondFloorPage extends StatefulWidget {
  @override
  _IndexSecondFloorPageState createState() => _IndexSecondFloorPageState();
}

class _IndexSecondFloorPageState extends State<IndexSecondFloorPage> {
  final log = Logger('IndexSecondFloorPage');

  @override
  Widget build(BuildContext context) {
    // super.build(context);

    log.info('IndexSecondFloorPage build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('LEEK BOX'),
      ),
      body: Center(
        child: Text("IndexSecondFloorPage"),
      ),
    );
  }

// @override
// bool get wantKeepAlive => true;
}
