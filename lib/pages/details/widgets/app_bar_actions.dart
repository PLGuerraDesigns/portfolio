import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/strings.dart';

/// Actions to navigate to the previous and next details screens.
class DetailsAppBarActions extends StatelessWidget {
  const DetailsAppBarActions({
    super.key,
    required this.onPreviousPressed,
    required this.onNextPressed,
    required this.isCompact,
  });

  /// Callback when the previous button is pressed.
  final Function()? onPreviousPressed;

  /// Callback when the next button is pressed.
  final Function()? onNextPressed;

  /// Whether the compact layout is enabled.
  final bool isCompact;

  /// The compact layout of the actions.
  Widget _compactLayout(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: onPreviousPressed,
          icon: const Icon(
            CupertinoIcons.chevron_up,
          ),
        ),
        const SizedBox(width: 4.0),
        IconButton(
          onPressed: onNextPressed,
          icon: const Icon(
            CupertinoIcons.chevron_down,
          ),
        ),
        const SizedBox(width: 8.0),
      ],
    );
  }

  /// The default layout of the actions.
  Widget _defaultLayout(BuildContext context) {
    return Row(
      children: <Widget>[
        OutlinedButton(
          onPressed: onPreviousPressed,
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            foregroundColor: Theme.of(context).colorScheme.onSurface,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.chevron_left,
              ),
              Text(
                Strings.prev.toUpperCase(),
              ),
              const SizedBox(width: 8.0),
            ],
          ),
        ),
        const SizedBox(width: 8.0),
        OutlinedButton(
          onPressed: onNextPressed,
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            foregroundColor: Theme.of(context).colorScheme.onSurface,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(width: 8.0),
              Text(
                Strings.next.toUpperCase(),
              ),
              const Icon(
                Icons.chevron_right,
              ),
            ],
          ),
        ),
        const SizedBox(width: 20.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return isCompact ? _compactLayout(context) : _defaultLayout(context);
  }
}
