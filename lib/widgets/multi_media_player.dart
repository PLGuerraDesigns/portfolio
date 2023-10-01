import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../common/color_schemes.g.dart';
import 'frosted_container.dart';
import 'gallery_controls.dart';

/// Displays different types of media (images, videos, YouTube videos)
/// with controls for navigating between them.
class MultiMediaPlayer extends StatefulWidget {
  const MultiMediaPlayer({
    super.key,
    required this.youtubeVideoIds,
    required this.videoPaths,
    required this.imagePaths,
    required this.imageCaptions,
    required this.currentIndex,
    this.onMediaBrowser,
  });

  final int currentIndex;
  final List<String> youtubeVideoIds;
  final List<String> videoPaths;
  final List<String> imagePaths;
  final List<String> imageCaptions;
  final Function()? onMediaBrowser;

  @override
  State<MultiMediaPlayer> createState() => MultiMediaPlayerState();
}

class MultiMediaPlayerState extends State<MultiMediaPlayer> {
  /// The index of the current media item.
  late int currentIndex;

  /// The controller for the image gallery.
  late PageController _imagePageController;

  /// The controller for the video player.
  late VideoPlayerController _videoPlayerController;

  /// The number of YouTube videos to display in the gallery.
  int get youtubeCount => widget.youtubeVideoIds.length;

  /// The number of images to display in the gallery.
  int get imageCount => widget.imagePaths.length;

  /// The number of videos to display in the gallery.
  int get videoCount => widget.videoPaths.length;

  /// The total number of media items to display in the gallery.
  int get totalMediaCount => youtubeCount + imageCount + videoCount;

  /// The list of media items to display in the gallery.
  List<MediaItem> get mediaItems {
    final List<MediaItem> items = <MediaItem>[];

    for (int i = 0; i < youtubeCount; i++) {
      items.add(
        MediaItem(
          type: MediaType.youtube,
          path: widget.youtubeVideoIds[i],
          caption: '',
        ),
      );
    }
    for (int i = 0; i < videoCount; i++) {
      items.add(
        MediaItem(
          type: MediaType.video,
          path: widget.videoPaths[i],
          caption: '',
        ),
      );
    }
    for (int i = 0; i < imageCount; i++) {
      items.add(
        MediaItem(
          type: MediaType.image,
          path: widget.imagePaths[i],
          caption:
              i < widget.imageCaptions.length ? widget.imageCaptions[i] : '',
        ),
      );
    }

    return items;
  }

