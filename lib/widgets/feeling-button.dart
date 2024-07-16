import 'package:flutter/material.dart';
import '../enums/feeling.dart';

class FeelingButton extends StatelessWidget {
  final Feeling feeling;
  const FeelingButton({
    Key? key,
    required this.feeling,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      width: (MediaQuery.of(context).size.width - 37) / 4,
      child: Column(children: [
        Icon(feelingsMap[feeling]!.icon),
        Text(
          feelingsMap[feeling]!.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ]),
    );
  }
}
