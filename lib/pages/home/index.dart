import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:leekbox/common/models/list_task_date.dart';
import 'package:leekbox/common/services/notification_service.dart';
import 'package:leekbox/common/utils/utils.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/common/widgets/responsive_builder.dart';
import 'package:leekbox/pages/activity/activities.page.dart';
import 'package:leekbox/pages/activity/activity_detail.page.dart';
import 'package:leekbox/pages/demo/wakelock_demo.dart';
import 'package:leekbox/pages/developer/dashboard.dart';
import 'package:leekbox/pages/developer/device_info.dart';
import 'package:leekbox/pages/home/components/card_task.dart';
import 'package:leekbox/pages/home/components/list_task_assigned.dart';
import 'package:leekbox/pages/home/components/one_day_normal_view.dart';
import 'package:leekbox/pages/home/components/statistics_item.dart';
import 'package:leekbox/pages/home/components/statistics_line_chart.dart';
import 'package:leekbox/pages/home/components/task_in_progress.dart';
import 'package:leekbox/pages/home/components/task_progress.dart';
import 'package:leekbox/pages/home/components/weekly_task.dart';
import 'package:leekbox/pages/login/login.dart';
import 'package:leekbox/pages/splash/intro/introduction_animation_screen.dart';
import 'package:leekbox/pages/splash/privacy_policy_page.dart';
import 'package:leekbox/pages/splash/splash_screen.dart';
import 'package:leekbox_infra/log/log.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

import 'components/checkin_record.dart';
import 'components/sidebar.dart';

///
class IndexPage extends ConsumerStatefulWidget {
  const IndexPage({super.key});

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends ConsumerState<IndexPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  // 定义一个globalKey, 由于GlobalKey要保持全局唯一性，我们使用静态变量存储
  static final GlobalKey<ScaffoldState> _globalScaffoldKey = GlobalKey();

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

