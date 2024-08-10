import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../common/enums.dart';
import '../../../../models/media_item.dart';

class MultiMediaPlayerController extends ChangeNotifier {
  MultiMediaPlayerController({
    required this.mediaItems,
    required bool isMediaBrowserOpen,
    required Function() updateMediaBrowserVisibilityState,
  }) {
    _isMediaBrowserOpen = isMediaBrowserOpen;
    _updateMediaBrowserVisibilityState = updateMediaBrowserVisibilityState;
    imagePageController = PageController(
      initialPage: currentIndex,
    );
  }

  /// The index of the current media item.
  int currentIndex = 0;

  /// The list of media items to display.
  final List<MediaItem> mediaItems;

  /// The current media item.
  MediaItem get currentMediaItem => mediaItems[currentIndex];

  /// The total number of media items.
  int get totalMediaCount => mediaItems.length;

  /// Whether the media browser is visible.
  bool _isMediaBrowserOpen = false;
  bool get isMediaBrowserOpen => _isMediaBrowserOpen;

  /// The axis of the media player and browser.
  Axis browserAxis = Axis.vertical;

  /// The controller for the image gallery.
  late PageController imagePageController;

  /// The controller for the video player.
  VideoPlayerController? _videoPlayerController;

  /// The function to call to toggle the media browser.
  late Function() _updateMediaBrowserVisibilityState;

  /// The video player controller.
  VideoPlayerController? get videoPlayerController {
    if (_videoPlayerController?.dataSource != currentMediaItem.source) {
      _disposeVideoPlayerController();
    }

    if (currentMediaItem.type == MediaType.localVideo &&
        _videoPlayerController != null) {
      return _videoPlayerController;
    } else if (currentMediaItem.type == MediaType.localVideo &&
        _videoPlayerController == null) {
      _videoPlayerController = VideoPlayerController.asset(
        currentMediaItem.source,
      );
      return _videoPlayerController;
    }
    return _videoPlayerController;
  }

  /// Toggle the media browser.
  void toggleMediaBrowser() {
    _updateMediaBrowserVisibilityState();
    _isMediaBrowserOpen = !_isMediaBrowserOpen;
    notifyListeners();
  }

  /// Navigate to the previous media item.
  Future<void> onPrevious() async {
    int previousIndex = currentIndex - 1;
    if (previousIndex < 0) {
      previousIndex = totalMediaCount - 1;
      imagePageController.jumpToPage(previousIndex);
    } else {
      if (<MediaType>[MediaType.youTubeVideo, MediaType.localVideo]
          .contains(mediaItems[currentIndex].type)) {
        imagePageController.jumpToPage(previousIndex);
      } else {
        await imagePageController.animateToPage(
          previousIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
    currentIndex = previousIndex;
    notifyListeners();
  }

  /// Navigate to the next media item.
  Future<void> onNext() async {
    int nextIndex = currentIndex + 1;
    if (nextIndex == totalMediaCount) {
      nextIndex = 0;
      imagePageController.jumpToPage(nextIndex);
    } else {
      if (<MediaType>[MediaType.youTubeVideo, MediaType.localVideo]
          .contains(mediaItems[currentIndex].type)) {
        imagePageController.jumpToPage(nextIndex);
      } else {
        await imagePageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
    currentIndex = nextIndex;
    notifyListeners();
  }

  /// The function to call when a media item is selected.
  void onMediaSelected(int index) {
    imagePageController.jumpToPage(index);
    currentIndex = index;
    notifyListeners();
  }

  /// Dispose of the video player controller.
  void _disposeVideoPlayerController() {
    _videoPlayerController?.dispose();
    _videoPlayerController = null;
  }

  @override
  void dispose() {
    imagePageController.dispose();
    _disposeVideoPlayerController();
    super.dispose();
  }
}
