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
  final VideoPlayerController videoPlayerController;

  @override
  Widget build(BuildContext context) {
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
        return const Spinner();
      },
    );
  }
}
