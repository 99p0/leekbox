import 'dart:io';

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leekbox/common/utils/android_back_desktop.dart';
import 'package:leekbox/pages/home/index.dart';
import 'package:leekbox/pages/mine/mine.page.dart';
import 'package:leekbox/pages/notice/notice.page.dart';
import 'package:leekbox/pages/tongji/tongji.page.dart';
import 'package:leekbox_infra/log/log.dart';
import 'package:leekbox_infra/watermark/watermark_controller.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  static String get routeName => 'home';

  static String get routeLocation => '/$routeName';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage>
    with AutomaticKeepAliveClientMixin {
  // WidgetsBindingObserver
  final bool _colorful = true;

  /// 当前的索引值
  int _currentIndex = 0;

  /// PageView 控制器 , 用于控制 PageView
  late PageController _pageController;

  final List<Widget> _pages = <Widget>[
    const IndexPage(), // 首页
    const NoticePage(), // 消息页
    const TongjiPage(), // 统计页
    const MinePage(), // 个人页
  ];

  Future<void> _onItemTapped(int index) async {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
    // _pageController.animateToPage(
    //   index,
    //   duration: const Duration(milliseconds: 400),
    //   curve: Curves.easeIn,
    // );
  }

  @override
  void initState() {
    super.initState();
    Log.debug('MyHomePage initState...');
    //
    // WidgetsBinding.instance?.addObserver(this);
    _pageController = PageController(initialPage: 0);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    // WidgetsBinding.instance?.removeObserver(this);

    /// 销毁 PageView 控制器
    _pageController.dispose();
    Log.debug('MyHomePage dispose...');
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   switch (state) {
  //     case AppLifecycleState.inactive:
  //       // 应用程序处于闲置状态并且没有收到用户的输入事件。
  //       // 注意这个状态，在切换到后台时候会触发，所以流程应该是先冻结窗口，然后停止UI
  //       Log.debug('>AppLifecycleState.inactive');
  //       break;
  //     case AppLifecycleState.paused:
  //       // 应用程序处于不可见状态
  //       Log.debug('>AppLifecycleState.paused');
  //       break;
  //     case AppLifecycleState.resumed:
  //       // 进入应用时候不会触发该状态
  //       // 应用程序处于可见状态，并且可以响应用户的输入事件。它相当于 Android 中Activity的onResume。
  //       Log.debug('>AppLifecycleState.resumed');
  //       break;
  //     case AppLifecycleState.detached:
  //       //当前页面即将退出
  //       Log.debug('>AppLifecycleState.detached');
  //       break;
  //   }
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //  添加水印
    if (mounted) addWatermark(context);
  }

  /// 水印
  Future<void> addWatermark(BuildContext context) async {
    Log.debug('添加水印 ...');
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    // 防止 widget 尚未加载完成
    Future<void>.delayed(const Duration(milliseconds: 500), () {
      WatermarkController.theOne.addWatermark(context, 'LEEKBOX V$version');
    });
  }

  Widget _buildBottomNavigationBar(themeData) {
    var borderRadius = const BorderRadius.only(
      topRight: Radius.circular(30),
      topLeft: Radius.circular(30),
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 8.0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: _buildItemsStyle1(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('MyHomePage build...');
    final themeData = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        if (Platform.isAndroid) {
          AndroidBackDesktop.backToDesktop(); //
        }
        return false;
      },
      child: Scaffold(
        // Important: to remove background of bottom navigation (making the bar transparent doesn't help)
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: PageView(
          // 禁止页面左右滑动切换
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: _pages,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),

        bottomNavigationBar: _buildBottomNavigationBar(themeData),
      ),
    );
  }

  Widget _buildItemsStyle1() => SlidingClippedNavBar.colorful(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        onButtonPressed: _onItemTapped,
        iconSize: 25,
        fontSize: 14.0,
        selectedIndex: _currentIndex,
        barItems: <BarItem>[
          BarItem(
            icon: PhosphorIcons.calendarCheck,
            title: '首页',
            activeColor: Colors.blue,
            inactiveColor: Colors.orange,
          ),
          BarItem(
            icon: PhosphorIcons.chatCircleDots,
            title: '消息',
            activeColor: Colors.pink,
            inactiveColor: Colors.green,
          ),
          BarItem(
            icon: PhosphorIcons.activity,
            title: '统计',
            activeColor: Colors.blue,
            inactiveColor: Colors.red,
          ),
          BarItem(
            icon: PhosphorIcons.user,
            title: '我',
            activeColor: Colors.cyan,
            inactiveColor: Colors.purple,
          ),
        ],
      );

  Widget _buildItemsStyle2() => SalomonBottomBar(
        margin: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 8),
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            title: const Text("首页"),
            // selectedColor: HexColor("#06c05f"),
            selectedColor: const Color.fromRGBO(9, 187, 7, 1),
          ),

          /// notice
          SalomonBottomBarItem(
            icon: const Icon(Icons.messenger_outline),
            activeIcon: const Icon(Icons.messenger),
            title: const Text("消息"),
            selectedColor: const Color.fromRGBO(2, 122, 255, 1),
          ),

          /// Tongji
          SalomonBottomBarItem(
            icon: const Icon(Icons.moving),
            activeIcon: const Icon(Icons.graphic_eq),
            title: const Text("统计"),
            selectedColor: const Color.fromRGBO(254, 194, 44, 1),
          ),

          /// Mine
          SalomonBottomBarItem(
            icon: const badges.Badge(
              badgeContent: Text(''),
              child: Icon(Icons.person_outline),
            ),
            activeIcon: const Icon(Icons.person),
            title: const Text("我"),
            selectedColor: const Color.fromRGBO(255, 36, 67, 1),
          ),
        ],
      );
}
