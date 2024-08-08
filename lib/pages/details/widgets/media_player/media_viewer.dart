import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:video_player/video_player.dart';

import '../../../../common/enums.dart';
import '../../../../models/media_item.dart';
import 'image_viewer.dart';
import 'local_video_player.dart';
import 'youtube_player.dart';

/// The viewer for the media player.
class MediaViewer extends StatelessWidget {
  const MediaViewer({
    super.key,
    required this.axis,
    required this.mediaItems,
    required this.totalMediaCount,
    required this.imagePageController,
  });

  /// The axis of the media player and browser.
  final Axis axis;

  /// The media to display.
  final List<MediaItem> mediaItems;

  /// The total number of media items.
  final int totalMediaCount;

  /// The controller for the image gallery.
  final PageController imagePageController;

  /// Returns the media widget based on the media type.
  Widget _media(MediaItem mediaItem) {
    final MediaType mediaType = mediaItem.type;
    switch (mediaType) {
      case MediaType.youTubeVideo:
        return CustomYouTubePlayer(videoId: mediaItem.source);
      case MediaType.localVideo:
        return LocalVideoPlayer(
          videoPlayerController: VideoPlayerController.asset(mediaItem.source),
        );
      case MediaType.localImage:
        return ImageViewer(
          imageProvider: AssetImage(mediaItem.source),
        );
      case MediaType.networkImage:
        return ImageViewer(
          imageProvider: NetworkImage(mediaItem.source),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: axis == Axis.vertical
              ? null
              : MediaQuery.of(context).size.height * 0.75,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: PhotoViewGallery.builder(
              enableRotation: true,
              itemCount: totalMediaCount,
              pageController: imagePageController,
              scrollPhysics: const NeverScrollableScrollPhysics(),
              backgroundDecoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions.customChild(
                  disableGestures: true,
                  heroAttributes: PhotoViewHeroAttributes(
                    tag: index.toString(),
                  ),
                  child: SizedBox(
                    key: ValueKey<String>(mediaItems[index].source),
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: _media(mediaItems[index]),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
