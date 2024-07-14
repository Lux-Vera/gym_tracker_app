import 'package:flutter/material.dart';
import '../theme.dart';

class BottomNavBar extends StatelessWidget {
  final int focusButtonIndex;

  BottomNavBar({this.focusButtonIndex = -1});

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
          BottomIconButton(Icon(Icons.fitness_center), "Workouts",
                  focus: focusButtonIndex == 0)
              .build(context),
          BottomIconButton(Icon(Icons.dynamic_feed), "Exercises",
                  focus: focusButtonIndex == 1)
              .build(context),
          BottomIconButton(Icon(Icons.query_stats), "Stats",
                  focus: focusButtonIndex == 2)
              .build(context),
          BottomIconButton(Icon(Icons.account_circle), "Profile",
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

  BottomIconButton(this.icon, this.tooltip, {this.focus = false});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      tooltip: tooltip,
      iconSize: 32,
      color: focus ? accentOrange : accentBlue,
      mouseCursor: SystemMouseCursors.click,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      onPressed: () => {},
    );
  }
}
