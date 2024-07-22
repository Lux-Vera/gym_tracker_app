import 'package:flutter/material.dart';
import 'package:gym_tracker_app/enums/feeling.dart';
import 'exercise.dart';

class Workout {
  String title;
  String? notes;
  Feeling? feeling;
  DateTime dateTime;
  Duration? duration;
  IconData icon;
  List<ExerciseEntry> exercises;

  Workout(this.title, this.dateTime, this.exercises,
      {Key? key,
      this.duration,
      this.icon = Icons.directions_run,
      this.notes,
      this.feeling});

  String getDateString() {
    return '${dateTime.year}/${dateTime.month}/${dateTime.day}';
  }

  String getDurationString() {
    if (duration != null) {
      return '${duration!.inHours}h ${duration!.inMinutes % 60}min';
    } else
      return '';
  }

  String dateAndDuration() {
    if (duration != null) {
      return '${getDateString()} - ${getDurationString()}';
    } else
      return getDateString();
  }
}
