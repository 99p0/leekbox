import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:leekbox/common/utils/utils.dart';
import 'package:leekbox/common/widgets/gaps.dart';
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
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:scrolls_to_top/scrolls_to_top.dart';

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
      title: '近期收益曲线',
      onTap: () {
        showToast('近期收益曲线');
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
                                  '三小时前',
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
    "Disruptor是LMAX开发的一个高性能队列",
    "回来后咱看看这几套吧，如果还没有卖的话",
  ];

  Future<void> _onScrollsToTop(ScrollsToTopEvent event) async {
    //TODO: Your code
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('IndexPage build...');
    final themeData = Theme.of(context);
    return ScrollsToTop(
      onScrollsToTop: _onScrollsToTop,
      child: Scaffold(
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

            /// 最近消息
            SliverToBoxAdapter(
              child: _buildRecentNews(context),
            ),

            /// 推荐组合，瀑布流的形式
            SliverToBoxAdapter(
              child: getBody(context),
            ),

            ///
            SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                  foregroundDecoration: RotatedCornerDecoration.withColor(
                    badgeCornerRadius: const Radius.circular(8),
                    color: Colors.blue,
                    badgeSize: Size(38.w, 38.w),
                    spanBaselineShift: 2,
                    // isEmoji: true,
                    textSpan: TextSpan(
                      children: [
                        TextSpan(
                          text: '👑\n',
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                        TextSpan(
                          text: 'VIP专属',
                          style: TextStyle(
                            fontSize: 5.sp,
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
                    textSpan: TextSpan(
                      text: 'OMG',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8.sp,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        shadows: const [
                          BoxShadow(color: Colors.yellowAccent, blurRadius: 8),
                        ],
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
              fontSize: 14.sp,
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

class DynamicWithComment extends StatefulWidget {
  const DynamicWithComment({Key? key}) : super(key: key);

  @override
  State<DynamicWithComment> createState() => _DynamicWithCommentState();
}

class _DynamicWithCommentState extends State<DynamicWithComment> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      onExpansionChanged: (expanded) {
        setState(() {
          _expanded = expanded;
        });
      },
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(ImageUtils.getImgPath('dps'), width: 20.0),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '这是标题',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 8.0),
                Text(
                  '这是说明文字',
                  style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      ),
      initiallyExpanded: _expanded,
      // 展开后的 title 组件的 text 颜色（未指定颜色时）
      // textColor: Colors.red,
      // 展开后背景色
      // backgroundColor: Colors.blue[50],
      //收起状态背景色
      // collapsedBackgroundColor: Colors.grey[50],
      trailing: Icon(
          _expanded
              ? Icons.keyboard_arrow_up_outlined
              : Icons.keyboard_arrow_down_outlined,
          color: Colors.grey),
      expandedAlignment: Alignment.centerLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding: EdgeInsets.zero,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
          padding: const EdgeInsets.all(5.0),
          // color: Colors.grey[400],
          child: const Text('xx1: 评论'),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
          padding: const EdgeInsets.all(5.0),
          // color: Colors.grey[400],
          alignment: Alignment.centerRight,
          child: const Text('xx2: 评论'),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 10.0),
          padding: const EdgeInsets.all(5.0),
          // color: Colors.grey[400],
          child: const Text('xx3: 评论'),
        ),
      ],
    );
  }
}
