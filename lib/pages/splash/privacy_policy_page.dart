import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/common/widgets/webview_page.dart';
import 'package:leekbox/pages/home/my_home_page.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  static String get routeName => 'privacy_policy';

  static String get routeLocation => '/$routeName';

  final msg = '''
亲爱的用户：

感谢您使用本产品！我们非常注重您的个人信息和隐私安全。为了更好的保障您的个人权益，请您充分阅读并理解《用户协议》和《隐私政策》的全部内容，同意并接受全部条款后开始使用我们的产品和服务。

1、为了更好的为您提供服务，我们将获取您的部分权限信息；

2、您可以访问、更正修改您的个人信息，我们也提供注销方式，未经您同意，不会从第三方获取、共享您的个人信息，感谢您的支持和信任;

3、我们将获取您的网络访问权限（读取通话状态和移动网络信息）、数据读写权限（方便您更好的编辑消息）、定位访问权限（读取您的所在位置，为您推荐好友）、拍摄照片和录制视频权限，为您提供更好的服务。
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            child: Text('$msg'),
          ),
          Gaps.vGap8,
          Card(
            child: Row(
              children: [
                const Text('阅读完整版本'),
                TextButton(
                    onPressed: () {
                      _handleURLButtonPress(
                        context,
                        "https://rule.tencent.com/rule/preview/46a15f24-e42c-4cb6-a308-2347139b1201",
                        "用户协议",
                      );
                    },
                    child: const Text('《用户协议》')),
                const Text('和'),
                TextButton(
                    onPressed: () {
                      _handleURLButtonPress(
                        context,
                        "https://www.huawei.com/cn/privacy-policy",
                        "隐私政策",
                      );
                    },
                    child: const Text('《隐私政策》')),
              ],
            ),
          ),
          Gaps.vGap12,
          ElevatedButton(
              onPressed: () {
                context.go(MyHomePage.routeLocation);
              },
              child: const Text('同意')),
          Gaps.vGap8,
          TextButton(
              onPressed: () {
                exit(0);
              },
              child: const Text('不同意并退出')),
        ],
      ),
    );
  }
}

void _handleURLButtonPress(BuildContext context, String url, String title) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => WebViewPage(url, title)));
}
