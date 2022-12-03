import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  static String get routeName => 'splash';
  static String get routeLocation => '/$routeName';

  @override
  Widget build(BuildContext context) {
    ///预缓存背景图片
    // precacheImage(const AssetImage(R.assetsImagesLoginBackground), context);
    return const Scaffold(
      body: Center(child: Text("Splash Page")),
    );
  }
}
