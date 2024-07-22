import 'package:flutter/material.dart';
import 'package:gym_tracker_app/pages/workout_form.dart';
import '../widgets/workout_list_item.dart';
import '../models/workout.dart';
import '../widgets/bottom-nav-bar.dart';
import '../widgets/custom-floating-action-button.dart';
import 'package:collection/collection.dart';

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
  List<Workout> _workoutList = [];
  SortingOption _sorting = SortingOption.sortOnDateRecents;

  void _createWorkout() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (BuildContext context) => new WorkoutForm(
            workout: Workout("Test", DateTime.now(), []),
            saveWorkout: _addWorkout),
      ),
    );
  }

  void _sortOnDateOldest() {
    setState(() {
      _workoutList.sortBy(((a) => a.dateTime));
    });
  }

  void _sortOnDateRecents() {
    _sortOnDateOldest();
    setState(() {
      _workoutList = _workoutList.reversed.toList();
    });
  }

  void _sortOnDuration() {
    setState(() {
      _workoutList.sortBy((e) => e.duration ?? Duration());
    });
  }

  void _sortOnDurationReverse() {
    _sortOnDuration();
    setState(() {
      _workoutList = _workoutList.reversed.toList();
    });
  }

  void _addWorkout(Workout workout) {
    setState(() {
      _workoutList.add(workout);
      _sortOnDateRecents();
    });
  }

  void handleClick(SortingOption value) {
    setState(() {
      _sorting = value;
    });
    switch (value) {
      case SortingOption.sortOnDateOldest:
        _sortOnDateOldest();
        break;
      case SortingOption.sortOnDateRecents:
        _sortOnDateRecents();
        break;

      case SortingOption.sortOnDuration:
        _sortOnDuration();
        break;

      case SortingOption.sortOnDurationReverse:
        _sortOnDurationReverse();
        break;
    }
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
          PopupMenuButton<SortingOption>(
            tooltip: 'Sort',
            icon: Icon(
              Icons.sort,
            ),
            onSelected: handleClick,
            initialValue: _sorting,
            itemBuilder: (BuildContext context) {
              return sortingOptionsMap.keys.map((SortingOption option) {
                return PopupMenuItem<SortingOption>(
                  value: option,
                  child: Text(sortingOptionsMap[option]!),
                );
              }).toList();
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
