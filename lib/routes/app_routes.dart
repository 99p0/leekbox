import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:leekbox/pages/error.page.dart';
import 'package:leekbox/pages/home/my_home_page.dart';
import 'package:leekbox/pages/login/login.dart';
import 'package:leekbox/pages/splash/intro/introduction_animation_screen.dart';
import 'package:leekbox/pages/splash/privacy_policy_page.dart';
import 'package:leekbox/pages/splash/splash_screen.dart';
import 'package:leekbox/routes/auth.dart';

final _key = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  ref.watch(authProvider);
  final authNotifier = ref.read(authProvider.notifier);

  final noAuthPages = [
    SplashPage.routeLocation,
    IntroScreen.routeLocation,
    PrivacyPolicyPage.routeLocation,
  ];

  return GoRouter(
    navigatorKey: _key,
    debugLogDiagnostics: true,
    initialLocation: SplashPage.routeLocation,
    errorBuilder: (context, state) => const ErrorPage(),
    redirect: (context, state) {
      // If our async state is loading, don't perform redirects, yet
      if (authNotifier.isLoading) return null;

      //
      if (noAuthPages.contains(state.location)) {
        return null;
      }
      final isAuth = authNotifier.isAuthenticated;
      // 登录页
      final isLoggingIn = state.location == LoginPage.routeLocation;
      if (isLoggingIn) {
        return isAuth ? MyHomePage.routeLocation : null;
      }

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
        path: IntroScreen.routeLocation,
        name: IntroScreen.routeName,
        builder: (context, state) {
          return const IntroScreen();
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
