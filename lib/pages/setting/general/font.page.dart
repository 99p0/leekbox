import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leekbox/common/utils/utils.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/common/widgets/my_app_bar.dart';
import 'package:leekbox/common/widgets/my_set_cell.dart';
import 'package:leekbox_infra/log/log.dart';

///
class FontsPage extends ConsumerStatefulWidget {
  const FontsPage({super.key});

  static String get routeName => 'settings/Fonts';

  static String get routeLocation => '/$routeName';

  @override
  _FontsPageState createState() => _FontsPageState();
}

class _FontsPageState extends ConsumerState<FontsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('FontsPage build...');
    return Scaffold(
      appBar: MyAppBar(
        title: '字体设置',
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
            title: '苹方SC',
            clickCallBack: () => showToast('账户与安全'),
          ),
          MySetCell(
            title: '粉嘟嘟拼音体',
            clickCallBack: () => showToast('粉嘟嘟拼音体'),
          ),
          MySetCell(
            title: '今年也要加油鸭',
            clickCallBack: () => showToast('今年也要加油鸭'),
          ),
          Gaps.vGap4,
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
