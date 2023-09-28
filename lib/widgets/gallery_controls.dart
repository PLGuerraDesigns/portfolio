import 'package:flutter/material.dart';

import '../common/strings.dart';

/// The controls for the media gallery.
class GalleryControls extends StatelessWidget {
  const GalleryControls({
    super.key,
    required this.currentIndex,
    required this.totalMediaCount,
    required this.onPrevious,
    required this.onNext,
    required this.onMediaBrowser,
  });

  /// The index of the current media.
  final int currentIndex;

  /// The total number of media.
  final int totalMediaCount;

  /// The function to call when the previous button is pressed.
  final Function()? onPrevious;

  /// The function to call when the next button is pressed.
  final Function()? onNext;

  /// The function to call when the media browser button is pressed.
  final Function()? onMediaBrowser;

  Widget _iconButton({
    required IconData iconData,
    required String tooltip,
    required Function()? onPressed,
  }) {
    return IconButton(
      padding: EdgeInsets.zero,
      icon: Icon(iconData),
      tooltip: tooltip,
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _iconButton(
          iconData: Icons.chevron_left,
          tooltip: Strings.previous,
          onPressed: onPrevious,
        ),
        Text(
          '${currentIndex + 1} / $totalMediaCount',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        _iconButton(
          iconData: Icons.chevron_right,
          tooltip: Strings.next,
          onPressed: onNext,
        ),
        const SizedBox(width: 8.0),
        _iconButton(
          iconData: Icons.grid_view,
          tooltip: Strings.viewAllMedia,
          onPressed: onMediaBrowser,
        ),
      ],
    );
  }
}
