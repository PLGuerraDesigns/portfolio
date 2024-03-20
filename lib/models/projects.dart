import 'package:intl/intl.dart';

import '../common/enums.dart';
import 'media_item.dart';

class Project {
  Project({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.startDate,
    required this.finalDate,
    required this.externalLinks,
    required this.mediaItems,
    required this.tags,
  });

  /// Creates a [Project] from a JSON object.
  factory Project.fromJson(Map<String, dynamic> json) {
    List<MediaItem> mediaItems = <MediaItem>[];
    if (json['media'] != null) {
      mediaItems = (json['media'] as List<dynamic>)
          .map((dynamic e) => MediaItem.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    for (int i = 0; i < mediaItems.length; i++) {
      final MediaItem mediaItem = mediaItems[i];
      if (mediaItem.type == MediaType.localImage ||
          mediaItem.type == MediaType.localVideo) {
        mediaItems[i].path =
            'assets/images/personal/${json['title'].toString().toLowerCase().replaceAll(' ', '_')}/${mediaItem.path}';
      }
    }

    return Project(
      title: json['title'].toString(),
      subtitle: json['subtitle'].toString(),
      description: json['description'].toString(),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'].toString()),
      finalDate: DateTime.parse(json['finalDate'].toString()),
      mediaItems: mediaItems,
      externalLinks: (json['externalLinks'] as List<dynamic>)
          .map((dynamic e) =>
              Map<String, String>.from(e as Map<dynamic, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>).map((dynamic e) {
        return e.toString();
      }).toList(),
    );
  }

  /// The title of the project.
  final String title;

  /// The subtitle of the project.
  final String subtitle;

  /// The title of the project as a path.
  String get titleAsPath => title.toLowerCase().replaceAll(' ', '_');

  /// The start date of the project.
  final DateTime? startDate;

  /// The final date of the project.
  final DateTime finalDate;

  /// The description of the project.
  final String description;

  /// Relevant external links.
  final List<Map<String, String>> externalLinks;

  /// Relevant tags.
  final List<String> tags;

  /// The list of media items.
  List<MediaItem> mediaItems;

  /// The total number of media items in the project.
  int get totalMediaCount => mediaItems.length;

  /// The base path for the media.
  String get baseMediaPath =>
      'assets/images/personal/${title.toLowerCase().replaceAll(' ', '_')}/';

  /// The path for the thumbnail.
  String get thumbnailPath => '${baseMediaPath}thumbnail.png';

  /// A string representation of the start date.
  String? get startDateString {
    if (startDate == null) {
      return null;
    }
    return DateFormat('MMMM yyyy').format(startDate!);
  }

  /// A string representation of the final date.
  String get finalDateString => DateFormat('MMMM yyyy').format(finalDate);
}
