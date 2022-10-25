import 'package:flutter/material.dart';
import 'package:leekbox_sdk/log.dart';

///
class ActivityDetailPage extends StatefulWidget {
  @override
  _ActivityDetailPageState createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {

  @override
  Widget build(BuildContext context) {
    Log.debug('ActivityDetailPage build');
    return Scaffold(
      body: Center(
        child: Text("ActivityDetailPage"),
      ),
    );
  }
}
