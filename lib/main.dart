import 'dart:async';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leekbox/pages/miui10_anim.dart';
import 'package:leekbox_sdk/log.dart';
import 'package:oktoast/oktoast.dart';
import 'package:power_image/power_image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'app_routes.dart';
import 'color_schemes.g.dart';
import 'my_app.dart';

void main() {
  runZonedGuarded(() async {
    ///
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
      Log.debug(details);
      // 生产模式：上传统计
      if (kReleaseMode) {
        // 。。。
      }
    };

    ///  Google fonts Licensing Fonts
    LicenseRegistry.addLicense(() async* {
      final license = await rootBundle.loadString('google_fonts/OFL.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    });

    /// 咸鱼 PowerImage图片库
    PowerImageBinding();
    PowerImageLoader.instance.setup(PowerImageSetupOptions(renderingTypeTexture,
        errorCallbackSamplingRate: null,
        errorCallback: (PowerImageLoadException exception) {}));

    ///
    runApp(const MyApp());
  }, (error, stackTrace) async {
    Log.error(error);
  });
}

Future<void> init() async {
  // do somethings
}
