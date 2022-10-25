import 'package:flutter/widgets.dart';

import 'custom_watermark_view.dart';

class WatermarkController {
  factory WatermarkController() => theOne;

  WatermarkController._internal();

  static final WatermarkController theOne = WatermarkController._internal();

  OverlayEntry? _overlayEntry;

  /// 添加默认水印
  /// [watermark] 水印文案
  /// [rowCount] 水印文案每行显示的个数
  /// [columnCount] 水印文案每列显示的个数
  /// [textStyle] 水印文案的样式
  Future<void> addWatermark(BuildContext context, String watermark,
      {int rowCount = 3, int columnCount = 10, TextStyle? textStyle}) async {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
    }
    final OverlayState? overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => CustomWatermarkView(
        rowCount: rowCount,
        columnCount: columnCount,
        text: watermark,
      ),
    );
    overlayState?.insert(_overlayEntry!);
  }

  /// 添加自定义水印。将[widget]覆盖在所有视图的最上层
  Future<void> addCustomWatermark(BuildContext context, Widget widget) async {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
    }
    final OverlayState? overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(builder: (BuildContext context) => widget);
    overlayState?.insert(_overlayEntry!);
  }

  /// 移除水印
  Future<void> removeWatermark() async {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}
