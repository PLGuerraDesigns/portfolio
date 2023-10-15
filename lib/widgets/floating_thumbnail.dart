import 'package:flutter/material.dart';

import '../common/color_schemes.dart';
import 'frosted_container.dart';
import 'hover_scale_handler.dart';

/// A thumbnail that displays an image, a title, and an optional subtitle and
/// logo. The thumbnail can be tapped to perform an action and can be on a
/// frosted glass background.
class FloatingThumbnail extends StatefulWidget {
  const FloatingThumbnail({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
    this.logoPath,
    this.subtitle,
    this.frosted = false,
  });

  /// The logo to display in the thumbnail.
  final String? logoPath;

  /// The title of the thumbnail.
  final String title;

  /// The image to display in the thumbnail.
  final String image;

  /// The subtitle to display in the thumbnail.
  final String? subtitle;

  /// The function to call when the thumbnail is tapped.
  final Function()? onTap;

  /// Whether the thumbnail should be on a frosted glass background.
  final bool frosted;

  @override
  State<FloatingThumbnail> createState() => _FloatingThumbnailState();
}

class _FloatingThumbnailState extends State<FloatingThumbnail> {
  Widget _body() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        if (widget.logoPath != null)
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: lightColorScheme.surface,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  widget.logoPath!,
                  fit: BoxFit.contain,
                  height: 50,
                  width: 50,
                ),
              ),
            ),
          ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Image.asset(
                widget.image,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.title.toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            if (widget.subtitle != null)
              Text(
                widget.subtitle!,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return HoverScaleHandler(
      onTap: widget.onTap,
      child: widget.frosted
          ? FrostedContainer(
              child: _body(),
            )
          : _body(),
    );
  }
}
