import 'package:flutter/material.dart';
import '../colors.dart';

class Exercise {
  final String name;

  Exercise(this.name);
}

class Set {
  final int reps;
  final int weight;

  Set(this.reps, this.weight);
}

enum Feeling { easy, medium, challenging, dead }

class ExerciseEntry {
  final Exercise exercise;
  final List<Set> sets;
  final Feeling? feeling;
  final String? notes;

  ExerciseEntry(this.exercise, this.sets, {this.feeling, this.notes});
}

class Workout {
  final String title;
  final DateTime dateTime;
  final List<ExerciseEntry> exercises;

  Workout(this.title, this.dateTime, this.exercises);
}

class WorkoutListItem extends StatelessWidget {
  final Workout workout;

  const WorkoutListItem({Key? key, required this.workout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new WorkoutPage(
                workout: workout,
              ))), //your login class name,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ListTile(
            title: Text(workout.title),
            subtitle: Text("sub"),
            textColor: accentBlue,
            tileColor: white,
            contentPadding: EdgeInsets.all(10),
          ),
        ),
      ),
    );
  }
}

class WorkoutPage extends StatelessWidget {
  final Workout workout;
  const WorkoutPage({Key? key, required this.workout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(workout.title),
      ),
      body: Center(
        // Display workout details here (name, exercises, etc.)
        child: Text('Name: ${workout.title}'),
      ),
    );
  }
}
