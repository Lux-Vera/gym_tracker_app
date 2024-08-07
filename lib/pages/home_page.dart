import 'package:flutter/material.dart';
import 'package:gym_tracker_app/models/exercise.dart';
import 'package:gym_tracker_app/pages/workout_form.dart';
import 'package:gym_tracker_app/widgets/filter_popup.dart';
import '../widgets/workout_list_item.dart';
import '../models/workout.dart';
import '../widgets/bottom-nav-bar.dart';
import '../widgets/custom-floating-action-button.dart';
import 'package:collection/collection.dart';
import 'workout_list_page.dart';
import 'my_exercise_page.dart';

enum SortingOption {
  sortOnDateRecents,
  sortOnDateOldest,
  sortOnDuration,
  sortOnDurationReverse
}

const Map<SortingOption, String> sortingOptionsMap = {
  SortingOption.sortOnDateRecents: 'Recents first',
  SortingOption.sortOnDateOldest: 'Oldest first',
  SortingOption.sortOnDuration: 'Duration ascending',
  SortingOption.sortOnDurationReverse: 'Duration decending'
};

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  final String title = "Workouts";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> _pages = [
    WorkoutListPage(),
    MyExercisesPage(),
    WorkoutListPage(),
    WorkoutListPage()
  ];
  int _currentPageIndex = 0;

  void _createWorkout() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (BuildContext context) => new WorkoutForm(
          workout:
              Workout(title: "Test", dateTime: DateTime.now(), exercises: []),
        ),
      ),
    );
  }

  void _createExercise() {
    // Navigator.of(context).push(
    //   new MaterialPageRoute(
    //     builder: (BuildContext context) => new ExerciseForm(
    //       exercise: Exercise(name: ""),
    //     ),
    //   ),
    // );
  }

  void _actionButtonAction() {
    switch (_currentPageIndex) {
      case 0:
        _createWorkout();
        break;
      case 1:
        _createExercise();
        break;
      case 2:
        break;
      case 3:
        break;
      default:
        throw ErrorDescription('_currentPageIndex invalid value');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages.elementAt(_currentPageIndex),
      bottomNavigationBar: BottomNavBar(focusButtonIndex: _currentPageIndex),
      floatingActionButton: CustomFloatingActionButton(
          icon: Icons.add, action: _actionButtonAction),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
