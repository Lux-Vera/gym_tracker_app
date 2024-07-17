import 'package:flutter/material.dart';
import 'package:gym_tracker_app/pages/home_page.dart';
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
      theme: GlobalThemeData.lightThemeData,
      // darkTheme: GlobalThemData.darkThemeData,
      home: MyHomePage(),
    );
  }
}
