import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

///
class ActivityListPage extends StatefulWidget {
  @override
  _ActivityListPageState createState() => _ActivityListPageState();
}

class _ActivityListPageState extends State<ActivityListPage> {
  final log = Logger('ActivityListPage');
  @override
  Widget build(BuildContext context) {
    log.info('ActivityListPage build');
    return Scaffold(
      body: Center(
        child: Text("ActivityListPage"),
      ),
    );
  }
}
