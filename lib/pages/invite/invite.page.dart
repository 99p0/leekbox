import 'package:flutter/material.dart';
import 'package:leekbox_infra/log/log.dart';

/// 页面
class InvitePage extends StatefulWidget {
  @override
  _InvitePageState createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // see AutomaticKeepAliveClientMixin
    Log.debug('InvitePage build');

    return Container(
      child: Text('邀请'),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
