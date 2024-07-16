import 'package:flutter/material.dart';
import 'package:gym_tracker_app/enums/feeling.dart';
import 'exercise.dart';

class Workout {
  String title;
  String? notes;
  Feeling? feeling;
  DateTime dateTime;
  int? durationMinutes;
  IconData icon;
  List<ExerciseEntry> exercises;

  Workout(this.title, this.dateTime, this.exercises,
      {this.durationMinutes,
      this.icon = Icons.directions_run,
      this.notes,
      this.feeling});

  String getDateString() {
    return '${dateTime.year}/${dateTime.month}/${dateTime.day}';
  }

  String getDurationString() {
    if (durationMinutes != null) {
      return '$durationMinutes min';
    } else
      return '';
  }

  String dateAndDuration() {
    if (durationMinutes != null) {
      return '${getDateString()} - ${getDurationString()}';
    } else
      return getDateString();
  }
}
