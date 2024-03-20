/// The different types of media that can be displayed in the media player and browser.
enum MediaType {
  localImage,
  networkImage,
  localVideo,
  youTubeVideo,
}

/// Converts a media type to a string.
extension MediaTypeExtension on MediaType {
  /// Converts a media type to a user-friendly string.
  String get stringValue {
    switch (this) {
      case MediaType.localImage:
        return 'Image';
      case MediaType.networkImage:
        return 'Image';
      case MediaType.localVideo:
        return 'Video';
      case MediaType.youTubeVideo:
        return 'YouTube Video';
    }
  }
}
