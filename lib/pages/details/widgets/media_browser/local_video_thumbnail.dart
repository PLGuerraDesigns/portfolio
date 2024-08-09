import 'package:flutter/material.dart';

import '../../../../common/theming/color_schemes.dart';
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
        Center(
          child: CircleAvatar(
            radius: 24.0,
            backgroundColor: Colors.white54,
            child: Icon(
              Icons.play_circle_fill,
              color: PortfolioColorSchemes.dark.tertiaryContainer,
              size: 48.0,
            ),
          ),
        ),
      ],
    );
  }
}
