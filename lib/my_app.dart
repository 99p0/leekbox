import 'dart:ui';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:leekbox/common/widgets/app_scroll_behavior.dart';
import 'package:leekbox/generated/l10n.dart';
import 'package:leekbox/routes/app_routes.dart';
import 'package:leekbox/theme/app_theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    final router = ref.watch(routerProvider);

    /// 动态主题 + go_router + SmartDialog
    final baseApp = DynamicColorBuilder(builder: (lightDynamic, darkDynamic) {
      return MaterialApp.router(
        /// go_router
        routerConfig: router,

        /// theme use material 3
        theme: AppTheme.buildLightTheme(lightDynamic),
        darkTheme: AppTheme.buildDarkTheme(darkDynamic),

        /// localization
        localizationsDelegates: const [
          //
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          //
          RefreshLocalizations.delegate,

          S.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,

        ///
        title: S.of(context).title,
        debugShowCheckedModeBanner: false,

        ///
        scrollBehavior: CustomScrollBehaviour(),

        ///
        builder: FlutterSmartDialog.init(
          builder: (context, widget) {
            return MediaQuery(
              /// Setting font does not change with system font size
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),

              /// app scroll
              child: ScrollConfiguration(
                behavior: AppScrollBehavior(),
                child: widget!,
              ),
            );
          },
        ),

        /// others settings
      );
    });

    ///  是否置灰：纪念某个时刻
    return ColorFiltered(
      colorFilter: const ColorFilter.mode(Colors.transparent, BlendMode.color),

      ///  配置ScreenUtil
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        // 分屏
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (context, child) {
          return baseApp;
        },
      ),
    );
  }

  /// 下拉刷新全局配置
  Widget _refreshScaffold({required Widget child}) => RefreshConfiguration(
        // 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
        headerBuilder: () => const WaterDropHeader(),
        // 配置默认底部指示器
        footerBuilder: () => const ClassicFooter(),
        // 头部触发刷新的越界距离
        headerTriggerDistance: 80.0,
        // 自定义回弹动画,三个属性值意义请查询flutter api
        springDescription:
            const SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
        //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
        maxOverScrollExtent: 100,
        // 底部最大可以拖动的范围
        maxUnderScrollExtent: 0,
        //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
        enableScrollWhenRefreshCompleted: true,
        //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
        enableLoadingWhenFailed: true,
        // Viewport不满一屏时,禁用上拉加载更多功能
        hideFooterWhenNotFull: false,
        // 可以通过惯性滑动触发加载更多
        enableBallisticLoad: true,
        child: child,
      );

  ///
  void _hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}

class CustomScrollBehaviour extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
