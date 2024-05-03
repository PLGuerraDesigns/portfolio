import 'package:flutter/material.dart';

class CustomFilterChip extends StatelessWidget {
  const CustomFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  /// The label of the filter chip.
  final String label;

  /// Whether the filter chip is selected.
  final bool selected;

  /// The function to call when the filter chip is selected.
  final Function(bool) onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: FilterChip.elevated(
        label: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        selected: selected,
        onSelected: onSelected,
        selectedColor: Theme.of(context).colorScheme.background,
        backgroundColor:
            Theme.of(context).colorScheme.background.withOpacity(0.2),
        checkmarkColor: Theme.of(context).colorScheme.primary,
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
