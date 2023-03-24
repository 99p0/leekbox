import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox_infra/log/log.dart';

///
class AccountAndSecurityPage extends ConsumerStatefulWidget {
  const AccountAndSecurityPage({super.key});

  static String get routeName => 'settings/AccountAndSecurity';

  static String get routeLocation => '/$routeName';

  @override
  _AccountAndSecurityPageState createState() => _AccountAndSecurityPageState();
}

class _AccountAndSecurityPageState extends ConsumerState<AccountAndSecurityPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('AccountAndSecurityPage build...');
    final themeData = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('账户与安全'),
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
