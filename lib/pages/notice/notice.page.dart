import 'package:flutter/material.dart';
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
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: NetworkImage(
            'https://img.zcool.cn/community/0372d195ac1cd55a8012062e3b16810.jpg'),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
        appBar: AppBar(
          backgroundColor: Colors.transparent, //把appbar的背景色改成透明
          // elevation: 0,//appbar的阴影
          title: const Text('消息'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
// @override
// bool get wantKeepAlive => true;
}
