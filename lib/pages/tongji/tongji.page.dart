import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leekbox/common/utils/utils.dart';
import 'package:leekbox/pages/home/components/statistics_circle_chart.dart';
import 'package:leekbox/pages/home/components/statistics_item.dart';
import 'package:leekbox/pages/home/components/statistics_line_chart.dart';
import 'package:leekbox/pages/home/components/statistics_order_item.dart';
import 'package:leekbox/pages/tongji/statistics_header_content.dart';
import 'package:leekbox_infra/log/log.dart';

///
class TongjiPage extends ConsumerStatefulWidget {
  const TongjiPage({super.key});

  @override
  _TongjiPageState createState() => _TongjiPageState();
}

class _TongjiPageState extends ConsumerState<TongjiPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Log.debug('TongjiPage initState...');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('MinePage build');
    final themeData = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('统计'),
            automaticallyImplyLeading: false,
            centerTitle: false,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      right: 12.0,
                      top: 12.0,
                      bottom: 22.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(18)),
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
          ),
        ],
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
      ],
    );
  }
}
