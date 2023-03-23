import 'dart:math' as math;

import 'package:leekbox_infra/log/log.dart';
import 'package:permission_handler/permission_handler.dart';

import 'toast_utils.dart';

export 'date_util.dart';
export 'device_utils.dart';
export 'emoji_utils.dart';
export 'font_util.dart';
export 'image_utils.dart';
export 'notification_utils.dart';
export 'package_utils.dart';
export 'toast_utils.dart';

const bool logMessageSocketPacket = false;

/// Pythagorean theorem.
/// 勾股定理
double pythagoreanTheorem(double short, double long) {
  return math.sqrt(math.pow(short, 2) + math.pow(long, 2));
}

/// Last time stamp when user trying to exit app.
/// 用户最后一次触发退出应用的时间戳
int _lastWantToPop = 0;

/// Method that check if user triggered back twice quickly.
/// 检测用户是否快读点击了两次返回，用于双击返回桌面功能。
Future<bool> doubleBackExit() async {
  final int now = DateTime.now().millisecondsSinceEpoch;
  if (now - _lastWantToPop > 800) {
    showToast('再按一次退出应用');
    _lastWantToPop = DateTime.now().millisecondsSinceEpoch;
    return false;
  } else {
    dismiss();
    return true;
  }
}

/// Check permissions and only return whether they succeed or not.
Future<bool> checkPermissions(List<Permission> permissions) async {
  try {
    final Map<Permission, PermissionStatus> status =
        await permissions.request();
    return !status.values.any(
      (PermissionStatus p) => p != PermissionStatus.granted,
    );
  } catch (e) {
    Log.debug('Error when requesting permission: $e');
    return false;
  }
}
