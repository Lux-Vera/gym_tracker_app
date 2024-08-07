import 'package:flutter/material.dart';
import 'package:gym_tracker_app/pages/workout_form.dart';
import 'package:gym_tracker_app/widgets/filter_popup.dart';
import '../widgets/workout_list_item.dart';
import '../models/workout.dart';
import 'package:collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

class WorkoutListPage extends StatefulWidget {
  WorkoutListPage({Key? key}) : super(key: key);
  final String title = "Workouts";

  @override
  _WorkoutListPageState createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  List<Workout> _workoutList = [];
  SortingOption _sorting = SortingOption.sortOnDateRecents;
  List<String> _selectedFilters = [];

  void _createWorkout() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (BuildContext context) => new WorkoutForm(
            workout:
                Workout(title: "Test", dateTime: DateTime.now(), exercises: []),
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

  void handleSortRequest(SortingOption value) {
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

  void _toggleFilter(FilterOption option) {
    setState(() {
      if (_selectedFilters.contains(option.toString())) {
        _selectedFilters.remove(option.toString());
      } else {
        _selectedFilters.add(option.toString());
      }
    });
  }

  void _showFilterPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => FilterPopup(
        selectedFilters: _selectedFilters,
        onFilterSelected: _toggleFilter,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
        stream: db
            .collection('users')
            .doc(auth.currentUser!.uid)
            .collection("workouts")
            .withConverter(
                fromFirestore: Workout.fromFirestore,
                toFirestore: (Workout workout, options) =>
                    workout.toFirestore())
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('no data');
            return CircularProgressIndicator();
          }

          _workoutList = snapshot.data!.docs.map((e) => e.data()).toList();

          return ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              // Get the data from the snapshot
              var data = snapshot.data!.docs[index];
              if (_selectedFilters.isEmpty) {
                return WorkoutListItem(
                    key: Key(data['title']), workout: data.data());
              } else
                return SizedBox.shrink();
            },
            separatorBuilder: (context, index) => SizedBox(
              height: 6,
            ),
          );
        },
      ),
    );
  }
}
