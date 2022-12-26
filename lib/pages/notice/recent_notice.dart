import 'package:flutter/material.dart';
import 'package:leekbox/common/widgets/my_app_bar.dart';
import 'package:leekbox_infra/log/log.dart';

class RecentNoticePage extends StatefulWidget {
  const RecentNoticePage({super.key});

  static String get routeName => 'notice/recent';

  static String get routeLocation => '/$routeName';

  @override
  _RecentNoticePageState createState() => _RecentNoticePageState();
}

class _RecentNoticePageState extends State<RecentNoticePage> {
  @override
  Widget build(BuildContext context) {
    Log.debug('RecentNoticePage build');
    return Scaffold(
      appBar: MyAppBar(title: '最近消息'),
      body: Text("RecentNoticePage"),
    );
  }
// @override
// bool get wantKeepAlive => true;
}
