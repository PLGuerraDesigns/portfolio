import 'package:flutter/material.dart';

import 'frosted_container.dart';
import 'hover_scale_handler.dart';

/// A button that displays an icon and a title on a frosted glass background.
/// The button can be tapped to perform an action.
class FrostedActionButton extends StatelessWidget {
  const FrostedActionButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  /// The icon to display in the button.
  final Widget icon;

  /// The title to display in the button.
  final String title;

  /// The function to call when the button is tapped.
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return HoverScaleHandler(
      onTap: onTap,
      child: FrostedContainer(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 4),
            icon,
            const SizedBox(height: 8),
            Text(
              title.toUpperCase(),
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
