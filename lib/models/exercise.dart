import '../enums/feeling.dart';

class Exercise {
  final String name;

  Exercise(this.name);
}

class ExerciseEntry {
  final Exercise exercise;
  final List<Set> sets;
  final Feeling? feeling;
  final String? notes;

  ExerciseEntry(this.exercise, this.sets, {this.feeling, this.notes});
}
