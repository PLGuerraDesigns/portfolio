import 'package:flutter/material.dart';

import '../../../../common/urls.dart';
import 'network_image_thumbnail.dart';

/// Thumbnail for a YouTube video.
class YouTubeThumbnail extends StatelessWidget {
  const YouTubeThumbnail({
    super.key,
    required this.videoId,
  });

  /// The id of the YouTube video.
  final String videoId;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: <Widget>[
        NetworkImageThumbnail(
          url: Urls.youTubeThumbnail(videoId),
        ),
        ColoredBox(
          color: Colors.transparent,
          child: Center(
            child: Icon(
              Icons.play_circle,
              color: Colors.red.withOpacity(0.95),
              size: 48.0,
            ),
          ),
        ),
      ],
    );
  }
}
