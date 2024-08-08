import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

/// A custom YouTube player that automatically plays the video.
class CustomYouTubePlayer extends StatelessWidget {
  const CustomYouTubePlayer({
    super.key,
    required this.videoId,
  });

  /// The ID of the YouTube video to display.
  final String videoId;

  @override
  Widget build(BuildContext context) {
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
}
