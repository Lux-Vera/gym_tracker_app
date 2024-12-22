import 'package:gym_tracker_app/enums/targets.dart';
import 'models/exercise.dart';
import 'models/exercise_data.dart';

Map<String, Exercise> dummyExercises = {
  "dips": Exercise(
      name: 'Dips',
      targets: [Targets.chest, Targets.triceps, Targets.strength]),
  "push-ups": Exercise(name: 'Push ups', targets: [
    Targets.chest,
    Targets.triceps,
    Targets.core,
    Targets.strength
  ]),
  "pistol-squats": Exercise(
      name: 'Pistol Squats',
      targets: [Targets.hamstrings, Targets.strength, Targets.flexibility]),
  "sit-ups":
      Exercise(name: 'Sit ups', targets: [Targets.core, Targets.strength]),
  "box-jumps": Exercise(
      name: 'Box Jumps', targets: [Targets.cardio, Targets.hamstrings]),
  "pull-ups": Exercise(
      name: 'Pull ups',
      targets: [Targets.back, Targets.triceps, Targets.strength]),
  "chin-ups": Exercise(
      name: 'Chin ups',
      targets: [Targets.back, Targets.biceps, Targets.strength]),
  "leg-lifts":
      Exercise(name: 'Leg lifts', targets: [Targets.core, Targets.strength])
};

List<ExerciseData> dummyExerciseList = [
  ExerciseData(exercise: dummyExercises["dips"]!, goal: 10, pb: 1),
  ExerciseData(exercise: dummyExercises["push-ups"]!, goal: 10, pb: 5),
  ExerciseData(exercise: dummyExercises["pistol-squats"]!, goal: 1, pb: 0),
  ExerciseData(exercise: dummyExercises["sit-ups"]!),
  ExerciseData(exercise: dummyExercises["box-jumps"]!),
  ExerciseData(exercise: dummyExercises["pull-ups"]!, goal: 1, pb: 0),
  ExerciseData(exercise: dummyExercises["chin-ups"]!, goal: 1, pb: 0),
  ExerciseData(exercise: dummyExercises["leg-lifts"]!, pb: 20),
];
