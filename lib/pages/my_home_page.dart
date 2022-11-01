import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:leekbox/components/watermark/watermark_controller.dart';
import 'package:leekbox/pages/home/index.page.dart';
import 'package:leekbox/pages/invite/invite.page.dart';
import 'package:leekbox/pages/mine/mine.page.dart';
import 'package:leekbox/pages/tongji/tongji.page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// 当前的索引值
  int _currentIndex = 0;

  /// PageView 控制器 , 用于控制 PageView
  final _pageController = PageController(
    /// 初始索引值
    initialPage: 0,
  );

  final List<Widget> _pages = <Widget>[
    IndexPage(), // 首页
    InvitePage(), // 邀请页
    // NoticePage(), // 消息页
    TongjiPage(), // 统计页
    MinePage(), // 个人页
  ];

  void _onItemTapped(int index) {
    // 控制 PageView 跳转到指定的页面
    _pageController.jumpToPage(index);
    // 更新当前的索引值
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  /// 添加水印
  Future<void> addWatermark(BuildContext context) async {
    String version = '2022.10.21';
    // 防止 widget 尚未加载完成
    Future<void>.delayed(const Duration(milliseconds: 1000), () {
      WatermarkController.theOne.addWatermark(context, 'LEEKBOX V$version');
    });
  }

  @override
  void dispose() {
    super.dispose();

    /// 销毁 PageView 控制器
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    addWatermark(context);

    return Scaffold(
      /// 滑动组件 , 界面的核心元素
      body: PageView(
        ///
        physics: const NeverScrollableScrollPhysics(),

        /// 控制跳转翻页的控制器
        controller: _pageController,

        /// 页面滑动
        /// 这里设置 PageView 页面滑动也能
        onPageChanged: (index) {
          setState(() {
            // 更新当前的索引值
            _currentIndex = index;
          });
        },

        /// Widget 组件数组 , 设置多个 Widget 组件
        /// 同一时间只显示一个页面组件
        children: _pages,
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            title: const Text("首页"),
          ),

          /// Invite
          SalomonBottomBarItem(
            icon: const Icon(Icons.favorite_border),
            activeIcon: const Icon(Icons.favorite),
            title: const Text("邀请"),
            selectedColor: Colors.pink,
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
          ),

          /// Mine
          SalomonBottomBarItem(
            icon: Badge(
              toAnimate: false,
              badgeContent: const Text(''),
              child: const Icon(Icons.person_outline),
            ),
            activeIcon: const Icon(Icons.person),
            title: const Text("我的"),
          ),
        ],
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
