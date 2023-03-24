import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leekbox_infra/log/log.dart';

///
class ActivityListPage extends ConsumerStatefulWidget {
  @override
  _ActivityListPageState createState() => _ActivityListPageState();
}

class _ActivityListPageState extends ConsumerState<ActivityListPage> {
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
