// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:leekbox/common/widgets/gaps.dart';
// import 'package:leekbox/pages/developer/device_info.dart';
// import 'package:leekbox/pages/home/components/one_day_normal_view.dart';
// import 'package:leekbox/pages/home/components/statistics_item.dart';
// import 'package:leekbox/pages/home/components/statistics_line_chart.dart';
// import 'package:leekbox/pages/login/login.dart';
// import 'package:leekbox/pages/splash/intro/introduction_animation_screen.dart';
// import 'package:leekbox/pages/splash/privacy_policy_page.dart';
// import 'package:leekbox/pages/splash/splash_screen.dart';
// import 'package:leekbox_infra/log/log.dart';
// import 'package:leekbox/common/utils/utils.dart';
//
// ///
// class IndexRecommendPage extends ConsumerStatefulWidget {
//   @override
//   _IndexRecommendPageState createState() => _IndexRecommendPageState();
// }
//
// class _IndexRecommendPageState extends ConsumerState<IndexRecommendPage>
//     with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
//   @override
//   bool get wantKeepAlive => true;
//
//   late AnimationController animationController;
//   bool multiple = true;
//
//   @override
//   void initState() {
//     animationController = AnimationController(
//         duration: const Duration(milliseconds: 800), vsync: this);
//     animationController?.forward(); //
//     super.initState();
//   }
//
//   Future<bool> getData() async {
//     await Future<dynamic>.delayed(const Duration(milliseconds: 0));
//     return true;
//   }
//
//   Future<bool> getRecentNewsData() async {
//     await Future<dynamic>.delayed(const Duration(milliseconds: 0));
//     return true;
//   }
//
//   @override
//   void dispose() {
//     ///
//     animationController?.dispose();
//     super.dispose();
//   }
//
//   ///
//   Widget _buildGreetings(BuildContext context) {
//     return FutureBuilder<bool>(
//       future: getData(),
//       builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//         if (!snapshot.hasData) {
//           return const SizedBox();
//         } else {
//           animationController?.forward();
//           return TimeAndWordView(
//             animation:
//                 Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
//                     .animate(
//               CurvedAnimation(
//                 parent: animationController,
//                 curve: const Interval(0.1, 1, curve: Curves.fastOutSlowIn),
//               ),
//             ),
//             animationController: animationController,
//           );
//         }
//       },
//     );
//   }
//
//   ///
//   Widget _buildRecentYieldCurve(BuildContext context) {
//     return StatisticsItem(
//       content: const StatisticsLineChart(
//         textColor: Color(0xFFD4E2FA),
//         lineColor: Color(0xFFAFCAFA),
//         datas: [0.6, 0.9, 0.3, 0.8, 0.3, 0.6, 0.8],
//         animationStyle: StatisticsLineAnimationStyle.horizontal,
//       ),
//       title: '近期收益曲线',
//       onTap: () {
//         showToastWidget(
//           context: context,
//           CorrectToast(
//             child: Text(
//               '近期收益曲线',
//               style: Theme.of(context).textTheme.headline1,
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   ///
//   Widget _buildRecentNews(BuildContext context) {
//     return FutureBuilder<bool>(
//       future: getRecentNewsData(),
//       builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//         if (!snapshot.hasData) {
//           return const SizedBox();
//         } else {
//           return GestureDetector(
//             onTap: () {
//               // context.go(RecentNoticePage.routeLocation);
//             },
//             child: Container(
//               margin: const EdgeInsets.only(left: 8, right: 8),
//               height: 90,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.only(left: 8, right: 16),
//                     height: 30,
//                     child: Row(
//                       children: [
//                         const Expanded(
//                           child: Text(
//                             '最近消息',
//                             style: TextStyle(fontWeight: FontWeight.w300),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 14,
//                           height: 14,
//                           child: Image.asset(
//                             'assets/images/icon_selected.png',
//                             // height: 16,
//                             // width: 16,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 60,
//                     child: Container(
//                       padding: const EdgeInsets.only(
//                         left: 20,
//                         right: 26,
//                         top: 2,
//                       ),
//                       child: ListView.builder(
//                           itemCount: litemsTop2.length,
//                           itemBuilder: (BuildContext ctxt, int index) {
//                             return Padding(
//                               padding: const EdgeInsets.only(top: 3.0),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Gaps.hGap5,
//                                   Expanded(
//                                     child: Text(
//                                       litemsTop2[index],
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .titleSmall
//                                           ?.copyWith(fontSize: 12.0),
//                                     ),
//                                   ),
//                                   Text(
//                                     '三小时前',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .headline1
//                                         ?.copyWith(fontSize: 10.0),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
//
//   List<String> litemsTop2 = [
//     "Disruptor是LMAX开发的一个高性能队列",
//     "回来后咱看看这几套吧，如果还没有卖的话",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     Log.debug('IndexRecommendPage build');
//     final themeData = Theme.of(context);
//     return Scaffold(
//       body: CustomScrollView(
//         physics: const BouncingScrollPhysics(),
//         slivers: [
//           /// 间距
//           const SliverPadding(
//             padding: EdgeInsets.only(top: 5),
//           ),
//           // 问候语
//           SliverToBoxAdapter(
//             child: getBody(context),
//           ),
//           // 今日收益曲线
//           SliverToBoxAdapter(
//             child: getBody(context),
//           ),
//           // 底线
//           SliverFixedExtentList(
//             delegate: SliverChildBuilderDelegate(
//                 (context, index) => Container(
//                       color: Colors.transparent,
//                       alignment: Alignment.center,
//                       child: Text(
//                         '-------- 我是有底线的 --------',
//                         style: themeData.textTheme.bodySmall
//                             ?.copyWith(color: Colors.black26),
//                       ),
//                     ),
//                 childCount: 1),
//             itemExtent: 60.0,
//           ),
//
//           /// 间距
//           const SliverPadding(
//             padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildSliverAppBar() {
//     return Container();
//   }
//
//   Widget getBody(context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Gaps.vGap4,
//         // 问候语
//         _buildGreetings(context),
//         // 近期收益曲线
//         _buildRecentYieldCurve(context),
//         // 最近消息
//         _buildRecentNews(context),
//         // 推荐组合，瀑布流的形式
//
//         Row(
//           children: [
//             Gaps.hGap10,
//             ElevatedButton(
//               onPressed: () {
//                 context.go(PrivacyPolicyPage.routeLocation);
//               },
//               child: const Text('隐私页'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 context.go(SplashPage.routeLocation);
//               },
//               child: const Text('启动页'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 context.go(IntroScreen.routeLocation);
//               },
//               child: const Text('引导页'),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Gaps.hGap10,
//             ElevatedButton(
//               onPressed: () {
//                 context.push(DeviceInfoPage.routeLocation);
//               },
//               child: const Text('设备页'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 context.push(LoginPage.routeLocation);
//               },
//               child: const Text('登录页'),
//             ),
//             ElevatedButton(
//               onPressed: () {},
//               child: const Text('Material Banner'),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
