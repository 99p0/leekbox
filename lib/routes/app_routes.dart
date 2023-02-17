import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:leekbox/pages/exception/error.page.dart';
import 'package:leekbox/pages/splash/splash_screen.dart';

import 'router_notifier.dart';

final _key = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

final routerProvider = Provider.autoDispose<GoRouter>((ref) {
  ///
  final notifier = ref.watch(routerNotifierProvider.notifier);

  return GoRouter(
    navigatorKey: _key,
    // 监听到的变化会导致路由器刷新路由。
    refreshListenable: notifier,
    debugLogDiagnostics: true,
    initialLocation: SplashPage.routeLocation,
    routes: notifier.routes,
    redirect: notifier.redirect,

    errorBuilder: (context, state) => const ErrorPage(),
  );
});
