import 'package:flutter/material.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/common/widgets/my_app_bar.dart';
import 'package:leekbox_infra/log/log.dart';

///
class AccountAndSecurityPage extends StatefulWidget {
  const AccountAndSecurityPage({super.key});

  static String get routeName => 'settings/AccountAndSecurity';

  static String get routeLocation => '/$routeName';

  @override
  _AccountAndSecurityPageState createState() => _AccountAndSecurityPageState();
}

class _AccountAndSecurityPageState extends State<AccountAndSecurityPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('AccountAndSecurityPage build...');
    return Scaffold(
      appBar: MyAppBar(
        title: '账户与安全',
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
