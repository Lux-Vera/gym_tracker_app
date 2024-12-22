import 'package:flutter/material.dart';
import '../models/exercise_data.dart';
import '../theme.dart';
import '../pages/exercise_page.dart';

class ExerciseListItem extends StatelessWidget {
  final ExerciseData exerciseData;

  const ExerciseListItem({Key? key, required this.exerciseData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (BuildContext context) => new ExercisePage(
            exerciseData: exerciseData,
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          color: white,
          child: Row(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exerciseData.exercise.name,
                  style: TextStyle(
                      color: accentBlue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
