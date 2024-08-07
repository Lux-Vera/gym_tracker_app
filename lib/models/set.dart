import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutSet {
  final int reps;
  final int? weight;

  WorkoutSet({required this.reps, this.weight});

  factory WorkoutSet.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return WorkoutSet(
      reps: data?['reps'],
      weight: data?['weight'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {"reps": reps, if (weight != null) "weight": weight};
  }
}
