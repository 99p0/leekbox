import 'package:flutter/material.dart';
import 'package:leekbox_infra/log/log.dart';

///
class IndexSecondFloorPage extends StatefulWidget {
  @override
  _IndexSecondFloorPageState createState() => _IndexSecondFloorPageState();
}

class _IndexSecondFloorPageState extends State<IndexSecondFloorPage> {
  @override
  Widget build(BuildContext context) {
    // super.build(context);

    Log.debug('IndexSecondFloorPage build');
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
