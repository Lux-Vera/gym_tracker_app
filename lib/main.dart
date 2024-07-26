import 'package:flutter/material.dart';
import 'package:gym_tracker_app/pages/home_page.dart';
import 'theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';

void main() {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // FirebaseAnalytics analytics = FirebaseAnalytics.instance;
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
