import 'package:flutter/material.dart';

import '../../../common/strings.dart';
import '../../../widgets/custom_filter_chip.dart';

/// A list of [FilterChip] widgets for filtering a list of items.
class FilterMenu extends StatelessWidget {
  const FilterMenu({
    super.key,
    required this.filterOptions,
    required this.selectedFilters,
    required this.onToggleFilter,
    required this.scrollController,
  });

  /// The list of filter option labels.
  final List<String> filterOptions;

  /// The list of selected filters.
  final List<String> selectedFilters;

  /// Callback for when a filter is selected.
  final void Function(String filter) onToggleFilter;

  /// The controller for the scroll view.
  final ScrollController scrollController;

  /// The filter option widget.
  Widget _option({
    required String label,
    required bool selected,
  }) {
    return CustomFilterChip(
      label: label,
      selected: selected,
      onSelected: (_) => onToggleFilter(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(children: <Widget>[
        Text(
          Strings.show.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: Theme.of(context).hintColor.withOpacity(0.5),
              ),
        ),
        const SizedBox(width: 8),
        ...filterOptions
            .map(
              (String filter) => _option(
                label: filter,
                selected: selectedFilters.contains(filter),
              ),
            )
            .toList(),
      ]),
    );
  }
}
