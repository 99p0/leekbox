import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'leekbox_sdk_method_channel.dart';

abstract class LeekboxSdkPlatform extends PlatformInterface {
  /// Constructs a LeekboxSdkPlatform.
  LeekboxSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static LeekboxSdkPlatform _instance = MethodChannelLeekboxSdk();

  /// The default instance of [LeekboxSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelLeekboxSdk].
  static LeekboxSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LeekboxSdkPlatform] when
  /// they register themselves.
  static set instance(LeekboxSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
