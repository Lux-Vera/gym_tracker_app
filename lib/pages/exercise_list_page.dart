import 'package:flutter/material.dart';
import 'package:gym_tracker_app/models/exercise.dart';
import 'package:gym_tracker_app/widgets/filter_popup.dart';
import '../widgets/exercise_list_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum ExerciseSortingOption { sortOnNameAscending, sortOnNameDecending }

enum ExerciseSortingFields { name }

const Map<ExerciseSortingOption, String> exerciseSortingOptionsMap = {
  ExerciseSortingOption.sortOnNameAscending: 'Name ascending',
  ExerciseSortingOption.sortOnNameDecending: 'Name decending',
};

class ExerciseListPage extends StatefulWidget {
  ExerciseListPage({Key? key}) : super(key: key);
  final String title = "Exercises";

  @override
  _ExerciseListPageState createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  ExerciseSortingOption _sortingOption =
      ExerciseSortingOption.sortOnNameAscending;
  ExerciseSortingFields _sortingField = ExerciseSortingFields.name;
  bool _sortDecending = true;
  List<String> _selectedFilters = [];

  void handleSortRequest(ExerciseSortingOption value) {
    setState(() {
      _sortingOption = value;
    });
    switch (value) {
      case ExerciseSortingOption.sortOnNameAscending:
        setState(() {
          _sortingField = ExerciseSortingFields.name;
          _sortDecending = false;
        });
        break;
      case ExerciseSortingOption.sortOnNameDecending:
        setState(() {
          _sortingField = ExerciseSortingFields.name;
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
          PopupMenuButton<ExerciseSortingOption>(
            tooltip: 'Sort',
            position: PopupMenuPosition.under,
            offset: Offset(0, 0),
            icon: Icon(
              Icons.sort,
            ),
            onSelected: handleSortRequest,
            initialValue: _sortingOption,
            itemBuilder: (BuildContext context) {
              return exerciseSortingOptionsMap.keys
                  .map((ExerciseSortingOption option) {
                return PopupMenuItem<ExerciseSortingOption>(
                  value: option,
                  child: Text(exerciseSortingOptionsMap[option]!),
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
              .collection('exercises')
              .withConverter(
                  fromFirestore: Exercise.fromFirestore,
                  toFirestore: (Exercise exercise, options) =>
                      exercise.toFirestore())
              .orderBy(_sortingField.name, descending: _sortDecending)
              .snapshots()
              .handleError((e) => print('error:::::::::::::: $e')),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            return ListView.separated(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // Get the data from the snapshot
                var data = snapshot.data!.docs[index];
                if (_selectedFilters.isEmpty) {
                  return ExerciseListItem(
                      key: Key(data['name']), exercise: data.data());
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
