import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

import '../common/color_schemes.dart';
import '../common/enums.dart';
import '../models/media_item.dart';
import 'frosted_container.dart';
import 'gallery_controls.dart';

/// Displays different types of media (images, videos, youTubeVideo videos)
/// with controls for navigating between them.
class MediaPlayer extends StatefulWidget {
  const MediaPlayer({
    super.key,
    required this.mediaList,
    required this.currentIndex,
    this.onMediaBrowser,
  });

  final int currentIndex;
  final List<MediaItem> mediaList;
  final Function()? onMediaBrowser;

  @override
  State<MediaPlayer> createState() => MediaPlayerState();
}

class MediaPlayerState extends State<MediaPlayer> {
  /// The index of the current media item.
  late int currentIndex;

  /// The controller for the image gallery.
  late PageController _imagePageController;

  /// The controller for the video player.
  VideoPlayerController? _videoPlayerController;

  int get totalMediaCount => widget.mediaList.length;

  List<MediaItem> get mediaItems => widget.mediaList;

  /// A banner that displays captions and controls for the player.
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    mediaItems[currentIndex].caption,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
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

  /// The viewer for the media gallery.
  Widget _viewer(BoxConstraints constraints) {
    return PhotoViewGallery.builder(
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions.customChild(
          heroAttributes: PhotoViewHeroAttributes(
            tag: index.toString(),
          ),
          child: SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: _media(index),
          ),
        );
      },
      enableRotation: true,
      itemCount: widget.mediaList.length,
      backgroundDecoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      pageController: _imagePageController,
      onPageChanged: (_) {},
    );
  }

  /// The current media item.
  Widget _media(int index) {
    final MediaType mediaType = mediaItems[index].type;
    switch (mediaType) {
      case MediaType.youTubeVideo:
        return _youTubePlayer();
      case MediaType.localVideo:
        if (_videoPlayerController != null) {
          _videoPlayerController!.dispose();
        }
        _videoPlayerController = VideoPlayerController.asset(
          mediaItems[index].path,
        );
        return _localVideoPlayer();
      case MediaType.localImage:
        return _imageViewer(AssetImage(mediaItems[index].path));
      case MediaType.networkImage:
        return _imageViewer(NetworkImage(mediaItems[index].path));
    }
  }

  /// A YouTube video player.
  Widget _youTubePlayer() {
    return YoutubePlayer(
      key: Key('yt$currentIndex'),
      controller: YoutubePlayerController.fromVideoId(
        videoId: mediaItems[currentIndex].path,
        autoPlay: true,
        params: const YoutubePlayerParams(
          strictRelatedVideos: true,
        ),
      ),
    );
  }

  /// A local video player.
  Widget _localVideoPlayer() {
    return Chewie(
      key: Key('video$currentIndex'),
      controller: ChewieController(
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoInitialize: true,
        videoPlayerController: _videoPlayerController!,
      ),
    );
  }

  /// An image viewer.
  Widget _imageViewer(ImageProvider imageProvider) {
    return ZoomOverlay(
      modalBarrierColor: Colors.black87,
      minScale: 0.5,
      maxScale: 3.0,
      animationDuration: const Duration(milliseconds: 300),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image(
          image: imageProvider,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  /// Navigate to the previous media item.
  Future<void> _onPrevious() async {
    int previousIndex = currentIndex - 1;
    if (previousIndex < 0) {
      previousIndex = totalMediaCount - 1;
      _imagePageController.jumpToPage(previousIndex);
      setState(() {
        currentIndex = previousIndex;
      });
    } else {
      setState(() {
        currentIndex = previousIndex;
      });
      if (mediaItems[currentIndex].type == MediaType.youTubeVideo) {
        _imagePageController.jumpToPage(previousIndex);
        return;
      }
      await _imagePageController.animateToPage(
        currentIndex = previousIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Navigate to the next media item.
  Future<void> _onNext() async {
    int nextIndex = currentIndex + 1;
    if (nextIndex == totalMediaCount) {
      nextIndex = 0;
      _imagePageController.jumpToPage(nextIndex);
      setState(() {
        currentIndex = nextIndex;
      });
    } else {
      setState(() {
        currentIndex = nextIndex;
      });
      if (mediaItems[currentIndex].type == MediaType.youTubeVideo) {
        _imagePageController.jumpToPage(nextIndex);
        return;
      }
      await _imagePageController.animateToPage(
        currentIndex = nextIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
    _imagePageController = PageController(
      initialPage: currentIndex,
    );
    _imagePageController.addListener(() {
      if (_imagePageController.page == null ||
          _imagePageController.page!.round() == currentIndex) {
        return;
      }

      currentIndex = _imagePageController.page!.round();
    });
  }

  @override
  void dispose() {
    _imagePageController.dispose();
    if (_videoPlayerController != null) {
      _videoPlayerController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ColoredBox(
                color: darkColorScheme.surface.withOpacity(0.9),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return _viewer(constraints);
                  },
                ),
              ),
            ),
            _playerControlBanner(
              context: context,
              onMediaBrowser: widget.onMediaBrowser,
            ),
          ],
        ),
      ),
    );
  }
}
