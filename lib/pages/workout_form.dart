import 'package:flutter/material.dart';
import 'package:gym_tracker_app/models/exercise.dart';
import 'package:gym_tracker_app/pages/workout_page.dart';
import 'package:gym_tracker_app/theme.dart';
import 'package:gym_tracker_app/widgets/selectable_exercise_list_item.dart';
import 'package:gym_tracker_app/widgets/exercise_entry_toggle_card.dart';
import 'package:gym_tracker_app/widgets/one-choice-toggle-buttons.dart';
import '../models/workout.dart';
import '../enums/feeling.dart';
import '../widgets/feeling-button.dart';
import 'package:flutter_picker/flutter_picker.dart';

class WorkoutForm extends StatefulWidget {
  final Workout workout;
  final Function saveWorkout;
  const WorkoutForm(
      {super.key, required this.workout, required this.saveWorkout});

  @override
  State<WorkoutForm> createState() => _WorkoutFormState(
      workout.dateTime, workout.duration, workout.icon, workout.exercises);
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _WorkoutFormState extends State<WorkoutForm> {
  Feeling? _workoutFeeling;
  DateTime _pickedDate;
  Duration? _duration;
  IconData _icon;
  List<ExerciseEntry> _exerciseList;

  final workoutTitleController = TextEditingController();
  final workoutNotesController = TextEditingController();

  _WorkoutFormState(
      this._pickedDate, this._duration, this._icon, this._exerciseList);

  List<bool> _selectedButtons = [false, false, false, false];
  List<IconData> _workoutIcons = [
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

  List<Exercise> _dummyExerciseList = [
    Exercise('Dips',
        targets: [Targets.chest, Targets.triceps, Targets.strength],
        goal: 10,
        pb: 1),
    Exercise('Push ups',
        targets: [
          Targets.chest,
          Targets.triceps,
          Targets.core,
          Targets.strength
        ],
        goal: 10,
        pb: 5),
    Exercise('Pistol Squats',
        targets: [Targets.hamstrings, Targets.strength, Targets.flexibility],
        goal: 1,
        pb: 0),
    Exercise('Sit ups', targets: [Targets.core, Targets.strength]),
    Exercise('Box Jumps', targets: [Targets.cardio, Targets.hamstrings]),
    Exercise('Pull ups',
        targets: [Targets.back, Targets.triceps, Targets.strength],
        goal: 1,
        pb: 0),
    Exercise('Chin ups',
        targets: [Targets.back, Targets.biceps, Targets.strength],
        goal: 1,
        pb: 0),
    Exercise('Leg lifts', targets: [Targets.core, Targets.strength], pb: 20),
  ];

  /* Set States */
  void _setWorkoutFeeling(Feeling? feeling) {
    // This approch makes sure workout isn't altered unless saved
    setState(() {
      _workoutFeeling = feeling;
    });
  }

  void _setDuration(Picker picker, List<int> value) {
    setState(() {
      _duration = Duration(
          hours: picker.getSelectedValues()[0],
          minutes: picker.getSelectedValues()[1]);
    });
  }

  void _addExerciseEntry(ExerciseEntry exercise) {
    setState(() {
      _exerciseList.add(exercise);
    });
  }

  void _removeExerciseEntry(ExerciseEntry entry) {
    setState(() {
      _exerciseList
          .removeWhere((e) => identityHashCode(e) == identityHashCode(entry));
    });
  }

  void _setIcon(IconData icon) {
    if (icon != _icon) {
      setState(() {
        _icon = icon;
      });
    }
  }

  void _setDate(DateTime date) {
    if (date != _pickedDate) {
      setState(() {
        _pickedDate = date;
      });
    }
  }

  void _reorderExerciseList(int oldIndex, int newIndex) {
    if (oldIndex != newIndex) {
      setState(() {
        ExerciseEntry movedExercise = _exerciseList.removeAt(oldIndex);
        _exerciseList.insert(newIndex, movedExercise);
      });
    }
  }

  void _saveAndNavigate() {
    widget.workout.title = workoutTitleController.text.isEmpty
        ? 'Workout'
        : workoutTitleController.text;
    widget.workout.notes = workoutNotesController.text.isEmpty
        ? null
        : workoutNotesController.text;
    widget.workout.feeling = _workoutFeeling;
    widget.workout.dateTime = _pickedDate;
    widget.workout.duration = _duration;
    widget.workout.exercises = _exerciseList;
    widget.workout.icon = _icon;

    widget.saveWorkout(widget.workout);

    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (BuildContext context) => new WorkoutPage(
          workout: widget.workout,
        ),
      ),
    );
  }

