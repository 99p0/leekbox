import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
  Widget build(BuildContext context) {
    super.build(context);
    Log.debug('NoticePage build');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '消息',
          style: GoogleFonts.zcoolQingKeHuangYou(
            textStyle: Theme.of(context).textTheme.headline1,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            // fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
