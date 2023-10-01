import 'package:flutter/material.dart';

/// Adds a hover scale effect to a widget. Scales a widget up when the
/// mouse is hovering over it and down when the mouse is not hovering
/// over it or when the widget is tapped.
class HoverScaleHandler extends StatefulWidget {
  const HoverScaleHandler({
    super.key,
    required this.child,
    required this.onTap,
  });

  /// The widget to apply the hover scale effect to.
  final Widget child;

  /// The function to call when the widget is tapped.
  final Function()? onTap;

  @override
  State<HoverScaleHandler> createState() => HoverScaleHandlerState();
}

class HoverScaleHandlerState extends State<HoverScaleHandler> {
  /// The duration of the animation in milliseconds.
  final int msAnimationDuration = 100;

  /// The default scale of the widget.
  final double defaultScale = 1;

  /// The scale of the widget when the mouse is hovering over it.
  final double scaleOnHover = 1.05;

  /// The current scale of the widget.
  double currentScale = 1;

  /// Whether the widget has been tapped.
  bool tapped = false;

  /// Whether the mouse is hovering over the widget.
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(
        () {
          isHovering = true;
          currentScale = scaleOnHover;
        },
      ),
      onExit: (_) => setState(
        () {
          isHovering = false;
          currentScale = defaultScale;
        },
      ),
      child: GestureDetector(
        onTap: () async {
          if (tapped) {
            return;
          }

          tapped = true;

          setState(() {
            currentScale = 1;
          });

          await Future<void>.delayed(
              Duration(milliseconds: msAnimationDuration + 50));

          setState(() {
            currentScale = scaleOnHover;
          });

          await Future<void>.delayed(
              Duration(milliseconds: msAnimationDuration));

          if (!isHovering) {
            setState(() {
              currentScale = defaultScale;
            });
          }

          widget.onTap?.call();

          tapped = false;
        },
        child: AnimatedScale(
          scale: currentScale,
          duration: Duration(milliseconds: msAnimationDuration),
          child: widget.child,
        ),
      ),
    );
  }
}
