import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leekbox/pages/login/login.dart';
import 'package:leekbox/pages/tongji/tongji.page.dart';
import 'package:leekbox/pages/setting/setting.page.dart';
import 'package:leekbox_infra/auth/stream_auth_scope.dart';

import '../error.page.dart';
import '../pages/my_home_page.dart';

class AppRoutes {
  // 用于路径路由(声明式路由)的常量, 路径不包含参数
  static const String homePath = '/'; // 根路由

  static const String settingPath = '/settings';
  static const String activityDetailPath = '/activity_detail';
  static const String searchPath = '/search';
  static const String loginPath = '/login';

  // 用于 命名路由的常量
  static const String homeNamed = 'home_page';
  static const String settingsNamed = 'setting_page';
  static const String activityDetailNamed = 'activity_detail_page';
  static const String searchNamed = 'search_page';

  static GoRouter router = GoRouter(
    debugLogDiagnostics: true,

    initialLocation: homePath, // 默认路由, 不指定这一荐时，默认路由为 '/'
    ///
    errorBuilder: (context, state) => ErrorPage(state.error!),

    ///
    routes: [
      GoRoute(
        // 不传递参数的路由项
        name: homeNamed, // 命名路由
        path: homePath, // 路径路由
        builder: (context, state) => const MyHomePage(),
      ),
      GoRoute(
        name: settingsNamed,
        path: settingPath,
        builder: (context, state) => SettingPage(),
      ),
      GoRoute(
        path: loginPath,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginPage(),
      ),
      GoRoute(
        // 传递参数方式1, 参数格式类似URL：/search?query=flutter
        name: searchNamed,
        path: searchPath,
        // 问号格式的参数，在路径中不需要包含参数信息

        // GoRouter.of(context).pushNamed(AppRoutes.searchNamed, queryParams: {'query': 'abcd'});
        // GoRouter.of(context).push('${AppRoutes.searchPath}?query=flutter');
        // GoRouter.of(context).go('/search?query=flutter');
        builder: (BuildContext context, GoRouterState state) {
          // state.queryParams 接收用问号隔开的参数
          final query = state.queryParams['query'];
          return SettingPage(); //query: query!
        },
      ),
      GoRoute(
        // 传递参数方式2, 参数格式：/activity_detail/123
        name: activityDetailNamed,
        path: '$activityDetailPath/:id',
        // 位置格式的参数，参数要包含在路径中

        // GoRouter.of(context).pushNamed(AppRoutes.searchNamed, params: {'query': 'abcd'});
        // GoRouter.of(context).push('${AppRoutes.activityDetailPath}/654321');
        // GoRouter.of(context).go('/activity_detail/654321');
        builder: (BuildContext context, GoRouterState state) {
          // state.params 接收 `/` 隔开的参数(按位置)
          final id = state.params['id']!;
          return SettingPage(); //id: id
        },
      ),
    ],

    // redirect to the login page if the user is not logged in
    redirect: (BuildContext context, GoRouterState state) async {
      // Using `of` method creates a dependency of StreamAuthScope. It will
      // cause go_router to reparse current route if StreamAuth has new sign-in
      // information.
      final bool loggedIn = await StreamAuthScope.of(context).isSignedIn();
      final bool loggingIn = state.subloc == loginPath;
      if (!loggedIn) {
        return loggingIn ? null : loginPath;
      }

      // if the user is logged in but still on the login page, send them to
      // the home page
      if (loggingIn) {
        return '/';
      }

      // no need to redirect at all
      return null;
    },
  );
}
