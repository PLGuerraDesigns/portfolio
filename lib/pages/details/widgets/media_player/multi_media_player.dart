import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/theming/color_schemes.dart';
import '../../../../widgets/frosted_container.dart';
import '../media_browser/media_browser.dart';
import 'media_viewer.dart';
import 'multi_media_player.controller.dart';
import 'player_banner.dart';

/// Displays different types of media (images, videos, youTubeVideo videos)
/// with controls for navigating between them.
class MultiMediaPlayer extends StatefulWidget {
  const MultiMediaPlayer({
    super.key,
  });

  @override
  State<MultiMediaPlayer> createState() => MultiMediaPlayerState();
}

class MultiMediaPlayerState extends State<MultiMediaPlayer> {
  /// Builds the media browser.
  Widget _browser({
    required BuildContext context,
    required MultiMediaPlayerController controller,
  }) {
    return Padding(
      padding: !controller.isMediaBrowserOpen
          ? EdgeInsets.zero
          : controller.browserAxis == Axis.vertical
              ? const EdgeInsets.only(bottom: 8.0)
              : const EdgeInsets.only(left: 8.0),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        child: SizedBox(
          height: controller.isMediaBrowserOpen
              ? controller.browserAxis == Axis.vertical
                  ? double.infinity
                  : MediaQuery.of(context).size.height * 0.8
              : 0,
          width: controller.isMediaBrowserOpen
              ? controller.browserAxis == Axis.vertical
                  ? double.infinity
                  : MediaQuery.of(context).size.width * 0.25
              : 0,
          child: Flex(
            direction: controller.browserAxis,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Divider(),
              Flexible(
                child: Padding(
                  padding: controller.browserAxis == Axis.vertical
                      ? const EdgeInsets.only(left: 8.0, bottom: 4.0)
                      : const EdgeInsets.only(top: 8.0),
                  child: MediaBrowser(
                    mediaItems: controller.mediaItems,
                    onTapped: controller.onMediaSelected,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MultiMediaPlayerController>(builder: (BuildContext context,
        MultiMediaPlayerController controller, Widget? child) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: FrostedContainer(
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ColoredBox(
                      color:
                          PortfolioColorSchemes.dark.surface.withOpacity(0.9),
                      child: MediaViewer(
                        axis: controller.browserAxis,
                        mediaItems: controller.mediaItems,
                        totalMediaCount: controller.totalMediaCount,
                        imagePageController: controller.imagePageController,
                      ),
                    ),
                    PlayerBanner(
                      controller: controller,
                      browserAxis: controller.browserAxis,
                    ),
                    if (controller.browserAxis == Axis.vertical)
                      Flexible(
                        child: _browser(
                          context: context,
                          controller: controller,
                        ),
                      ),
                  ],
                ),
              ),
              if (controller.browserAxis == Axis.horizontal)
                _browser(
                  context: context,
                  controller: controller,
                ),
            ],
          ),
        ),
      );
    });
  }
}
