import 'package:flutter/material.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/common/widgets/my_app_bar.dart';
import 'package:leekbox_infra/log/log.dart';

///
class VipIntroPage extends StatefulWidget {
  const VipIntroPage({super.key});

  static String get routeName => 'mine/VipIntro';

  static String get routeLocation => '/$routeName';

  @override
  _VipIntroPageState createState() => _VipIntroPageState();
}

class _VipIntroPageState extends State<VipIntroPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('VipIntroPage build...');
    return Scaffold(
      appBar: MyAppBar(
        title: '升级更高会员',
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
