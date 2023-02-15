import 'package:flutter/material.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/common/widgets/my_app_bar.dart';
import 'package:leekbox_infra/log/log.dart';

///
class CardPackagePage extends StatefulWidget {
  const CardPackagePage({super.key});

  static String get routeName => 'mine/CardPackage';

  static String get routeLocation => '/$routeName';

  @override
  _CardPackagePageState createState() => _CardPackagePageState();
}

class _CardPackagePageState extends State<CardPackagePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('CardPackagePage build...');
    return Scaffold(
      appBar: MyAppBar(
        title: '卡包',
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
