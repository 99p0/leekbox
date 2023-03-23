import 'package:isar/isar.dart';

class Global {
  /// 是否为release版
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  /// 初始化全局信息，会在APP启动时执行
  static Future init() async {
    /// 初始化Isar
    await Isar.initializeIsarCore(download: true);
  }
}
