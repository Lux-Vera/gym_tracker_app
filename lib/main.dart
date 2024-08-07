import 'package:flutter/material.dart';
import 'package:gym_tracker_app/models/workout.dart';
import 'package:gym_tracker_app/pages/home_page.dart';
import 'theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './models/exercise.dart';
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

      // DEBUG add bunch of dummy exercises
      // List<Exercise> dummyExerciseList = [
      //   Exercise(
      //       name: 'Dips',
      //       targets: [Targets.chest, Targets.triceps, Targets.strength],
      //       goal: 10,
      //       pb: 1),
      //   Exercise(
      //       name: 'Push ups',
      //       targets: [
      //         Targets.chest,
      //         Targets.triceps,
      //         Targets.core,
      //         Targets.strength
      //       ],
      //       goal: 10,
      //       pb: 5),
      //   Exercise(
      //       name: 'Pistol Squats',
      //       targets: [
      //         Targets.hamstrings,
      //         Targets.strength,
      //         Targets.flexibility
      //       ],
      //       goal: 1,
      //       pb: 0),
      //   Exercise(name: 'Sit ups', targets: [Targets.core, Targets.strength]),
      //   Exercise(
      //       name: 'Box Jumps', targets: [Targets.cardio, Targets.hamstrings]),
      //   Exercise(
      //       name: 'Pull ups',
      //       targets: [Targets.back, Targets.triceps, Targets.strength],
      //       goal: 1,
      //       pb: 0),
      //   Exercise(
      //       name: 'Chin ups',
      //       targets: [Targets.back, Targets.biceps, Targets.strength],
      //       goal: 1,
      //       pb: 0),
      //   Exercise(
      //       name: 'Leg lifts',
      //       targets: [Targets.core, Targets.strength],
      //       pb: 20),
      // ];

      // dummyExerciseList.forEach((element) {
      //   docRef
      //       .collection("exercises")
      //       .withConverter(
      //           fromFirestore: Exercise.fromFirestore,
      //           toFirestore: (Exercise exercise, options) =>
      //               exercise.toFirestore())
      //       .add(element)
      //       .then((_) {
      //     print("exercise created");
      //   }).catchError((e) {
      //     print('an error occured $e');
      //   });
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
