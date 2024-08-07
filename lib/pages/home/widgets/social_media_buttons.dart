import 'package:flutter/material.dart';

import '../../../common/asset_paths.dart';
import '../../../common/strings.dart';
import '../../../common/urls.dart';
import 'social_icon_button.dart';

/// A list of social media buttons that redirect to the respective URLs.
class SocialMediaButtons extends StatelessWidget {
  const SocialMediaButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SocialIconButton(
          title: Strings.github,
          socialAssetBasePath: AssetPaths.socialIconsBase,
          urlString: Urls.github,
        ),
        SocialIconButton(
          title: Strings.linkedin,
          socialAssetBasePath: AssetPaths.socialIconsBase,
          urlString: Urls.linkedin,
        ),
        SocialIconButton(
          title: Strings.thingiverse,
          socialAssetBasePath: AssetPaths.socialIconsBase,
          urlString: Urls.thingiverse,
        ),
      ],
    );
  }
}
