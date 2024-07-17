import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../theme.dart';

class SelectableExerciseListItem extends StatefulWidget {
  final Exercise exercise;
  final Function? action;

  const SelectableExerciseListItem(
      {Key? key, required this.exercise, this.action})
      : super(key: key);

  @override
  _SelectableExerciseListItemState createState() =>
      _SelectableExerciseListItemState();
}

class _SelectableExerciseListItemState
    extends State<SelectableExerciseListItem> {
  bool isSelected = false;

  void _toggleSelect() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {_toggleSelect(), widget.action!(isSelected)},
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 48,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              color: isSelected ? accentBlue : white,
              child: Text(
                widget.exercise.name,
                style: TextStyle(color: isSelected ? lightBlue : accentBlue),
              ),
            ),
          ),
        ]));
  }
}