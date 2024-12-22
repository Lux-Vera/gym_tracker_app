import '../enums/feeling.dart';
import '../models/set.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'exercise_data.dart';

class ExerciseEntry {
  final ExerciseData exerciseData;
  final List<WorkoutSet?> workoutSets;
  String? id;
  final Feeling? feeling;
  final String? notes;

  ExerciseEntry(
      {required this.exerciseData,
      required this.workoutSets,
      this.id,
      this.feeling,
      this.notes});

  factory ExerciseEntry.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    final id = snapshot.id;
    return ExerciseEntry.fromMap(id, data);
  }

  factory ExerciseEntry.fromMap(
    String id,
    Map<String, dynamic>? data,
  ) {
    final exerciseDataRef = data?['exercise_data'] as DocumentReference?;
    try {
      final exerciseDataDoc =
          _fetchExerciseData(exerciseDataRef) as ExerciseData;
      return ExerciseEntry(
          id: id,
          exerciseData: exerciseDataDoc,
          workoutSets: List.from(data?['workout_sets']),
          notes: data?['notes'],
          feeling: data?['feeling'] != null
              ? Feeling.values.byName(data?['feeling'])
              : null);
    } catch (e) {
      throw Exception('An error occured fetching the exercise_data doc: $e ');
    }
  }

  static Future<ExerciseData?> _fetchExerciseData(
      DocumentReference? reference) async {
    if (reference == null) {
      return null;
    }

    try {
      final exerciseDataSnapshot = await reference.get();
      return ExerciseData.fromFirestore(
          exerciseDataSnapshot as DocumentSnapshot<Map<String, dynamic>>, null);
    } catch (e) {
      // Handle errors
      print('Error fetching post: $e');
      return null;
    }
  }

  Map<String, dynamic> toFirestore() {
    return {
      "exercise": exerciseData.toFirestore(),
      "workoutSets": workoutSets.map((e) => e?.toFirestore()).toList(),
      if (feeling != null) "feeling": feeling!.name,
      if (notes != null) "notes": notes
    };
  }
}
