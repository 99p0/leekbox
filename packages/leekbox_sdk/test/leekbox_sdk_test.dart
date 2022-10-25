import 'package:flutter_test/flutter_test.dart';
import 'package:leekbox_sdk/leekbox_sdk.dart';
import 'package:leekbox_sdk/leekbox_sdk_platform_interface.dart';
import 'package:leekbox_sdk/leekbox_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLeekboxSdkPlatform
    with MockPlatformInterfaceMixin
    implements LeekboxSdkPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final LeekboxSdkPlatform initialPlatform = LeekboxSdkPlatform.instance;

  test('$MethodChannelLeekboxSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelLeekboxSdk>());
  });

  test('getPlatformVersion', () async {
    LeekboxSdk leekboxSdkPlugin = LeekboxSdk();
    MockLeekboxSdkPlatform fakePlatform = MockLeekboxSdkPlatform();
    LeekboxSdkPlatform.instance = fakePlatform;

    expect(await leekboxSdkPlugin.getPlatformVersion(), '42');
  });
}
