import 'package:flutter/material.dart';

import 'my_app.dart';

void main() {
  /// License
  // LicenseRegistry.addLicense(() async* {
  ///  Google fonts Licensing Fonts
  // final license = await rootBundle.loadString('google_fonts/OFL.txt');
  // yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  // });

  /// 咸鱼 PowerImage图片库
  // PowerImageBinding();
  // PowerImageLoader.instance.setup(PowerImageSetupOptions(renderingTypeTexture,
  //     errorCallbackSamplingRate: null,
  //     errorCallback: (PowerImageLoadException exception) {}));

  // 初始 flutter 引擎
  // WidgetsFlutterBinding.ensureInitialized();

  // 初始
  // Get.put<GlobalService>(GlobalService());

  /// 是否已经登录：home or login
  // await initServices();

  ///
  runApp(const MyApp());
}

void initServices() async {}
