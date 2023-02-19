import 'package:flutter/material.dart';
import 'package:leekbox_infra/log/log.dart';
import 'package:rive/rive.dart';

///
class InvitePage extends StatefulWidget {
  const InvitePage({super.key});

  @override
  _InvitePageState createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage>
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
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: RiveAnimation.asset(
                        'assets/rives/raster_graphics.riv',
                        fit: BoxFit.cover,
                      ),
                    ),
                childCount: 1),
            itemExtent: 460.0,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
