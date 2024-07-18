import '../enums/feeling.dart';
import '../models/set.dart';

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

  Exercise(this.name, {this.pb, this.goal, this.targets});
}

class ExerciseEntry {
  final Exercise exercise;
  final List<WorkoutSet?> workoutSets;
  final Feeling? feeling;
  final String? notes;

  ExerciseEntry(this.exercise, this.workoutSets, {this.feeling, this.notes});
}