  final NotificationService _notificationService = NotificationService();

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
  Widget _builderMobileView(BuildContext context, BoxConstraints constraints) {
    final themeData = Theme.of(context);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        /// appbar
        _buildSliverAppBar(),

        /// 推荐组合，瀑布流的形式
        SliverToBoxAdapter(
          child: _buildTaskContent(),
        ),

        /// 推荐组合，瀑布流的形式
        SliverToBoxAdapter(
          child: getBody(context),
        ),
        SliverToBoxAdapter(
          child: buildNotification(context),
        ),

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
    );
  }

  ///
  Widget _builderTabletView(BuildContext context, BoxConstraints constraints) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: constraints.maxWidth > 800 ? 8 : 7,
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: _buildTaskContent(
              onPressedMenu: () =>
                  _globalScaffoldKey.currentState?.openDrawer(),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const VerticalDivider(),
        ),
        _builderRightSide(context, constraints),
      ],
    );
  }

  Widget _builderRightSide(BuildContext context, BoxConstraints constraints) {
    return Flexible(
      flex: constraints.maxWidth > 1350 ? 3 : 4,
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            const SizedBox(height: kSpacing / 2),
            const Divider(thickness: 1),
            const SizedBox(height: kSpacing),
            const CheckinRecord(),
            const SizedBox(height: kSpacing),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: kSpacing),
            //   child: GetPremiumCard(onPressed: () {}),
            // ),
            const SizedBox(height: kSpacing),
            const Divider(thickness: 1),
            const SizedBox(height: kSpacing),
            const CheckinRecord(),
          ],
        ),
      ),
    );
  }

  ///
  Widget _builderDesktopView(BuildContext context, BoxConstraints constraints) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: constraints.maxWidth > 1350 ? 3 : 4,
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: const Sidebar(),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const VerticalDivider(
            color: Colors.red,
            width: 10,
            thickness: 0.1,
            indent: 20,
            endIndent: 20,
          ),
        ),
        Flexible(
          flex: constraints.maxWidth > 1350 ? 10 : 9,
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: _buildTaskContent(axis: Axis.horizontal),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const VerticalDivider(
            color: Colors.red,
            width: 10,
            thickness: 0.1,
            indent: 20,
            endIndent: 20,
          ),
        ),
        _builderRightSide(context, constraints),
      ],
    );
  }

  Widget _buildProgress({Axis axis = Axis.horizontal}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: (axis == Axis.horizontal)
          ? Row(
              children: [
                Flexible(
                  flex: 5,
                  child: _buildRecentYieldCurve(context),
                ),
                const SizedBox(width: kSpacing / 2),
                Flexible(
                  flex: 4,
                  child: StatisticsItem(
                    content: const StatisticsLineChart(
                      textColor: Color(0xFFFFEACC),
                      lineColor: Color(0xFFFFDFB3),
                      datas: [0.9, 0.65, 0.3, 0.7, 0.6, 0.9, 0.6],
                      animationStyle: StatisticsLineAnimationStyle.vertical,
                    ),
                    title: '近期闯关曲线',
                    onTap: () {
                      showToast('近期闯关曲线');
                    },
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRecentYieldCurve(context),
                const SizedBox(height: kSpacing / 2),
                StatisticsItem(
                  content: const StatisticsLineChart(
                    textColor: Color(0xFFFFEACC),
                    lineColor: Color(0xFFFFDFB3),
                    datas: [0.9, 0.65, 0.3, 0.7, 0.6, 0.9, 0.6],
                    animationStyle: StatisticsLineAnimationStyle.vertical,
                  ),
                  title: '近期闯关曲线',
                  onTap: () {
                    showToast('近期闯关曲线');
                  },
                ),
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('IndexPage build...');
    return Scaffold(
      //设置key
      key: _globalScaffoldKey,
      drawer: ResponsiveBuilder.isDesktop(context)
          ? null
          : const Drawer(
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Sidebar(),
                ),
              ),
            ),
      body: ResponsiveBuilder(
        mobileBuilder: _builderMobileView,
        tabletBuilder: _builderTabletView,
        desktopBuilder: _builderDesktopView,
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
        '那些年，我们立下的flag都实现了吗？',
        style: Theme.of(context).textTheme.titleMedium,
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

  Widget buildNotification(context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }

  Widget getBody(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
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
                    MaterialPageRoute(
                        builder: (context) => WakelockExampleApp()),
                  );
                },
                child: const Text('Wakelock'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('icon_flip_nav_bar'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('txt_nav_bar'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaskContent({
    Function()? onPressedMenu,
    Axis axis = Axis.vertical,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kSpacing),
          Row(
            children: [
              if (onPressedMenu != null)
                Padding(
                  padding: const EdgeInsets.only(right: kSpacing / 2),
                  child: IconButton(
                    onPressed: onPressedMenu,
                    icon: const Icon(Icons.menu),
                  ),
                ),
              if (onPressedMenu != null)
                const Expanded(
                  child: Text(
                    '那些年，我们立下的flag都实现了吗？',
                  ),
                ),
            ],
          ),

          /// 问候语
          _buildGreetings(context),
          const SizedBox(height: kSpacing),
          _buildProgress(axis: axis),
          const SizedBox(height: kSpacing),
          Row(
            children: [
              Expanded(
                child: Text(DateTime.now().formatdMMMMY()),
              ),
              const SizedBox(width: kSpacing / 2),
              const SizedBox(
                width: 200,
                child: TaskProgress(
                    data: TaskProgressData(totalTask: 5, totalCompleted: 1)),
              ),
            ],
          ),
          const SizedBox(height: kSpacing),
          TaskInProgress(data: taskInProgress),
          const SizedBox(height: kSpacing * 2),
          Row(
            children: [
              const Text("每日任务"),
              const Spacer(),
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.double_arrow,
                  size: 16,
                ),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                ),
                label: const Text("更多"),
              ),
            ],
          ),
          const SizedBox(height: kSpacing),
          WeeklyTask(
            data: weeklyTask,
            onPressed: (index, data) {},
            onPressedAssign: (index, data) {},
            onPressedMember: (index, data) {},
          ),
        ],
      ),
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

final weeklyTask = [
  ListTaskAssignedData(
    icon: const Icon(Icons.monitor, color: Colors.blueGrey),
    label: "Slicing UI",
    jobDesk: "Programmer",
    assignTo: "Alex Ferguso",
    editDate: DateTime.now().add(-const Duration(hours: 2)),
  ),
  ListTaskAssignedData(
    icon: const Icon(Icons.star, color: Colors.amber),
    label: "Personal branding",
    jobDesk: "Marketing",
    assignTo: "Justin Beck",
    editDate: DateTime.now().add(-const Duration(days: 50)),
  ),
  const ListTaskAssignedData(
    icon: Icon(Icons.color_lens, color: Colors.blue),
    label: "UI UX ",
    jobDesk: "Design",
  ),
  const ListTaskAssignedData(
    icon: Icon(Icons.pie_chart, color: Colors.redAccent),
    label: "Determine meeting schedule ",
    jobDesk: "System Analyst",
  ),
];
final taskInProgress = [
  CardTaskData(
    label: "Determine meeting schedule",
    jobDesk: "System Analyst",
    dueDate: DateTime.now().add(const Duration(minutes: 50)),
  ),
  CardTaskData(
    label: "Personal branding",
    jobDesk: "Marketing",
    dueDate: DateTime.now().add(const Duration(hours: 4)),
  ),
  CardTaskData(
    label: "UI UX",
    jobDesk: "Design",
    dueDate: DateTime.now().add(const Duration(days: 2)),
  ),
  CardTaskData(
    label: "Determine meeting schedule",
    jobDesk: "System Analyst",
    dueDate: DateTime.now().add(const Duration(minutes: 50)),
  ),
  CardTaskData(
    label: "Determine meeting schedule",
    jobDesk: "System Analyst",
    dueDate: DateTime.now().add(const Duration(minutes: 50)),
  ),
  CardTaskData(
    label: "Personal branding",
    jobDesk: "Marketing",
    dueDate: DateTime.now().add(const Duration(hours: 4)),
  ),
  CardTaskData(
    label: "UI UX",
    jobDesk: "Design",
    dueDate: DateTime.now().add(const Duration(days: 2)),
  ),
  CardTaskData(
    label: "Determine meeting schedule",
    jobDesk: "System Analyst",
    dueDate: DateTime.now().add(const Duration(minutes: 50)),
  )
];
