import 'package:flutter/material.dart';

import '../../../common/strings.dart';
import '../../../common/urls.dart';
import '../../../services/redirect_handler.dart';
import '../../../widgets/hover_scale_handler.dart';

/// Builds the tags menu.
class TagsMenu extends StatelessWidget {
  const TagsMenu({super.key, required this.tags});

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          Strings.tags,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            for (final String tag in tags)
              HoverScaleHandler(
                onTap: () {
                  RedirectHandler.openUrl('${Urls.googleSearchBase}$tag');
                },
                child: Chip(
                    label: Text(tag),
                    backgroundColor:
                        Theme.of(context).colorScheme.surface.withOpacity(0.9)),
              ),
          ],
        ),
      ],
    );
  }
}
