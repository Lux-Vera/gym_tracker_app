import 'package:flutter/material.dart';

enum Feeling { easy, medium, challenging, dead }

class Feel {
  final IconData icon;
  final String title;

  Feel(this.icon, this.title);
}

final feelingsMap = {
  Feeling.easy: Feel(Icons.sentiment_very_satisfied, 'Easy'),
  Feeling.medium: Feel(Icons.sentiment_satisfied, 'Medium'),
  Feeling.challenging: Feel(Icons.sentiment_dissatisfied, 'Challenging'),
  Feeling.dead: Feel(Icons.sentiment_very_dissatisfied, 'Dead')
};
