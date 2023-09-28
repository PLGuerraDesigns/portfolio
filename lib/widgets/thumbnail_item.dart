import 'package:flutter/material.dart';

import 'hover_scale_handler.dart';

/// A project thumbnail widget containing an image, title, and subtitle. Can be
/// tapped to perform an action.
class ProjectThumbnail extends StatefulWidget {
  const ProjectThumbnail({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.onTap,
    this.compact = false,
  });

  /// the title of the project.
  final String title;

  /// The subtitle of the project.
  final String subtitle;

  /// The path to the image.
  final String imagePath;

  /// The action to perform when the thumbnail is tapped.
  final Function()? onTap;

  /// Whether the thumbnail should be compact.
  final bool compact;

  @override
  State<ProjectThumbnail> createState() => _ProjectThumbnailState();
}

class _ProjectThumbnailState extends State<ProjectThumbnail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: HoverScaleHandler(
        onTap: widget.onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return Icon(
                      Icons.broken_image_outlined,
                      size: 50,
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceVariant
                          .withOpacity(0.5),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              widget.title,
              style: widget.compact
                  ? Theme.of(context).textTheme.bodyMedium
                  : Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              widget.subtitle,
              style: widget.compact
                  ? Theme.of(context).textTheme.labelMedium
                  : Theme.of(context).textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
