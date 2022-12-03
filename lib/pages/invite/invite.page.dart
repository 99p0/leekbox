import 'package:custom_tabbar/custom_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:leekbox_infra/log/log.dart';

/// 页面
class InvitePage extends StatefulWidget {
  @override
  _InvitePageState createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 9, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // see AutomaticKeepAliveClientMixin
    Log.debug('InvitePage build');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(2, 122, 255, 1),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        bottom: KuGouTabBar(
          tabs: const [
            Tab(text: "音乐"),
            Tab(text: "动态"),
            Tab(text: "语文"),
            Tab(text: "音乐"),
            Tab(text: "动态"),
            Tab(text: "语文"),
            Tab(text: "音乐"),
            Tab(text: "动态"),
            Tab(text: "语文")
          ],
          // labelPadding: EdgeInsets.symmetric(horizontal: 8),
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.label,
          isScrollable: true,
          padding: EdgeInsets.zero,
          indicator: const RRecTabIndicator(
              radius: 4, insets: EdgeInsets.only(bottom: 5)),
          indicatorMinWidth: 6,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Center(
            child: Text("音乐"),
          ),
          Center(
            child: Text("动态"),
          ),
          Center(
            child: Text("语文"),
          ),
          Center(
            child: Text("音乐"),
          ),
          Center(
            child: Text("动态"),
          ),
          Center(
            child: Text("语文"),
          ),
          Center(
            child: Text("音乐"),
          ),
          Center(
            child: Text("动态"),
          ),
          Center(
            child: Text("语文"),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  buildPageView(String content) {
    return Center(
      child: Text(
        content,
        style: const TextStyle(color: Colors.blue, fontSize: 24),
      ),
    );
  }
}
