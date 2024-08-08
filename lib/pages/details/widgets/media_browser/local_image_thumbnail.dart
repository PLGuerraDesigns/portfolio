import 'package:flutter/material.dart';

/// Thumbnail for a local image.
class LocalImageThumbnail extends StatelessWidget {
  const LocalImageThumbnail({
    super.key,
    required this.source,
  });

  /// The path to the image.
  final String source;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      source,
      cacheHeight: 120,
      width: 120,
      height: 120,
      fit: BoxFit.cover,
    );
  }
}
