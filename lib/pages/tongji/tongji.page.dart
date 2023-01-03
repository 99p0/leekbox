import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leekbox/pages/home/components/statistics_circle_chart.dart';
import 'package:leekbox/pages/home/components/statistics_item.dart';
import 'package:leekbox/pages/home/components/statistics_line_chart.dart';
import 'package:leekbox/pages/home/components/statistics_order_item.dart';
import 'package:leekbox/pages/tongji/bar_chart/bar_chart_page.dart';
import 'package:leekbox/pages/tongji/line_chart/line_chart_page2.dart';
import 'package:leekbox/pages/tongji/line_chart/line_chart_page3.dart';
import 'package:leekbox/pages/tongji/line_chart/line_chart_page4.dart';
import 'package:leekbox/pages/tongji/pie_chart/pie_chart_page.dart';
import 'package:leekbox/pages/tongji/radar_chart/radar_chart_page.dart';
import 'package:leekbox/pages/tongji/scatter_chart/scatter_chart_page.dart';
import 'package:leekbox/pages/tongji/statistics_header_content.dart';
import 'package:leekbox_infra/log/log.dart';
import 'package:oktoast/oktoast.dart';

import 'bar_chart/bar_chart_page2.dart';
import 'bar_chart/bar_chart_page3.dart';
import 'line_chart/line_chart_page.dart';

///
class TongjiPage extends StatefulWidget {
  const TongjiPage({super.key});

  @override
  _TongjiPageState createState() => _TongjiPageState();
}

class _TongjiPageState extends State<TongjiPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  late TabController _tabController;

  final _pages = const [
    LineChartPage(),
    LineChartPage2(),
    LineChartPage3(),
    LineChartPage4(),
    BarChartPage(),
    BarChartPage2(),
    BarChartPage3(),
    PieChartPage(),
    ScatterChartPage(),
    RadarChartPage(),
  ];

  final List<Tab> myTabs = const <Tab>[
    Tab(text: "音乐 1"),
    Tab(text: "音乐 2"),
    Tab(text: "动态 3"),
    Tab(text: "语文 4"),
    Tab(text: "音乐 5"),
    Tab(text: "动态 6"),
    Tab(text: "语文 7"),
    Tab(text: "音乐 8"),
    Tab(text: "动态 9"),
    Tab(text: "语文 10")
  ];

  @override
  void initState() {
    _tabController = TabController(length: _pages.length, vsync: this);
    super.initState();
    _tabController.animation?.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('MinePage build');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '统计',
          style: GoogleFonts.zcoolXiaoWei(
            textStyle: Theme.of(context).textTheme.headline1,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            // fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 22.0,
                right: 22.0,
                bottom: 12.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xffDCE7FA).withOpacity(0.5),
                      offset: const Offset(0, 2),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                height: 120,
                child: const StatisticsHeaderContent(),
              ),
            ),
            StatisticsItem(
              content: const StatisticsLineChart(
                textColor: Color(0xFFFFEACC),
                lineColor: Color(0xFFFFDFB3),
                datas: [0.9, 0.65, 0.3, 0.7, 0.6, 0.9, 0.6],
                animationStyle: StatisticsLineAnimationStyle.vertical,
              ),
              title: '交易额统计',
              onTap: () {
                showToast('交易额统计');
              },
            ),
            StatisticsItem(
              content: const StatisticsCircleChart(
                datas: [0.8, 0.5, 0.65],
              ),
              title: '商品统计',
              onTap: () {
                showToast('商品统计');
              },
            ),
            StatisticsOrderItem(
              bgColor: Colors.amberAccent,
              title: '全部订单',
              numbers: const [500, 600, 400, 500, 300, 500, 600],
              content: (number) {
                return itemContent(number);
              },
            ),
          ],
        ),
      ),
    );
  }

  TextSpan itemContent(int number) {
    String unit = "单";
    return TextSpan(
        style: const TextStyle(
          textBaseline: TextBaseline.alphabetic,
        ),
        children: [
          TextSpan(
            text: '$number',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: ' $unit',
            style: const TextStyle(
              color: Color(0xfff1f1f1),
              fontSize: 9,
            ),
          ),
        ]);
  }
}
