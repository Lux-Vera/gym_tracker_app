import 'package:flutter/material.dart';
import 'package:gym_tracker_app/pages/workout_page.dart';
import 'package:gym_tracker_app/theme.dart';
import 'package:gym_tracker_app/widgets/one-choice-toggle-buttons.dart';
import '../models/workout.dart';
import '../enums/feeling.dart';
import '../widgets/feeling-button.dart';

class WorkoutForm extends StatefulWidget {
  final Workout workout;
  const WorkoutForm({super.key, required this.workout});

  @override
  State<WorkoutForm> createState() => _WorkoutFormState(workout.dateTime);
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _WorkoutFormState extends State<WorkoutForm> {
  Feeling? workoutFeeling;
  DateTime pickedDate;
  _WorkoutFormState(this.pickedDate);
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final workoutTitleController = TextEditingController();
  final workoutNotesController = TextEditingController();
  String testNotes =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque a leo ut turpis tristique cursus vitae eu lacus. Sed quis mauris suscipit, feugiat leo et, feugiat velit. ";

  void setWorkoutFeeling(Feeling? feeling) {
    // This approch makes sure workout isn't altered unless saved
    setState(() {
      workoutFeeling = feeling;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: pickedDate,
      currentDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (picked != null && picked != pickedDate) {
      setState(() {
        pickedDate = picked;
      });
    }
  }

  List<bool> _selectedButton = [false, false, false, false];

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    workoutTitleController.dispose();
    workoutNotesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit workout"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: DefaultTextStyle(
          style: TextStyle(color: accentBlue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: workoutTitleController,
                cursorColor: accentBlue,
                decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: accentBlue)),
                    labelText: 'Workout name',
                    floatingLabelStyle: TextStyle(color: accentBlue)),
              ),
              SizedBox(
                height: 16,
              ),
              Row(children: [
                OutlinedButton(
                    onPressed: () => {_selectDate(context)},
                    child: Text(
                        '${pickedDate.year}/${pickedDate.month}/${pickedDate.day}')),
                SizedBox(
                  width: 16,
                ),
                OutlinedButton(
                    onPressed: () => {},
                    child: Text(
                        '${widget.workout.durationMinutes == null ? 'add duration' : widget.workout.getDurationString()}'))
              ]),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: workoutNotesController,
                cursorColor: accentBlue,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Workout notes',
                ),
              ),
              SizedBox(
                height: 16,
              ),
              OneChoiceToggleButtons(
                buttons: feelingsMap.keys
                    .map((key) => FeelingButton(
                          feeling: key,
                        ))
                    .toList(),
                selectedButtons: _selectedButton,
                action: setWorkoutFeeling,
                indexedValue: feelingsMap.keys.toList(),
              ),
              SizedBox(
                height: 16,
              ),
              OutlinedButton(
                  onPressed: () => {
                        widget.workout.title =
                            workoutTitleController.text.isEmpty
                                ? 'Workout'
                                : workoutTitleController.text,
                        widget.workout.notes =
                            workoutNotesController.text.isEmpty
                                ? null
                                : workoutNotesController.text,
                        widget.workout.feeling = workoutFeeling,
                        widget.workout.dateTime = pickedDate,
                        Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context) => new WorkoutPage(
                              workout: widget.workout,
                            ),
                          ),
                        ),
                      },
                  child: Text('Create Workout')),
            ],
          ),
        ),
      ),
    );
  }
}
