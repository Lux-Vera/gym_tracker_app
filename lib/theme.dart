import 'package:flutter/material.dart';

const Color lightBlue = Color(0xFFEDF2FB);
const Color disabledBlue = Color(0xFFABC4FF);
const Color accentBlue = Color(0xFF5286FF);
const Color white = Color(0xFFFFFFFF);
const Color accentOrange = Color(0xFFFC9E4F);

class GlobalThemData {
  // static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  // static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData = themeData();
  // static ThemeData darkThemeData = themeData(darkColorScheme, Colors.grey);

  static ThemeData themeData() {
    return ThemeData(
        textTheme:
            TextTheme().apply(bodyColor: accentBlue, displayColor: accentBlue),
        fontFamily: 'Lato',
        iconTheme: IconThemeData(color: accentBlue, size: 32),
        // colorScheme: colorScheme,
        appBarTheme: AppBarTheme(color: lightBlue, foregroundColor: accentBlue),
        canvasColor: lightBlue,
        scaffoldBackgroundColor: lightBlue,
        bottomAppBarColor: lightBlue,
        disabledColor: disabledBlue,
        highlightColor: Colors.transparent,
        dividerColor: disabledBlue,
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: accentOrange));
  }

  // static const ColorScheme lightColorScheme = ColorScheme(
  //   primary: accentOrange,
  //   onPrimary: accentBlue,
  //   secondary: accentOrange,
  //   onSecondary: white,
  //   error: Colors.redAccent,
  //   onError: white,
  //   background: lightBlue,
  //   onBackground: accentBlue,
  //   surface: white,
  //   onSurface: accentBlue,
  //   brightness: Brightness.light,
  // );

  // static const ColorScheme darkColorScheme = ColorScheme(
  //   primary: Color(0xFFFF8383),
  //   secondary: Color(0xFF4D1F7C),
  //   background: Color(0xFF241E30),
  //   surface: Color(0xFF1F1929),
  //   onBackground: Color(0x0DFFFFFF),
  //   error: Colors.redAccent,
  //   onError: Colors.white,
  //   onPrimary: Colors.white,
  //   onSecondary: Colors.white,
  //   onSurface: Colors.white,
  //   brightness: Brightness.dark,
  // );
}
