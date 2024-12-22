import 'package:gym_tracker_app/enums/workout_type.dart';
import '../enums/feeling.dart';

class FilterOptions {
  List<WorkoutType> workoutTypes;
  List<Duration> workoutLength;
  List<Feeling> feelings;

  static const List<WorkoutType> resetWorkoutTypes = [
    WorkoutType.gym,
    WorkoutType.running
  ];
  static const List<Duration> resetWorkoutLenght = [
    Duration(),
    Duration(hours: 24)
  ];
  static const List<Feeling> resetFeeling = [
    Feeling.easy,
    Feeling.medium,
    Feeling.challenging,
    Feeling.dead
  ];

  FilterOptions(
      {this.workoutTypes = resetWorkoutTypes,
      this.workoutLength = resetWorkoutLenght,
      this.feelings = resetFeeling});

  bool noFilters() {
    return workoutTypes == resetWorkoutTypes &&
        workoutLength == resetWorkoutLenght &&
        feelings == resetFeeling;
  }

  void resetAll() {
    workoutTypes = resetWorkoutTypes;
    workoutLength = resetWorkoutLenght;
    feelings = resetFeeling;
  }
}
