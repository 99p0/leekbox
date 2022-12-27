import 'dart:io';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leekbox/common/utils/android_back_desktop.dart';
import 'package:leekbox/pages/home/index.dart';
import 'package:leekbox/pages/invite/invite.page.dart';
import 'package:leekbox/pages/mine/mine.page.dart';
import 'package:leekbox/pages/notice/notice.page.dart';
import 'package:leekbox/pages/tongji/tongji.page.dart';
import 'package:leekbox_infra/log/log.dart';
import 'package:leekbox_infra/watermark/watermark_controller.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import 'components/drawer/my_drawer.dart';
import 'components/drawer/my_enddrawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  static String get routeName => 'home';

  static String get routeLocation => '/';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _colorful = true;

  /// 当前的索引值
  int _currentIndex = 0;

  /// PageView 控制器 , 用于控制 PageView
  late PageController _pageController;

  final List<Widget> _pages = <Widget>[
    IndexPage(), // 首页
    const InvitePage(), // 邀请页
    const NoticePage(), // 消息页
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (mounted) addWatermark(context);
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

  _buildCircleAvatar() {
    return CachedNetworkImage(
      imageUrl:
          "https://tupian.qqw21.com/article/UploadPic/2019-5/201951113193417891.jpeg",
      imageBuilder: (context, imageProvider) => Container(
        width: 38.w,
        height: 38.h,
        // margin: const EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider),
        ),
        // child: Text('TNT'),
      ),
      placeholder: (context, url) => const SizedBox(width: 38, height: 38),
      errorWidget: (context, url, error) =>
          const SizedBox(width: 38, height: 38),
    );
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
        extendBody: true,
        // Important: to remove background of bottom navigation (making the bar transparent doesn't help)
        backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        appBar: _currentIndex == 0
            ? AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                leadingWidth: 42.w,
                leading: GestureDetector(
                  onTap: () => _scaffoldKey.currentState?.openDrawer(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: _buildCircleAvatar(),
                  ),
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
        // drawerEdgeDragWidth: 0.0,// 去除滑动打开
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
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            boxShadow: const [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: _colorful
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
                        inactiveColor: Colors.blue,
                      ),
                      BarItem(
                        icon: Icons.favorite_border,
                        title: '邀请',
                        activeColor: Colors.red,
                        inactiveColor: Colors.red,
                      ),
                      BarItem(
                        icon: Icons.messenger_outline,
                        title: '消息',
                        activeColor: Colors.lightBlue,
                        inactiveColor: Colors.lightBlue,
                      ),
                      BarItem(
                        icon: Icons.moving,
                        title: '统计',
                        activeColor: Colors.green,
                        inactiveColor: Colors.green,
                      ),
                      BarItem(
                        icon: Icons.person_outline,
                        title: '我',
                        activeColor: Colors.orange,
                        inactiveColor: Colors.orange,
                      ),
                    ],
                  )
                : SalomonBottomBar(
                    margin: const EdgeInsets.only(
                        left: 12, right: 12, bottom: 8, top: 8),
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

                      /// Invite
                      SalomonBottomBarItem(
                        icon: const Icon(Icons.favorite_border),
                        activeIcon: const Icon(Icons.favorite),
                        title: const Text("邀请"),
                        // selectedColor: HexColor("#027AFF"),
                        selectedColor: const Color.fromRGBO(2, 122, 255, 1),
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
                        icon: Badge(
                          toAnimate: false,
                          badgeContent: const Text(''),
                          child: const Icon(Icons.person_outline),
                        ),
                        activeIcon: const Icon(Icons.person),
                        title: const Text("我"),
                        selectedColor: const Color.fromRGBO(255, 36, 67, 1),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
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
