import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:leekbox/pages/developer/dashboard.dart';
import 'package:leekbox/pages/developer/device_info.dart';
import 'package:leekbox/pages/exception/connection.exception.page.dart';
import 'package:leekbox/pages/home/my_home_page.dart';
import 'package:leekbox/pages/home/not_login_homepage.dart';
import 'package:leekbox/pages/login/login.dart';
import 'package:leekbox/pages/mine/card_package.page.dart';
import 'package:leekbox/pages/mine/moneybags.page.dart';
import 'package:leekbox/pages/mine/user_profile.page.dart';
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

import '../state/auth.dart';

/// This notifier is meant to implement the [Listenable] our [GoRouter] needs.
///
/// We aim to trigger redirects whenever's needed.
/// This is done by calling our (only) listener everytime we want to notify stuff.
/// This allows to centralize global redirecting logic in this class.
/// In this simple case, we just listen to auth changes.
///
/// SIDE NOTE.
/// This might look overcomplicated at a first glance;
/// Instead, this method aims to follow some good some good practices:
///   1. It doesn't require us to pipe down any `ref` parameter
///   2. It works as a complete replacement for [ChangeNotifier] (it's a [Listenable] implementation)
///   3. It allows for listening to multiple providers if needed (we do have a [Ref] now!)
class RouterNotifier extends AutoDisposeAsyncNotifier<void>
    implements Listenable {
  VoidCallback? routerListener;
  bool isAuth = false; // Useful for our global redirect functio

  @override
  Future<void> build() async {
    // One could watch more providers and write logic accordingly

    isAuth = await ref.watch(
      authNotifierProvider.selectAsync((data) => data != null),
    );

    ref.listenSelf((_, __) {
      // One could write more conditional logic for when to call redirection
      if (state.isLoading) return;
      routerListener?.call();
    });
  }

  /// ???????????????????????????????????????
  final noAuthPages = [
    SplashPage.routeLocation,
    IntroScreen.routeLocation,
    PrivacyPolicyPage.routeLocation,
  ];

  /// Redirects the user when our authentication changes
  String? redirect(BuildContext context, GoRouterState state) {
    if (this.state.isLoading) return null;
    //
    if (noAuthPages.contains(state.location)) return null;

    // ???????????????
    final isLoggingIn = state.location == LoginPage.routeLocation;

    // ????????????????????????????????? /login?????????????????????
    // ??????????????????????????? /login??????????????????????????????
    if (isLoggingIn) return isAuth ? MyHomePage.routeLocation : null;

    // ??????????????????????????????????????????????????????????????????
    return isAuth ? null : LoginPage.routeLocation;
  }

  /// Our application routes. Obtained through code generation
  List<GoRoute> get routes => [
        //
        GoRoute(
          path: SplashPage.routeLocation,
          name: SplashPage.routeName,
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: LoginPage.routeLocation,
          name: LoginPage.routeName,
          builder: (context, state) {
            // ??????????????? location ??? LoginScreen (?????????)
            return LoginPage(from: state.queryParams['from']);
          },
        ),
        GoRoute(
          path: MyHomePage.routeLocation,
          name: MyHomePage.routeName,
          builder: (context, state) => const MyHomePage(),
        ),

        ///
        GoRoute(
          path: UserProfilePage.routeLocation,
          name: UserProfilePage.routeName,
          builder: (context, state) => const UserProfilePage(),
        ),

        ///
        GoRoute(
          path: ConnectionExceptionPage.routeLocation,
          name: ConnectionExceptionPage.routeName,
          builder: (context, state) => const ConnectionExceptionPage(),
        ),
        GoRoute(
          path: DeviceInfoPage.routeLocation,
          name: DeviceInfoPage.routeName,
          builder: (context, state) => const DeviceInfoPage(),
        ),
        GoRoute(
          path: DashboardPage.routeLocation,
          name: DashboardPage.routeName,
          builder: (context, state) => const DashboardPage(),
        ),
        GoRoute(
          path: NoticePage.routeLocation,
          name: NoticePage.routeName,
          builder: (context, state) => const NoticePage(),
        ),
        GoRoute(
          path: RecentNoticePage.routeLocation,
          name: RecentNoticePage.routeName,
          builder: (context, state) => const RecentNoticePage(),
        ),

        /// ?????????
        GoRoute(
          path: LanguagesPage.routeLocation,
          name: LanguagesPage.routeName,
          builder: (context, state) => const LanguagesPage(),
        ),
        // ?????????????????????
        GoRoute(
          path: FontsPage.routeLocation,
          name: FontsPage.routeName,
          builder: (context, state) => const FontsPage(),
        ),
        // ????????????
        GoRoute(
          path: ColorSchemePage.routeLocation,
          name: ColorSchemePage.routeName,
          builder: (context, state) => const ColorSchemePage(),
        ),
        // ????????????
        GoRoute(
          path: ThemesPage.routeLocation,
          name: ThemesPage.routeName,
          builder: (context, state) => const ThemesPage(),
        ),
        // ????????????
        GoRoute(
          path: HomePageManagePage.routeLocation,
          name: HomePageManagePage.routeName,
          builder: (context, state) => const HomePageManagePage(),
        ),
        // ????????????
        GoRoute(
          path: StorageManagePage.routeLocation,
          name: StorageManagePage.routeName,
          builder: (context, state) => const StorageManagePage(),
        ),

        /// ???????????????
        GoRoute(
          path: AccountAndSecurityPage.routeLocation,
          name: AccountAndSecurityPage.routeName,
          builder: (context, state) => const AccountAndSecurityPage(),
        ),
        // ???????????????
        GoRoute(
          path: NewNotificationPage.routeLocation,
          name: NewNotificationPage.routeName,
          builder: (context, state) => const NewNotificationPage(),
        ),
        // ??????
        GoRoute(
          path: PrivacyPage.routeLocation,
          name: PrivacyPage.routeName,
          builder: (context, state) => const PrivacyPage(),
        ),
        GoRoute(
          path: GeneralSettingPage.routeLocation,
          name: GeneralSettingPage.routeName,
          builder: (context, state) => const GeneralSettingPage(),
        ),
        // ???????????????
        GoRoute(
          path: HelpPage.routeLocation,
          name: HelpPage.routeName,
          builder: (context, state) => const HelpPage(),
        ),
        // ??????
        GoRoute(
          path: AboutPage.routeLocation,
          name: AboutPage.routeName,
          builder: (context, state) => const AboutPage(),
        ),

        ///
        GoRoute(
          path: MoneybagsPage.routeLocation,
          name: MoneybagsPage.routeName,
          builder: (context, state) => const MoneybagsPage(),
        ),
        GoRoute(
          path: VipIntroPage.routeLocation,
          name: VipIntroPage.routeName,
          builder: (context, state) => const VipIntroPage(),
        ),
        GoRoute(
          path: CardPackagePage.routeLocation,
          name: CardPackagePage.routeName,
          builder: (context, state) => const CardPackagePage(),
        ),
        GoRoute(
          path: SettingPage.routeLocation,
          name: SettingPage.routeName,
          builder: (context, state) => const SettingPage(),
        ),

        /// ?????????
        GoRoute(
          path: PrivacyPolicyPage.routeLocation,
          name: PrivacyPolicyPage.routeName,
          builder: (context, state) => const PrivacyPolicyPage(),
        ),
        // ????????????
        GoRoute(
          path: IntroScreen.routeLocation,
          name: IntroScreen.routeName,
          builder: (context, state) => const IntroScreen(),
        ),

        /// ????????????????????????
        GoRoute(
          path: NotLoggedInHomePage.routeLocation,
          name: NotLoggedInHomePage.routeName,
          builder: (context, state) => const NotLoggedInHomePage(),
        ),
      ];

  /// Adds [GoRouter]'s listener as specified by its [Listenable].
  /// [GoRouteInformationProvider] uses this method on creation to handle its
  /// internal [ChangeNotifier].
  /// Check out the internal implementation of [GoRouter] and
  /// [GoRouteInformationProvider] to see this in action.
  @override
  void addListener(VoidCallback listener) {
    routerListener = listener;
  }

  /// Removes [GoRouter]'s listener as specified by its [Listenable].
  /// [GoRouteInformationProvider] uses this method when disposing,
  /// so that it removes its callback when destroyed.
  /// Check out the internal implementation of [GoRouter] and
  /// [GoRouteInformationProvider] to see this in action.
  @override
  void removeListener(VoidCallback listener) {
    routerListener = null;
  }
}

final routerNotifierProvider =
    AutoDisposeAsyncNotifierProvider<RouterNotifier, void>(() {
  return RouterNotifier();
});

/// A simple extension to determine wherever should we redirect our users
// extension RedirecttionBasedOnRole on UserRole {
//   String? redirectBasedOn(String location) {
//     switch (this) {
//       case UserRole.user:
//         return null;
//       case UserRole.guest:
//       case UserRole.none:
//         if (location != NotLoggedInHomePage.routeLocation) {
//           return NotLoggedInHomePage.routeLocation;
//         }
//         return null;
//     }
//   }
// }
