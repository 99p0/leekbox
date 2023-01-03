import 'package:custom_tabbar/custom_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// 页面
class InvitePage extends StatefulWidget {
  const InvitePage({super.key});

  @override
  _InvitePageState createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  late ScrollController _scrollViewController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '邀请',
          style: GoogleFonts.zcoolQingKeHuangYou(
            textStyle: Theme.of(context).textTheme.headline1,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            // fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              expandedHeight: 280,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  //头部整个背景颜色
                  height: double.infinity,
                  // color: const Color(0xffcccccc),
                  child: Column(
                    children: <Widget>[
                      _buildBanner(),
                      _buildButtons(),
                      _buildTabBarBg()
                    ],
                  ),
                ),
              ),
              bottom: KuGouTabBar(
                tabs: [
                  const Tab(text: "aaa"),
                  const Tab(text: "bbb"),
                  const Tab(text: "ccc"),
                ],
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
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildListView("aaa:"),
            _buildListView("bbb:"),
            _buildListView("ccc:"),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
      height: 144,
      // child: Swiper(
      //     //第三方的banner库：flutter_swiper
      //     itemBuilder: (BuildContext context, int index) {
      //       return Container(
      //         width: double.infinity,
      //         height: 144,
      //         child: Image.network(
      //           "https://github.com/best-flutter/flutter_swiper/raw/master/banner.jpg",
      //           height: double.infinity,
      //           fit: BoxFit.fill,
      //         ),
      //       );
      //     },
      //     itemCount: 3,
      //     scale: 0.9,
      //     pagination: new SwiperPagination()),
    );
  }

  //banner下面的按钮
  Widget _buildButtons() {
    return Expanded(
      child: Row(
        children: <Widget>[
          _buildButtonItem(Icons.chat, "xxxx"),
          _buildButtonItem(Icons.pages, "xxxx"),
          _buildButtonItem(Icons.phone_android, "xxxx"),
          _buildButtonItem(Icons.print, "xxxx"),
        ],
      ),
    );
  }

  Widget _buildButtonItem(IconData icon, String text) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, size: 28.0),
        Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: Text(text,
              style: const TextStyle(color: Color(0xff999999), fontSize: 12)),
        )
      ],
    ));
  }

  Widget _buildTabBarBg() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.redAccent,
      ),
      //TabBar圆角背景颜色
      height: 50,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        // child: Container(color: Colors.white),
      ),
    );
  }

  Widget _buildListView(String s) {
    return ListView.separated(
        itemCount: 20,
        separatorBuilder: (BuildContext context, int index) => const Divider(
              color: Colors.orange,
              height: 1,
            ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
              color: Colors.white,
              child: ListTile(title: Text("$s第$index 个条目")));
        });
  }
}
