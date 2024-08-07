import 'package:flutter/material.dart';
import 'package:gym_tracker_app/models/exercise.dart';
import '../theme.dart';

class ExercisePage extends StatelessWidget {
  final Exercise exercise;
  const ExercisePage({Key? key, required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercise.name,
              style: TextStyle(
                  color: accentBlue,
                  fontSize: 36.0,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 16,
            ),
            Row(children: [
              Text(
                "Goal: ",
                style: GlobalThemeData.lightTextStyle
                    .merge(GlobalThemeData.textStyleSize24),
              ),
              Text(
                '${exercise.goal ?? '-'}',
                style: GlobalThemeData.lightTextStyle
                    .merge(GlobalThemeData.textStyleSize24),
              )
            ]),
            Row(children: [
              Text(
                "Pb: ",
                style: GlobalThemeData.lightTextStyle
                    .merge(GlobalThemeData.textStyleSize24),
              ),
              Text(
                '${exercise.pb ?? '-'}',
                style: GlobalThemeData.lightTextStyle
                    .merge(GlobalThemeData.textStyleSize24),
              )
            ]),
            Divider(),
          ],
        ),
      ),
    );
  }
}
