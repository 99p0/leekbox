import 'package:get/get.dart';
import 'package:leekbox/pages/my_home_page.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const MyHomePage(),
    ),
  ];
}
