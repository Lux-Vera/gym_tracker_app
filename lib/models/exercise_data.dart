import 'package:cloud_firestore/cloud_firestore.dart';
import 'exercise.dart';

class ExerciseData {
  Exercise exercise;
  String? id;
  int? pb;
  int? goal;

  ExerciseData({required this.exercise, this.id, this.pb, this.goal});

  factory ExerciseData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    final id = snapshot.id;
    return ExerciseData.fromMap(id, data);
  }

  factory ExerciseData.fromMap(String id, Map<String, dynamic>? data) {
    return ExerciseData(
        id: id,
        exercise: data?['exercise'],
        pb: data?['pb'],
        goal: data?['goal']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "exercise": exercise,
      if (pb != null) "pb": pb,
      if (goal != null) "goal": goal,
    };
  }
}
