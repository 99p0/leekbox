import 'package:flutter/material.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/common/widgets/my_app_bar.dart';
import 'package:leekbox_infra/log/log.dart';

///
class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  static String get routeName => 'settings/About';

  static String get routeLocation => '/$routeName';

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('AboutPage build...');
    return Scaffold(
      appBar: MyAppBar(
        title: '关于',
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
