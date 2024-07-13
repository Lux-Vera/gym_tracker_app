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
      color: lightBlue,
      child: Row(
        mainAxisSize:
            MainAxisSize.max, // Stretch the Row across the entire width
        mainAxisAlignment:
            MainAxisAlignment.spaceEvenly, // Evenly distribute icons
        children: [
          BottomIconButton(Icon(Icons.fitness_center),
              focus: focusButtonIndex == 0),
          BottomIconButton(Icon(Icons.dynamic_feed),
              focus: focusButtonIndex == 1),
          BottomIconButton(Icon(Icons.query_stats),
              focus: focusButtonIndex == 2),
          BottomIconButton(Icon(Icons.account_circle),
              focus: focusButtonIndex == 3),
          Spacer(),
        ],
      ),
    );
  }
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
      onPressed: () => {},
    );
  }
}
