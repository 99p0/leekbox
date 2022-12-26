import 'package:flutter/material.dart';
import 'package:leekbox/common/widgets/my_app_bar.dart';
import 'package:leekbox_infra/log/log.dart';

/// 页面
class NoticePage extends StatefulWidget {
  const NoticePage({super.key});

  static String get routeName => 'notice';

  static String get routeLocation => '/$routeName';

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  Widget build(BuildContext context) {
    Log.debug('NoticePage build');
    return Scaffold(
      appBar: MyAppBar(
        title: '消息',
      ),
      body: Text("消息"),
    );
  }
// @override
// bool get wantKeepAlive => true;
}
