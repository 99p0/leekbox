import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/common/widgets/my_app_bar.dart';
import 'package:leekbox_infra/log/log.dart';

///
class StorageManagePage extends ConsumerStatefulWidget {
  const StorageManagePage({super.key});

  static String get routeName => 'settings/StorageManage';

  static String get routeLocation => '/$routeName';

  @override
  _StorageManagePageState createState() => _StorageManagePageState();
}

class _StorageManagePageState extends ConsumerState<StorageManagePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('StorageManagePage build...');
    return Scaffold(
      appBar: MyAppBar(
        title: '存储空间',
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: getBody(context),
        ),
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
