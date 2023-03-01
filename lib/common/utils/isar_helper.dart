import 'package:isar/isar.dart';

class IsarHelper {
  IsarHelper._privateConstructor();

  static final IsarHelper _instance = IsarHelper._privateConstructor();

  static IsarHelper get instance => _instance;

  late Isar isarInstance;

  init() async {
    // isarInstance = await Isar.open([InventorySchema]);
  }
}
