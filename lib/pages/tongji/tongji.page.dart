import 'package:flutter/material.dart';
import 'package:leekbox/pages/tongji/bar_chart/bar_chart_page.dart';
import 'package:leekbox/pages/tongji/bar_chart/bar_chart_page2.dart';
import 'package:leekbox/pages/tongji/bar_chart/bar_chart_page3.dart';
import 'package:leekbox/pages/tongji/line_chart/line_chart_page.dart';
import 'package:leekbox/pages/tongji/line_chart/line_chart_page2.dart';
import 'package:leekbox/pages/tongji/line_chart/line_chart_page3.dart';
import 'package:leekbox/pages/tongji/line_chart/line_chart_page4.dart';
import 'package:leekbox/pages/tongji/pie_chart/pie_chart_page.dart';
import 'package:leekbox/pages/tongji/radar_chart/radar_chart_page.dart';
import 'package:leekbox/pages/tongji/scatter_chart/scatter_chart_page.dart';
import 'package:leekbox/common/utils/platform_info.dart';


///
class TongjiPage extends StatefulWidget {
  @override
  _TongjiPageState createState() => _TongjiPageState();
}

class _TongjiPageState extends State<TongjiPage> {
  int _currentPage = 0;

  final _controller = PageController();
  final _duration = const Duration(milliseconds: 300);
  final _curve = Curves.easeInOutCubic;
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

  bool get isDesktopOrWeb => PlatformInfo().isDesktopOrWeb();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PageView(
          physics: isDesktopOrWeb
              ? const NeverScrollableScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
          controller: _controller,
          children: _pages,
        ),
      ),
      bottomNavigationBar: isDesktopOrWeb
          ? Container(
              padding: const EdgeInsets.all(16),
              color: Colors.transparent,
              child: Row(
                children: [
                  Visibility(
                    visible: _currentPage != 0,
                    child: FloatingActionButton(
                      onPressed: () => _controller.previousPage(
                        duration: _duration,
                        curve: _curve,
                      ),
                      child: const Icon(Icons.chevron_left_rounded),
                    ),
                  ),
                  const Spacer(),
                  Visibility(
                    visible: _currentPage != _pages.length - 1,
                    child: FloatingActionButton(
                      onPressed: () => _controller.nextPage(
                        duration: _duration,
                        curve: _curve,
                      ),
                      child: const Icon(Icons.chevron_right_rounded),
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
