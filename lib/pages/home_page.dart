import 'package:flutter/material.dart';
import 'package:gym_tracker_app/pages/workout_form.dart';
import '../models/workout.dart';
import '../widgets/bottom-nav-bar.dart';
import '../widgets/custom-floating-action-button.dart';
import 'workout_list_page.dart';
import 'exercise_list_page.dart';
import 'statistics_page.dart';
import 'user_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> _pages = [
    WorkoutListPage(),
    ExerciseListPage(),
    StatisticsPage(),
    UserPage()
  ];

  List<String> _actionButtonTooltips = [
    "Add workout",
    "Add exercise",
    "...",
    "..."
  ]; //TODO: tooltips
  int _currentPageIndex = 0;

  void _setCurrentPageIndex(int i) {
    if (_currentPageIndex != i) {
      setState(() {
        _currentPageIndex = i;
      });
    }
  }

  void _createWorkout() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (BuildContext context) => new WorkoutForm(
          workout: Workout(title: "", dateTime: DateTime.now(), exercises: []),
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
      bottomNavigationBar: BottomNavBar(
        focusButtonIndex: _currentPageIndex,
        setNewIndex: _setCurrentPageIndex,
      ),
      floatingActionButton: CustomFloatingActionButton(
          icon: Icons.add,
          action: _actionButtonAction,
          tooltip: _actionButtonTooltips[_currentPageIndex]),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
