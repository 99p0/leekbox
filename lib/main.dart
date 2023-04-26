import 'dart:async';
import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:leekbox/common/global.dart';
import 'package:leekbox/common/services/notification_service.dart';
import 'package:leekbox/common/utils/state_logger.dart';
import 'package:leekbox/my_app.dart';
import 'package:leekbox_infra/log/log.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:window_manager/window_manager.dart';

bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

Future<void> _configureLocalTimeZone() async {
  if (kIsWeb || Platform.isLinux) {
    return;
  }
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName!));
}

/// only： TTF，OTF
Future<void> _loadFonts() async {
  await Future.wait([
    // 金额数字
    rootBundle.load('assets/fonts/DIN-Pro-Regular.otf').then(
      (data) {
        final font = FontLoader('DINPro');
        font.addFont(Future.value(data));
        return font.load();
      },
    ),
    // 时间字体
    rootBundle.load('assets/fonts/digital-7.ttf').then(
      (data) {
        final font = FontLoader('Digital7');
        font.addFont(Future.value(data));
        return font.load();
      },
    ),
  ]);
}

void main() {
  runZonedGuarded(() async {
    /// use 'flutter_native_splash' packages build Splash view
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    ///
    await _configureLocalTimeZone();
    await NotificationService().init();

    /// 咸鱼 PowerImage图片库
    // PowerImageBinding();
    // PowerImageLoader.instance.setup(PowerImageSetupOptions(renderingTypeTexture,
    //     errorCallbackSamplingRate: null,
    //     errorCallback: (PowerImageLoadException exception) {
    //   Log.error(exception);
    // }));

    // setPathUrlStrategy();

    /// 加载字体
    await _loadFonts();

    /// desktop
    if (isDesktop) {
      await windowManager.ensureInitialized();

      WindowOptions windowOptions = const WindowOptions(
        size: Size(1200, 800),
        center: true,
        backgroundColor: Colors.transparent,
        skipTaskbar: false,
        titleBarStyle: TitleBarStyle.hidden,
      );
      windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.show();
        await windowManager.focus();
      });
    }

    /// 全屏模式 SystemUiMode.edgeToEdge
    // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    /// 竖屏模式：just now
    // await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    //   DeviceOrientation.portraitUp,
    // ]);

    /// License
    LicenseRegistry.addLicense(() async* {
      // Google fonts Licensing Fonts
      final license = await rootBundle.loadString('google_fonts/OFL.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    });

    /// 初始化完成后 加载UI
    Global.init().then((e) => runApp(
          ProviderScope(
            observers: const [
              StateLogger(),
            ],
            // 开发模式
            child: DevicePreview(
              enabled: false, //kDebugMode,
              builder: (context) => const MyApp(),
            ),
          ),
        ));

    ///
    if (Platform.isAndroid) {
      // 透明沉浸式状态栏
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ));
    }

    // 在输入频率与显示刷新率不匹配情况下提供平滑的滚动效果 :: 后遗症：这个方法会带来巨大的输入延迟，而且可能看起来不对劲
    // GestureBinding.instance.resamplingEnabled = true;

    /// do others
  }, (Object obj, StackTrace stack) {
    Log.error('obj:: $obj');
    Log.error('stack:: $stack');
  });
}
