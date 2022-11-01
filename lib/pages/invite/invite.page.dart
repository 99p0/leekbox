import 'package:flutter/material.dart';
import 'package:leekbox_infra/log/log.dart';

/// 页面
class InvitePage extends StatefulWidget {
  @override
  _InvitePageState createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  @override
  Widget build(BuildContext context) {
    // super.build(context);

    Log.debug('InvitePage build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('LEEK BOX'),
      ),
      body: Center(
        child: Text("InvitePage"),
      ),
    );
  }
// @override
// bool get wantKeepAlive => true;
}
