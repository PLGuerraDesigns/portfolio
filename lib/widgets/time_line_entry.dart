import 'package:flutter/material.dart';

import '../common/color_schemes.dart';
import '../services/redirect_handler.dart';

/// A timeline entry widget containing an icon, title, description, and time
/// frame. The title is a clickable link that redirects to the specified URL.
class TimelineEntry extends StatelessWidget {
  const TimelineEntry({
    super.key,
    required this.logoPath,
    required this.title,
    required this.description,
    required this.timeFrame,
    required this.urlString,
  });

  /// The path to the logo.
  final String logoPath;

  /// The title of the entry.
  final String title;

  /// The description of the entry.
  final String description;

  /// The time frame of the entry.
  final String timeFrame;

  /// The URL string to redirect to.
  final String urlString;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 0,
        dense: false,
        visualDensity: VisualDensity.standard,
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: lightColorScheme.surface,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              logoPath,
              fit: BoxFit.contain,
              height: 50,
              width: 50,
            ),
          ),
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () => RedirectHandler.openUrl(urlString),
            child: Text(title.toUpperCase()),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(
            '$timeFrame\n$description',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
