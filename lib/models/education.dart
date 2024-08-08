import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../common/strings.dart';
import '../pages/home/widgets/time_line_entry.dart';

/// A class representing an education entry.
class Education {
  Education({
    required this.school,
    required this.degree,
    required this.location,
    required this.startDate,
    required this.finalDate,
    required this.logoPath,
    required this.url,
  });

  /// Creates an [Education] entry from a JSON object.
  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      school: json['school'].toString(),
      degree: json['degree'].toString(),
      location: json['location'].toString(),
      startDate: DateTime.parse(json['startDate'].toString()),
      finalDate: DateTime.parse(json['endDate'].toString()),
      logoPath: 'assets/images/home/${json['logo']}',
      url: json['url'].toString(),
    );
  }

  /// The name of the school.
  final String school;

  /// The degree obtained.
  final String degree;

  /// The location of the school.
  final String location;

  /// The start date of the education.
  final DateTime startDate;

  /// The final date of the education.
  final DateTime finalDate;

  /// The url to the school's website.
  final String url;

  /// The path to the logo of the school.
  final String logoPath;

  /// A string representation of the final date.
  String get finalDateString {
    final String dateString = DateFormat('MMM yyyy').format(finalDate);
    if (finalDate.isBefore(DateTime.now())) {
      return dateString;
    }
    return '$dateString (${Strings.expected})'.toUpperCase();
  }

  /// A timeline entry for the education.
  TimelineEntry get timelineEntry => TimelineEntry(
        title: school,
        logoPath: logoPath,
        startDate: startDate,
        finalDateString: finalDateString,
        description: degree,
        label: Strings.education,
        labelColor: Colors.green,
        urlString: url,
        coverImage: false,
      );
}
