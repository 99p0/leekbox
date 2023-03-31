import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:leekbox/common/models/list_task_date.dart';
import 'package:leekbox/common/utils/utils.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/pages/activity/activities.page.dart';
import 'package:leekbox/pages/activity/activity_detail.page.dart';
import 'package:leekbox/pages/demo/icon_flip_nav_bar/demo.dart';
import 'package:leekbox/pages/demo/txt_nav_bar/bottom_9_page.dart';
import 'package:leekbox/pages/demo/wakelock_demo.dart';
import 'package:leekbox/pages/developer/dashboard.dart';
import 'package:leekbox/pages/developer/device_info.dart';
import 'package:leekbox/pages/home/components/one_day_normal_view.dart';
import 'package:leekbox/pages/home/components/statistics_item.dart';
import 'package:leekbox/pages/home/components/statistics_line_chart.dart';
import 'package:leekbox/pages/login/login.dart';
import 'package:leekbox/pages/splash/intro/introduction_animation_screen.dart';
import 'package:leekbox/pages/splash/privacy_policy_page.dart';
import 'package:leekbox/pages/splash/splash_screen.dart';
import 'package:leekbox_infra/log/log.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

import 'components/checkin_record.dart';

///
class IndexPage extends ConsumerStatefulWidget {
  const IndexPage({super.key});

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends ConsumerState<IndexPage>
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
      title: '近期收益曲线',
      onTap: () {
        showToast('近期收益曲线');
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
          /// appbar
          _buildSliverAppBar(),

          /// 问候语
          SliverToBoxAdapter(
            child: _buildGreetings(context),
          ),

          /// 近期收益曲线
          SliverToBoxAdapter(
            child: _buildRecentYieldCurve(context),
          ),

          /// 推荐组合，瀑布流的形式
          // const SliverToBoxAdapter(
          //   child: CheckinRecord(),
          // ),

          /// 打卡消息
          const SliverToBoxAdapter(
            child: CheckinRecord(),
          ),

          ///
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                child: Container(
                  foregroundDecoration: RotatedCornerDecoration.withColor(
                    badgeCornerRadius: const Radius.circular(8),
                    color: Colors.blue,
                    badgeSize: Size(38.w, 38.w),
                    spanBaselineShift: 2,
                    // isEmoji: true,
                    textSpan: const TextSpan(
                      children: [
                        TextSpan(
                          text: '👑\n',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                        TextSpan(
                          text: 'VIP专属',
                          style: TextStyle(
                            fontSize: 5,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 3.5,
                            color: Colors.yellow,
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: RotatedCornerDecoration.withColor(
                    badgePosition: BadgePosition.topStart,
                    badgeCornerRadius: const Radius.circular(8),
                    color: Colors.red,
                    badgeSize: Size(32.w, 32.w),
                    textSpan: const TextSpan(
                      text: 'OMG',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          BoxShadow(color: Colors.yellowAccent, blurRadius: 8),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              childCount: 21,
            ),
            itemExtent: 120.0.h,
          ),

          /// 底线
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                alignment: Alignment.center,
                child: Text(
                  '-------- 我是有底线的 --------',
                  style: themeData.textTheme.labelSmall
                      ?.copyWith(color: Colors.black26),
                ),
              ),
              childCount: 1,
            ),
            itemExtent: 50.0,
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
        '因律社群',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 14,
            ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      floating: false,
      pinned: true,
      snap: false,
      // forceElevated: true,
      // stretch: true,
      // expandedHeight: 200.0,
      actions: const [],
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
        Row(
          children: [
            Text('网络状态::$_connectionStatus'),
          ],
        ),
        Gaps.vGap24,
        Row(
          children: [
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
        Gaps.vGap24,
        Row(
          children: [
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
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push(DashboardPage.routeLocation);
              },
              child: const Text('仪表盘'),
            ),
          ],
        ),
        Gaps.vGap24,
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push(ActivityListPage.routeLocation);
              },
              child: const Text('活动列表'),
            ),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push(ActivityDetailPage.routeLocation);
              },
              child: const Text('活动详情'),
            ),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push(DashboardPage.routeLocation);
              },
              child: const Text('仪表盘'),
            ),
          ],
        ),
        Gaps.vGap24,
        Text('Demo如下：', style: Theme.of(context).textTheme.titleMedium),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WakelockExampleApp()),
                );
              },
              child: const Text('Wakelock'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BubbleTabBarDemo()),
                );
              },
              child: const Text('icon_flip_nav_bar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Bottom9Page()),
                );
              },
              child: const Text('txt_nav_bar'),
            ),
          ],
        ),
      ],
    );
  }
}

final taskGroup = [
  [
    ListTaskDateData(
      date: DateTime.now().add(const Duration(days: 2, hours: 10)),
      label: "5 posts on  instagram",
      jobdesk: "Marketing",
    ),
    ListTaskDateData(
      date: DateTime.now().add(const Duration(days: 2, hours: 11)),
      label: "Platform Concept",
      jobdesk: "Animation",
    ),
  ],
  [
    ListTaskDateData(
      date: DateTime.now().add(const Duration(days: 4, hours: 5)),
      label: "UI UX Marketplace",
      jobdesk: "Design",
    ),
    ListTaskDateData(
      date: DateTime.now().add(const Duration(days: 4, hours: 6)),
      label: "Create Post For App",
      jobdesk: "Marketing",
    ),
  ],
  [
    ListTaskDateData(
      date: DateTime.now().add(const Duration(days: 6, hours: 5)),
      label: "2 Posts on Facebook",
      jobdesk: "Marketing",
    ),
    ListTaskDateData(
      date: DateTime.now().add(const Duration(days: 6, hours: 6)),
      label: "Create Icon App",
      jobdesk: "Design",
    ),
    ListTaskDateData(
      date: DateTime.now().add(const Duration(days: 6, hours: 8)),
      label: "Fixing Error Payment",
      jobdesk: "Programmer",
    ),
    ListTaskDateData(
      date: DateTime.now().add(const Duration(days: 6, hours: 10)),
      label: "Create Form Interview",
      jobdesk: "System Analyst",
    ),
  ],
  [
    ListTaskDateData(
      date: DateTime.now().add(const Duration(days: 1, hours: 5)),
      label: "2 Posts on Facebook",
      jobdesk: "Marketing",
    ),
    ListTaskDateData(
      date: DateTime.now().add(const Duration(days: 1, hours: 6)),
      label: "Create Icon App",
      jobdesk: "Design",
    ),
    ListTaskDateData(
      date: DateTime.now().add(const Duration(days: 1, hours: 8)),
      label: "Fixing Error Payment",
      jobdesk: "Programmer",
    ),
    ListTaskDateData(
      date: DateTime.now().add(const Duration(days: 1, hours: 10)),
      label: "Create Form Interview",
      jobdesk: "System Analyst",
    ),
  ],
  [
    ListTaskDateData(
      date: DateTime.now().add(const Duration(days: 1, hours: 5)),
      label: "2 Posts on Facebook",
      jobdesk: "Marketing",
    ),
    ListTaskDateData(
      date: DateTime.now().add(const Duration(days: 2, hours: 6)),
      label: "Create Icon App",
      jobdesk: "Design",
    ),
    ListTaskDateData(
      date: DateTime.now().add(const Duration(days: 3, hours: 8)),
      label: "Fixing Error Payment",
      jobdesk: "Programmer",
    ),
    ListTaskDateData(
      date: DateTime.now().add(const Duration(days: 4, hours: 10)),
      label: "Create Form Interview",
      jobdesk: "System Analyst",
    ),
  ]
];
