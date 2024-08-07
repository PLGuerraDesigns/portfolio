import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

import '../../../../common/enums.dart';
import '../../../../common/theming/color_schemes.dart';
import '../../../../models/media_item.dart';
import '../../../../widgets/frosted_container.dart';
import '../../../../widgets/gallery_controls.dart';
import 'media_browser.dart';

/// Displays different types of media (images, videos, youTubeVideo videos)
/// with controls for navigating between them.
class MediaPlayer extends StatefulWidget {
  const MediaPlayer({
    super.key,
    required this.mediaList,
    required this.browserAxis,
    required this.currentIndex,
    required this.onMediaSelected,
    required this.onMediaBrowserToggle,
    required this.isMediaBrowserVisible,
  });

  /// The index of the current media item.
  final int currentIndex;

  /// The list of media items to display.
  final List<MediaItem> mediaList;

  /// The function to call when the media browser is toggled.
  final Function() onMediaBrowserToggle;

  /// The function to call when a media item is selected.
  final Function(int)? onMediaSelected;

  /// Whether the media browser is visible.
  final bool isMediaBrowserVisible;

  /// The axis of the media player and browser.
  final Axis browserAxis;

  @override
  State<MediaPlayer> createState() => MediaPlayerState();
}

class MediaPlayerState extends State<MediaPlayer> {
  /// Whether the media browser is visible.
  late bool _isMediaBrowserVisible;

  /// The index of the current media item.
  late int _currentIndex;

  /// The controller for the image gallery.
  late PageController _imagePageController;

  /// The controller for the video player.
  VideoPlayerController? _videoPlayerController;

  int get totalMediaCount => widget.mediaList.length;

  List<MediaItem> get mediaItems => widget.mediaList;

  /// The viewer for the media gallery.
  Widget _viewer(BoxConstraints constraints) {
    return SizedBox(
      width: constraints.maxWidth,
      height: widget.browserAxis == Axis.vertical
          ? null
          : MediaQuery.of(context).size.height * 0.75,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: PhotoViewGallery.builder(
          scrollPhysics: const NeverScrollableScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions.customChild(
              disableGestures: true,
              heroAttributes: PhotoViewHeroAttributes(
                tag: index.toString(),
              ),
              child: ZoomOverlay(
                twoTouchOnly: true,
                modalBarrierColor: Colors.black87,
                minScale: 0.5,
                maxScale: 3.0,
                animationDuration: const Duration(milliseconds: 300),
                child: SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: _media(index),
                ),
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
        ),
      ),
    );
  }

