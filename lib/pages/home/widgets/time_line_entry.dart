import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/theming/color_schemes.dart';
import '../../../services/redirect_handler.dart';

/// A timeline entry widget containing an icon, title, description, and time
/// frame. The title is a clickable link that redirects to the specified URL.
class TimelineEntry extends StatelessWidget {
  const TimelineEntry({
    super.key,
    required this.logoPath,
    required this.title,
    required this.label,
    required this.description,
    required this.startDate,
    required this.finalDateString,
    required this.urlString,
    required this.labelColor,
    this.coverImage = true,
  });

  /// The path to the logo.
  final String logoPath;

  /// The title of the entry.
  final String title;

  /// The label of the entry.
  final String label;

  /// The color of the label.
  final Color labelColor;

  /// The description of the entry.
  final String description;

  /// The start date of the entry.
  final DateTime startDate;

  /// The final date of the entry.
  final String finalDateString;

  /// The URL string to redirect to.
  final String urlString;

  /// Whether the image should cover the entire space.
  final bool coverImage;

  /// A string representation of the start date.
  String get startDateString =>
      DateFormat('MMM yyyy').format(startDate).toUpperCase();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 8,
        dense: false,
        visualDensity: VisualDensity.standard,
        leading: ClipOval(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: PortfolioColorSchemes.light.surface,
            ),
            child: Padding(
              padding: coverImage ? EdgeInsets.zero : const EdgeInsets.all(4.0),
              child: Image.asset(
                logoPath,
                fit: coverImage ? BoxFit.cover : BoxFit.contain,
                height: coverImage ? 50 : 38,
                width: coverImage ? 50 : 38,
              ),
            ),
          ),
        ),
        title: Wrap(
          children: <Widget>[
            TextButton(
              onPressed: () => RedirectHandler.openUrl(urlString),
              child: Text(title.toUpperCase()),
            ),
            const SizedBox(width: 2),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Container(
                decoration: BoxDecoration(
                  color: labelColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  label.toUpperCase(),
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: labelColor.withOpacity(0.8),
                      ),
                ),
              ),
            )
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$startDateString - $finalDateString',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
