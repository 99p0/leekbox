import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox_infra/log/log.dart';

///
class NewNotificationPage extends ConsumerStatefulWidget {
  const NewNotificationPage({super.key});

  static String get routeName => 'settings/NewNotification';

  static String get routeLocation => '/$routeName';

  @override
  _NewNotificationPageState createState() => _NewNotificationPageState();
}

class _NewNotificationPageState extends ConsumerState<NewNotificationPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('NewNotificationPage build...');
    final themeData = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('新消息通知'),
          ),
          SliverToBoxAdapter(
            child: getBody(context),
          ),
        ],
      ),
    );
  }

  Widget getBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Gaps.vGap4,
          Gaps.vGap4,
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
