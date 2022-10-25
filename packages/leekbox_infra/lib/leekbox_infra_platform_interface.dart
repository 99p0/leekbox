import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'leekbox_infra_method_channel.dart';

abstract class LeekboxInfraPlatform extends PlatformInterface {
  /// Constructs a LeekboxInfraPlatform.
  LeekboxInfraPlatform() : super(token: _token);

  static final Object _token = Object();

  static LeekboxInfraPlatform _instance = MethodChannelLeekboxInfra();

  /// The default instance of [LeekboxInfraPlatform] to use.
  ///
  /// Defaults to [MethodChannelLeekboxInfra].
  static LeekboxInfraPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LeekboxInfraPlatform] when
  /// they register themselves.
  static set instance(LeekboxInfraPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
