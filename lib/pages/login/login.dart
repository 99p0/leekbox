import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:leekbox/common/utils/android_back_desktop.dart';
import 'package:leekbox/common/utils/image_utils.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/pages/login/widgets/bottom_wave_clipper.dart';
import 'package:leekbox/state/auth.dart';
import 'package:leekbox_infra/log/log.dart';
import 'package:oktoast/oktoast.dart';

class LoginPage extends ConsumerWidget {
  final String? from;

  const LoginPage({this.from, Key? key}) : super(key: key);

  static String get routeName => 'login';

  static String get routeLocation => '/$routeName';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Log.debug('LoginPage build...');

    /// logo 图片区域
    Widget logoImageArea = Container(
      alignment: Alignment.topCenter,
      // 设置图片为圆形
      child: ClipOval(
        child: Image.asset(
          ImageUtils.getImgPath('logo_round'),
          height: 110,
          width: 110,
          fit: BoxFit.cover,
        ),
      ),
    );

    /// 第三方登录区域
    Widget thirdLoginArea = Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 60,
                height: 1.0,
                color: Colors.grey.shade400,
              ),
              const Text('第三方登录'),
              Container(
                width: 60,
                height: 1.0,
                color: Colors.grey.shade400,
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                color: Colors.green[200],
                icon: const Icon(Icons.wallet),
                iconSize: 40.0,
                onPressed: () {
                  ref.watch(authNotifierProvider.notifier).login(
                        "myEmail",
                        "myPassword",
                      );
                  // 如果有location的话，跳转过去
                  if (from != null) context.go(from!);
                },
              ),
              IconButton(
                color: Colors.green[200],
                icon: const Icon(Icons.facebook),
                iconSize: 40.0,
                onPressed: () {
                  showToast('暂未接入');
                },
              ),
              IconButton(
                color: Colors.green[200],
                icon: const Icon(Icons.terrain),
                iconSize: 40.0,
                onPressed: () {
                  showToast('暂未接入');
                },
              )
            ],
          )
        ],
      ),
    );

    /// button widget
    Widget buildBtn(String text, Color splashColor, Color highlightColor,
        Color fillColor, Color textColor, void Function() function) {
      return ElevatedButton(
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: 18,
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        AndroidBackDesktop.backToDesktop();
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: AppBar(
            flexibleSpace: Container(
              color: Theme.of(context).primaryColor,
            ),
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Gaps.vGap100,
            logoImageArea,
            Gaps.vGap200,
            Gaps.vGap100,
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              height: 50,
              child: buildBtn(
                "支付宝授权登录",
                Theme.of(context).primaryColor,
                Colors.white,
                Colors.white,
                Theme.of(context).primaryColor,
                () async {
                  ref.watch(authNotifierProvider.notifier).login(
                        "myEmail",
                        "myPassword",
                      );
                  // 如果有location的话，跳转过去
                  if (from != null) context.go(from!);
                },
              ),
            ),

            // thirdLoginArea,
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ClipPath(
                  clipper: BottomWaveClipper(),
                  child: Container(
                    color: Colors.white,
                    height: 300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
