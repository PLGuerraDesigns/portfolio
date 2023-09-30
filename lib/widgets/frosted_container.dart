import 'dart:ui';

import 'package:flutter/material.dart';

/// A container with a frosted glass effect.
class FrostedContainer extends StatelessWidget {
  const FrostedContainer({
    super.key,
    required this.child,
    this.borderRadiusAmount = 24,
    this.padding = const EdgeInsets.all(12.0),
  });

  /// The widget to display inside the container.
  final Widget child;

  /// The padding to apply to the container.
  final EdgeInsets padding;

  /// The amount of border radius to apply to the container.
  final double borderRadiusAmount;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadiusAmount),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(
                Theme.of(context).brightness == Brightness.light ? 0.4 : 0.3),
            borderRadius: BorderRadius.circular(borderRadiusAmount),
          ),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
