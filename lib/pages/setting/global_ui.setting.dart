import 'package:flutter/material.dart';
import 'package:leekbox/common/widgets/my_app_bar.dart';
import 'package:leekbox_infra/log/log.dart';

///
class GlobalUISettingPage extends StatefulWidget {
  const GlobalUISettingPage({super.key});

  static String get routeName => 'settings/global_UI';

  static String get routeLocation => '/$routeName';

  @override
  _GlobalUISettingPageState createState() => _GlobalUISettingPageState();
}

class _GlobalUISettingPageState extends State<GlobalUISettingPage> {
  @override
  Widget build(BuildContext context) {
    // super.build(context);

    Log.debug('GlobalUISettingPage build');
    return Scaffold(
      appBar: MyAppBar(title: 'UI配置'),
      body: Center(
        child: Text("GlobalUISettingPage"),
      ),
    );
  }

// @override
// bool get wantKeepAlive => true;
}
