import 'package:flutter/material.dart';

import 'color_schemes.g.dart';

class AppTheme {
  AppTheme._();

  //  use material 3
  static ThemeData buildDarkTheme() {
    var baseTheme = ThemeData(
      colorScheme: darkColorScheme,
      useMaterial3: true,
    );

    return baseTheme.copyWith(
        // textTheme: GoogleFonts.nunitoTextTheme(baseTheme.textTheme),
        );
  }

  //  use material 3
  static ThemeData buildLightTheme() {
    var baseTheme = ThemeData(
      colorScheme: lightColorScheme,
      useMaterial3: true,
    );

    return baseTheme.copyWith(
        // textTheme: GoogleFonts.nunitoTextTheme(baseTheme.textTheme),
        );
  }
}
