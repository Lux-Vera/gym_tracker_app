import '../enums/feeling.dart';
import '../models/set.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum Targets {
  chest,
  biceps,
  triceps,
  core,
  back,
  glutes,
  hamstrings,
  strength,
  flexibility,
  cardio
}

class Exercise {
  String name;
  int? pb;
  int? goal;
  List<Targets>? targets;

  Exercise({required this.name, this.pb, this.goal, this.targets});

  factory Exercise.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Exercise.fromMap(data);
  }

  factory Exercise.fromMap(Map<String, dynamic>? data) {
    return Exercise(
        name: data?['name'],
        pb: data?['pb'],
        goal: data?['goal'],
        targets: data?['targets'] != null
            ? List.from(data?['targets'])
                .map((e) => Targets.values.byName(e))
                .toList()
            : null);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      if (pb != null) "pb": pb,
      if (goal != null) "goal": goal,
      if (targets != null) "targets": targets!.map((e) => e.name).toList()
    };
  }
}

class ExerciseEntry {
  final Exercise exercise;
  final List<WorkoutSet?> workoutSets;
  final Feeling? feeling;
  final String? notes;

  ExerciseEntry(
      {required this.exercise,
      required this.workoutSets,
      this.feeling,
      this.notes});

  factory ExerciseEntry.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ExerciseEntry.fromMap(data);
  }

  factory ExerciseEntry.fromMap(
    Map<String, dynamic>? data,
  ) {
    return ExerciseEntry(
        exercise: Exercise.fromMap(data?['exercise']),
        workoutSets: List.from(data?['workoutSets']),
        notes: data?['notes'],
        feeling: data?['feeling'] != null
            ? Feeling.values.byName(data?['feeling'])
            : null);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "exercise": exercise.toFirestore(),
      "workoutSets": workoutSets.map((e) => e?.toFirestore()).toList(),
      if (feeling != null) "feeling": feeling!.name,
      if (notes != null) "notes": notes
    };
  }
}
