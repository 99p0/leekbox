import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/common/widgets/my_set_cell.dart';
import 'package:leekbox/pages/setting/about.page.dart';
import 'package:leekbox/pages/setting/general.setting.dart';
import 'package:leekbox/state/auth.dart';
import 'package:leekbox_infra/log/log.dart';

import 'account_security.page.dart';
import 'help.page.dart';
import 'new_notification.page.dart';
import 'privacy.page.dart';

///
class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  static String get routeName => 'settings';

  static String get routeLocation => '/$routeName';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Log.debug('SettingPage build...');
    final themeData = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('设置'),
          ),
          SliverToBoxAdapter(
            child: getBody(context),
          ),
          SliverToBoxAdapter(
            child: ElevatedButton(
              onPressed: () async {
                ref.watch(authNotifierProvider.notifier).logout();
              },
              child: const Text('退出'),
            ),
          ),
        ],
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
}
