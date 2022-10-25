import 'package:flutter_test/flutter_test.dart';
import 'package:leekbox_infra/leekbox_infra.dart';
import 'package:leekbox_infra/leekbox_infra_platform_interface.dart';
import 'package:leekbox_infra/leekbox_infra_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLeekboxInfraPlatform
    with MockPlatformInterfaceMixin
    implements LeekboxInfraPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final LeekboxInfraPlatform initialPlatform = LeekboxInfraPlatform.instance;

  test('$MethodChannelLeekboxInfra is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelLeekboxInfra>());
  });

  test('getPlatformVersion', () async {
    LeekboxInfra leekboxInfraPlugin = LeekboxInfra();
    MockLeekboxInfraPlatform fakePlatform = MockLeekboxInfraPlatform();
    LeekboxInfraPlatform.instance = fakePlatform;

    expect(await leekboxInfraPlugin.getPlatformVersion(), '42');
  });
}
