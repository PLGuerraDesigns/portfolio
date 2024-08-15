import 'package:flutter/material.dart';

import 'frosted_container.dart';
import 'spinner.dart';

/// A grid menu with a frosted glass background.
///
/// Displays a title and a grid of children.
class FrostedGridMenu extends StatelessWidget {
  const FrostedGridMenu({
    super.key,
    required this.title,
    required this.children,
    required this.scrollController,
    this.crossAxisSpacing = 0.0,
    this.mainAxisSpacing = 0.0,
    this.crossAxisCount = 3,
    this.aspectRatio = 1.0,
    this.subtitle,
  });

  /// The title of the grid menu.
  final String title;

  /// The children of the grid menu.
  final List<Widget>? children;

  /// The scroll controller for the grid menu.
  final ScrollController scrollController;

  /// The main axis spacing.
  final double mainAxisSpacing;

  /// The cross axis spacing.
  final double crossAxisSpacing;

  /// The cross axis count.
  final int crossAxisCount;

  /// The aspect ratio.
  final double aspectRatio;

  /// The subtitle widget of the grid menu.
  final Widget? subtitle;

  /// Returns the header of the grid menu.
  Widget _header({
    required BuildContext context,
    required bool compact,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: compact
                ? Theme.of(context).textTheme.bodyMedium
                : Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          const Divider(),
        ],
      ),
    );
  }

  /// Returns a [GridView] with custom settings.
  GridView _gridView() {
    return GridView.custom(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        crossAxisCount: crossAxisCount,
        childAspectRatio: aspectRatio,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childrenDelegate: SliverChildBuilderDelegate(
        childCount: children!.length,
        (BuildContext context, int index) {
          return children![index];
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      return FrostedContainer(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _header(
              context: context,
              compact: orientation == Orientation.portrait,
            ),
            if (children == null)
              const Expanded(child: Spinner())
            else
              Expanded(
                child: Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    padding: orientation == Orientation.portrait
                        ? const EdgeInsets.only(right: 8)
                        : EdgeInsets.zero,
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (subtitle != null)
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 8,
                            ),
                            child: subtitle,
                          ),
                        _gridView(),
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      );
    });
  }
}
