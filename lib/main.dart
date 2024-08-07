import 'package:flutter/material.dart';
import 'package:gym_tracker_app/models/workout.dart';
import 'package:gym_tracker_app/pages/home_page.dart';
import 'theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth.instance.idTokenChanges().listen((User? user) async {
    if (user == null) {
      print('User is currently signed out!');
      print('Signing in verisez ...');
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: "verisez@gmail.com", password: "password");
    } else {
      print('User is signed in!');
      print(user.uid);
      final docRef = db.collection("users").doc(user.uid);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          print(data["Name"]);
          // ...
        },
        onError: (e) => print("Error getting document: $e"),
      );

      // DEBUG : add dummy exercise
      // final workout = new Workout(
      //     title: "Arm sesh", dateTime: DateTime.now(), exercises: []);
      // docRef
      //     .collection("workouts")
      //     .withConverter(
      //         fromFirestore: Workout.fromFirestore,
      //         toFirestore: (Workout workout, options) => workout.toFirestore())
      //     .add(workout)
      //     .then((_) {
      //   print("collection created");
      // }).catchError((e) {
      //   print('an error occured $e');
      // });
    }
  });

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