  /// Build dialog with icon grid
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
            children: _workoutIcons
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

  /// Build dialog with exercise list
  Widget exerciseSelectorDialog(BuildContext context) {
    List<ExerciseEntry> exerciseEntries = [];

    return StatefulBuilder(builder: ((context, setState) {
      return AlertDialog(
        title: Text('Select exercise'),
        content: Container(
          width: MediaQuery.of(context).size.width - 32,
          height: MediaQuery.of(context).size.height - 32,
          child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                Exercise exercise = _dummyExerciseList[index];
                final ExerciseEntry entry = ExerciseEntry(exercise, []);
                return SelectableExerciseListItem(
                    exercise: exercise,
                    action: (bool isSelected) => {
                          if (isSelected)
                            {
                              setState(
                                () => exerciseEntries.add(entry),
                              )
                            }
                          else
                            setState(() => exerciseEntries.removeWhere(
                                (e) => e.exercise.name == exercise.name))
                        });
              },
              separatorBuilder: ((context, index) => SizedBox(height: 8)),
              itemCount: _dummyExerciseList.length),
        ),
        backgroundColor: lightBlue,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(exerciseEntries);
            },
            child: Text('Add'),
          ),
        ],
      );
    }));
  }

  /* Actions */
  Future<void> _selectIcon(BuildContext context) async {
    final IconData? picked =
        await showDialog(context: context, builder: iconPickerDialog);

    if (picked != null) {
      _setIcon(picked);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _pickedDate,
      currentDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (picked != null) {
      _setDate(picked);
    }
  }

  Future<void> _selectExercise(BuildContext context) async {
    final List<ExerciseEntry>? exercises =
        await showDialog(context: context, builder: exerciseSelectorDialog);

    if (exercises != null) {
      exercises.forEach((exercise) {
        _addExerciseEntry(exercise);
      });
    }
  }

  Widget dragTarget(int newIndex) {
    return DragTarget<int>(
      builder: (context, o, d) {
        return Container(
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
            height: 4,
            color: o.isNotEmpty
                ? accentOrange.withOpacity(0.5)
                : Colors.transparent);
      },
      onAcceptWithDetails: (details) {
        _reorderExerciseList(details.data, newIndex);
      },
    );
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
        centerTitle: true,
        title: Text(
          "Edit workout",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () => {_saveAndNavigate()}, icon: Icon(Icons.save))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: DefaultTextStyle(
          style: GlobalThemeData.lightTextStyle,
          child: SingleChildScrollView(
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
                          '${_pickedDate.year}/${_pickedDate.month}/${_pickedDate.day}')),
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
                        onConfirm: _setDuration,
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
                  action: _setWorkoutFeeling,
                  indexedValue: feelingsMap.keys.toList(),
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(
                  thickness: 2,
                ),
                dragTarget(0),
                Column(
                    children: _exerciseList
                        .asMap()
                        .entries
                        .map((exerciseEntry) => Column(children: [
                              ExerciseEntryToggleCard(
                                index: exerciseEntry.key,
                                exerciseEntry: exerciseEntry.value,
                                handleDelete: _removeExerciseEntry,
                                handleDuplicate: _addExerciseEntry,
                              ),
                              dragTarget(exerciseEntry.key)
                            ]))
                        .toList()),
                ElevatedButton(
                  onPressed: () => {_selectExercise(context)},
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: lightBlue,
                        ),
                        Text(
                          'Add exercises',
                          style: GlobalThemeData.lightTextStyleOn
                              .merge(GlobalThemeData.boldTextStyle),
                        ),
                      ]),
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(
                          (MediaQuery.of(context).size.width - 36),
                          (MediaQuery.of(context).size.width - 36) * 0.12)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
