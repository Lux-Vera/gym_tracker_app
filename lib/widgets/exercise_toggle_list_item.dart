import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../theme.dart';

class ExerciseToggleListItem extends StatelessWidget {
  final ExerciseEntry exerciseEntry;

  const ExerciseToggleListItem({Key? key, required this.exerciseEntry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          color: white,
        ),
      ),
    );
  }
}
