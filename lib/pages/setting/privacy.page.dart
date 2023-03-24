import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox_infra/log/log.dart';

///
class PrivacyPage extends ConsumerStatefulWidget {
  const PrivacyPage({super.key});

  static String get routeName => 'settings/Privacy';

  static String get routeLocation => '/$routeName';

  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

class _PrivacyPageState extends ConsumerState<PrivacyPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('PrivacyPage build...');
    final themeData = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('隐私'),
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
