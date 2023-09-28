import 'package:intl/intl.dart';

class ProfessionalExperience {
  const ProfessionalExperience({
    required this.company,
    required this.role,
    required this.location,
    required this.startDate,
    required this.finalDate,
    required this.description,
    required this.externalLinks,
    required this.youtubeVideoIds,
  });

  /// Creates a [ProfessionalExperience] from a JSON object.
  factory ProfessionalExperience.fromJson(Map<String, dynamic> json) {
    return ProfessionalExperience(
      company: json['company'].toString(),
      role: json['role'].toString(),
      location: json['location'].toString(),
      description: json['description'].toString(),
      startDate: DateTime.parse(json['startDate'].toString()),
      finalDate: json['endDate'] == null
          ? null
          : DateTime.parse(
              json['endDate'].toString(),
            ),
      youtubeVideoIds:
          (json['youtubeVideoIds'] as List<dynamic>).map((dynamic e) {
        return e.toString();
      }).toList(),
      externalLinks: (json['externalLinks'] as List<dynamic>)
          .map((dynamic e) =>
              Map<String, String>.from(e as Map<dynamic, dynamic>))
          .toList(),
    );
  }

  /// The name of the company.
  final String company;

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

  /// The YouTube video IDs.
  final List<String> youtubeVideoIds;

  /// The base path for the media.
  String get baseMediaPath =>
      'images/professional/${company.toLowerCase().replaceAll(' ', '_').replaceAll('.', '')}/';

  /// The path for the thumbnail.
  String get thumbnailPath => '${baseMediaPath}thumbnail.png';

  /// The path for the logo.
  String get logoPath => '${baseMediaPath}logo.png';

  /// A string representation of the start date.
  String get startDateString => DateFormat('MMMM yyyy').format(startDate);

  /// A string representation of the final date.
  String? get finalDateString {
    if (finalDate == null) {
      return null;
    }
    return DateFormat('MMMM yyyy').format(finalDate!);
  }
}
