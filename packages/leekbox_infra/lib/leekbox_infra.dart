
import 'leekbox_infra_platform_interface.dart';

class LeekboxInfra {
  Future<String?> getPlatformVersion() {
    return LeekboxInfraPlatform.instance.getPlatformVersion();
  }
}
