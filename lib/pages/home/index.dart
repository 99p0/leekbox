import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_tabbar/custom_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leekbox/pages/setting/global_ui.setting.dart';
import 'package:leekbox_infra/log/log.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'index.recommend.dart';
import 'index.square.dart';

///
class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late TabController _tabController;
  late List<Widget> _tabList;

  final _pages = [
    IndexSquarePage(),
    IndexRecommendPage(),
  ];
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length + 1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    _tabList = [
      const Tab(text: "广场"),
      const Tab(text: "推荐"),
    ];

    _tabController =
        TabController(initialIndex: 1, length: _tabList.length, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('IndexPage build');

    return Scaffold(
      appBar: _buildAppbar(context),
      body: TabBarView(
        controller: _tabController,
        children: _pages,
      ),
    );
  }

  _buildCircleAvatar() {
    return CachedNetworkImage(
      imageUrl:
          "https://tupian.qqw21.com/article/UploadPic/2019-5/201951113193417891.jpeg",
      imageBuilder: (context, imageProvider) => Container(
        width: 38,
        height: 38,
        margin: const EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider),
        ),
        // child: Text('TNT'),
      ),
      placeholder: (context, url) => const SizedBox(width: 38, height: 38),
      errorWidget: (context, url, error) =>
          const SizedBox(width: 38, height: 38),
    );
  }

  _buildAppbar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(48),
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        // width: 200,
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                context.push(GlobalUISettingPage.routeLocation);
              },
              child: _buildCircleAvatar(),
            ),
            KuGouTabBar(
              tabs: _tabList,
              labelPadding: const EdgeInsets.symmetric(horizontal: 10),
              controller: _tabController,
              labelColor: Theme.of(context).textTheme.titleSmall?.color,
              labelStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w500,
                  ),
              unselectedLabelStyle:
                  Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 16.0,
                      ),
              isScrollable: true,
              padding: EdgeInsets.zero,
              indicator: const RRecTabIndicator(
                radius: 4,
                insets: EdgeInsets.only(bottom: 5),
                color: Colors.lightBlueAccent,
              ),
              indicatorMinWidth: 6,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Theme.of(context).textTheme.titleSmall?.color,
            ),
            IconButton(
              icon: const Icon(Icons.color_lens_outlined),
              onPressed: () {
                context.push(GlobalUISettingPage.routeLocation);
              },
            ),
          ],
        ),
      ),
    );
  }
}
