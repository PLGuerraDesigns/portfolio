import 'package:intl/intl.dart';
import 'package:unorm_dart/unorm_dart.dart' as unorm;

class ProfessionalExperience {
  ProfessionalExperience({
    required this.company,
    required this.folderName,
    required this.role,
    required this.location,
    required this.startDate,
    required this.finalDate,
    required this.description,
    required this.externalLinks,
    required this.youtubeVideoIds,
    required this.imageCount,
    required this.videoCount,
    required this.webImagePaths,
    required this.localMediaCaptions,
  });

  /// Creates a [ProfessionalExperience] from a JSON object.
  factory ProfessionalExperience.fromJson(Map<String, dynamic> json) {
    return ProfessionalExperience(
      company: json['company'].toString(),
      folderName: json['folderName'].toString(),
      role: json['role'].toString(),
      location: json['location'].toString(),
      description: json['description'].toString(),
      startDate: DateTime.parse(json['startDate'].toString()),
      finalDate: json['endDate'] == null
          ? null
          : DateTime.parse(
              json['endDate'].toString(),
            ),
      imageCount: int.parse(json['imageCount'].toString()),
      webImagePaths: json['webImages'] == null
          ? <String>[]
          : (json['webImages'] as List<dynamic>).map((dynamic e) {
              return e.toString();
            }).toList(),
      videoCount: int.parse(json['videoCount'].toString()),
      localMediaCaptions:
          (json['mediaCaptions'] as List<dynamic>).map((dynamic e) {
        return e.toString();
      }).toList(),
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

  /// The name of the folder.
  final String folderName;

  /// The name of the company and role as a path
  String get titleAsPath => unorm.nfkc(
      '${company.toLowerCase().replaceAll(' ', '_')}_${role.toLowerCase().replaceAll(' ', '_')}');

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

  /// The number of images in the project.
  final int imageCount;

  /// The number of videos in the project.
  final int videoCount;

  /// The captions for local media.
  final List<String> localMediaCaptions;

  /// The paths for the web images in the project.
  List<String> webImagePaths = <String>[];

  /// The YouTube video IDs.
  final List<String> youtubeVideoIds;

  /// The base path for the media.
  String get baseMediaPath => 'assets/images/professional/$folderName/';

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

  /// The paths for the videos in the project.
  List<String> get videoPaths {
    final List<String> paths = <String>[];
    for (int i = 1; i < videoCount + 1; i++) {
      paths.add('${baseMediaPath}video_$i.mp4');
    }
    return paths;
  }

  /// The paths for the images in the project.
  List<String> get imagePaths {
    final List<String> paths = <String>[];
    paths.add(thumbnailPath);
    for (int i = 1; i < imageCount; i++) {
      paths.add('${baseMediaPath}image_$i.png');
    }
    return paths;
  }
}
