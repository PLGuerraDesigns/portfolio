import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

/// Thumbnail for a network image.
class NetworkImageThumbnail extends StatelessWidget {
  const NetworkImageThumbnail({
    super.key,
    required this.url,
  });

  /// The url of the image.
  final String url;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.cover,
      child: Stack(
        children: <Widget>[
          ImageNetwork(
            image: url,
            height: 120,
            width: 120,
            onLoading: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white70,
              ),
            ),
            onError: const Center(
              child: Icon(
                Icons.error_outline,
                color: Colors.white70,
                size: 48.0,
              ),
            ),
          ),
          // Container to block the ImageNetwork onTap event from being reached.
          Container(
            width: 120,
            height: 120,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
