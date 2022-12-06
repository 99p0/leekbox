import 'package:custom_tabbar/custom_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:leekbox/pages/tongji/bar_chart/bar_chart_page.dart';
import 'package:leekbox/pages/tongji/line_chart/line_chart_page2.dart';
import 'package:leekbox/pages/tongji/line_chart/line_chart_page3.dart';
import 'package:leekbox/pages/tongji/line_chart/line_chart_page4.dart';
import 'package:leekbox/pages/tongji/pie_chart/pie_chart_page.dart';
import 'package:leekbox/pages/tongji/radar_chart/radar_chart_page.dart';
import 'package:leekbox/pages/tongji/scatter_chart/scatter_chart_page.dart';
import 'package:leekbox_infra/log/log.dart';

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
    return Container(
      child: Column(
        children: <Widget>[
          CustomScrollView(
            shrinkWrap: true,
            slivers: <Widget>[
              // SliverToBoxAdapter(
              //   child: Text('asda'),
              // ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.blue),
                  child: KuGouTabBar(
                    indicatorMinWidth: 6,
                    indicator: const RRecTabIndicator(
                        radius: 4, insets: EdgeInsets.only(bottom: 5)),
                    controller: _tabController,
                    labelColor: Colors.black,
                    tabs: <Widget>[...myTabs],
                    isScrollable: true,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 600,
                  child: TabBarView(
                    controller: _tabController,
                    children: _pages,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 20,
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
