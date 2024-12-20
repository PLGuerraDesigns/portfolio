import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../common/enums.dart';
import '../common/routing/routes.dart';
import '../common/strings.dart';
import '../common/urls.dart';
import '../pages/details/details.model.dart';
import '../pages/home/widgets/time_line_entry.dart';
import 'media_item.dart';

class Project {
  Project({
    required this.title,
    required this.subtitle,
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
        mediaItems[i].source =
            'assets/images/personal/${json['title'].toString().toLowerCase().replaceAll(' ', '_')}/${mediaItem.source}';
      }
    }

    return Project(
      title: json['title'].toString(),
      subtitle: json['subtitle'].toString(),
      startDate: DateTime.parse(json['startDate'].toString()),
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

  /// The source of the professional experience.
  String get _source => title.toLowerCase().replaceAll(' ', '_');

  /// The source of the project.
  String get descriptionSource =>
      'assets/docs/project_descriptions/$_source.md';

  /// The title of the project as a path.
  String get titleAsPath => title.toLowerCase().replaceAll(' ', '-');

  /// The start date of the project.
  final DateTime startDate;

  /// The final date of the project.
  final DateTime finalDate;

  /// Relevant external links.
  final List<Map<String, String>> externalLinks;

  /// Relevant tags.
  final List<String> tags;

  /// The list of media items.
  List<MediaItem> mediaItems;

  /// The total number of media items in the project.
  int get totalMediaCount => mediaItems.length;

  /// The base path for the media.
  String get baseMediaPath => 'assets/images/personal/$_source/';

  /// The path for the thumbnail.
  String get thumbnailPath => '${baseMediaPath}thumbnail.webp';

  /// A string representation of the start date.
  String get startDateString {
    return DateFormat('MMM yyyy').format(startDate).toUpperCase();
  }

  /// A string representation of the final date.
  String get finalDateString =>
      DateFormat('MMM yyyy').format(finalDate).toUpperCase();

  /// A timeline entry for the professional experience.
  TimelineEntry get timelineEntry => TimelineEntry(
        title: title,
        logoPath: thumbnailPath,
        label: Strings.projects,
        labelColor: Colors.grey,
        startDate: startDate,
        finalDateString: finalDateString,
        description: subtitle,
        urlString:
            '${Urls.portfolioBase}${Routes.projectDetails(titleAsPath: titleAsPath)}',
      );

  /// The details for the project.
  Details get details => Details(
        logoPath: null,
        title: title,
        titleAsPath: titleAsPath,
        appBarTitle: Strings.personalProjects,
        subtitle: subtitle,
        descriptionSource: descriptionSource,
        externalLinks: externalLinks,
        startDate: startDateString,
        endDate: finalDateString,
        mediaItems: mediaItems,
        tags: tags,
      );
}
