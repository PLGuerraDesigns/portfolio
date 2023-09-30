import 'package:intl/intl.dart';

class Project {
  Project({
    required this.title,
    required this.description,
    required this.startDate,
    required this.finalDate,
    required this.imageCount,
    required this.imageCaptions,
    required this.videoCount,
    required this.externalLinks,
    required this.tags,
  });

  /// Creates a [Project] from a JSON object.
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['title'].toString(),
      description: json['description'].toString(),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'].toString()),
      finalDate: DateTime.parse(json['finalDate'].toString()),
      imageCount: int.parse(json['imageCount'].toString()),
      imageCaptions: (json['imageCaptions'] as List<dynamic>).map((dynamic e) {
        return e.toString();
      }).toList(),
      videoCount: int.parse(json['videoCount'].toString()),
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

  /// The title of the project as a path.
  String get titleAsPath => title.toLowerCase().replaceAll(' ', '_');

  /// The start date of the project.
  final DateTime? startDate;

  /// The final date of the project.
  final DateTime finalDate;

  /// The description of the project.
  final String description;

  /// The number of images in the project.
  final int imageCount;

  /// The captions for the images in the project.
  final List<String> imageCaptions;

  /// The number of videos in the project.
  final int videoCount;

  /// Relevant external links.
  final List<Map<String, String>> externalLinks;

  /// Relevant tags.
  final List<String> tags;

  /// The total number of media items in the project.
  int get totalMediaCount => imageCount + videoCount;

  /// The base path for the media.
  String get baseMediaPath =>
      'images/personal/${title.toLowerCase().replaceAll(' ', '_')}/';

  /// The paths for the images in the project.
  List<String> get imagePaths {
    final List<String> paths = <String>[];
    paths.add(thumbnailPath);
    for (int i = 1; i < imageCount; i++) {
      paths.add('${baseMediaPath}image_$i.png');
    }
    return paths;
  }

  /// The paths for the videos in the project.
  List<String> get videoPaths {
    final List<String> paths = <String>[];
    for (int i = 1; i < videoCount + 1; i++) {
      paths.add('${baseMediaPath}video_$i.mp4');
    }
    return paths;
  }

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