  /// Navigates to the previous media item.
  void _onPrevious() {
    final MediaType currentMediaType = mediaItems[currentIndex].type;

    int previousIndex = currentIndex - 1;
    if (previousIndex < 0) {
      previousIndex = totalMediaCount - 1;
    }
    final MediaType previousMediaType = mediaItems[previousIndex].type;

    if (currentMediaType == MediaType.video) {
      _videoPlayerController.dispose();
    }

    switch (previousMediaType) {
      case MediaType.youtube:
        break;
      case MediaType.video:
        _videoPlayerController = VideoPlayerController.asset(
          mediaItems[previousIndex].path,
        );
      case MediaType.image:
        if (currentMediaType != MediaType.image) {
          currentIndex = previousIndex;
          _setupImagePageController();
          break;
        }

        _imagePageController.animateToPage(
          previousIndex - youtubeCount - videoCount,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
    }

    setState(() {
      currentIndex = previousIndex;
    });
  }

  /// Navigates to the next media item.
  void _onNext() {
    final MediaType currentMediaType = mediaItems[currentIndex].type;

    int nextIndex = currentIndex + 1;
    if (nextIndex == totalMediaCount) {
      nextIndex = 0;
    }
    final MediaType nextMediaType = mediaItems[nextIndex].type;

    if (currentMediaType == MediaType.video) {
      _videoPlayerController.dispose();
    }

    switch (nextMediaType) {
      case MediaType.youtube:
        break;
      case MediaType.video:
        _videoPlayerController = VideoPlayerController.asset(
          mediaItems[nextIndex].path,
        );
      case MediaType.image:
        if (currentMediaType != MediaType.image) {
          _setupImagePageController();
          break;
        }
        _imagePageController.animateToPage(
          nextIndex - youtubeCount - videoCount,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
    }

    setState(() {
      currentIndex = nextIndex;
    });
  }

  /// Builds a banner that displays captions and controls for the player.
  Widget _playerControlBanner(
      {required BuildContext context, required Function()? onMediaBrowser}) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        child: FrostedContainer(
          borderRadiusAmount: 0,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Text(
                  mediaItems[currentIndex].caption,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              GalleryControls(
                currentIndex: currentIndex,
                totalMediaCount: totalMediaCount,
                onPrevious: _onPrevious,
                onNext: _onNext,
                onMediaBrowser: onMediaBrowser,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the YouTube player.
  Widget _youTubePlayer() {
    return Center(
      child: YoutubePlayer(
        key: Key('yt$currentIndex'),
        controller: YoutubePlayerController.fromVideoId(
          videoId: widget.youtubeVideoIds[currentIndex],
          params: const YoutubePlayerParams(
            strictRelatedVideos: true,
          ),
        ),
      ),
    );
  }

  /// Builds the video player.
  Widget _videoPlayer() {
    return Chewie(
      key: Key('video$currentIndex'),
      controller: ChewieController(
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoInitialize: true,
        videoPlayerController: _videoPlayerController,
      ),
    );
  }

  /// Builds the image to be displayed in the image gallery.
  PhotoViewGalleryPageOptions _galleryImageItem(
      BuildContext context, int index) {
    return PhotoViewGalleryPageOptions(
      gestureDetectorBehavior: HitTestBehavior.opaque,
      imageProvider: AssetImage(widget.imagePaths[index]),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * 0.1,
      maxScale: PhotoViewComputedScale.covered * 5,
      filterQuality: FilterQuality.high,
      heroAttributes: PhotoViewHeroAttributes(
        tag: index.toString(),
      ),
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        return const Icon(
          Icons.error_outline,
          color: Colors.black12,
          size: 100,
        );
      },
    );
  }

  /// Builds the image viewer.
  Widget _imageViewer() {
    return PhotoViewGallery.builder(
      scrollPhysics: const NeverScrollableScrollPhysics(),
      builder: _galleryImageItem,
      pageController: _imagePageController,
      itemCount: imageCount,
      backgroundDecoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      onPageChanged: (_) {},
    );
  }

  /// Sets up the image page controller.
  void _setupImagePageController() {
    _imagePageController = PageController(
      initialPage: currentIndex - youtubeCount - videoCount,
    );
    _imagePageController.addListener(() {
      if (_imagePageController.page == null ||
          _imagePageController.page!.round() ==
              currentIndex - youtubeCount - videoCount) {
        return;
      }
      currentIndex =
          _imagePageController.page!.round() + youtubeCount + videoCount;
    });
  }

  @override
  void initState() {
    super.initState();
    // Set up the initial media to be displayed.
    currentIndex = widget.currentIndex;
    if (mediaItems[currentIndex].type == MediaType.video) {
      _videoPlayerController = VideoPlayerController.asset(
        mediaItems[currentIndex].path,
      );
    }
    if (mediaItems[currentIndex].type == MediaType.image) {
      _setupImagePageController();
    }
  }

  @override
  void dispose() {
    if (mediaItems[currentIndex].type == MediaType.video) {
      _videoPlayerController.dispose();
    }
    if (mediaItems[currentIndex].type == MediaType.image) {
      _imagePageController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          child: ColoredBox(
            color: darkColorScheme.surface.withOpacity(0.9),
            child: mediaItems[currentIndex].type == MediaType.youtube
                ? _youTubePlayer()
                : mediaItems[currentIndex].type == MediaType.video
                    ? _videoPlayer()
                    : _imageViewer(),
          ),
        ),
        _playerControlBanner(
          context: context,
          onMediaBrowser: widget.onMediaBrowser,
        ),
      ],
    );
  }
}

/// The different types of media that can be displayed in the gallery.
enum MediaType {
  image,
  video,
  youtube,
}

/// A media item to be displayed in the gallery.
class MediaItem {
  const MediaItem({
    required this.type,
    required this.path,
    required this.caption,
  });

  /// The type of media to be displayed.
  final MediaType type;

  /// The path to the media.
  final String path;

  /// The caption to be displayed with the media.
  final String caption;
}
