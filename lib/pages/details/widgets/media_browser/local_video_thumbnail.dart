import 'package:flutter/material.dart';

import 'local_image_thumbnail.dart';

/// Thumbnail for a local video.
class LocalVideoThumbnail extends StatelessWidget {
  const LocalVideoThumbnail({
    super.key,
    required this.source,
  });

  /// The path to the video.
  final String source;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        LocalImageThumbnail(source: source),
        ColoredBox(
          color: Colors.transparent,
          child: Center(
            child: Icon(
              Icons.play_circle_outline,
              color: Colors.white.withOpacity(0.95),
              size: 48.0,
            ),
          ),
        ),
      ],
    );
  }
}
