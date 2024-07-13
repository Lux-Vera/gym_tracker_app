import 'package:flutter/material.dart';
import 'exercise.dart';

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
