class FontUtil {
  factory FontUtil() {
    return _singleton;
  }

  FontUtil._internal();
  static final FontUtil _singleton = FontUtil._internal();

  // static Future<bool> downloadFontAndLoad(
  //     String fontFamily, String fontFamilyUrl) async {
  //   if (TextUtil.isEmpty(fontFamilyUrl) || TextUtil.isEmpty(fontFamilyUrl)) {
  //     return false;
  //   }
  //   //加载本地字体到app中: only (OTF)(TTF)
  //   Future<void> loadFontToApp(String path) async {
  //     try {
  //       var fontLoader = FontLoader(fontFamily);
  //       Future<ByteData> _byteData = File(path).readAsBytes().then((value) {
  //         return value.buffer.asByteData();
  //       });
  //       fontLoader.addFont(_byteData);
  //       await fontLoader.load();
  //     } catch (e) {
  //       print(e);
  //     }
  //   }
  //
  //   File ttfFile = await FileUtil.getFilePath("ttf/", fontFamily);
  //   //如果本地已经存在这个字体,则加载本地
  //   if (ttfFile.existsSync()) {
  //     await loadFontToApp(ttfFile.path);
  //     return true;
  //   }
  //
  //   String newTTFFile = await FileUtil.createFile2(ttfFile);
  //   String localFontFile =
  //       await DownFileUtil.down(fontFamilyUrl, newTTFFile); //检查是否需要本地下载字体
  //   await loadFontToApp(localFontFile);
  //   return true;
  // }
}
