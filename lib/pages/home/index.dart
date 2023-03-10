import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
import 'package:nil/nil.dart';
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
    Log.debug('IndexPage initState...');

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
    bool hasConnection = await InternetConnectionChecker().hasConnection;
    Log.debug('hasConnection:: $hasConnection');
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
    _connectivitySubscription.cancel();
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
      title: '??????????????????',
      onTap: () {
        showToastWidget(
          context: context,
          CorrectToast(
            child: Text(
              '??????????????????',
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
          return const Nil();
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
                            '????????????',
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
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        itemCount: litemsTop2.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    litemsTop2[index],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(fontSize: 12.0),
                                  ),
                                ),
                                Text(
                                  '????????????',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontSize: 10.0),
                                ),
                              ],
                            ),
                          );
                        }),
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
    "Disruptor???LMAX??????????????????????????????",
    "?????????????????????????????????????????????????????????",
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
          /// appbar
          _buildSliverAppBar(),

          /// ?????????
          SliverToBoxAdapter(
            child: _buildGreetings(context),
          ),

          /// ??????????????????
          SliverToBoxAdapter(
            child: _buildRecentYieldCurve(context),
          ),

          /// ????????????
          SliverToBoxAdapter(
            child: _buildRecentNews(context),
          ),

          /// ?????????????????????????????????
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
          SliverToBoxAdapter(
            child: getBody(context),
          ),

          /// ??????
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                alignment: Alignment.center,
                child: Text(
                  '-------- ?????????????????? --------',
                  style: themeData.textTheme.labelSmall
                      ?.copyWith(color: Colors.black26),
                ),
              ),
              childCount: 1,
            ),
            itemExtent: 50.0,
          ),

          /// ??????
          const SliverPadding(
            padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // leading: Builder(builder: (context) {
      //   return PreferredSize(
      //     preferredSize: const Size(double.infinity, 120),
      //     child: _buildGreetings(context),
      //   );
      // }),
      // leadingWidth: double.infinity,
      title: Text(
        '????????????',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 14.sp,
            ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      floating: true,
      // pinned: true,
      snap: true,
      // forceElevated: true,
      // stretch: true,
      // expandedHeight: 200.0,
      actions: [],
      // bottom: PreferredSize(
      //   preferredSize: const Size(double.infinity, 80),
      //   child: _buildGreetings(context),
      // ),
    );
  }

  Widget getBody(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Gaps.hGap10,
        ElevatedButton(
          onPressed: () {
            GoRouter.of(context).push(PrivacyPolicyPage.routeLocation);
          },
          child: const Text('?????????'),
        ),
        ElevatedButton(
          onPressed: () {
            GoRouter.of(context).push(SplashPage.routeLocation);
          },
          child: const Text('?????????'),
        ),
        ElevatedButton(
          onPressed: () {
            GoRouter.of(context).push(IntroScreen.routeLocation);
          },
          child: const Text('?????????'),
        ),
        Gaps.hGap10,
        ElevatedButton(
          onPressed: () {
            GoRouter.of(context).push(DeviceInfoPage.routeLocation);
          },
          child: const Text('?????????'),
        ),
        ElevatedButton(
          onPressed: () {
            GoRouter.of(context).push(LoginPage.routeLocation);
          },
          child: const Text('?????????'),
        ),
        ElevatedButton(
          onPressed: () {
            showToast('$_connectionStatus');
          },
          child: Text('$_connectionStatus'),
        ),
      ],
    );
  }
}
