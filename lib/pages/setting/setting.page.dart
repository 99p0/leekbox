import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/common/widgets/my_app_bar.dart';
import 'package:leekbox/common/widgets/my_set_cell.dart';
import 'package:leekbox/pages/setting/about.page.dart';
import 'package:leekbox/pages/setting/general.setting.dart';
import 'package:leekbox_infra/log/log.dart';

import 'account_security.page.dart';
import 'help.page.dart';
import 'new_notification.page.dart';
import 'privacy.page.dart';

///
class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  static String get routeName => 'settings';

  static String get routeLocation => '/$routeName';

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('SettingPage build...');
    return Scaffold(
      appBar: MyAppBar(
        title: '设置',
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
          MySetCell(
            title: '账户与安全',
            clickCallBack: () =>
                context.push(AccountAndSecurityPage.routeLocation),
          ),
          Gaps.vGap4,
          MySetCell(
            title: '新消息通知',
            clickCallBack: () =>
                context.push(NewNotificationPage.routeLocation),
          ),
          MySetCell(
            title: '隐私',
            clickCallBack: () => context.push(PrivacyPage.routeLocation),
          ),
          MySetCell(
            title: '通用',
            clickCallBack: () => context.push(GeneralSettingPage.routeLocation),
          ),
          Gaps.vGap4,
          MySetCell(
            title: '帮助与反馈',
            clickCallBack: () => context.push(HelpPage.routeLocation),
          ),
          MySetCell(
            title: '关于',
            clickCallBack: () => context.push(AboutPage.routeLocation),
          ),
          Gaps.vGap4,
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
