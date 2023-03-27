import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leekbox_infra/log/log.dart';

///
class ActivityDetailPage extends ConsumerStatefulWidget {
  const ActivityDetailPage({super.key});

  static String get routeName => 'activity/detail';

  static String get routeLocation => '/$routeName';

  @override
  _ActivityDetailPageState createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends ConsumerState<ActivityDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
