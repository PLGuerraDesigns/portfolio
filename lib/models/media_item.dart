import '../common/enums.dart';

/// A media item to be displayed in the gallery.
class MediaItem {
  const MediaItem({
    required this.type,
    required this.path,
    required this.caption,
  });

  /// The type of media.
  final MediaType type;

  /// The path to the media.
  final String path;

  /// The caption to be displayed with the media.
  final String caption;
}
