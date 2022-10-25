import 'package:flutter/material.dart';
import 'package:leekbox_sdk/log.dart';

/// 页面
class NoticePage extends StatefulWidget {
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage>  {

  @override
  Widget build(BuildContext context) {
    // super.build(context);

    Log.debug('NoticePage build');
    return Scaffold(

      appBar: AppBar(
        title: const Text('LEEK BOX'),
      ),
      body: Center(
        child: Text("NoticePage"),
      ),
    );
  }
  // @override
  // bool get wantKeepAlive => true;
}
