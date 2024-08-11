import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';

/// A handler that tilts a widget around a point.
///
/// This can be the pointer location when hovered or the center of the widget
/// when not hovered and [selfTilt] is set to true.
class TiltHandler extends StatefulWidget {
  const TiltHandler({
    super.key,
    required this.child,
    this.selfTilt = false,
    this.reducedMotion = false,
  });

  /// The widget to tilt.
  final Widget child;

  /// Whether the widget should continuously tilt itself.
  final bool selfTilt;

  /// Whether the tilt motion should be reduced.
  final bool reducedMotion;

  @override
  State<TiltHandler> createState() => _TiltHandlerState();
}

class _TiltHandlerState extends State<TiltHandler>
    with TickerProviderStateMixin {
  /// The controller for the tilt stream.
  late StreamController<TiltStreamModel> tiltStreamController;

  /// The controller for the self-tilt animation.
  late AnimationController aroundAnimationController;

  /// Set up the animations for the self-tilt effect.
  void setupAnimations() {
    aroundAnimationController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    aroundAnimationController.addListener(() {
      final double radian =
          aroundAnimationController.value * 360 * math.pi / 180;
      const double r = 100;
      final double x = math.cos(radian) * r + 150;
      final double y = math.sin(radian) * r + 150;
      tiltStreamController.add(TiltStreamModel(position: Offset(x, y)));
    });

    aroundAnimationController.repeat();
  }

  /// Stop all animations.
  void stopAllAnimation() {
    aroundAnimationController.stop();
    tiltStreamController.add(
      const TiltStreamModel(position: Offset.zero, gestureUse: false),
    );
  }

  @override
  void initState() {
    super.initState();
    // Initialize the tilt stream controller.
    tiltStreamController = StreamController<TiltStreamModel>.broadcast();

    // If the widget should tilt itself, set up the animations.
    if (widget.selfTilt) {
      Future<void>.delayed(const Duration(milliseconds: 500), () {
        setupAnimations();
      });
    }
  }

  @override
  void dispose() {
    tiltStreamController.close();
    aroundAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Tilt(
      tiltStreamController: tiltStreamController,
      tiltConfig: TiltConfig(
        angle: widget.reducedMotion ? 5 : 10,
      ),
      // Disable the shadow and light effects as these are expensive and
      // cause other issues.
      shadowConfig: const ShadowConfig(disable: true),
      lightConfig: const LightConfig(disable: true),
      childLayout: ChildLayout(
        behind: <Widget>[
          // The shadow of the widget.
          TiltParallax(
            size: widget.reducedMotion
                ? const Offset(-3, -3)
                : const Offset(-7, -7),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Theme.of(context).shadowColor.withOpacity(
                      Brightness.dark == Theme.of(context).brightness
                          ? 0.25
                          : 0.15,
                    ),
                BlendMode.srcATop,
              ),
              child: widget.child,
            ),
          )
        ],
      ),
      child: widget.child,
    );
  }
}
