import 'package:app_settings/app_settings.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leekbox/common/utils/image_utils.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/common/widgets/my_app_bar.dart';

class ConnectionExceptionPage extends StatelessWidget {
  const ConnectionExceptionPage({super.key});

  static String get routeName => 'connection_exception';

  static String get routeLocation => '/$routeName';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const MyAppBar(
          title: '未能连接到互联网',
        ),
        body: Container(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: AvatarGlow(
                  glowColor: Colors.blue,
                  endRadius: 90.0,
                  child: Material(
                    // Replace this child with your own
                    elevation: 8.0,
                    shape: const CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      radius: 45.0,
                      child: Image.asset(
                        ImageUtils.getImgPath('common/no_network'),
                        // height: 290,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                '您的设备未启用移动网络或无线局域网',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Gaps.vGap12,
              const Text('如需要连接到互联网，请参考以下几点：'),
              Gaps.vGap4,
              const Text(
                '  检查手机中的无线局域网设置，查看是否有可接入的无线局域网信号。',
                maxLines: 2,
              ),
              TextButton(
                  onPressed: () =>
                      AppSettings.openAppSettings(type: AppSettingsType.wifi),
                  child: const Text('去设置')),
              Gaps.vGap4,
              const Text('  检查手机是否已接入移动网络，并且手机没有被停机。'),
              TextButton(
                  onPressed: () => AppSettings.openAppSettings(
                      type: AppSettingsType.dataRoaming),
                  child: const Text('去设置')),
              Gaps.vGap4,
              Gaps.vGap12,
              Text(
                '如果您已接入无线局域网',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Gaps.vGap4,
              const Text(
                '  请检查您所连接的无线局域网热点是否已接入互联网，或该热点是否已允许您的设备访问互联网。',
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
