import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../../common/asset_paths.dart';
import '../../../common/strings.dart';
import '../../../widgets/frosted_container.dart';
import 'social_media_buttons.dart';

/// A header banner with a profile photo, name, subtitle, and social media
/// buttons.
class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.compact,
  });

  /// Whether the header should be compact.
  final bool compact;

  /// My profile picture.
  CircleAvatar _profilePicture(BuildContext context) {
    return CircleAvatar(
      radius: compact ? 38 : 55,
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      backgroundImage: const AssetImage(AssetPaths.profilePhoto),
    );
  }

  /// The title of the header.
  Row _title(BuildContext context) {
    return Row(
      crossAxisAlignment:
          compact ? CrossAxisAlignment.center : CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          Strings.name,
          style: compact
              ? Theme.of(context).textTheme.titleLarge
              : Theme.of(context).textTheme.headlineLarge,
        ),
        const Spacer(),
        if (!compact) const SocialMediaButtons(),
        const SizedBox(width: 8.0),
        if (compact) _location(context),
      ],
    );
  }

  /// The subtitle of the header.
  Row _subtitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: DefaultTextStyle(
            style: compact
                ? Theme.of(context).textTheme.labelSmall!
                : Theme.of(context).textTheme.titleMedium!,
            maxLines: 2,
            child: AnimatedTextKit(
              repeatForever: true,
              pause: const Duration(milliseconds: 250),
              animatedTexts: Strings.headerSubtitles.map<AnimatedText>(
                (String text) {
                  return RotateAnimatedText(
                    text,
                    alignment: Alignment.centerLeft,
                    duration: const Duration(seconds: 7),
                  );
                },
              ).toList(),
            ),
          ),
        ),
        SizedBox(
          height: compact ? 40 : 55,
        ),
        if (!compact) _location(context),
      ],
    );
  }

  /// My current location.
  Widget _location(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.pin_drop,
          size: compact ? 14 : 18,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
        ),
        const SizedBox(width: 4.0),
        Text(
          Strings.currentLocation,
          style: compact
              ? Theme.of(context).textTheme.labelSmall
              : Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(width: 18.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FrostedContainer(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        children: <Widget>[
          _profilePicture(context),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: _title(context),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: _subtitle(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
