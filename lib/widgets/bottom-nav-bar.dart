import 'package:flutter/material.dart';
import '../theme.dart';

class BottomNavBar extends StatelessWidget {
  final int focusButtonIndex;
  final Function setNewIndex;

  BottomNavBar({this.focusButtonIndex = -1, required this.setNewIndex});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 16.0,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisSize:
            MainAxisSize.max, // Stretch the Row across the entire width
        mainAxisAlignment:
            MainAxisAlignment.spaceEvenly, // Evenly distribute icons
        children: [
          BottomIconButton(
                  icon: Icon(Icons.fitness_center),
                  tooltip: "Workouts",
                  onPressed: () => setNewIndex(0),
                  focus: focusButtonIndex == 0)
              .build(context),
          BottomIconButton(
                  icon: Icon(Icons.dynamic_feed),
                  tooltip: "Exercises",
                  onPressed: () => setNewIndex(1),
                  focus: focusButtonIndex == 1)
              .build(context),
          BottomIconButton(
                  icon: Icon(Icons.query_stats),
                  tooltip: "Stats",
                  onPressed: () => setNewIndex(2),
                  focus: focusButtonIndex == 2)
              .build(context),
          BottomIconButton(
                  icon: Icon(Icons.account_circle),
                  tooltip: "Profile",
                  onPressed: () => setNewIndex(3),
                  focus: focusButtonIndex == 3)
              .build(context),
          Spacer(),
        ],
      ),
    );
  }
}

class BottomIconButton extends State<StatefulWidget> {
  final Icon icon;
  final bool focus;
  final String tooltip;
  final void Function() onPressed;

  BottomIconButton(
      {required this.icon,
      required this.tooltip,
      this.focus = false,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      tooltip: tooltip,
      iconSize: 32,
      color: focus ? accentOrange : accentBlue,
      mouseCursor: SystemMouseCursors.click,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      onPressed: onPressed,
    );
  }
}
