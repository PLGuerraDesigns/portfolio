import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

/// A simple image viewer that displays an image.
class ImageViewer extends StatelessWidget {
  const ImageViewer({
    super.key,
    required this.imageProvider,
  });

  /// The image provider for the image to display.
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return PinchZoom(
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
}
