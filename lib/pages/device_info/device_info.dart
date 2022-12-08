import 'package:custom_tabbar/custom_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leekbox_infra/log/log.dart';

class DeviceInfoPage extends StatefulWidget {
  static String get routeName => 'device_info';

  static String get routeLocation => '/$routeName';

  @override
  _DeviceInfoPageState createState() => _DeviceInfoPageState();
}

class _DeviceInfoPageState extends State<DeviceInfoPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      //点击tab回调一次，滑动切换tab不会回调
      if (_tabController.indexIsChanging) {
        Log.debug("ysl--${_tabController.index}");
      }

      //点击tab时或滑动tab回调一次
      // if (_tabController.index.toDouble() == _tabController.animation.value) {
      //   Log.debug("ysl${_tabController.index}");
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    Log.debug('DeviceInfoPage build');

    return Scaffold(
      appBar: AppBar(
        title: const Text('设备信息'),
        backgroundColor: Color.fromRGBO(2, 122, 255, 1),
        leading: TextButton(
          onPressed: () {
            context.go('/');
          },
          child: Icon(Icons.arrow_back_ios_outlined),
        ),
        bottom: KuGouTabBar(
          tabs: const [
            Tab(text: "DASHBOARD"),
            Tab(text: "设备信息"),
            Tab(text: "WLAN信息"),
            Tab(text: "移动信息"),
          ],
          // labelPadding: EdgeInsets.symmetric(horizontal: 8),
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.label,
          isScrollable: true,
          padding: EdgeInsets.zero,
          indicator: const RRecTabIndicator(
              radius: 4, insets: EdgeInsets.only(bottom: 5)),
          indicatorMinWidth: 6,
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: const [
          Center(
            child: Text("音乐"),
          ),
          Center(
            child: Text("动态"),
          ),
          Center(
            child: Text("语文"),
          ),
          Center(
            child: Text("音乐"),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  buildPageView(String content) {
    return Center(
      child: Text(
        content,
        style: const TextStyle(color: Colors.blue, fontSize: 24),
      ),
    );
  }
}
