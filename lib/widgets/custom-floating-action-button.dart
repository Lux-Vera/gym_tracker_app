import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final IconData icon;
  final void Function() action;

  CustomFloatingActionButton({required this.icon, required this.action});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: action,
      tooltip: 'Add workout',
      child: Icon(icon),
    );
  }
}
