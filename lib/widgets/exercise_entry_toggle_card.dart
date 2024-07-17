import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/exercise.dart';
import '../theme.dart';

class ExerciseEntryToggleCard extends StatefulWidget {
  final ExerciseEntry exerciseEntry;
  final Function? handleDelete;
  final Function? handleDuplicate;
  final Function? handleSelect;

  const ExerciseEntryToggleCard(
      {Key? key,
      required this.exerciseEntry,
      this.handleSelect,
      this.handleDelete,
      this.handleDuplicate})
      : super(key: key);

  @override
  _ExerciseEntryToggleCardState createState() =>
      _ExerciseEntryToggleCardState();
}

class _ExerciseEntryToggleCardState extends State<ExerciseEntryToggleCard> {
  bool isOpen = false;

  final repsController = TextEditingController();
  final weightController = TextEditingController();

  void handleClick(String value) {
    switch (value) {
      case 'Duplicate':
        widget.handleDuplicate!(widget.exerciseEntry);
        break;
      case 'Remove':
        widget.handleDelete!(widget.exerciseEntry);
        break;
    }
  }

  void _toggleOpen() {
    setState(() {
      isOpen = !isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {_toggleOpen(), widget.handleSelect!()},
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: isOpen ? Radius.zero : Radius.circular(10),
                bottomRight: isOpen ? Radius.zero : Radius.circular(10)),
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 48,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                color: isOpen ? accentBlue : white,
                child: Row(
                  children: [
                    Text(
                      widget.exerciseEntry.exercise.name,
                      style: GlobalThemeData.boldTextStyle
                          .merge(isOpen
                              ? GlobalThemeData.lightTextStyleOn
                              : GlobalThemeData.lightTextStyle)
                          .merge(GlobalThemeData.textStyleSize16),
                    ),
                    Spacer(),
                    if (widget.handleDelete != null ||
                        widget.handleDuplicate != null)
                      PopupMenuButton<String>(
                        tooltip: 'Options',
                        icon: Icon(
                          Icons.more_vert,
                          color: isOpen ? lightBlue : accentBlue,
                        ),
                        onSelected: handleClick,
                        itemBuilder: (BuildContext context) {
                          return {
                            if (widget.handleDuplicate != null) 'Duplicate',
                            if (widget.handleDelete != null) 'Remove'
                          }.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                  ],
                )),
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
                      TextField(
                        controller: repsController,
                        decoration: new InputDecoration(labelText: "Reps"),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ])),
        ]));
  }
}
