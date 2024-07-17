import 'package:flutter/material.dart';

import '../models/exercise.dart';
import '../theme.dart';

class ExerciseEntryToggleDisplayCard extends StatefulWidget {
  final ExerciseEntry exerciseEntry;

  const ExerciseEntryToggleDisplayCard({
    Key? key,
    required this.exerciseEntry,
  }) : super(key: key);

  @override
  _ExerciseEntryToggleDisplayCardState createState() =>
      _ExerciseEntryToggleDisplayCardState();
}

class _ExerciseEntryToggleDisplayCardState
    extends State<ExerciseEntryToggleDisplayCard> {
  bool isOpen = false;

  void _toggleOpen() {
    setState(() {
      isOpen = !isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {_toggleOpen()},
      child: Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: isOpen ? Radius.zero : Radius.circular(10),
              bottomRight: isOpen ? Radius.zero : Radius.circular(10)),
          child: Container(
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width,
            height: 48,
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            color: accentBlue,
            child: Row(
              children: [
                Icon(
                  isOpen ? Icons.keyboard_arrow_down : Icons.chevron_right,
                  color: lightBlue,
                ),
                Text(
                  widget.exerciseEntry.exercise.name,
                  style: GlobalThemeData.boldTextStyle
                      .merge(GlobalThemeData.lightTextStyleOn)
                      .merge(GlobalThemeData.textStyleSize16),
                ),
                Spacer(),
                Text(
                  'Sets: ${widget.exerciseEntry.workoutSets.length}',
                  style: GlobalThemeData.boldTextStyle
                      .merge(GlobalThemeData.lightTextStyleOn)
                      .merge(GlobalThemeData.textStyleSize16),
                )
              ],
            ),
          ),
        ),
        if (isOpen)
          Container(
            decoration: BoxDecoration(
              color: white,
              border: Border.all(color: accentBlue, width: 2),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.zero,
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child:
                // widget.exerciseEntry.workoutSets.isNotEmpty
                //     ? Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: widget.exerciseEntry.workoutSets
                //             .map((e) =>
                //                 Text('Reps: ${e.reps}. Weight: ${e.weight}kg'))
                //             .toList())
                //     :
                Text('No sets added.'), // TODO:
          ),
      ]),
    );
  }
}
