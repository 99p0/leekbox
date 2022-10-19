import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

///
class ActivityDetailPage extends StatefulWidget {
  @override
  _ActivityDetailPageState createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  final log = Logger('ActivityDetailPage');

  @override
  Widget build(BuildContext context) {
    log.info('ActivityDetailPage build');
    return Scaffold(
      body: Center(
        child: Text("ActivityDetailPage"),
      ),
    );
  }
}
