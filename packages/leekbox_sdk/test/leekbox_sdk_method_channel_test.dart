import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leekbox_sdk/leekbox_sdk_method_channel.dart';

void main() {
  MethodChannelLeekboxSdk platform = MethodChannelLeekboxSdk();
  const MethodChannel channel = MethodChannel('leekbox_sdk');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
