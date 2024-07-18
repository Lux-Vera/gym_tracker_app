import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_tracker_app/models/set.dart';
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
      _ExerciseEntryToggleCardState(exerciseEntry.workoutSets);
}

class _ExerciseEntryToggleCardState extends State<ExerciseEntryToggleCard> {
  bool _isOpen = false;
  List<WorkoutSet?> _sets;

  final List<TextEditingController?> repsController = [];
  final List<TextEditingController?> weightController = [];

  _ExerciseEntryToggleCardState(this._sets);

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
      _isOpen = !_isOpen;
    });
  }

  void _increaseSets() {
    setState(() {
      _sets.add(WorkoutSet(0, 0));
      repsController.add(TextEditingController());
      weightController.add(TextEditingController());
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
                bottomLeft: _isOpen ? Radius.zero : Radius.circular(10),
                bottomRight: _isOpen ? Radius.zero : Radius.circular(10)),
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 48,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                color: _isOpen ? accentBlue : white,
                child: Row(
                  children: [
                    Icon(
                      _isOpen ? Icons.keyboard_arrow_down : Icons.chevron_right,
                      color: _isOpen ? lightBlue : accentBlue,
                    ),
                    Text(
                      widget.exerciseEntry.exercise.name,
                      style: GlobalThemeData.boldTextStyle
                          .merge(_isOpen
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
                          color: _isOpen ? lightBlue : accentBlue,
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
          if (_isOpen)
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
                    Column(
                      children: _sets
                          .asMap()
                          .entries
                          .map((e) => Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('Set ${e.key + 1}: '),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          controller: repsController[e.key],
                                          decoration: new InputDecoration(
                                            labelText: 'Reps',
                                            border: OutlineInputBorder(),
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          controller: weightController[e.key],
                                          decoration: new InputDecoration(
                                            labelText: 'Weight',
                                            border: OutlineInputBorder(),
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  )
                                ],
                              ))
                          .toList(),
                    ),
                    IconButton(
                      onPressed: () => {_increaseSets()},
                      icon: Icon(Icons.add),
                    )
                  ]),
            ),
        ]));
  }
}
