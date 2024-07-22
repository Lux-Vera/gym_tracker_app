import 'package:flutter/material.dart';

const Color lightBlue = Color(0xFFEDF2FB);
const Color disabledBlue = Color(0xFFABC4FF);
const Color accentBlue = Color(0xFF5286FF);
const Color white = Color(0xFFFFFFFF);
const Color accentOrange = Color(0xFFFC9E4F);

class GlobalThemeData {
  // static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  // static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData = themeData(lightColorScheme);
  // static ThemeData darkThemeData = themeData(darkColorScheme, Colors.grey);

  static TextStyle lightTextStyle = TextStyle(
    fontFamily: 'Lato',
    color: accentBlue,
  );

  static TextStyle lightTextStyleOn =
      TextStyle(fontFamily: 'Lato', color: lightBlue);

  static TextStyle boldTextStyle = TextStyle(fontWeight: FontWeight.bold);
  static TextStyle textStyleSize16 = TextStyle(fontSize: 16);
  static TextStyle textStyleSize24 = TextStyle(fontSize: 24);

  static ThemeData themeData(ColorScheme colorScheme) {
    return ThemeData(
        textTheme:
            TextTheme().apply(bodyColor: accentBlue, displayColor: accentBlue),
        fontFamily: 'Lato',
        iconTheme: IconThemeData(color: accentBlue, size: 32),
        colorScheme: colorScheme,
        appBarTheme: AppBarTheme(color: lightBlue, foregroundColor: accentBlue),
        canvasColor: lightBlue,
        scaffoldBackgroundColor: lightBlue,
        bottomAppBarColor: lightBlue,
        disabledColor: disabledBlue,
        popupMenuTheme: PopupMenuThemeData(textStyle: lightTextStyle),
        dialogTheme: DialogTheme(
            backgroundColor: white,
            titleTextStyle:
                lightTextStyle.merge(boldTextStyle).merge(textStyleSize24),
            contentTextStyle: lightTextStyle.merge(textStyleSize16)),
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
          buttonColor: accentBlue,
        ),
        highlightColor: disabledBlue,
        dividerColor: disabledBlue,
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: accentOrange));
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: accentBlue,
    onPrimary: lightBlue,
    secondary: accentOrange,
    onSecondary: white,
    error: Colors.redAccent,
    onError: white,
    background: lightBlue,
    onBackground: accentBlue,
    surface: white,
    onSurface: accentBlue,
    brightness: Brightness.light,
  );

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
