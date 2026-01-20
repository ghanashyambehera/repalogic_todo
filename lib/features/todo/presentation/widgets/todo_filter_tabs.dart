
import 'package:flutter/material.dart';
import '../../../../core/utils/enums.dart';

class TodoFilterTabs extends StatelessWidget {
  final TodoFilter selected;
  final Function(TodoFilter) onChanged;

  const TodoFilterTabs({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: TodoFilter.values.map((filter) {
        final isSelected = filter == selected;

        return ChoiceChip(
          label: Text(filter.name.toUpperCase()),
          selected: isSelected,
          onSelected: (_) => onChanged(filter),
        );
      }).toList(),
    );
  }
}