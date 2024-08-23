import '../../models/media_item.dart';

class Details {
  Details({
    required this.appBarTitle,
    required this.title,
    required this.titleAsPath,
    required this.subtitle,
    required this.descriptionSource,
    required this.mediaItems,
    required this.tags,
    required this.externalLinks,
    required this.logoPath,
    required this.startDate,
    required this.endDate,
  });

  /// The title of the app bar.
  final String appBarTitle;

  /// The path to the logo image to display.
  final String? logoPath;

  /// The title of the project/experience.
  final String title;

  /// The title as a path.
  final String titleAsPath;

  /// The subtitle of the project/experience.
  final String subtitle;

  /// The start date of the project/experience.
  final String? startDate;

  /// The end date of the project/experience.
  final String? endDate;

  /// The source of the description.
  final String descriptionSource;

  /// The list of media items to display.
  final List<MediaItem> mediaItems;

  /// The tags to display.
  final List<String> tags;

  /// The external links to display.
  final List<Map<String, String>> externalLinks;
}
