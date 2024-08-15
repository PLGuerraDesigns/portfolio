import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/routing/routes.dart';
import '../../../models/project.dart';
import '../../../widgets/hover_scale_handler.dart';
import '../../../widgets/tilt_handler.dart';

/// A project thumbnail widget containing an image, title, and subtitle. Can be
/// tapped to perform an action.
class ProjectThumbnail extends StatefulWidget {
  const ProjectThumbnail({
    super.key,
    required this.project,
  });

  /// The project to display.
  final Project project;

  @override
  State<ProjectThumbnail> createState() => _ProjectThumbnailState();
}

class _ProjectThumbnailState extends State<ProjectThumbnail> {
  /// The project to display.
  Project get project => widget.project;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: HoverScaleHandler(
        onTap: () => context.go(
          Routes.projectDetails(
            titleAsPath: project.titleAsPath,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TiltHandler(
              reducedMotion: true,
              child: AspectRatio(
                aspectRatio: 1.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    project.thumbnailPath,
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
            ),
            const SizedBox(height: 8.0),
            Text(
              project.title,
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              project.subtitle,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
