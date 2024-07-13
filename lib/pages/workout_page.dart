import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/workout.dart';
import '../widgets/exercise_toggle_list_item.dart';

class WorkoutPage extends StatelessWidget {
  final Workout workout;
  const WorkoutPage({Key? key, required this.workout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              workout.dateAndDuration(),
              style: TextStyle(color: accentBlue, fontSize: 20),
            ),
            Text(
              workout.title,
              style: TextStyle(
                  color: accentBlue,
                  fontSize: 36.0,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque a leo ut turpis tristique cursus vitae eu lacus. Sed quis mauris suscipit, feugiat leo et, feugiat velit. ",
              style: TextStyle(
                color: accentBlue,
                fontSize: 16.0,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Icon(
                  Icons.sentiment_very_dissatisfied,
                  color: accentBlue,
                  size: 32,
                ),
                Text(
                  "Dead",
                  style: TextStyle(
                    color: accentBlue,
                    fontSize: 20.0,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Divider(
              color: disabledBlue,
            ),
            workout.exercises.isNotEmpty
                ? ListView.separated(
                    itemBuilder: (context, index) {
                      return ExerciseToggleListItem(
                          exerciseEntry: workout.exercises[index]);
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 6,
                        ),
                    itemCount: workout.exercises.length)
                : Text("No exercises added to this workout.",
                    style: TextStyle(
                      color: disabledBlue,
                      fontSize: 20.0,
                    ))
          ],
        ),
      ),
    );
  }
}
