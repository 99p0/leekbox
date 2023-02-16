import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:leekbox/pages/developer/dashboard.dart';
import 'package:leekbox/pages/developer/device_info.dart';
import 'package:leekbox/pages/error.page.dart';
import 'package:leekbox/pages/home/my_home_page.dart';
import 'package:leekbox/pages/login/login.dart';
import 'package:leekbox/pages/mine/card_package.page.dart';
import 'package:leekbox/pages/mine/moneybags.page.dart';
import 'package:leekbox/pages/mine/vip_intro.page.dart';
import 'package:leekbox/pages/notice/notice.page.dart';
import 'package:leekbox/pages/notice/recent_notice.dart';
import 'package:leekbox/pages/setting/about.page.dart';
import 'package:leekbox/pages/setting/account_security.page.dart';
import 'package:leekbox/pages/setting/general.setting.dart';
import 'package:leekbox/pages/setting/general/color_scheme.page.dart';
import 'package:leekbox/pages/setting/general/font.page.dart';
import 'package:leekbox/pages/setting/general/home_page_manage.page.dart';
import 'package:leekbox/pages/setting/general/language.page.dart';
import 'package:leekbox/pages/setting/general/storage_manage.page.dart';
import 'package:leekbox/pages/setting/general/themes.page.dart';
import 'package:leekbox/pages/setting/help.page.dart';
import 'package:leekbox/pages/setting/new_notification.page.dart';
import 'package:leekbox/pages/setting/privacy.page.dart';
import 'package:leekbox/pages/setting/setting.page.dart';
import 'package:leekbox/pages/splash/intro/introduction_animation_screen.dart';
import 'package:leekbox/pages/splash/privacy_policy_page.dart';
import 'package:leekbox/pages/splash/splash_screen.dart';
import 'package:leekbox/routes/auth.dart';
import 'package:leekbox_infra/log/log.dart';

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
    redirect: (context, state) async {
      // If our async state is loading, don't perform redirects, yet
      if (authNotifier.isLoading) return null;

      Log.debug('state.location:: ${state.location}');
      //
      if (noAuthPages.contains(state.location)) {
        return null;
      }
      final isAuth = authNotifier.isAuthenticated;
      Log.debug('isAuth:: $isAuth');
      // 登录页
      final isLoggingIn = state.location == LoginPage.routeLocation;
      Log.debug('isLoggingIn:: $isLoggingIn ');
      if (isLoggingIn) {
        return isAuth ? MyHomePage.routeLocation : null;
      }
      return isAuth ? null : MyHomePage.routeLocation;
    },
    routes: [
      GoRoute(
        path: DeviceInfoPage.routeLocation,
        name: DeviceInfoPage.routeName,
        builder: (context, state) {
          return const DeviceInfoPage();
        },
      ),
      GoRoute(
        path: DashboardPage.routeLocation,
        name: DashboardPage.routeName,
        builder: (context, state) {
          return const DashboardPage();
        },
      ),
      GoRoute(
        path: NoticePage.routeLocation,
        name: NoticePage.routeName,
        builder: (context, state) {
          return const NoticePage();
        },
      ),
      GoRoute(
        path: RecentNoticePage.routeLocation,
        name: RecentNoticePage.routeName,
        builder: (context, state) {
          return const RecentNoticePage();
        },
      ),

      // ********** ********
      // 多语言
      GoRoute(
        path: LanguagesPage.routeLocation,
        name: LanguagesPage.routeName,
        builder: (context, state) {
          return const LanguagesPage();
        },
      ),
      // 字体风格与大小
      GoRoute(
        path: FontsPage.routeLocation,
        name: FontsPage.routeName,
        builder: (context, state) {
          return const FontsPage();
        },
      ),
      // 深色模式
      GoRoute(
        path: ColorSchemePage.routeLocation,
        name: ColorSchemePage.routeName,
        builder: (context, state) {
          return const ColorSchemePage();
        },
      ),
      // 主题风格
      GoRoute(
        path: ThemesPage.routeLocation,
        name: ThemesPage.routeName,
        builder: (context, state) {
          return const ThemesPage();
        },
      ),
      // 首页管理
      GoRoute(
        path: HomePageManagePage.routeLocation,
        name: HomePageManagePage.routeName,
        builder: (context, state) {
          return const HomePageManagePage();
        },
      ),
      // 存储空间
      GoRoute(
        path: StorageManagePage.routeLocation,
        name: StorageManagePage.routeName,
        builder: (context, state) {
          return const StorageManagePage();
        },
      ),
      // ********** ********
      // ********** ********
      // 账户与安全
      GoRoute(
        path: AccountAndSecurityPage.routeLocation,
        name: AccountAndSecurityPage.routeName,
        builder: (context, state) {
          return const AccountAndSecurityPage();
        },
      ),
      // 新消息通知
      GoRoute(
        path: NewNotificationPage.routeLocation,
        name: NewNotificationPage.routeName,
        builder: (context, state) {
          return const NewNotificationPage();
        },
      ),
      // 隐私
      GoRoute(
        path: PrivacyPage.routeLocation,
        name: PrivacyPage.routeName,
        builder: (context, state) {
          return const PrivacyPage();
        },
      ),
      GoRoute(
        path: GeneralSettingPage.routeLocation,
        name: GeneralSettingPage.routeName,
        builder: (context, state) {
          return const GeneralSettingPage();
        },
      ),
      // 帮助与反馈
      GoRoute(
        path: HelpPage.routeLocation,
        name: HelpPage.routeName,
        builder: (context, state) {
          return const HelpPage();
        },
      ),
      // 关于
      GoRoute(
        path: AboutPage.routeLocation,
        name: AboutPage.routeName,
        builder: (context, state) {
          return const AboutPage();
        },
      ),
      // ********** ********
      // ********** ********
      GoRoute(
        path: MoneybagsPage.routeLocation,
        name: MoneybagsPage.routeName,
        builder: (context, state) {
          return const MoneybagsPage();
        },
      ),
      GoRoute(
        path: VipIntroPage.routeLocation,
        name: VipIntroPage.routeName,
        builder: (context, state) {
          return const VipIntroPage();
        },
      ),
      GoRoute(
        path: CardPackagePage.routeLocation,
        name: CardPackagePage.routeName,
        builder: (context, state) {
          return const CardPackagePage();
        },
      ),
      GoRoute(
        path: SettingPage.routeLocation,
        name: SettingPage.routeName,
        builder: (context, state) {
          return const SettingPage();
        },
      ),
      // ********** ********
      GoRoute(
        path: MyHomePage.routeLocation,
        name: MyHomePage.routeName,
        builder: (context, state) {
          return const MyHomePage();
        },
        routes: [],
      ),
      GoRoute(
        path: PrivacyPolicyPage.routeLocation,
        name: PrivacyPolicyPage.routeName,
        builder: (context, state) {
          return const PrivacyPolicyPage();
        },
      ),

      //
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
        path: LoginPage.routeLocation,
        name: LoginPage.routeName,
        builder: (context, state) {
          return const LoginPage();
        },
      ),
    ],
  );
});
