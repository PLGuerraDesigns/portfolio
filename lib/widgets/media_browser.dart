import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../common/strings.dart';
import 'hover_scale_handler.dart';

/// Displays a gallery of YouTube videos, local images, and local videos.
class MediaBrowser extends StatelessWidget {
  MediaBrowser({
    super.key,
    required this.imagePaths,
    required this.webImagePaths,
    required this.videoPaths,
    required this.onTapped,
    required this.youtubeVideoIds,
  });

  /// A list of YouTube video IDs.
  final List<String> youtubeVideoIds;

  /// A list of local image paths.
  final List<String> imagePaths;

  /// A list of web image paths.
  final List<String> webImagePaths;

  /// A list of local video paths.
  final List<String> videoPaths;

  /// The function to call when an image, video, or YouTube video is tapped.
  final Function(int)? onTapped;

  /// The controller for the scroll view.
  final ScrollController _scrollController = ScrollController();

  /// Builds the YouTube gallery.
  Widget _youtubeGallery(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          Strings.youTubeVideos,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8.0),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: youtubeVideoIds.length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return HoverScaleHandler(
              onTap: () {
                if (onTapped == null) {
                  return;
                }
                onTapped!(index);
              },
              child: ColoredBox(
                color: Colors.black12,
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: Image.network(
                        'https://i3.ytimg.com/vi/${youtubeVideoIds[index]}/sddefault.jpg',
                        fit: BoxFit.cover,
                        cacheHeight: 250,
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
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 8.0),
        const Divider(),
      ],
    );
  }

  /// Builds the video gallery.
  Widget _videoGallery(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          Strings.videos,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8.0),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: videoPaths.length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return HoverScaleHandler(
              onTap: () {
                if (onTapped == null) {
                  return;
                }
                onTapped!(index + youtubeVideoIds.length);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: ColoredBox(
                  color: Colors.black12,
                  child: Stack(
                    children: <Widget>[
                      Chewie(
                        controller: ChewieController(
                          videoPlayerController: VideoPlayerController.asset(
                            videoPaths[index],
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
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 8.0),
        const Divider(),
      ],
    );
  }

  /// Builds the image gallery.
  Widget _imageGallery(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          Strings.images,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8.0),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: imagePaths.length + webImagePaths.length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return HoverScaleHandler(
              onTap: () {
                if (onTapped == null) {
                  return;
                }
                onTapped!(index + youtubeVideoIds.length + videoPaths.length);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: ColoredBox(
                  color: Colors.black12,
                  child: index < imagePaths.length
                      ? Image.asset(
                          imagePaths[index],
                          cacheHeight: 250,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          webImagePaths[index - imagePaths.length],
                          cacheHeight: 250,
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
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.error_outline,
                                color: Colors.white70,
                                size: 48.0,
                              ),
                            );
                          },
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 8.0),
        const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      controller: _scrollController,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 14.0),
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (youtubeVideoIds.isNotEmpty) _youtubeGallery(context),
            if (videoPaths.isNotEmpty) _videoGallery(context),
            if (imagePaths.isNotEmpty || webImagePaths.isNotEmpty)
              _imageGallery(context),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
