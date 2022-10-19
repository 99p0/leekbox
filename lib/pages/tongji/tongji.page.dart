import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

///
class TongjiPage extends StatefulWidget {
  @override
  _TongjiPageState createState() => _TongjiPageState();
}

class _TongjiPageState extends State<TongjiPage> {
  final log = Logger('TongjiPage');

  @override
  Widget build(BuildContext context) {
    // super.build(context);

    log.info('Tongji build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('LEEK BOX'),
      ),
      body: Center(
        child: Text("Tongji"),
      ),
    );
  }

// @override
// bool get wantKeepAlive => true;
}
