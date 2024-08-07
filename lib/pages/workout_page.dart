import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker_app/enums/feeling.dart';
import '../theme.dart';
import '../models/workout.dart';
import '../widgets/exercise_entry_toggle_display_card.dart';
import 'package:gym_tracker_app/pages/workout_form.dart';

class WorkoutPage extends StatelessWidget {
  final Workout workout;
  const WorkoutPage({Key? key, required this.workout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            icon: Icon(Icons.arrow_back)),
        actions: [
          IconButton(
              onPressed: () => {
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context) => new WorkoutForm(
                          workout: workout,
                        ),
                      ),
                    )
                  },
              icon: Icon(Icons.edit)),
          IconButton(
              onPressed: () => {
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return AlertDialog(
                              title: Text("Delete workout?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .collection("workouts")
                                        .withConverter(
                                            fromFirestore:
                                                Workout.fromFirestore,
                                            toFirestore:
                                                (Workout workout, options) =>
                                                    workout.toFirestore())
                                        .doc(workout.doc_id)
                                        .delete()
                                        .then((value) => {
                                              print("workout deleted"),
                                              Navigator.popUntil(context,
                                                  ModalRoute.withName('/'))
                                            });
                                  },
                                  child: Text('Yes, delete'),
                                ),
                              ]);
                        }))
                  },
              icon: Icon(Icons.delete))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              workout.dateAndDuration(),
              style: TextStyle(color: accentBlue, fontSize: 20),
            ),
            Text(
              workout.title,
              style: TextStyle(
                  color: accentBlue,
                  fontSize: 36.0,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 8,
            ),
            if (workout.notes != null)
              Text(
                workout.notes!,
                style: TextStyle(
                  color: accentBlue,
                  fontSize: 16.0,
                ),
              ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                if (workout.feeling != null)
                  Icon(
                    feelingsMap[workout.feeling]!.icon,
                    color: accentBlue,
                    size: 32,
                  ),
                if (workout.feeling != null)
                  Text(
                    feelingsMap[workout.feeling]!.title,
                    style: TextStyle(
                      color: accentBlue,
                      fontSize: 20.0,
                    ),
                  )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Divider(),
            workout.exercises.isNotEmpty
                ? Column(
                    children: workout.exercises
                        .map((entry) => Column(
                              children: [
                                ExerciseEntryToggleDisplayCard(
                                    exerciseEntry: entry),
                                SizedBox(
                                  height: 8,
                                )
                              ],
                            ))
                        .toList())
                : Text("No exercises added to this workout.",
                    style: TextStyle(
                      color: disabledBlue,
                      fontSize: 20.0,
                    ))
          ],
        ),
      ),
    );
  }
}
