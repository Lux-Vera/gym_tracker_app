import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../theme.dart';

class ExerciseEntryListItem extends StatefulWidget {
  final ExerciseEntry exercise;
  final Function? action;

  const ExerciseEntryListItem({Key? key, required this.exercise, this.action})
      : super(key: key);

  @override
  _ExerciseEntryListItemState createState() => _ExerciseEntryListItemState();
}

class _ExerciseEntryListItemState extends State<ExerciseEntryListItem> {
  bool isOpen = false;

  void _toggleOpen() {
    setState(() {
      isOpen = !isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {_toggleOpen(), widget.action!()},
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: isOpen ? Radius.zero : Radius.circular(10),
                bottomRight: isOpen ? Radius.zero : Radius.circular(10)),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              color: isOpen ? accentBlue : white,
              child: Text(
                widget.exercise.exercise.name,
                style: TextStyle(color: isOpen ? lightBlue : accentBlue),
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
                        bottomRight: Radius.circular(10))),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Latest: ...'), //TODO:
                      Text('PB: ${widget.exercise.exercise.pb.toString()}'),
                      Text('Goal: ${widget.exercise.exercise.goal.toString()}')
                    ])),
        ]));
  }
}
