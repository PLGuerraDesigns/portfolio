import 'package:flutter/material.dart';

import '../../../common/strings.dart';
import '../../../services/redirect_handler.dart';

/// Builds the more info section.
class MoreInfo extends StatelessWidget {
  const MoreInfo({
    super.key,
    required this.externalLinks,
  });

  final List<Map<String, String>> externalLinks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(height: 8.0),
        const Divider(height: 32),
        Text(
          Strings.moreInfo,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8.0),
        for (final Map<String, String> link in externalLinks)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Text(
                  '${link['title']}:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(width: 8.0),
                TextButton(
                  child: Text(
                    link['url']!,
                  ),
                  onPressed: () {
                    RedirectHandler.openUrl(link['url']!);
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}
