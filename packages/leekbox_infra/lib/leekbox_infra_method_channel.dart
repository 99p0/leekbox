import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'leekbox_infra_platform_interface.dart';

/// An implementation of [LeekboxInfraPlatform] that uses method channels.
class MethodChannelLeekboxInfra extends LeekboxInfraPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('leekbox_infra');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
