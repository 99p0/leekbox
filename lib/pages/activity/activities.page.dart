import 'package:flutter/material.dart';
import 'package:leekbox_sdk/log.dart';

///
class ActivityListPage extends StatefulWidget {
  @override
  _ActivityListPageState createState() => _ActivityListPageState();
}

class _ActivityListPageState extends State<ActivityListPage> {
  @override
  Widget build(BuildContext context) {
    Log.debug('ActivityListPage build');
    return Scaffold(
      body: Center(
        child: Text("ActivityListPage"),
      ),
    );
  }
}
