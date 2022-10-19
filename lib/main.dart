import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logging/logging.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'app_routes.dart';
import 'color_schemes.g.dart';

void main() {
  /// Licensing Fonts
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  /// 日志
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  ///
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          /// 下拉刷新 全剧控制
          return refreshScaffold(
            /// dynamic color
            child: DynamicColorBuilder(
              builder: (lightDynamic, darkDynamic) {
                return MaterialApp.router(
                  //
                  debugShowCheckedModeBanner: kDebugMode,
                  title: '',

                  /// use go_router
                  routerConfig: AppRoutes.router,

                  /// use material 3
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

                  ///
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
          );
        });
  }

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
