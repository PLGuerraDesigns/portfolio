import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../common/enums.dart';
import '../models/media_item.dart';
import 'hover_scale_handler.dart';

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

  /// Thumbnail for a YouTube video.
  Widget _youTubeVideoThumbnail(
    String path,
  ) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: <Widget>[
        Image.network(
          'https://i3.ytimg.com/vi/$path/sddefault.jpg',
          fit: BoxFit.cover,
          cacheHeight: 250,
        ),
        ColoredBox(
          color: Colors.transparent,
          child: Center(
            child: Icon(
              Icons.play_circle,
              color: Colors.red.withOpacity(0.95),
              size: 48.0,
            ),
          ),
        ),
      ],
    );
  }

  /// Thumbnail for a local video.
  Widget _videoThumbnail(String path) {
    return Stack(
      children: <Widget>[
        Chewie(
          controller: ChewieController(
            videoPlayerController: VideoPlayerController.asset(
              path,
            ),
            showControls: false,
            allowFullScreen: false,
            allowMuting: false,
            placeholder: Container(
              color: Colors.black,
            ),
          ),
        ),
        const ColoredBox(
          color: Colors.transparent,
          child: Center(
            child: Icon(
              Icons.play_circle_outline,
              color: Colors.white70,
              size: 48.0,
            ),
          ),
        ),
      ],
    );
  }

  /// Thumbnail for a local image.
  Widget _imageThumbnail(String path) {
    return Image.asset(
      path,
      cacheHeight: 250,
      width: 250,
      height: 250,
      fit: BoxFit.cover,
    );
  }

  /// Thumbnail for a network image.
  Widget _networkImageThumbnail(String path) {
    return Image.network(
      path,
      cacheHeight: 250,
      height: 250,
      width: 250,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.white70,
            ),
          ),
        );
      },
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return const Center(
          child: Icon(
            Icons.error_outline,
            color: Colors.white70,
            size: 48.0,
          ),
        );
      },
      fit: BoxFit.cover,
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: ColoredBox(
                      color: Colors.black12,
                      child: mediaItems[index].type == MediaType.localImage
                          ? _imageThumbnail(mediaItems[index].path)
                          : mediaItems[index].type == MediaType.networkImage
                              ? _networkImageThumbnail(mediaItems[index].path)
                              : mediaItems[index].type == MediaType.localVideo
                                  ? _videoThumbnail(mediaItems[index].path)
                                  : _youTubeVideoThumbnail(
                                      mediaItems[index].path),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