  /// Builds the media browser.
  Widget _mediaBrowser({required BuildContext context}) {
    return Padding(
      padding: !widget.isMediaBrowserVisible
          ? EdgeInsets.zero
          : widget.browserAxis == Axis.vertical
              ? const EdgeInsets.only(bottom: 8.0)
              : const EdgeInsets.only(left: 8.0),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        child: SizedBox(
          height: _isMediaBrowserVisible
              ? widget.browserAxis == Axis.vertical
                  ? double.infinity
                  : MediaQuery.of(context).size.height * 0.8
              : 0,
          width: _isMediaBrowserVisible
              ? widget.browserAxis == Axis.vertical
                  ? double.infinity
                  : MediaQuery.of(context).size.width * 0.25
              : 0,
          child: Flex(
            direction: widget.browserAxis,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Divider(),
              Flexible(
                child: Padding(
                  padding: widget.browserAxis == Axis.vertical
                      ? const EdgeInsets.only(left: 8.0, bottom: 4.0)
                      : const EdgeInsets.only(top: 8.0),
                  child: MediaBrowser(
                    mediaItems: mediaItems,
                    onTapped: widget.onMediaSelected,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// A banner that displays captions and controls for the player.
  Widget _playerControlBanner(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: widget.browserAxis == Axis.horizontal &&
                  _isMediaBrowserVisible
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
                  mediaItems[_currentIndex].caption,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: GalleryControls(
                currentIndex: _currentIndex,
                totalMediaCount: totalMediaCount,
                onPrevious: _onPrevious,
                onNext: _onNext,
                onMediaBrowser: () {
                  widget.onMediaBrowserToggle();
                  setState(() {
                    _isMediaBrowserVisible = !_isMediaBrowserVisible;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// The current media item.
  Widget _media(int index) {
    final MediaType mediaType = mediaItems[index].type;
    switch (mediaType) {
      case MediaType.youTubeVideo:
        return _youTubePlayer(mediaItems[_currentIndex].path);
      case MediaType.localVideo:
        if (_videoPlayerController != null) {
          _videoPlayerController!.dispose();
        }
        _videoPlayerController = VideoPlayerController.asset(
          mediaItems[index].path,
        );
        return _localVideoPlayer(_videoPlayerController!);
      case MediaType.localImage:
        return _imageViewer(AssetImage(mediaItems[index].path));
      case MediaType.networkImage:
        return _imageViewer(NetworkImage(mediaItems[index].path));
    }
  }

  /// A YouTube video player.
  Widget _youTubePlayer(String videoId) {
    return YoutubePlayer(
      controller: YoutubePlayerController.fromVideoId(
        videoId: videoId,
        autoPlay: true,
        params: const YoutubePlayerParams(
          strictRelatedVideos: true,
          loop: true,
        ),
      ),
    );
  }

  /// A local video player.
  Widget _localVideoPlayer(VideoPlayerController videoPlayerController) {
    return FutureBuilder<void>(
      future: videoPlayerController.initialize(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Chewie(
            controller: ChewieController(
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoInitialize: true,
              videoPlayerController: videoPlayerController,
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).hintColor,
          ),
        );
      },
    );
  }

  /// An image viewer.
  Widget _imageViewer(ImageProvider imageProvider) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image(
        image: imageProvider,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.medium,
      ),
    );
  }

  /// Navigate to the previous media item.
  Future<void> _onPrevious() async {
    int previousIndex = _currentIndex - 1;
    if (previousIndex < 0) {
      previousIndex = totalMediaCount - 1;
      _imagePageController.jumpToPage(previousIndex);
      setState(() {
        _currentIndex = previousIndex;
      });
    } else {
      setState(() {
        _currentIndex = previousIndex;
      });
      if (mediaItems[_currentIndex].type == MediaType.youTubeVideo) {
        _imagePageController.jumpToPage(previousIndex);
        return;
      }
      await _imagePageController.animateToPage(
        _currentIndex = previousIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Navigate to the next media item.
  Future<void> _onNext() async {
    int nextIndex = _currentIndex + 1;
    if (nextIndex == totalMediaCount) {
      nextIndex = 0;
      _imagePageController.jumpToPage(nextIndex);
      setState(() {
        _currentIndex = nextIndex;
      });
    } else {
      setState(() {
        _currentIndex = nextIndex;
      });
      if (mediaItems[_currentIndex].type == MediaType.youTubeVideo) {
        _imagePageController.jumpToPage(nextIndex);
        return;
      }
      await _imagePageController.animateToPage(
        _currentIndex = nextIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _isMediaBrowserVisible = widget.isMediaBrowserVisible;
    _currentIndex = widget.currentIndex;
    _imagePageController = PageController(
      initialPage: _currentIndex,
    );
    _imagePageController.addListener(() {
      if (_imagePageController.page == null ||
          _imagePageController.page!.round() == _currentIndex) {
        return;
      }
      _currentIndex = _imagePageController.page!.round();
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
                    color: PortfolioColorSchemes.dark.surface.withOpacity(0.9),
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return _viewer(constraints);
                      },
                    ),
                  ),
                  _playerControlBanner(context),
                  if (widget.browserAxis == Axis.vertical)
                    Flexible(
                      child: _mediaBrowser(context: context),
                    ),
                ],
              ),
            ),
            if (widget.browserAxis == Axis.horizontal)
              _mediaBrowser(context: context),
          ],
        ),
      ),
    );
  }
}
