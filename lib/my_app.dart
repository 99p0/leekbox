import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leekbox/generated/l10n.dart';
import 'package:leekbox/routes/app_routes.dart';
import 'package:leekbox/theme/color_schemes.g.dart';
import 'package:leekbox_infra/log/log.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'pages/miui10_anim.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    final router = ref.watch(routerProvider);

    ///  是否 禁用
    return IgnorePointer(
      ignoring: false,

      ///  是否 置灰： 纪念某个时刻return
      child: ColorFiltered(
        colorFilter: const ColorFilter.mode(
          Colors.transparent,
          BlendMode.color,
        ),

        /// Toast 配置
        child: OKToast(
          position: ToastPosition.bottom,
          radius: 20,
          dismissOtherOnShow: true,
          movingOnWindowChange: false,
          textPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          animationCurve: Curves.easeIn,
          animationBuilder: const Miui10AnimBuilder(),
          animationDuration: const Duration(milliseconds: 200),

          /// ScreenUtil
          child: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            useInheritedMediaQuery: true,
            builder: (context, child) {
              /// 动态主题
              return DynamicColorBuilder(builder: (lightDynamic, darkDynamic) {
                /// app 入口
                return MaterialApp.router(
                  /// go_router
                  routerConfig: router,
                  // routeInformationParser: router.routeInformationParser,
                  // routerDelegate: router.routerDelegate,
                  // routeInformationProvider: router.routeInformationProvider,

                  /// theme use material 3
                  theme: ThemeData(
                    colorScheme: lightDynamic ?? lightColorScheme,
                    useMaterial3: true,
                  ),
                  darkTheme: ThemeData(
                    colorScheme: darkDynamic ?? darkColorScheme,
                    useMaterial3: true,
                  ),

                  /// localization
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    RefreshLocalizations.delegate,
                    S.delegate,
                  ],
                  supportedLocales: S.delegate.supportedLocales,

                  ///
                  debugShowCheckedModeBanner: false,

                  ///
                  title: '',

                  ///
                  builder: (BuildContext context, Widget? child) {
                    Log.debug('root builder...');
                    // 保证文字大小不受手机系统设置影响 防止UI变形
                    return MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        textScaleFactor: 1.0,
                      ),
                      child: GestureDetector(
                        onTap: () => _hideKeyboard(context),
                        child: child,
                      ),
                    );
                  },

                  /// others settings
                );
              });
            },
          ),
        ),
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
