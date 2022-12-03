import 'dart:async';
import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leekbox/my_app.dart';

void main() {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();

    /// License
    // LicenseRegistry.addLicense(() async* {
    //   // Google fonts Licensing Fonts
    //   final license = await rootBundle.loadString('google_fonts/OFL.txt');
    //   yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    // });

    /// 咸鱼 PowerImage图片库
    // PowerImageBinding();
    // PowerImageLoader.instance.setup(PowerImageSetupOptions(renderingTypeTexture,
    //     errorCallbackSamplingRate: null,
    //     errorCallback: (PowerImageLoadException exception) {
    //   Log.error(exception);
    // }));

    // await SpUtil.getInstance();

    ///
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    ///
    runApp(
      ProviderScope(
        child: DevicePreview(
          enabled: kDebugMode,
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

    /// 屏幕刷新率和显示率不一致时的优化，必须挪动到 runApp 之后
    GestureBinding.instance.resamplingEnabled = true;

    /// do others
  }, (Object obj, StackTrace stack) {
    print(obj);
    print(stack);
  });
}

void initServices() async {}
