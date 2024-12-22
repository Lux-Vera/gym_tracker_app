import '../enums/targets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Static exercises part of global database
class Exercise {
  String name;
  String? id;
  List<Targets>? targets;

  Exercise({required this.name, this.id, this.targets});

  /// Fetch exercise entry from database
  factory Exercise.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    final id = snapshot.id;
    return Exercise.fromMap(id, data);
  }

  factory Exercise.fromMap(String id, Map<String, dynamic>? data) {
    return Exercise(
        id: id,
        name: data?['name'],
        targets: data?['targets'] != null
            ? List.from(data?['targets'])
                .map((e) => Targets.values.byName(e))
                .toList()
            : null);
  }

  /// TODO: only when debug
  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      if (targets != null) "targets": targets!.map((e) => e.name).toList()
    };
  }
}

/// Custom Exercises that expands the global exercise library
/// User-specific
class CustomExercise extends Exercise {
  CustomExercise({required String name, String? id, List<Targets>? targets})
      : super(name: name, id: id, targets: targets);

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      if (targets != null) "targets": targets!.map((e) => e.name).toList()
    };
  }
}
