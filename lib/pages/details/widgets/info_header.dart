import 'package:flutter/material.dart';

import '../../../common/strings.dart';
import '../../../common/theming/color_schemes.dart';
import '../details.model.dart';

/// Builds the header with the logo, title, subtitle, and date range.
class InfoHeader extends StatelessWidget {
  const InfoHeader({
    super.key,
    required this.details,
    required this.compact,
  });

  final Details details;
  final bool compact;

  /// The date range text to display.
  String get dateRangeText {
    String startDateText = '';
    if (details.startDate != null) {
      startDateText = details.startDate!;
    }

    if (details.endDate == null) {
      return '$startDateText - ${Strings.present}';
    } else if (details.endDate != details.startDate) {
      return '$startDateText - ${details.endDate}';
    }

    return startDateText;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (details.logoPath != null)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: PortfolioColorSchemes.light.surface,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  details.logoPath!,
                  fit: BoxFit.contain,
                  height: 40,
                  width: 40,
                ),
              ),
            ),
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              details.title,
              style: compact
                  ? Theme.of(context).textTheme.titleMedium
                  : Theme.of(context).textTheme.titleLarge,
            ),
            if (details.subtitle.isNotEmpty)
              Text(
                details.subtitle,
                style: compact
                    ? Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.normal,
                        )
                    : Theme.of(context).textTheme.titleMedium,
              ),
            Text(
              dateRangeText,
              style: compact
                  ? Theme.of(context).textTheme.bodySmall
                  : Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}
