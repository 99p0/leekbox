import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

/// 页面
class InvitePage extends StatefulWidget {
  @override
  _InvitePageState createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  final log = Logger('InvitePage');

  @override
  Widget build(BuildContext context) {
    // super.build(context);

    log.info('InvitePage build');
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
