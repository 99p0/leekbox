import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leekbox/pages/login/login.dart';
import 'package:leekbox_infra/log/log.dart';

class NotLoggedInHomePage extends StatelessWidget {
  const NotLoggedInHomePage({super.key});

  static String get routeName => 'home/not_logged_in';

  static String get routeLocation => '/$routeName';

  @override
  Widget build(BuildContext context) {
    Log.debug('NotLoggedInHomePage build...');
    final themeData = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('那些年，我们立下的flag都实现了吗？'),
          ),
          SliverToBoxAdapter(
            child: ElevatedButton(
              onPressed: () {
                context.go(LoginPage.routeLocation);
              },
              child: const Text('请登录后访问额'),
            ),
          ),
        ],
      ),
    );
  }
}
