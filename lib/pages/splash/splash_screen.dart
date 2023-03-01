import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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

  Timer? _timer;
  int count = 3;

  startTime() async {
    //设置启动图生效时间
    var oneSec = const Duration(seconds: 1);
    //
    callback(v) {
      Log.debug('count:: $count');
      count--;
      if (count == 1) {
        goHome();
      } else {
        if (mounted) setState(() {});
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
    if (mounted) context.go(LoginPage.routeLocation);
  }

  @override
  void initState() {
    super.initState();
    Log.debug('SplashPage initState...');
    initialization();
  }

  void initialization() async {
    debugPrint('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    debugPrint('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    debugPrint('ready in 1...');
    initLauncher();
  }

  ///
  final String launcher_def = 'assets/images/ic_launcher.png';
  String launcher_birthday = 'assets/images/happy_birthday.png';
  String launcher_special = 'assets/images/launcher_lc.png';

  // 默认
  late String launcher = launcher_def;

  /// 更换背景图
  void initLauncher() async {
    // 网络下载 新的图片， 没有的话使用默认的
    String launcher_birthday_net = '';
    // 节日性图片
    String ic_launcher_net = '';
    // 今天是否生日
    if (false) {
      setState(() {
        launcher = launcher_birthday;
      });

      startTime();
      FlutterNativeSplash.remove();
      Log.debug('FlutterNativeSplash.remove...');
    } else {
      // 今天是否特殊日期
      if (Random().nextBool()) {
        setState(() {
          launcher = launcher_special;
        });
        startTime();
        FlutterNativeSplash.remove();
        Log.debug('FlutterNativeSplash.remove...');
      } else {
        FlutterNativeSplash.remove();
        Log.debug('FlutterNativeSplash.remove...goHome');
        goHome();
      }
    }
  }

  void _precache() {
    /// 预缓存背景图片
    precacheImage(AssetImage(launcher_special), context);
    precacheImage(AssetImage(launcher_birthday), context);
  }

  @override
  Widget build(BuildContext context) {
    Log.debug('SplashPage build...');
    _precache();

    ///
    return Stack(
      alignment: const Alignment(1.0, -1.0), // 右上角对齐
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Image.asset(
            launcher,
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 30.0, 25.0, 0.0),
          child: GestureDetector(
            onTap: () async => goHome(),
            child: Text(
              "${count}s 跳过",
              style: const TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(0.0, 30.0, 90.0, 0.0),
          child: Text(
            "已预加载",
            style: TextStyle(color: Colors.white, fontSize: 12.0),
          ),
        ),
      ],
    );
  }
}
