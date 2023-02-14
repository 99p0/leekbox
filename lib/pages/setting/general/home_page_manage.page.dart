import 'package:flutter/material.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/common/widgets/my_app_bar.dart';
import 'package:leekbox_infra/log/log.dart';

///
class HomePageManagePage extends StatefulWidget {
  const HomePageManagePage({super.key});

  static String get routeName => 'settings/HomePageManage';

  static String get routeLocation => '/$routeName';

  @override
  _HomePageManagePageState createState() => _HomePageManagePageState();
}

class _HomePageManagePageState extends State<HomePageManagePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('HomePageManagePage build...');
    return Scaffold(
      appBar: MyAppBar(
        title: '首页管理',
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
