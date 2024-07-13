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

class ExerciseToggleListItem extends StatelessWidget {
  final ExerciseEntry exerciseEntry;

  const ExerciseToggleListItem({Key? key, required this.exerciseEntry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          color: white,
        ),
      ),
    );
  }
}

class Workout {
  final String title;
  final DateTime dateTime;
  final int durationMinutes;
  final IconData icon;
  final List<ExerciseEntry> exercises;

  Workout(this.title, this.dateTime, this.exercises,
      {this.durationMinutes = 0, this.icon = Icons.directions_run});

  String dateAndDuration() {
    return '${dateTime.year}/${dateTime.month}/${dateTime.day} - $durationMinutes min';
  }
}

class WorkoutListItem extends StatelessWidget {
  final Workout workout;

  const WorkoutListItem({Key? key, required this.workout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (BuildContext context) => new WorkoutPage(
            workout: workout,
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          color: white,
          child: Row(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workout.dateAndDuration(),
                  style: TextStyle(
                    color: accentBlue,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  workout.title,
                  style: TextStyle(
                      color: accentBlue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            Spacer(),
            Icon(
              workout.icon,
              color: accentBlue,
              size: 32.0,
            )
          ]),
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
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            workout.dateAndDuration(),
            style: TextStyle(color: accentBlue, fontSize: 20),
          ),
          Text(
            workout.title,
            style: TextStyle(
                color: accentBlue, fontSize: 36.0, fontWeight: FontWeight.w700),
          ),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque a leo ut turpis tristique cursus vitae eu lacus. Sed quis mauris suscipit, feugiat leo et, feugiat velit. ",
            style: TextStyle(
              color: accentBlue,
              fontSize: 16.0,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.sentiment_very_dissatisfied,
                color: accentBlue,
                size: 32,
              ),
              Text(
                "Dead",
                style: TextStyle(
                  color: accentBlue,
                  fontSize: 20.0,
                ),
              )
            ],
          ),
          ListView.separated(
              itemBuilder: (context, index) {
                return ExerciseToggleListItem(
                    exerciseEntry: workout.exercises[index]);
              },
              separatorBuilder: (context, index) => SizedBox(
                    height: 6,
                  ),
              itemCount: workout.exercises.length)
        ],
      ),
    );
  }
}
