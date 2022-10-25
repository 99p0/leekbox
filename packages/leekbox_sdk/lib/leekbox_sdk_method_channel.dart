import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'leekbox_sdk_platform_interface.dart';

/// An implementation of [LeekboxSdkPlatform] that uses method channels.
class MethodChannelLeekboxSdk extends LeekboxSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('leekbox_sdk');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
