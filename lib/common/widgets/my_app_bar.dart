import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  // ignore: use_key_in_widget_constructors
  const MyAppBar(
      {this.title = '',
      this.centerTitle = true,
      this.rightDMActions,
      this.backgroundColor,
      this.titleW,
      this.bottom,
      this.leadingImg = '',
      this.leadingW,
      this.automaticallyImplyLeading = true,
      this.elevation = 0.07});

  final String title;
  final bool centerTitle; //标题是否居中，默认居中
  final List<Widget>? rightDMActions;
  final Color? backgroundColor;
  final Widget? titleW;
  final Widget? leadingW;
  final PreferredSizeWidget? bottom;
  final String leadingImg;
  final double elevation;
  final bool automaticallyImplyLeading; //配合leading 使用，如果左侧不需要图标 ，设置false

//  @override
//  Size get preferredSize => Size(100, 48);

  /// appbar 的高度  默认高度是：56  kToolbarHeight
  @override
  Size get preferredSize => Size.fromHeight(
      AppBar().preferredSize.height + (bottom?.preferredSize.height ?? 0.0));

  Widget leading(BuildContext context) {
    final ModalRoute<dynamic> parentRoute = ModalRoute.of(context)!;
    final bool canPop = parentRoute.canPop;
    final bool useCloseButton =
        parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;

    return canPop
        ? useCloseButton
            ? CloseButton(
                color: Theme.of(context).appBarTheme.titleTextStyle?.color,
              )
            : BackButton(
                color: Theme.of(context).appBarTheme.titleTextStyle?.color,
              )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleW ??
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).appBarTheme.titleTextStyle?.color,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
      backgroundColor:
          backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
      elevation: elevation,
      leading:
          leadingW ?? (automaticallyImplyLeading ? leading(context) : null),
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      actions: rightDMActions ?? [const Center()],
      bottom: bottom,
    );
  }
}
