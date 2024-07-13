import 'package:flutter/material.dart';
import '../models/workout.dart';
import '../theme.dart';
import '../pages/workout_page.dart';

class WorkoutListItem extends StatelessWidget {
  final Workout workout;

  const WorkoutListItem({Key? key, required this.workout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (BuildContext context) => new WorkoutPage(
            workout: workout,
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
                  workout.dateAndDuration(),
                  style: TextStyle(
                    color: accentBlue,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  workout.title,
                  style: TextStyle(
                      color: accentBlue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            Spacer(),
            Icon(
              workout.icon,
              color: accentBlue,
              size: 32.0,
            )
          ]),
        ),
      ),
    );
  }
}
