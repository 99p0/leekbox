import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/pages/demo/app_toast.dart';
import 'package:leekbox/pages/developer/device_info.dart';
import 'package:leekbox/pages/home/components/one_day_normal_view.dart';
import 'package:leekbox/pages/home/components/statistics_item.dart';
import 'package:leekbox/pages/home/components/statistics_line_chart.dart';
import 'package:leekbox/pages/login/login.dart';
import 'package:leekbox/pages/splash/intro/introduction_animation_screen.dart';
import 'package:leekbox/pages/splash/privacy_policy_page.dart';
import 'package:leekbox/pages/splash/splash_screen.dart';
import 'package:leekbox_infra/log/log.dart';
import 'package:oktoast/oktoast.dart';

///
class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  late AnimationController animationController;
  bool multiple = true;

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    animationController?.forward(); //

    super.initState();

    ///
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      Log.error('Couldn\'t check connectivity status::$e');
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  Future<bool> getRecentNewsData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void dispose() {
    ///
    _connectivitySubscription.cancel();

    ///
    animationController?.dispose();

    super.dispose();
  }

  ///
  Widget _buildGreetings(BuildContext context) {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          animationController?.forward();
          return TimeAndWordView(
            animation:
                Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                    .animate(
              CurvedAnimation(
                parent: animationController,
                curve: const Interval(0.1, 1, curve: Curves.fastOutSlowIn),
              ),
            ),
            animationController: animationController,
          );
        }
      },
    );
  }

  ///
  Widget _buildRecentYieldCurve(BuildContext context) {
    return StatisticsItem(
      content: const StatisticsLineChart(
        textColor: Color(0xFFD4E2FA),
        lineColor: Color(0xFFAFCAFA),
        datas: [0.6, 0.9, 0.3, 0.8, 0.3, 0.6, 0.8],
        animationStyle: StatisticsLineAnimationStyle.horizontal,
      ),
      title: '近期收益曲线',
      onTap: () {
        showToastWidget(
          context: context,
          CorrectToast(
            child: Text(
              '近期收益曲线',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        );
      },
    );
  }

  ///
  Widget _buildRecentNews(BuildContext context) {
    return FutureBuilder<bool>(
      future: getRecentNewsData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return GestureDetector(
            onTap: () {
              // context.go(RecentNoticePage.routeLocation);
            },
            child: Container(
              margin: const EdgeInsets.only(left: 8, right: 8),
              height: 90,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 8, right: 16),
                    height: 30,
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            '最近消息',
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                        ),
                        SizedBox(
                          width: 14,
                          height: 14,
                          child: Image.asset(
                            'assets/images/icon_selected.png',
                            // height: 16,
                            // width: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 26,
                        top: 2,
                      ),
                      child: ListView.builder(
                          itemCount: litemsTop2.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Gaps.hGap5,
                                  Expanded(
                                    child: Text(
                                      litemsTop2[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(fontSize: 12.0),
                                    ),
                                  ),
                                  Text(
                                    '三小时前',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(fontSize: 10.0),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  List<String> litemsTop2 = [
    "Disruptor是LMAX开发的一个高性能队列",
    "回来后咱看看这几套吧，如果还没有卖的话",
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('IndexPage build...');
    final themeData = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // appbar
          _buildSliverAppBar(),

          /// 间距
          // const SliverPadding(
          //   padding: EdgeInsets.only(top: 5),
          // ),
          /// 问候语
          SliverToBoxAdapter(
            child: _buildGreetings(context),
          ),

          /// 近期收益曲线
          SliverToBoxAdapter(
            child: _buildRecentYieldCurve(context),
          ),

          /// 最近消息
          SliverToBoxAdapter(
            child: _buildRecentNews(context),
          ),

          /// 推荐组合，瀑布流的形式
          SliverToBoxAdapter(
            child: getBody(context),
          ),
          SliverToBoxAdapter(
            child: getBody(context),
          ),
          SliverToBoxAdapter(
            child: getBody(context),
          ),
          SliverToBoxAdapter(
            child: getBody(context),
          ),
          SliverToBoxAdapter(
            child: getBody(context),
          ),

          /// 底线
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Text(
                        '-------- 我是有底线的 --------',
                        style: themeData.textTheme.bodySmall
                            ?.copyWith(color: Colors.black26),
                      ),
                    ),
                childCount: 1),
            itemExtent: 60.0,
          ),

          /// 间距
          const SliverPadding(
            padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return const SliverAppBar(
      automaticallyImplyLeading: true,
      //标题是否居中
      centerTitle: false,
      //标题间距
      title: Text("因律社群"),
      // expandedHeight: 190,
      floating: false,
      pinned: true,
      snap: false,
      // forceElevated: true,
    );
  }

  Widget getBody(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Gaps.hGap10,
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push(PrivacyPolicyPage.routeLocation);
              },
              child: const Text('隐私页'),
            ),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push(SplashPage.routeLocation);
              },
              child: const Text('启动页'),
            ),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push(IntroScreen.routeLocation);
              },
              child: const Text('引导页'),
            ),
          ],
        ),
        Row(
          children: [
            Gaps.hGap10,
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push(DeviceInfoPage.routeLocation);
              },
              child: const Text('设备页'),
            ),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push(LoginPage.routeLocation);
              },
              child: const Text('登录页'),
            ),
          ],
        ),
      ],
    );
  }
}
