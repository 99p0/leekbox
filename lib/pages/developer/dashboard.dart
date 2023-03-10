import 'package:flutter/material.dart';
import 'package:leekbox/common/widgets/my_app_bar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  static String get routeName => 'developer/dashboard';

  static String get routeLocation => '/$routeName';

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: '面板',
      ),
      body: Container(),
    );
  }
}
