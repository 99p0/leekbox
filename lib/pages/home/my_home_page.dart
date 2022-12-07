import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leekbox/common/utils/android_back_desktop.dart';
import 'package:leekbox/pages/home/index.page.dart';
import 'package:leekbox/pages/invite/invite.page.dart';
import 'package:leekbox/pages/mine/mine.page.dart';
import 'package:leekbox/pages/tongji/tongji.page.dart';
import 'package:leekbox_infra/log/log.dart';
import 'package:leekbox_infra/watermark/watermark_controller.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import 'my_drawer.dart';
import 'my_enddrawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  static String get routeName => 'home';

  static String get routeLocation => '/';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _colorful = false;

  /// 当前的索引值
  int _currentIndex = 0;

  /// PageView 控制器 , 用于控制 PageView
  late PageController _pageController;

  final List<Widget> _pages = <Widget>[
    IndexPage(), // 首页
    InvitePage(), // 邀请页
    // NoticePage(), // 消息页
    const TongjiPage(), // 统计页
    const MinePage(), // 个人页
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);

    /// 销毁 PageView 控制器
    _pageController.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        //  应用程序处于闲置状态并且没有收到用户的输入事件。
        //注意这个状态，在切换到后台时候会触发，所以流程应该是先冻结窗口，然后停止UI
        Log.debug('>AppLifecycleState.inactive');
        break;
      case AppLifecycleState.paused:
