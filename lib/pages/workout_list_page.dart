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

enum SortingFields { dateTime, duration }

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
  SortingOption _sortingOption = SortingOption.sortOnDateRecents;
  SortingFields _sortingField = SortingFields.dateTime;
  bool _sortDecending = true;
  List<String> _selectedFilters = [];

  void handleSortRequest(SortingOption value) {
    setState(() {
      _sortingOption = value;
    });
    switch (value) {
      case SortingOption.sortOnDateOldest:
        setState(() {
          _sortingField = SortingFields.dateTime;
          _sortDecending = false;
        });
        break;
      case SortingOption.sortOnDateRecents:
        setState(() {
          _sortingField = SortingFields.dateTime;
          _sortDecending = true;
        });
        break;

      case SortingOption.sortOnDuration:
        setState(() {
          _sortingField = SortingFields.duration;
          _sortDecending = false;
        });
        break;

      case SortingOption.sortOnDurationReverse:
        setState(() {
          _sortingField = SortingFields.duration;
          _sortDecending = true;
        });
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
              _showFilterPopup(context);
            },
          ),
          PopupMenuButton<SortingOption>(
            tooltip: 'Sort',
            position: PopupMenuPosition.under,
            offset: Offset(0, 0),
            icon: Icon(
              Icons.sort,
            ),
            onSelected: handleSortRequest,
            initialValue: _sortingOption,
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
        child: StreamBuilder(
          stream: db
              .collection('users')
              .doc(auth.currentUser!.uid)
              .collection("workouts")
              .withConverter(
                  fromFirestore: Workout.fromFirestore,
                  toFirestore: (Workout workout, options) =>
                      workout.toFirestore())
              .orderBy(_sortingField.name, descending: _sortDecending)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            return ListView.separated(
              physics: BouncingScrollPhysics(),
              padding:
                  EdgeInsets.fromLTRB(12, 12, 12, kBottomNavigationBarHeight),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // Get the data from the snapshot
                var data = snapshot.data!.docs[index];
                Workout w = data.data();
                w.doc_id = data.id;
                if (_selectedFilters.isEmpty) {
                  return WorkoutListItem(key: Key(data['title']), workout: w);
                } else
                  return SizedBox.shrink();
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 6,
              ),
            );
          },
        ),
      ),
    );
  }
}
