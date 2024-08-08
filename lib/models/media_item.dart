import '../common/enums.dart';

/// A media item to be displayed in the gallery.
class MediaItem {
  MediaItem({
    required this.type,
    required this.source,
    required this.caption,
  });

  /// Creates a [MediaItem] from a JSON object.
  factory MediaItem.fromJson(Map<String, dynamic> json) {
    return MediaItem(
      type: mediaTypeFromString(json['type'].toString()),
      source: json['source'].toString(),
      caption: json['caption'].toString(),
    );
  }

  /// The type of media.
  final MediaType type;

  /// The path to the media.
  String source;

  /// The caption to be displayed with the media.
  final String caption;

  /// Converts a string to a [MediaType].
  static MediaType mediaTypeFromString(String type) {
    switch (type) {
      case 'localImage':
        return MediaType.localImage;
      case 'localVideo':
        return MediaType.localVideo;
      case 'youTubeVideo':
        return MediaType.youTubeVideo;
      default:
        return MediaType.networkImage;
    }
  }
}
