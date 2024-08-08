import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unorm_dart/unorm_dart.dart' as unorm;

import '../common/enums.dart';
import '../common/routing/routes.dart';
import '../common/strings.dart';
import '../common/urls.dart';
import '../pages/details/details.model.dart';
import '../pages/home/widgets/time_line_entry.dart';
import 'media_item.dart';

class ProfessionalExperience {
  ProfessionalExperience({
    required this.company,
    required this.folderName,
    required this.role,
    required this.location,
    required this.startDate,
    required this.finalDate,
    required this.mediaItems,
    required this.description,
    required this.externalLinks,
  });

  /// Creates a [ProfessionalExperience] from a JSON object.
  factory ProfessionalExperience.fromJson(Map<String, dynamic> json) {
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
            'assets/images/professional/${json['folderName'].toString().toLowerCase().replaceAll(' ', '_')}/${mediaItem.source}';
      }
    }

    return ProfessionalExperience(
      company: json['company'].toString(),
      folderName: json['folderName'].toString(),
      role: json['role'].toString(),
      location: json['location'].toString(),
      description: json['description'].toString(),
      startDate: DateTime.parse(json['startDate'].toString()),
      mediaItems: mediaItems,
      finalDate: json['endDate'] == null
          ? null
          : DateTime.parse(
              json['endDate'].toString(),
            ),
      externalLinks: (json['externalLinks'] as List<dynamic>)
          .map((dynamic e) =>
              Map<String, String>.from(e as Map<dynamic, dynamic>))
          .toList(),
    );
  }

  /// The name of the company.
  final String company;

  /// The name of the folder.
  final String folderName;

  /// The name of the company and role as a path
  String get titleAsPath => unorm.nfkc(
      '${company.toLowerCase().replaceAll(' ', '-')}_${role.toLowerCase().replaceAll(' ', '-')}');

  /// The role in the company.
  final String role;

  /// The location of the company.
  final String location;

  /// The start date of the experience.
  final DateTime startDate;

  /// The final date of the experience.
  final DateTime? finalDate;

  /// The description of the experience.
  final String description;

  /// Relevant external links.
  final List<Map<String, String>> externalLinks;

  /// The list of media items.
  List<MediaItem> mediaItems;

  /// The total number of media items in the project.
  int get totalMediaCount => mediaItems.length;

  /// The base path for the media.
  String get baseMediaPath => 'assets/images/professional/$folderName/';

  /// The path for the thumbnail.
  String get thumbnailPath => '${baseMediaPath}thumbnail.webp';

  /// The path for the logo.
  String get logoPath => '${baseMediaPath}logo.webp';

  /// A string representation of the start date.
  String get startDateString =>
      DateFormat('MMM yyyy').format(startDate).toUpperCase();

  /// A string representation of the final date.
  String? get finalDateString {
    if (finalDate == null) {
      return null;
    }
    return DateFormat('MMM yyyy').format(finalDate!).toUpperCase();
  }

  /// A timeline entry for the professional experience.
  TimelineEntry get timelineEntry => TimelineEntry(
        logoPath: logoPath,
        title: company,
        label: Strings.professionalExperiences,
        labelColor: Colors.deepOrangeAccent,
        description: role,
        startDate: startDate,
        finalDateString: finalDateString == null
            ? Strings.present.toUpperCase()
            : '$finalDateString',
        urlString:
            '${Urls.portfolioBase}${Routes.professionalExpDetails(titleAsPath: titleAsPath)}',
        coverImage: false,
      );

  /// The details for the professional experience.
  Details get details => Details(
        title: company,
        titleAsPath: titleAsPath,
        subtitle: role,
        appBarTitle: Strings.professionalExperiences,
        logoPath: logoPath,
        description: description,
        externalLinks: externalLinks,
        startDate: startDateString,
        endDate: finalDateString,
        mediaItems: mediaItems,
        tags: const <String>[],
      );
}
