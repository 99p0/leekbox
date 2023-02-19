import 'package:flutter/material.dart';
import 'package:leekbox_infra/log/log.dart';

/// 页面
class NoticePage extends StatefulWidget {
  const NoticePage({super.key});

  static String get routeName => 'notice';

  static String get routeLocation => '/$routeName';

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    Log.debug('NoticePage initState...');
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
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('NoticePage build');
    final themeData = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('消息'),
            automaticallyImplyLeading: false,
            centerTitle: false,
          ),
          SliverToBoxAdapter(
            child: Container(),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
