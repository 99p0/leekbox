import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leekbox/lang/translation_service.dart';
import 'package:leekbox/pages/miui10_anim.dart';
import 'package:leekbox/routes/app_pages.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'theme/color_schemes.g.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// app 是否 置灰： 纪念某个时刻
    return ColorFiltered(
      colorFilter: const ColorFilter.mode(
        Colors.transparent, // Colors.grey
        BlendMode.color,
      ),

      /// Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
      child: ScreenUtilInit(
          // designSize: const Size(750, 1334),
          minTextAdapt: true,
          splitScreenMode: true,
          // 禁止跟随系统变化
          useInheritedMediaQuery: true,
          builder: (context, child) {
            /// 下拉刷新 全剧控制
            return OKToast(
              // 2-A: wrap your app with OKToast
              // textStyle: const TextStyle(fontSize: 19.0, color: Colors.white),
              backgroundColor: Colors.grey,
              animationCurve: Curves.easeIn,
              animationBuilder: const Miui10AnimBuilder(),
              animationDuration: const Duration(milliseconds: 200),
              duration: const Duration(seconds: 3),

              /// 全剧下拉配置
              child: refreshScaffold(
                /// dynamic color
                child: DynamicColorBuilder(
                  builder: (lightDynamic, darkDynamic) {
                    /// 全局toast
                    return GetMaterialApp(
                      // 开发配置
                      debugShowCheckedModeBanner: false,

                      /// theme use material 3
                      theme: ThemeData(
                        colorScheme: lightDynamic ?? lightColorScheme,
                        useMaterial3: true,
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                      ),
                      darkTheme: ThemeData(
                        colorScheme: darkDynamic ?? darkColorScheme,
                        useMaterial3: true,
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                      ),
                      themeMode: ThemeMode.system,

                      ///
                      initialRoute: AppPages.INITIAL,
                      getPages: AppPages.routes,

                      ///
                      enableLog: true,
                      defaultTransition: Transition.fade,
                      opaqueRoute: Get.isOpaqueRouteDefault,
                      popGesture: Get.isPopGestureEnable,

                      /// i18n
                      locale: TranslationService.locale,
                      fallbackLocale: TranslationService.fallbackLocale,
                      translations: TranslationService(),
                      localizationsDelegates: const [
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                        RefreshLocalizations.delegate,
                      ],
                      supportedLocales: const [
                        Locale('zh'),
                        Locale('en', ''),
                      ],
                    );
                  },
                ),
              ),
            );
          }),
    );
  }

  /// 下拉刷新全局配置
  Widget refreshScaffold({required Widget child}) => RefreshConfiguration(
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
}
