import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leekbox/common/utils/utils.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/common/widgets/my_app_bar.dart';
import 'package:leekbox/common/widgets/my_set_cell.dart';
import 'package:leekbox_infra/log/log.dart';

///
class ThemesPage extends ConsumerStatefulWidget {
  const ThemesPage({super.key});

  static String get routeName => 'settings/Themes';

  static String get routeLocation => '/$routeName';

  @override
  _ThemesPageState createState() => _ThemesPageState();
}

class _ThemesPageState extends ConsumerState<ThemesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('ThemesPage build...');
    return Scaffold(
      appBar: MyAppBar(
        title: '主题风格',
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
            title: '跟随系统',
            clickCallBack: () => showToast('账户与安全'),
          ),
          MySetCell(
            title: '浅色模式',
            clickCallBack: () => showToast('支付设置'),
          ),
          MySetCell(
            title: '深色模式',
            clickCallBack: () => showToast('支付设置'),
          ),
          Gaps.vGap4,
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
