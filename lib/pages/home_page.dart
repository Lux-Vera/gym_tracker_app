import 'package:flutter/material.dart';
import 'package:gym_tracker_app/pages/workout_form.dart';
import '../widgets/workout_list_item.dart';
import '../models/workout.dart';
import '../widgets/bottom-nav-bar.dart';
import '../widgets/custom-floating-action-button.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  final String title = "Workouts";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Workout> _workoutList = [];

  void _createWorkout() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (BuildContext context) => new WorkoutForm(
            workout: Workout("Test", DateTime.now(), []),
            saveWorkout: _addWorkout),
      ),
    );
  }

  void _addWorkout(Workout workout) {
    setState(() {
      _workoutList.add(workout);
      _workoutList.sort(((a, b) => b.dateTime.compareTo(a.dateTime)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () {
              // Handle filters for workout list
            },
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              // Handle sorting of workout list
            },
          ),
        ],
      ),
      body: Center(
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          itemCount: _workoutList.length,
          itemBuilder: (context, index) {
            final workout = _workoutList[index];
            return WorkoutListItem(key: Key(workout.title), workout: workout);
          },
          separatorBuilder: (context, index) => SizedBox(
            height: 6,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(focusButtonIndex: 0),
      floatingActionButton:
          CustomFloatingActionButton(icon: Icons.add, action: _createWorkout),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
