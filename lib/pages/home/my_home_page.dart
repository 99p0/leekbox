import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                  title: const Text(""),
                  leading: IconButton(
                    icon: const Icon(Icons.dashboard_outlined),
                    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                  ),
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
                      icon: const Icon(Icons.tune_rounded),
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
              ? SlidingClippedNavBar(
                  backgroundColor: Colors.white,
                  onButtonPressed: _onItemTapped,
                  iconSize: 29,
                  fontSize: 14.0,
                  activeColor: const Color(0xFF01579B),
                  selectedIndex: _currentIndex,
                  barItems: <BarItem>[
                    BarItem(
                      icon: Icons.home_outlined,
                      title: '首页',
                    ),
                    BarItem(
                      icon: Icons.favorite_border,
                      title: '邀请',
                    ),
                    BarItem(
                      icon: Icons.moving,
                      title: '统计',
                    ),
                    BarItem(
                      icon: Icons.person_outline,
                      title: '我',
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
