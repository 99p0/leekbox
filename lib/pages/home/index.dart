import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_tabbar/custom_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leekbox/pages/setting/global_ui.setting.dart';
import 'package:leekbox_infra/log/log.dart';

import 'index.recommend.dart';
import 'index.square.dart';

///
class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  late TabController _tabController;
  late List<Widget> _tabList;

  final _pages = [
    IndexSquarePage(),
    IndexRecommendPage(),
  ];

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

    return Material(
      child: DefaultTabController(
        length: _pages.length,
        child: Scaffold(
          // extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  child: _buildCircleAvatar(),
                  onTap: () async =>
                      context.push(GlobalUISettingPage.routeLocation),
                );
              },
            ),
            leadingWidth: 40.w,
            title: KuGouTabBar(
              tabs: _tabList,
              labelPadding: const EdgeInsets.symmetric(horizontal: 10),
              controller: _tabController,
              labelColor: Theme.of(context).textTheme.titleSmall?.color,
              labelStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 16.0.sp,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = const LinearGradient(colors: [
                        Colors.red,
                        Colors.yellow,
                      ]).createShader(const Rect.fromLTWH(0, 0, 150, 0)),
                  ),
              unselectedLabelStyle:
                  Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 14.0.sp,
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
            actions: [
              IconButton(
                icon: const Icon(Icons.color_lens_outlined),
                onPressed: () async =>
                    context.push(GlobalUISettingPage.routeLocation),
              ),
            ],
          ),
          body: TabBarView(
            controller: _tabController,
            children: _pages,
          ),
        ),
      ),
    );
  }

  _buildCircleAvatar() {
    return CachedNetworkImage(
      imageUrl:
          "https://tupian.qqw21.com/article/UploadPic/2019-5/201951113193417891.jpeg",
      imageBuilder: (context, imageProvider) => Container(
        alignment: const Alignment(0, 0),
        margin: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider),
          border: Border.all(width: 2.2, color: Colors.orange),
        ),
        // child: const Text(''),
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