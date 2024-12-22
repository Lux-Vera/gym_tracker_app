import 'package:flutter/material.dart';
import '../enums/feeling.dart';

class FeelingButton extends StatelessWidget {
  final Feeling feeling;
  final double? width;
  final bool withText;
  const FeelingButton(
      {Key? key, required this.feeling, this.width, this.withText = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      width: width != null
          ? width
          : ((MediaQuery.of(context).size.width - 37) / 4),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          feelingsMap[feeling]!.icon,
          size: width != null ? width! - 16 : null,
        ),
        if (withText)
          Text(
            feelingsMap[feeling]!.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          )
      ]),
    );
  }
}
