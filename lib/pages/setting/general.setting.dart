import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/common/widgets/my_set_cell.dart';
import 'package:leekbox_infra/log/log.dart';

import 'general/color_scheme.page.dart';
import 'general/font.page.dart';
import 'general/home_page_manage.page.dart';
import 'general/language.page.dart';
import 'general/storage_manage.page.dart';
import 'general/themes.page.dart';

///
class GeneralSettingPage extends StatefulWidget {
  const GeneralSettingPage({super.key});

  static String get routeName => 'settings/global_UI';

  static String get routeLocation => '/$routeName';

  @override
  _GeneralSettingPageState createState() => _GeneralSettingPageState();
}

class _GeneralSettingPageState extends State<GeneralSettingPage> {
  @override
  Widget build(BuildContext context) {
    // super.build(context);

    Log.debug('GeneralSettingPage build');
    final themeData = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('通用'),
          ),
          SliverToBoxAdapter(
            child: getBody(context),
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
          MySetCell(
            title: '深色模式',
            clickCallBack: () => context.push(ColorSchemePage.routeLocation),
          ),
          Gaps.vGap4,
          MySetCell(
            title: '字体风格与大小',
            clickCallBack: () => context.push(FontsPage.routeLocation),
          ),
          MySetCell(
            title: '多语言',
            clickCallBack: () => context.push(LanguagesPage.routeLocation),
          ),
          Gaps.vGap4,
          MySetCell(
            title: '主题风格',
            clickCallBack: () => context.push(ThemesPage.routeLocation),
          ),
          MySetCell(
            title: '首页管理',
            clickCallBack: () => context.push(HomePageManagePage.routeLocation),
          ),
          MySetCell(
            title: '存储空间',
            clickCallBack: () => context.push(StorageManagePage.routeLocation),
          ),
        ],
      ),
    );
  }
// @override
// bool get wantKeepAlive => true;
}
