import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leekbox/pages/demo/drawer/drawer_user_controller.dart';
import 'package:leekbox/pages/demo/drawer/home_drawer.dart';
import 'package:leekbox/pages/setting/setting.page.dart';
import 'package:leekbox_infra/log/log.dart';

import '../../activity/activities.page.dart';
import '../../home/my_home_page.dart';
import '../../notice/notice.page.dart';

class GoHomeScreen extends StatefulWidget {
  const GoHomeScreen({super.key});
  //
  // static String get routeName => 'home';
  //
  // static String get routeLocation => '/';

  @override
  _GoHomeScreenState createState() => _GoHomeScreenState();
}

class _GoHomeScreenState extends State<GoHomeScreen>
    with WidgetsBindingObserver {
  /// 监听应用从后台切换到前台时，读取粘贴板中的数据，验证URL，已保存分享
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    Log.debug("didChangeAppLifecycleState: $state");

    if (state == AppLifecycleState.resumed) {
      var clipboardData = Clipboard.getData(Clipboard.kTextPlain);
      clipboardData.then((value) {
        Log.debug("clipboardData=> ${value?.text}");
        if (value != null &&
            value.text != null &&
            value.text!.isNotEmpty &&
            (value.text!.startsWith("https://") ||
                value.text!.startsWith("http://"))) {
          // showToast("clipboardData:: ${value.text!}");
        }
      });
    }
  }

  ///当前系统改变了一些访问性活动的回调
  @override
  void didChangeAccessibilityFeatures() {
    super.didChangeAccessibilityFeatures();
    Log.debug("didChangeAccessibilityFeatures");
  }

  /// Called when the system is running low on memory.
  ///低内存回调
  @override
  void didHaveMemoryPressure() {
    super.didHaveMemoryPressure();
    Log.debug("didHaveMemoryPressure");
  }

  /// Called when the application's dimensions change. For example,
  /// when a phone is rotated.
  ///应用尺寸改变时回调，例如旋转
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    Size size = WidgetsBinding.instance.window.physicalSize;
    Log.debug("didChangeMetrics  ：宽：${size.width} 高：${size.height}");
  }

  /// {@macro on_platform_brightness_change}
  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    Log.debug("didChangePlatformBrightness");
  }

  ///文字系数变化
  @override
  void didChangeTextScaleFactor() {
    super.didChangeTextScaleFactor();
    Log.debug(
        "didChangeTextScaleFactor  ：${WidgetsBinding.instance.window.textScaleFactor}");
  }

  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const MyHomePage();
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    Log.debug('GoHomePage build');

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: DrawerUserController(
          screenIndex: drawerIndex,
          drawerWidth: MediaQuery.of(context).size.width * 0.85,
          onDrawerCall: (DrawerIndex drawerIndexdata) {
            changeIndex(drawerIndexdata);
            //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
          },
          screenView: screenView,
          //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = const MyHomePage();
        });
      } else if (drawerIndex == DrawerIndex.Help) {
        setState(() {
          screenView = ActivityListPage();
        });
      } else if (drawerIndex == DrawerIndex.FeedBack) {
        setState(() {
          screenView = NoticePage();
        });
      } else if (drawerIndex == DrawerIndex.Invite) {
        setState(() {
          screenView = SettingPage();
        });
      } else {
        //do in your way......
      }
    }
  }
}
