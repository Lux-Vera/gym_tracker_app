import '../enums/feeling.dart';

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
  final List<Set> sets;
  final Feeling? feeling;
  final String? notes;

  ExerciseEntry(this.exercise, this.sets, {this.feeling, this.notes});
}
