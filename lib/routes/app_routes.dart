import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:leekbox/pages/error.page.dart';
import 'package:leekbox/pages/home/my_home_page.dart';
import 'package:leekbox/pages/login/login.dart';
import 'package:leekbox/pages/splash/splash_screen.dart';
import 'package:leekbox/routes/auth.dart';

final _key = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  ref.watch(authProvider);
  final authNotifier = ref.read(authProvider.notifier);

  return GoRouter(
    navigatorKey: _key,
    debugLogDiagnostics: true,

    errorBuilder: (context, state) => const ErrorPage(),
    // state.error
    redirect: (context, state) {
      // If our async state is loading, don't perform redirects, yet
      if (authNotifier.isLoading) return null;

      final isAuth = authNotifier.isAuthenticated;

      final isSplash = state.location == SplashPage.routeLocation;
      if (isSplash) {
        return isAuth ? MyHomePage.routeLocation : LoginPage.routeLocation;
      }

      final isLoggingIn = state.location == LoginPage.routeLocation;
      if (isLoggingIn) return isAuth ? MyHomePage.routeLocation : null;

      return isAuth ? null : SplashPage.routeLocation;
    },

    routes: [
      GoRoute(
        path: SplashPage.routeLocation,
        name: SplashPage.routeName,
        builder: (context, state) {
          return const SplashPage();
        },
      ),
      GoRoute(
        path: MyHomePage.routeLocation,
        name: MyHomePage.routeName,
        builder: (context, state) {
          return const MyHomePage();
        },
      ),
      GoRoute(
        path: LoginPage.routeLocation,
        name: LoginPage.routeName,
        builder: (context, state) {
          return const LoginPage();
        },
      ),
    ],
  );
});
