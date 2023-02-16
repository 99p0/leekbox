import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/pages/demo/app_toast.dart';
import 'package:leekbox/pages/device_info/device_info.dart';
import 'package:leekbox/pages/home/components/one_day_normal_view.dart';
import 'package:leekbox/pages/home/components/statistics_item.dart';
import 'package:leekbox/pages/home/components/statistics_line_chart.dart';
import 'package:leekbox/pages/login/login.dart';
import 'package:leekbox/pages/splash/intro/introduction_animation_screen.dart';
import 'package:leekbox/pages/splash/privacy_policy_page.dart';
import 'package:leekbox/pages/splash/splash_screen.dart';
import 'package:leekbox_infra/log/log.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///
class IndexRecommendPage extends StatefulWidget {
  @override
  _IndexRecommendPageState createState() => _IndexRecommendPageState();
}

class _IndexRecommendPageState extends State<IndexRecommendPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    items = ["1", "2", "3", "4", "5", "6", "7", "8"];
    _refreshController.refreshCompleted();
    if (mounted) {
      setState(() {});
    }
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    var len = items.length;
    items.addAll([
      (len + 1).toString(),
      (len + 2).toString(),
      (len + 3).toString(),
      (len + 4).toString(),
      (len + 5).toString(),
      (len + 6).toString(),
      (len + 7).toString(),
      (len + 8).toString(),
      (len + 9).toString(),
      (len + 10).toString(),
      (len + 11).toString(),
      (len + 12).toString(),
      (len + 13).toString(),
      (len + 14).toString(),
      (len + 15).toString(),
      (len + 16).toString(),
      (len + 17).toString(),
      (len + 18).toString(),
      (len + 19).toString(),
      (len + 20).toString(),
    ]);
    if (mounted) {
      setState(() {});
    }
    _refreshController.loadComplete();
  }

  late AnimationController animationController;
  bool multiple = true;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    animationController?.forward(); //
    super.initState();
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
    Log.debug('IndexRecommendPage build');

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Gaps.vGap4,
            // 问候语
            _buildGreetings(context),
            // 近期收益曲线
            _buildRecentYieldCurve(context),
            // 最近消息
            _buildRecentNews(context),

            // 推荐组合，瀑布流的形式
            _buildRecentNews(context),

            Row(
              children: [
                Gaps.hGap10,
                ElevatedButton(
                  onPressed: () {
                    context.go(PrivacyPolicyPage.routeLocation);
                  },
                  child: const Text('隐私页'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.go(SplashPage.routeLocation);
                  },
                  child: const Text('启动页'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.go(IntroScreen.routeLocation);
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
                    context.push(DeviceInfoPage.routeLocation);
                  },
                  child: const Text('设备页'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.push(LoginPage.routeLocation);
                  },
                  child: const Text('登录页'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Material Banner'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
