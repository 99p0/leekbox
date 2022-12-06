import 'package:flutter/services.dart';

class AndroidBackDesktop {
  static const MethodChannel _channel = MethodChannel('android/back/desktop');

  static Future backToDesktop() async {
    return _channel.invokeMethod('backDesktop').then((value) => value ?? false);
  }
}
