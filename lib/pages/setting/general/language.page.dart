import 'package:flutter/material.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/common/widgets/my_app_bar.dart';
import 'package:leekbox/common/widgets/my_set_cell.dart';
import 'package:leekbox_infra/log/log.dart';
import 'package:oktoast/oktoast.dart';

///
class LanguagesPage extends StatefulWidget {
  const LanguagesPage({super.key});

  static String get routeName => 'settings/Languages';

  static String get routeLocation => '/$routeName';

  @override
  _LanguagesPageState createState() => _LanguagesPageState();
}

class _LanguagesPageState extends State<LanguagesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('LanguagesPage build...');
    return Scaffold(
      appBar: MyAppBar(
        title: '多语言',
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
            title: '简体中文',
            clickCallBack: () => showToast('支付设置'),
          ),
          MySetCell(
            title: '繁体中文',
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
