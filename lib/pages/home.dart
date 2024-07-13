import 'package:flutter/material.dart';
import 'workout.dart';
import '../theme.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  final String title = "Workouts";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class BottomIconButton extends StatelessWidget {
  final Icon icon;
  final bool focus;

  BottomIconButton(this.icon, {this.focus = false});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      iconSize: 32,
      color: focus ? accentOrange : accentBlue,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      onPressed: () => print('workout button pressed'),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List<Workout> _workoutList = [];

  void _addWorkout() {
    setState(() {
      _workoutList.add(Workout(
          'Workout name', DateTime.now(), [])); // Replace with user input
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(widget.title),
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
          shrinkWrap: true,
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
      bottomNavigationBar: BottomAppBar(
        notchMargin: 16.0,
        shape: const CircularNotchedRectangle(),
        color: lightBlue,
        child: Row(
          mainAxisSize:
              MainAxisSize.max, // Stretch the Row across the entire width
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, // Evenly distribute icons
          children: [
            BottomIconButton(Icon(Icons.fitness_center), focus: true),
            BottomIconButton(Icon(Icons.dynamic_feed)),
            BottomIconButton(Icon(Icons.query_stats)),
            BottomIconButton(Icon(Icons.account_circle)),
            Spacer(),
          ],
        ),
        // child: Container(
        //   height: 50.0,
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addWorkout,
        tooltip: 'Add workout',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
