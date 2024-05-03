import 'package:flutter/material.dart';

import 'frosted_container.dart';

/// A banner that displays a leading widget, a title, and a subtitle.
class HeaderBanner extends StatelessWidget {
  const HeaderBanner({
    super.key,
    required this.title,
    required this.subtitle,
    this.leading,
  });

  /// The widget to display on the left side of the banner.
  final Widget? leading;

  /// The widget to display as the title of the banner.
  final Widget title;

  /// The widget to display as the subtitle of the banner.
  final Widget subtitle;

  @override
  Widget build(BuildContext context) {
    return FrostedContainer(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        children: <Widget>[
          if (leading != null) leading!,
          if (leading != null) const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: title,
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: subtitle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
