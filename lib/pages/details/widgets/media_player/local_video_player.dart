import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../widgets/spinner.dart';

/// A video player that plays a local video.
class LocalVideoPlayer extends StatelessWidget {
  const LocalVideoPlayer({
    super.key,
    required this.videoPlayerController,
  });

  /// The controller for the video player.
  final VideoPlayerController? videoPlayerController;

  @override
  Widget build(BuildContext context) {
    if (videoPlayerController == null) {
      return const Spinner();
    }
    return Chewie(
      controller: ChewieController(
        videoPlayerController: videoPlayerController!,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoInitialize: true,
        zoomAndPan: true,
        showControlsOnInitialize: false,
        hideControlsTimer: const Duration(milliseconds: 1500),
        materialProgressColors: ChewieProgressColors(
          backgroundColor: Colors.white10,
          bufferedColor: Colors.white24,
          playedColor: Colors.white38,
        ),
      ),
    );
  }
}
