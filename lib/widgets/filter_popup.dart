import 'package:flutter/material.dart';
import 'package:gym_tracker_app/theme.dart';
import 'package:gym_tracker_app/widgets/one-choice-toggle-buttons.dart';
import '../enums/feeling.dart';
import '../widgets/feeling-button.dart';
import '../models/filter_options.dart';

class FilterPopup extends StatefulWidget {
  FilterOptions filter;
  final Function(FilterOptions) onFilterSelected;

  FilterPopup({Key? key, required this.filter, required this.onFilterSelected})
      : super(key: key);

  @override
  State<FilterPopup> createState() => _FilterPopupState();
}

class _FilterPopupState extends State<FilterPopup> {
  late TextEditingController startControllerWoLength;
  late TextEditingController endControllerWoLength;
  late List<bool> _selectedFeelingsButtons;

  @override
  void initState() {
    super.initState();
    startControllerWoLength = TextEditingController(
        text:
            '${widget.filter.workoutLength[0].inHours} : ${widget.filter.workoutLength[0].inMinutes % 60}');
    endControllerWoLength = TextEditingController(
        text:
            '${widget.filter.workoutLength[1].inHours} : ${widget.filter.workoutLength[1].inMinutes % 60}');

    _selectedFeelingsButtons = [
      widget.filter.feelings.contains(Feeling.easy),
      widget.filter.feelings.contains(Feeling.medium),
      widget.filter.feelings.contains(Feeling.challenging),
      widget.filter.feelings.contains(Feeling.dead)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
      child: Column(children: [
        Text("Filter"),
        SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 40,
          child: Row(children: [
            SizedBox(width: 180, child: Text("Workout duration:")),
            SizedBox(
              width: 64,
              child: TextFormField(
                controller: startControllerWoLength,
                cursorColor: accentBlue,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            Expanded(
                child: Text(
              "-",
              textAlign: TextAlign.center,
            )),
            SizedBox(
              width: 64,
              child: TextFormField(
                controller: endControllerWoLength,
                cursorColor: accentBlue,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            )
          ]),
        ),
        SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 40,
          child: Row(children: [
            SizedBox(width: 180, child: Text("Workout types:")),
          ]),
        ),
        SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 40,
          child: Row(children: [
            SizedBox(width: 180, child: Text("Feelings:")),
          ]),
        ),
      ]),
    );
  }
}
