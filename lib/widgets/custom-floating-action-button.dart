import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final IconData icon;
  final void Function() action;
  final String? tooltip;

  CustomFloatingActionButton(
      {required this.icon, required this.action, this.tooltip});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: action,
      tooltip: tooltip,
      child: Icon(icon),
    );
  }
}
