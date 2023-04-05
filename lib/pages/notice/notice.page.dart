import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:leekbox/common/widgets/my_app_bar.dart';
import 'package:leekbox/pages/notice/recent_notice.dart';

/// 页面
class NoticePage extends ConsumerStatefulWidget {
  const NoticePage({super.key});

  static String get routeName => 'notice';

  static String get routeLocation => '/$routeName';

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends ConsumerState<NoticePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: MyAppBar(
        title: '消息',
        rightDMActions: [
          TextButton(
            onPressed: () => context.push(RecentNoticePage.routeLocation),
            child: const Text('通知示例'),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
