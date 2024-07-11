import 'package:flutter/material.dart';
import 'workout.dart';

class MyExercisesPage extends StatefulWidget {
  MyExercisesPage({Key? key}) : super(key: key);
  final String title = "Exercises";

  @override
  _MyExercisesPageState createState() => _MyExercisesPageState();
}

class _MyExercisesPageState extends State<MyExercisesPage> {
  List<Exercise> _exerciseList = [];

  void _addExercise() {
    setState(() {
      _exerciseList
          .add(Exercise("Exercise name")); //TODO: Replace with user input
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
          // child: ListView.builder(
          //   itemCount: _exerciseList.length,
          //   itemBuilder: (context, index) {
          //     final workout = _exerciseList[index];
          //     return GestureDetector(
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => WorkoutPage(
          //                   key: Key(workout.title), workout: workout),
          //             ),
          //           );
          //         },
          //         child:
          //             WorkoutListItem(key: Key(workout.title), workout: workout));
          //   },
          // ),
          ),
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(
            height: 50.0,
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: _addExercise,
        tooltip: 'Add exercise',
        child: Icon(Icons.add),
      ),
    );
  }
}
