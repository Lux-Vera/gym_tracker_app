import 'package:flutter/material.dart';
import '../theme.dart';

class OneChoiceToggleButtons extends StatefulWidget {
  final List<Widget> buttons;
  List<bool> selectedButtons;
  List? indexedValue;
  Function? action;

  OneChoiceToggleButtons(
      {Key? key,
      required this.buttons,
      required this.selectedButtons,
      this.indexedValue,
      this.action})
      : super(key: key);

  @override
  State<OneChoiceToggleButtons> createState() => _OneChoiceToggleButtonsState();
}

class _OneChoiceToggleButtonsState extends State<OneChoiceToggleButtons> {
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: widget.buttons,
      isSelected: widget.selectedButtons,
      direction: Axis.horizontal,
      mouseCursor: SystemMouseCursors.click,
      borderColor: accentBlue,
      borderRadius: BorderRadius.circular(12),
      selectedBorderColor: accentBlue,
      splashColor: Colors.transparent,
      selectedColor: lightBlue,
      fillColor: accentBlue,
      color: accentBlue,
      constraints: BoxConstraints(minWidth: 0),
      onPressed: (int index) {
        setState(() {
          widget.action!(widget.selectedButtons[index]
              ? null
              : widget.indexedValue![index]);
          for (int i = 0; i < widget.buttons.length; i++) {
            widget.selectedButtons[i] =
                (i == index) && !widget.selectedButtons[i];
          }
        });
      },
    );
  }
}
