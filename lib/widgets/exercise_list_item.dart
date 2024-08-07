import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../theme.dart';
import '../pages/exercise_page.dart';

class ExerciseListItem extends StatelessWidget {
  final Exercise exercise;

  const ExerciseListItem({Key? key, required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (BuildContext context) => new ExercisePage(
            exercise: exercise,
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
                  exercise.name,
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
