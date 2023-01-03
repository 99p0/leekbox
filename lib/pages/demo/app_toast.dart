import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leekbox_infra/log/log.dart';

class CorrectToast extends ConsumerWidget {
  final Widget child;

  const CorrectToast({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var brightness = Theme.of(context).brightness;
    final bool isDark = brightness == Brightness.dark;
    Log.debug('$brightness ::  isDark: $isDark');
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(bottom: 15.h, left: 10.w, right: 10.w),
        padding: EdgeInsets.only(left: 20.w),
        decoration: BoxDecoration(
          // color: isDark ? Colors.black26 : Colors.white70,
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          boxShadow: const [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        width: double.infinity,
        height: 60.h,
        child: Padding(
          padding: const EdgeInsets.only(top: 26.0),
          child: child,
        ),
      ),
    );
  }
}
