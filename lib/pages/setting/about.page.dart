import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leekbox/common/utils/image_utils.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/common/widgets/my_set_cell.dart';
import 'package:leekbox_infra/log/log.dart';
import 'package:package_info_plus/package_info_plus.dart';

///
class AboutPage extends ConsumerStatefulWidget {
  const AboutPage({super.key});

  static String get routeName => 'settings/About';

  static String get routeLocation => '/$routeName';

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends ConsumerState<AboutPage> {
  @override
  void initState() {
    super.initState();

    _getPackageInfo();
  }

  String _subStr = '';
  late String appName, packageName, version, buildNumber;

  ///
  Future _getPackageInfo() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _subStr = 'appName: ${packageInfo.appName}\n'
            'packageName: ${packageInfo.packageName}\n'
            'version: ${packageInfo.version}\n'
            'buildNumber: ${packageInfo.buildNumber}\n';
      });
    } catch (e) {
      Log.error("获取版本信息异常");
    }
  }

  @override
  Widget build(BuildContext context) {
    Log.debug('AboutPage build...');
    final themeData = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('关于'),
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
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 65),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45,
            backgroundImage: ImageUtils.getAssetImage('common/ic_logo'),
          ),
          Gaps.vGap24,
          Text(
            _subStr,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 8.0,
                ),
          ),
          Gaps.vGap24,
          MySetCell(
            title: '去评分',
            clickCallBack: () => {},
          ),
          MySetCell(
            title: '版权信息',
            clickCallBack: () => {},
          ),
          MySetCell(
            title: '服务协议',
            clickCallBack: () => {},
          ),
          MySetCell(
            title: '检查新版本',
            clickCallBack: () => {},
          ),
          Gaps.vGap24,
        ],
      ),
    );
  }
}
