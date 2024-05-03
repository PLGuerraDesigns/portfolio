import 'dart:ui';

import 'package:flutter/material.dart';

/// A container with a frosted glass effect.
class FrostedContainer extends StatelessWidget {
  const FrostedContainer({
    super.key,
    required this.child,
    this.borderRadiusAmount = 16.0,
    this.padding = const EdgeInsets.all(16.0),
  });

  /// The widget to display inside the container.
  final Widget child;

  /// The padding to apply to the container.
  final EdgeInsets padding;

  /// The amount of border radius to apply to the container.
  final double borderRadiusAmount;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 3,
      shadowColor: Colors.black87,
      borderRadius: BorderRadius.circular(borderRadiusAmount),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadiusAmount),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? Theme.of(context).colorScheme.background.withOpacity(0.8)
                  : Theme.of(context)
                      .colorScheme
                      .surfaceVariant
                      .withOpacity(0.3),
              borderRadius: BorderRadius.circular(borderRadiusAmount),
            ),
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
