
import 'leekbox_sdk_platform_interface.dart';

class LeekboxSdk {
  Future<String?> getPlatformVersion() {
    return LeekboxSdkPlatform.instance.getPlatformVersion();
  }
}
