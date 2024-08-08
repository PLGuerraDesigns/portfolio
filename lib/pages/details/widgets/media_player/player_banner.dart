import 'package:flutter/material.dart';

import '../../../../common/theming/color_schemes.dart';
import 'gallery_controls.dart';
import 'multi_media_player.controller.dart';

/// A banner that displays captions and controls for the player.
class PlayerBanner extends StatelessWidget {
  const PlayerBanner({
    super.key,
    required this.browserAxis,
    required this.controller,
  });

  /// The axis of the media browser.
  final Axis browserAxis;

  /// The controller for the media player.
  final MultiMediaPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: browserAxis == Axis.horizontal &&
                  controller.isMediaBrowserOpen
              ? Border(
                  right: BorderSide(
                    color: PortfolioColorSchemes.dark.surface.withOpacity(0.5),
                  ),
                )
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  controller.currentMediaItem.caption,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: GalleryControls(
                currentIndex: controller.currentIndex,
                totalMediaCount: controller.totalMediaCount,
                onPrevious: controller.onPrevious,
                onNext: controller.onNext,
                onMediaBrowser: controller.toggleMediaBrowser,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
