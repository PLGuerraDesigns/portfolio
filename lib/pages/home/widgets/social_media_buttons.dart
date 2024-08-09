import 'package:flutter/material.dart';

import '../../../common/asset_paths.dart';
import '../../../common/strings.dart';
import '../../../common/urls.dart';
import '../../../services/redirect_handler.dart';

/// A list of social media buttons that redirect to the respective URLs.
class SocialMediaButtons extends StatelessWidget {
  const SocialMediaButtons({super.key});

  Widget _iconButton({
    required BuildContext context,
    required String label,
    required String url,
  }) {
    return IconButton(
      icon: Image.asset(
        AssetPaths.socialMediaIcon(label),
        height: 24.0,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      tooltip: label,
      onPressed: () => RedirectHandler.openUrl(url),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _iconButton(
          context: context,
          label: Strings.github,
          url: Urls.github,
        ),
        _iconButton(
          context: context,
          label: Strings.linkedin,
          url: Urls.linkedin,
        ),
        _iconButton(
          context: context,
          label: Strings.youtube,
          url: Urls.youtube,
        ),
        _iconButton(
          context: context,
          label: Strings.thingiverse,
          url: Urls.thingiverse,
        ),
      ],
    );
  }
}
