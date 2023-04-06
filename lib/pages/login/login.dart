import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:go_router/go_router.dart';
import 'package:leekbox/common/utils/hex_color.dart';
import 'package:leekbox/common/utils/utils.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/common/widgets/my_button.2.dart';
import 'package:leekbox/state/auth.dart';
import 'package:leekbox_infra/log/log.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:rive/rive.dart';
import 'package:video_player/video_player.dart';

class LoginPage extends ConsumerStatefulWidget {
  final String? from;

  const LoginPage({this.from, Key? key}) : super(key: key);

  static String get routeName => 'login';

  static String get routeLocation => '/$routeName';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  // 声明视频控制器
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    // 初始化视频
    _videoPlayerController =
        VideoPlayerController.asset('assets/videos/login_bg.mp4')
          ..initialize().then((_) {
            setState(() {});
            _videoPlayerController.play();
            _videoPlayerController.setLooping(true);
          });

    //
    // initFluwx();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Widget buildBg() => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // color: Colors.red,
          image: DecorationImage(
            image: ImageUtils.getAssetImage('login/bg_1'),
            fit: BoxFit.fitWidth,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Transform.scale(
          //   scale: _videoPlayerController.value.aspectRatio /
          //       MediaQuery.of(context).size.aspectRatio *
          //       1.1,
          //   // scale: _videoPlayerController.value.aspectRatio,
          //   child: _videoPlayerController.value.isInitialized
          //       ? AspectRatio(
          //           aspectRatio: _videoPlayerController.value.aspectRatio,
          //           child: VideoPlayer(_videoPlayerController),
          //         )
          //       : Container(
          //           decoration: BoxDecoration(
          //             image: DecorationImage(
          //               image: ImageUtils.getAssetImage('login/bg_1'),
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //         ),
          // ),
          Positioned(
            width: MediaQuery.of(context).size.width * 1.4,
            left: 100,
            bottom: 100,
            child: Image.asset(
              ImageUtils.getImgPath('common/spline'),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: const SizedBox(),
            ),
          ),
          const RiveAnimation.asset(
            "assets/rives/shapes.riv",
            fit: BoxFit.fitWidth,
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
          // 头部欢迎语
          Positioned(
            width: MediaQuery.of(context).size.width,
            top: 80.0.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text(
                  '欢迎萌新驾到',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
          // 登录按钮
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 16.0.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 280.w,
                  child: MyButton2(
                    text: '手机号登录',
                    onPressed: _mobileAuth,
                  ),
                ),
                Gaps.vGap10,
                const Center(
                  child: Text(
                    'OR',
                    style: TextStyle(color: Colors.black12, fontSize: 13.0),
                  ),
                ),
                Gaps.vGap10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    thirdLoginIcon(
                      PhosphorIcons.regular.twitterLogo,
                      HexColor('#1AAD19'),
                      _weChatAuth,
                    ),
                    Gaps.hGap32,
                    thirdLoginIcon(
                      PhosphorIcons.regular.appleLogo,
                      HexColor('#027AFF'),
                      _alipayAuth,
                    ),
                    Gaps.hGap10,
                  ],
                ),
                const SizedBox(height: 60.0),
                const Text(
                  "我已阅读并同意《服务协议》及《隐私政策》",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // floatingActionButton: _videoPlayerController.value.isInitialized
      //     ? FloatingActionButton(
      //         onPressed: () {
      //           setState(() {
      //             _videoPlayerController.value.isPlaying
      //                 ? _videoPlayerController.pause()
      //                 : _videoPlayerController.play();
      //           });
      //         },
      //         child: Icon(
      //           _videoPlayerController.value.isPlaying
      //               ? Icons.pause
      //               : Icons.play_arrow,
      //         ),
      //       )
      //     : nil,
    );
  }

  ///
  Widget thirdLoginIcon(
      IconData? icon, Color? color, GestureTapCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Material(
        //背景色
        color: Colors.black12,
        shape: const CircleBorder(
          side: BorderSide(
            color: Colors.transparent,
            width: 0.0,
          ),
        ),
        child: Container(
          // color: Colors.teal,
          padding: const EdgeInsets.all(10.0),
          child: Icon(
            icon,
            color: color,
            size: 32.0,
          ),
        ),
      ),
    );
  }

  Future<void> initFluwx() async {
    Log.debug('init Fluwx...');
    await fluwx.registerWxApi(
      appId: 'wx461d03aca7072c02', //查看微信开放平台
      universalLink: 'https://your.univerallink.com/link/', //查看微信开放平台
    );
  }

  Future<void> _mobileAuth() async {
    showToast('手机号登录');
    // 一键登录， 手机号 +
  }

  Future<void> _weChatAuth() async {
    showToast('请安装 微信 后使用该功能');
  }

  Future<void> _alipayAuth() async {
    showToast('支付宝登录');
    ref.watch(authNotifierProvider.notifier).login(
          "myEmail",
          "myPassword",
        );
    // 如果有location的话，跳转过去
    if (widget.from != null) context.go(widget.from!);
  }
}
