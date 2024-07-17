import 'package:flutter/material.dart';
import 'package:gym_tracker_app/pages/workout_page.dart';
import 'package:gym_tracker_app/theme.dart';
import 'package:gym_tracker_app/widgets/one-choice-toggle-buttons.dart';
import '../models/workout.dart';
import '../enums/feeling.dart';
import '../widgets/feeling-button.dart';
import 'package:flutter_picker/flutter_picker.dart';

class WorkoutForm extends StatefulWidget {
  final Workout workout;
  const WorkoutForm({super.key, required this.workout});

  @override
  State<WorkoutForm> createState() =>
      _WorkoutFormState(workout.dateTime, workout.duration, workout.icon);
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _WorkoutFormState extends State<WorkoutForm> {
  Feeling? workoutFeeling;
  DateTime pickedDate;
  Duration? _duration;
  IconData _icon;

  final workoutTitleController = TextEditingController();
  final workoutNotesController = TextEditingController();

  _WorkoutFormState(this.pickedDate, this._duration, this._icon);

  List<bool> _selectedButtons = [false, false, false, false];
  List<IconData> workoutIcons = [
    Icons.directions_run,
    Icons.directions_bike,
    Icons.directions_walk,
    Icons.fitness_center,
    Icons.sports_soccer,
    Icons.pool,
    Icons.star,
    Icons.sports_tennis,
    Icons.sports_gymnastics,
    Icons.sports_kabaddi,
    Icons.nordic_walking,
  ];

  void setWorkoutFeeling(Feeling? feeling) {
    // This approch makes sure workout isn't altered unless saved
    setState(() {
      workoutFeeling = feeling;
    });
  }

  void setDuration(Picker picker, List<int> value) {
    setState(() {
      _duration = Duration(
          hours: picker.getSelectedValues()[0],
          minutes: picker.getSelectedValues()[1]);
    });
  }

  Widget iconPickerDialog(BuildContext context) {
    IconData picked = _icon;

    return StatefulBuilder(builder: ((context, setState) {
      return AlertDialog(
        title: Text('Select icon'),
        content: Container(
          width: 32 * 4 + 16,
          height: 32 * 6,
          child: GridView.count(
            crossAxisCount: 4,
            children: workoutIcons
                .map((icon) => IconButton(
                      onPressed: () => setState(() {
                        picked = icon;
                      }),
                      icon: Icon(icon),
                      color: picked == icon ? accentOrange : accentBlue,
                    ))
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(picked);
            },
            child: Text('OK'),
          ),
        ],
      );
    }));
  }

  Future<void> _selectIcon(BuildContext context) async {
    final IconData? picked =
        await showDialog(context: context, builder: iconPickerDialog);

    print(picked);
    if (picked != null && picked != _icon) {
      setState(() {
        _icon = picked;
      });
    }
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
                  onPressed: () => {
                    Picker(
                      adapter: NumberPickerAdapter(data: <NumberPickerColumn>[
                        NumberPickerColumn(
                            initValue:
                                _duration != null ? _duration!.inHours : 0,
                            begin: 0,
                            end: 23,
                            suffix: Text(' hours')),
                        NumberPickerColumn(
                            initValue: _duration != null
                                ? _duration!.inMinutes % 60
                                : 0,
                            begin: 0,
                            end: 60,
                            suffix: Text(' minutes'),
                            jump: 1),
                      ]),
                      delimiter: <PickerDelimiter>[
                        PickerDelimiter(
                          child: Container(
                            width: 30.0,
                            alignment: Alignment.center,
                            child: Text(
                              ':',
                              style: TextStyle(
                                  color: accentBlue,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                      hideHeader: true,
                      confirmText: 'Set',
                      title: const Text(
                        'Select duration',
                      ),
                      selectedTextStyle: TextStyle(color: Colors.blue),
                      onConfirm: setDuration,
                    ).showDialog(context)
                  },
                  child: Text(
                      '${_duration == null ? 'add duration' : '${_duration!.inHours}h ${_duration!.inMinutes % 60}min'}'),
                ),
                IconButton(
                    onPressed: () => _selectIcon(context), icon: Icon(_icon))
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
                selectedButtons: _selectedButtons,
                action: setWorkoutFeeling,
                indexedValue: feelingsMap.keys.toList(),
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () => {},
                child: Text('Add exercise'),
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(
                        (MediaQuery.of(context).size.width - 36),
                        (MediaQuery.of(context).size.width - 36) * 0.12))),
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
                        widget.workout.duration = _duration,
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
