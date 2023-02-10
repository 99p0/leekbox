import 'dart:async';
import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leekbox/my_app.dart';
import 'package:leekbox_infra/log/log.dart';

void main() {
  runZonedGuarded(() async {
    ///
    WidgetsFlutterBinding.ensureInitialized();

    /// 咸鱼 PowerImage图片库
    // PowerImageBinding();
    // PowerImageLoader.instance.setup(PowerImageSetupOptions(renderingTypeTexture,
    //     errorCallbackSamplingRate: null,
    //     errorCallback: (PowerImageLoadException exception) {
    //   Log.error(exception);
    // }));

    // await SpUtil.getInstance();

    // 全屏模式 SystemUiMode.edgeToEdge
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // 竖屏模式：just now
    await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);

    ///
    runApp(
      ProviderScope(
        child: DevicePreview(
          enabled: false, //kDebugMode,
          builder: (context) => const MyApp(),
        ),
      ),
    );

    ///
    if (Platform.isAndroid) {
      // 透明沉浸式状态栏
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ));
    }

    // 在输入频率与显示刷新率不匹配情况下提供平滑的滚动效果 :: 后遗症：这个方法会带来巨大的输入延迟，而且可能看起来不对劲
    GestureBinding.instance.resamplingEnabled = true;

    /// License
    // LicenseRegistry.addLicense(() async* {
    //   // Google fonts Licensing Fonts
    //   final license = await rootBundle.loadString('google_fonts/OFL.txt');
    //   yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    // });

    /// do others
  }, (Object obj, StackTrace stack) {
    Log.error('obj:: $obj');
    Log.error('stack:: $stack');
  });
}

void initServices() async {}
