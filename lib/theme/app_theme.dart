import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_schemes.g.dart';

class AppTheme {
  AppTheme._();

  //
  static ThemeData buildDarkTheme(darkDynamic) {
    var baseTheme = ThemeData(
      colorScheme: darkDynamic ?? darkColorScheme,
      useMaterial3: true,
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.nunitoTextTheme(baseTheme.textTheme),
    );
  }

  //
  static ThemeData buildLightTheme(lightDynamic) {
    var baseTheme = ThemeData(
      colorScheme: lightDynamic ?? lightColorScheme,
      useMaterial3: true,
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.nunitoTextTheme(baseTheme.textTheme),
    );
  }
}
