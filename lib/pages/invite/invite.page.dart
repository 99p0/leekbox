import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leekbox_infra/log/log.dart';

///
class InvitePage extends ConsumerStatefulWidget {
  const InvitePage({super.key});

  static String get routeName => 'invite';

  static String get routeLocation => '/$routeName';

  @override
  _InvitePageState createState() => _InvitePageState();
}

class _InvitePageState extends ConsumerState<InvitePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    Log.debug('InvitePage initState...');
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
    Log.debug('InvitePage build');
    final themeData = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('邀请'),
            automaticallyImplyLeading: false,
            centerTitle: false,
          ),
          // SliverFixedExtentList(
          //   delegate: SliverChildBuilderDelegate(
          //       (context, index) => Container(
          //             color: Colors.transparent,
          //             alignment: Alignment.center,
          //             child: RiveAnimation.asset(
          //               'assets/rives/raster_graphics.riv',
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //       childCount: 1),
          //   itemExtent: 460.0,
          // ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
