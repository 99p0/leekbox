import 'package:flutter/material.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/common/widgets/my_app_bar.dart';
import 'package:leekbox_infra/log/log.dart';

///
class NewNotificationPage extends StatefulWidget {
  const NewNotificationPage({super.key});

  static String get routeName => 'settings/NewNotification';

  static String get routeLocation => '/$routeName';

  @override
  _NewNotificationPageState createState() => _NewNotificationPageState();
}

class _NewNotificationPageState extends State<NewNotificationPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('NewNotificationPage build...');
    return Scaffold(
      appBar: MyAppBar(
        title: '新消息通知',
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: getBody(context),
        ),
      ),
    );
  }

  Widget getBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Gaps.vGap4,
          Gaps.vGap4,
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
