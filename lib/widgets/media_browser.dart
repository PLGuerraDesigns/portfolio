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
    required this.videoPaths,
    required this.onTapped,
    required this.youtubeVideoIds,
  });

  /// A list of YouTube video IDs.
  final List<String> youtubeVideoIds;

  /// A list of local image paths.
  final List<String> imagePaths;

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
        const SizedBox(height: 8.0),
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
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Image.network(
                      'https://i3.ytimg.com/vi/${youtubeVideoIds[index]}/sddefault.jpg',
                      fit: BoxFit.cover,
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
            );
          },
        ),
        const SizedBox(height: 8.0),
        const Divider(
          indent: 8.0,
          endIndent: 8.0,
        ),
      ],
    );
  }

  /// Builds the video gallery.
  Widget _videoGallery(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            Strings.videos,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
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
                onTapped!(youtubeVideoIds.length + imagePaths.length + index);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Stack(
                  children: <Widget>[
                    Chewie(
                      controller: ChewieController(
                        videoPlayerController: VideoPlayerController.asset(
                          videoPaths[index],
                        )..initialize(),
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
            );
          },
        ),
        const SizedBox(height: 8.0),
        const Divider(
          indent: 8.0,
          endIndent: 8.0,
        ),
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
            const SizedBox(height: 8.0),
            Text(
              Strings.images,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8.0),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: imagePaths.length,
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
                    onTapped!(youtubeVideoIds.length + index);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Image.asset(
                      imagePaths[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 8.0),
            const Divider(
              indent: 8.0,
              endIndent: 8.0,
            ),
            if (videoPaths.isNotEmpty) _videoGallery(context),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
