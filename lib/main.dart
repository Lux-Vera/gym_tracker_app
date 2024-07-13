import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym Tracker',
      themeMode: ThemeMode.light, //or ThemeMode.dark
      theme: GlobalThemData.lightThemeData,
      darkTheme: GlobalThemData.darkThemeData,
      home: MyHomePage(),
    );
  }
}
