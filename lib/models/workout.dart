import 'package:flutter/material.dart';
import 'package:gym_tracker_app/enums/feeling.dart';
import 'exercise_entry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Workout {
  String? docId;
  String title;
  String? notes;
  Feeling? feeling;
  DateTime dateTime;
  Duration? duration;
  IconData icon;
  List<ExerciseEntry> exercises;

  Workout(
      {required this.title,
      required this.dateTime,
      required this.exercises,
      Key? key,
      this.duration,
      this.icon = Icons.directions_run,
      this.notes,
      this.feeling,
      this.docId});

  factory Workout.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    try {
      // final List<ExerciseEntry> exercises = List.from(data?['exercises'])
      //     .map((e) => _fetchExerciseEntry(e) as ExerciseEntry)
      //     .toList();
      return Workout(
          title: data?['title'],
          dateTime: DateTime.fromMicrosecondsSinceEpoch(data?['dateTime']),
          exercises: [],
          duration: data?['duration'] != null
              ? Duration(minutes: data!['duration'])
              : null,
          icon: IconData(data?['icon'], fontFamily: 'MaterialIcons'),
          notes: data?['notes'],
          feeling: data?['feeling'] != null
              ? Feeling.values.byName(data?['feeling'])
              : null);
    } catch (e) {
      throw Exception('An error occured fetching the exercise_entry doc: $e ');
    }
  }

  static Future<ExerciseEntry?> _fetchExerciseEntry(
      DocumentReference? reference) async {
    if (reference == null) {
      return null;
    }

    try {
      final exerciseEntrySnapshot = await reference.get();
      return ExerciseEntry.fromFirestore(
          exerciseEntrySnapshot as DocumentSnapshot<Map<String, dynamic>>,
          null);
    } catch (e) {
      // Handle errors
      print('Error fetching post: $e');
      return null;
    }
  }

  Map<String, dynamic> toFirestore() {
    return {
      "title": title,
      "dateTime": dateTime.microsecondsSinceEpoch,
      "exercises": exercises.map((e) => e.toFirestore()).toList(),
      if (duration != null) "duration": duration!.inMinutes,
      "icon": icon.codePoint,
      if (notes != null) "notes": notes,
      if (feeling != null) "feeling": feeling!.name
    };
  }

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