//      应用程序处于不可见状态
        Log.debug('>AppLifecycleState.paused');
        break;
      case AppLifecycleState.resumed:
        //    进入应用时候不会触发该状态
        //  应用程序处于可见状态，并且可以响应用户的输入事件。它相当于 Android 中Activity的onResume。
        Log.debug('>AppLifecycleState.resumed');
        break;
      case AppLifecycleState.detached:
        //当前页面即将退出
        Log.debug('>AppLifecycleState.detached');
        break;
    }
  }

  ///当前系统改变了一些访问性活动的回调
  @override
  void didChangeAccessibilityFeatures() {
    super.didChangeAccessibilityFeatures();
    Log.debug("@@@@@@@@@ didChangeAccessibilityFeatures");
  }

  ///低内存回调
  @override
  void didHaveMemoryPressure() {
    super.didHaveMemoryPressure();
    Log.debug("@@@@@@@@@ didHaveMemoryPressure");
  }

  ///应用尺寸改变时回调，例如旋转
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    Size size = WidgetsBinding.instance.window.physicalSize;
    Log.debug("@@@@@@@@@ didChangeMetrics  ：宽：${size.width} 高：${size.height}");
  }

  @override
  Future<bool> didPopRoute() {
    Log.debug('didPopRoute'); //页面弹出
    return Future.value(false); //true为拦截，false不拦截
  }

  @override
  Future<bool> didPushRoute(String route) {
    Log.debug('PushRoute');
    return Future.value(true);
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    Log.debug('didPushRouteInformation');
    return Future.value(true);
  }

  @override
  void didChangePlatformBrightness() {
    final window = WidgetsBinding.instance.window;
    final brightness = window.platformBrightness;
    // Brightness.light 亮色
    // Brightness.dark 暗色
    Log.debug('平台主题改变-didChangePlatformBrightness$brightness');
    window.onPlatformBrightnessChanged = () {
      // This callback gets invoked every time brightness changes
      final brightness = window.platformBrightness;
      Log.debug('平台亮度改变-didChangePlatformBrightness$brightness');
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    /// 在加载后初始化
    addWatermark(context);
  }

  /// 添加水印
  Future<void> addWatermark(BuildContext context) async {
    Log.debug('addWatermark ...');
    String version = '2022.10.21';
    // 防止 widget 尚未加载完成
    Future<void>.delayed(const Duration(milliseconds: 500), () {
      WatermarkController.theOne.addWatermark(context, 'LEEKBOX V$version');
    });
  }

  @override
  Widget build(BuildContext context) {
    Log.debug('MyHomePage build');
    return WillPopScope(
        onWillPop: () async {
          if (Platform.isAndroid) {
            AndroidBackDesktop.backToDesktop(); //
          }
          return false;
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: _currentIndex == 0
              ? AppBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: const Text(""),
                  leading: GestureDetector(
                    onTap: () => _scaffoldKey.currentState?.openDrawer(),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: CircleAvatar(
                        radius: 28.0.w,
                        foregroundColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                            'https://img.zcool.cn/community/0162225743fc7132f8759a3e2592e5.jpg@1280w_1l_2o_100sh.jpg'),
                      ),
                    ),
                  ),
                  // IconButton(
                  //       icon: const Icon(Icons.tune_rounded),
                  //       onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                  //     ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Colorful?'),
                      onPressed: () {
                        setState(() {
                          _colorful = !_colorful;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.color_lens_outlined),
                      onPressed: () {
                        _scaffoldKey.currentState?.openEndDrawer();
                      },
                    ),
                  ],
                )
              : null,
          drawer: const MyDrawer(),
          endDrawer: const MyEndDrawer(),
          // 去除滑动打开
          drawerEdgeDragWidth: 0.0,
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: _pages,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          bottomNavigationBar: _colorful
              ? SlidingClippedNavBar.colorful(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  onButtonPressed: _onItemTapped,
                  iconSize: 24,
                  fontSize: 14.0,
                  // activeColor: const Color(0xFF01579B),
                  selectedIndex: _currentIndex,
                  barItems: <BarItem>[
                    BarItem(
                      icon: Icons.home_outlined,
                      title: '首页',
                      activeColor: Colors.blue,
                      inactiveColor: Colors.orange,
                    ),
                    BarItem(
                      icon: Icons.favorite_border,
                      title: '邀请',
                      activeColor: Colors.deepPurpleAccent,
                      inactiveColor: Colors.green,
                    ),
                    BarItem(
                      icon: Icons.moving,
                      title: '统计',
                      activeColor: Colors.blue,
                      inactiveColor: Colors.red,
                    ),
                    BarItem(
                      icon: Icons.person_outline,
                      title: '我',
                      activeColor: Colors.cyan,
                      inactiveColor: Colors.purple,
                    ),
                  ],
                )
              : SalomonBottomBar(
                  margin: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 10, top: 8),
                  currentIndex: _currentIndex,
                  onTap: _onItemTapped,
                  items: [
                    /// Home
                    SalomonBottomBarItem(
                      icon: const Icon(Icons.home_outlined),
                      activeIcon: const Icon(Icons.home),
                      title: const Text("首页"),
                      // selectedColor: HexColor("#06c05f"),
                      selectedColor: Color.fromRGBO(9, 187, 7, 1),
                    ),

                    /// Invite
                    SalomonBottomBarItem(
                      icon: const Icon(Icons.favorite_border),
                      activeIcon: const Icon(Icons.favorite),
                      title: const Text("邀请"),
                      // selectedColor: HexColor("#027AFF"),
                      selectedColor: Color.fromRGBO(2, 122, 255, 1),
                    ),

                    /// notice
                    // SalomonBottomBarItem(
                    //   icon: const Icon(Icons.message_outlined),
                    //   activeIcon: const Icon(Icons.message),
                    //   title: const Text("消息"),
                    // ),

                    /// Tongji
                    SalomonBottomBarItem(
                      icon: const Icon(Icons.moving),
                      activeIcon: const Icon(Icons.graphic_eq),
                      title: const Text("统计"),
                      selectedColor: Color.fromRGBO(254, 194, 44, 1),
                    ),

                    /// Mine
                    SalomonBottomBarItem(
                      icon: Badge(
                        toAnimate: false,
                        badgeContent: const Text(''),
                        child: const Icon(Icons.person_outline),
                      ),
                      activeIcon: const Icon(Icons.person),
                      title: const Text("我"),
                      selectedColor: Color.fromRGBO(255, 36, 67, 1),
                    ),
                  ],
                ),
        ));
  }

  void showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('Example Dialog'),
        actions: <TextButton>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          )
        ],
      ),
    );
  }
}
