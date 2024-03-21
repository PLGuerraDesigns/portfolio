import 'package:flutter/material.dart';

import '../services/redirect_handler.dart';

/// A social icon button widget containing an icon that redirects to the
/// specified URL.
class SocialIconButton extends StatelessWidget {
  const SocialIconButton({
    super.key,
    required this.title,
    required this.socialAssetBasePath,
    required this.urlString,
  });

  /// The title of the social media platform.
  final String title;

  /// The base path to the social media assets.
  final String socialAssetBasePath;

  /// The URL string to redirect to.
  final String urlString;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        '$socialAssetBasePath/${title.toLowerCase()}.webp',
        height: 24.0,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      tooltip: title,
      onPressed: () => RedirectHandler.openUrl(urlString),
    );
  }
}
