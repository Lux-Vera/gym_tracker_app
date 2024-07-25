import 'package:flutter/material.dart';
import 'package:gym_tracker_app/widgets/one-choice-toggle-buttons.dart';
import '../enums/feeling.dart';

enum FilterOption { workoutType, exercise, feeling }

const Map<FilterOption, String> filterOptionLabels = {
  FilterOption.workoutType: 'Workout Type',
  FilterOption.exercise: 'Exercise',
  FilterOption.feeling: 'Feeling',
};

class FilterPopup extends StatelessWidget {
  final List<String> selectedFilters;
  final Function(FilterOption) onFilterSelected;

  const FilterPopup(
      {required this.selectedFilters, required this.onFilterSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          children: FilterOption.values
                  .map((option) => _buildFilterItem(option))
                  .toList() +
              [
                // OneChoiceToggleButtons(
                //   buttons: feelingsMap.keys
                //       .map((key) => FeelingButton(
                //             feeling: key,
                //           ))
                //       .toList(),
                //   selectedButtons: _selectedButtons,
                //   action: _setWorkoutFeeling,
                //   indexedValue: feelingsMap.keys.toList(),
                // ),
              ]),
    );
  }

  Widget _buildFilterItem(FilterOption option) {
    final isSelected = selectedFilters.contains(option.toString());
    return CheckboxListTile(
      title: Text(filterOptionLabels[option]!),
      value: isSelected,
      onChanged: (value) => onFilterSelected(option),
    );
  }
}
