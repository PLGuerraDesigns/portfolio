import 'package:flutter/material.dart';

import '../../../common/strings.dart';

/// Actions to navigate to the previous and next details screens.
class DetailsAppBarActions extends StatelessWidget {
  const DetailsAppBarActions({
    super.key,
    this.onPreviousPressed,
    this.onNextPressed,
  });

  /// Callback when the previous button is pressed.
  final Function()? onPreviousPressed;

  /// Callback when the next button is pressed.
  final Function()? onNextPressed;

  @override
  Widget build(BuildContext context) {
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
}
