import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leekbox/pages/login/login.dart';
import 'package:leekbox_infra/log/log.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static String get routeName => 'splash';

  static String get routeLocation => '/$routeName';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  /// step1  弹窗显示 隐私

  /// step2 引导页（app简介说明）

  late Timer _timer;
  int count = 3;

  startTime() async {
    //设置启动图生效时间
    var oneSec = const Duration(seconds: 1);
    //
    callback(v) {
      Log.debug('count:: $count');
      count--;
      if (count == 0) {
        goHome();
      } else {
        setState(() {});
      }
    }

    //
    Timer(oneSec, () {
      // 空等1秒之后再计时
      _timer = Timer.periodic(oneSec, callback);
    });
  }

  void goHome() {
    _timer?.cancel();
    context.go(LoginPage.routeLocation);
  }

  @override
  void initState() {
    super.initState();

    /// 在加载后初始化
    startTime();
  }

  final _bg = 'assets/images/happy_birthday.png';

  @override
  Widget build(BuildContext context) {
    /// 预缓存背景图片
    precacheImage(AssetImage(_bg), context);
    return Stack(
      alignment: const Alignment(1.0, -1.0), // 右上角对齐
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Image.asset(
            _bg,
            fit: BoxFit.contain,
          ),
        ),
        // ElevatedButton(
        //   onPressed: () {
        //     context.go(MyHomePage.routeLocation);
        //   },
        //   child: Text('首页'),
        // ),
        // ElevatedButton(
        //   onPressed: () {
        //     context.go(PrivacyPolicyPage.routeLocation);
        //   },
        //   child: Text('隐私'),
        // ),
        // ElevatedButton(
        //   onPressed: () {
        //     context.go(IntroScreen.routeLocation);
        //   },
        //   child: Text('引导页'),
        // ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 30.0, 10.0, 0.0),
          child: ElevatedButton(
            onPressed: () {
              goHome();
            },
            child: Text(
              "$count 跳过",
              style: const TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          ),
        )
      ],
    );
  }
}
