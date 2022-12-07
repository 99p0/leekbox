import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leekbox/pages/home/my_home_page.dart';
import 'package:leekbox/pages/splash/intro/introduction_animation_screen.dart';
import 'package:leekbox/pages/splash/privacy_policy_page.dart';
import 'package:leekbox_infra/log/log.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static String get routeName => 'splash';

  static String get routeLocation => '/$routeName';

  /// step1  弹窗显示 隐私
  Future<void> _checkPrivacyPolicy() async {
    Log.debug('checkPrivacyPolicy ...');
    Future<void>.delayed(const Duration(milliseconds: 500), () {});
  }

  /// step2 引导页（app简介说明）
  Future<void> _checkIntro() async {
    Log.debug('checkPrivacyPolicy ...');
    Future<void>.delayed(const Duration(milliseconds: 500), () {});
  }

  @override
  Widget build(BuildContext context) {
    /// 预缓存背景图片
    // precacheImage(AssetImage(R.assetsImagesLoginBackground), context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              context.go(MyHomePage.routeLocation);
            },
            child: Text('首页'),
          ),
          ElevatedButton(
            onPressed: () {
              context.go(PrivacyPolicyPage.routeLocation);
            },
            child: Text('隐私'),
          ),
          SizedBox(
            height: 53,
            width: 230,
            child: ElevatedButton(
              child: Text('something'),
              onPressed: () {},
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.go(IntroScreen.routeLocation);
            },
            child: Text('引导页'),
          ),
        ],
      ),
    );
  }
}
