import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomWatermarkView extends StatelessWidget {
  const CustomWatermarkView(
      {Key? key,
      required this.rowCount,
      required this.columnCount,
      required this.text})
      : super(key: key);

  final int rowCount;
  final int columnCount;

  final String text;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Column(
        children: creatColumnWidgets(),
      ),
    );
  }

  List<Widget> creatRowWidgets() {
    final List<Widget> list = <Widget>[];
    for (int i = 0; i < rowCount; i++) {
      final Expanded widget = Expanded(
        child: Center(
          child: Transform.rotate(
            angle: pi / 10,
            child: Text(
              text,
              style: TextStyle(
                // const Color(0xFF383838).withOpacity(0.2)
                color: const Color(0x08000000).withOpacity(0.1),
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      );
      list.add(widget);
    }
    return list;
  }

  List<Widget> creatColumnWidgets() {
    final List<Widget> list = <Widget>[];
    for (int i = 0; i < columnCount; i++) {
      final Expanded widget = Expanded(
        child: Row(
          children: creatRowWidgets(),
        ),
      );
      list.add(widget);
    }
    return list;
  }
}
