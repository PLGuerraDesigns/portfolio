import 'package:flutter/material.dart';

import '../../../../common/enums.dart';
import '../../../../models/media_item.dart';
import '../../../../widgets/hover_scale_handler.dart';
import 'local_image_thumbnail.dart';
import 'local_video_thumbnail.dart';
import 'network_image_thumbnail.dart';
import 'youtube_thumbnail.dart';

/// Displays a gallery of YouTube videos, local images, and local videos.
class MediaBrowser extends StatelessWidget {
  MediaBrowser({
    super.key,
    required this.mediaItems,
    required this.onTapped,
  });

  /// The media items to display.
  final List<MediaItem> mediaItems;

  /// The function to call when an image, video, or YouTube video is tapped.
  final Function(int)? onTapped;

  /// The controller for the scroll view.
  final ScrollController _scrollController = ScrollController();

  /// The thumbnail for the specified video.
  String _localVideoThumbnailPath(String source) {
    final String thumbnailPath =
        source.split('_').sublist(0, source.split('_').length - 1).join('_');
    final int index = int.parse(
      source.split('_').last.split('.').first,
    );
    return '${thumbnailPath}_thumbnail_$index.webp';
  }

  /// Returns the thumbnail for the specified media item.
  Widget _thumbnail(MediaItem mediaItem) {
    Widget thumbnailImage;

    if (mediaItem.type == MediaType.localImage) {
      thumbnailImage = LocalImageThumbnail(
        source: mediaItem.source,
      );
    } else if (mediaItem.type == MediaType.networkImage) {
      thumbnailImage = NetworkImageThumbnail(
        url: mediaItem.source,
      );
    } else if (mediaItem.type == MediaType.localVideo) {
      thumbnailImage = LocalVideoThumbnail(
        source: _localVideoThumbnailPath(mediaItem.source),
      );
    } else {
      thumbnailImage = YouTubeThumbnail(
        videoId: mediaItem.source,
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: ColoredBox(
        color: Colors.black12,
        child: thumbnailImage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: true,
      child: CustomScrollView(
        controller: _scrollController,
        shrinkWrap: true,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.only(
              right: 14.0,
              top: 2.0,
              bottom: 2.0,
              left: 2.0,
            ),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              ),
              delegate: SliverChildBuilderDelegate(
                childCount: mediaItems.length,
                (BuildContext context, int index) => HoverScaleHandler(
                  tooltip: mediaItems[index].type.stringValue,
                  onTap: () {
                    if (onTapped == null) {
                      return;
                    }
                    onTapped!(index);
                  },
                  child: _thumbnail(mediaItems[index]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
