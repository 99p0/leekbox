import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leekbox/common/utils/image_utils.dart';
import 'package:leekbox/common/widgets/my_app_bar.dart';
import 'package:leekbox_infra/log/log.dart';

const double kDefaultPadding = 20.0;

///
class ActivityListPage extends ConsumerStatefulWidget {
  const ActivityListPage({super.key});

  static String get routeName => 'activities';

  static String get routeLocation => '/$routeName';

  @override
  _ActivityListPageState createState() => _ActivityListPageState();
}

class _ActivityListPageState extends ConsumerState<ActivityListPage> {
  @override
  Widget build(BuildContext context) {
    Log.debug('ActivityListPage build');
    return Scaffold(
      appBar: const MyAppBar(
        title: '那些年，我们立下的flag都实现了吗？',
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              ImageUtils.getImgPath('common/bg', format: 'svg'),
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
