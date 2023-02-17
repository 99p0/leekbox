import 'package:flutter/material.dart';
import 'package:leekbox_infra/log/log.dart';

///
class InvitePage extends StatefulWidget {
  const InvitePage({super.key});

  @override
  _InvitePageState createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('InvitePage build');
    final themeData = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('邀请'),
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
