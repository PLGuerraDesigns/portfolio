import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/asset_paths.dart';
import '../../../common/routing/routes.dart';
import '../../../common/strings.dart';
import '../../../widgets/floating_thumbnail.dart';
import '../../../widgets/frosted_container.dart';

/// A menu that allows the user to navigate to the professional experience
/// and personal projects screens.
class ProfessionalVsPersonalMenu extends StatelessWidget {
  const ProfessionalVsPersonalMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return FrostedContainer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              Strings.explore.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Theme.of(context).hintColor.withOpacity(0.75),
                  ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: FloatingThumbnail(
                    title: Strings.professional,
                    image: AssetPaths.professionalExperiencePhoto,
                    shimmer: true,
                    selfTilt: true,
                    onTap: () => context.go(Routes.professionalExperiences),
                  ),
                ),
                Column(
                  children: <Widget>[
                    const Expanded(
                      child: VerticalDivider(
                        indent: 8,
                        endIndent: 8,
                      ),
                    ),
                    Text(
                      Strings.or.toUpperCase(),
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Theme.of(context).hintColor.withOpacity(0.5),
                          ),
                    ),
                    const Expanded(
                      child: VerticalDivider(
                        indent: 8,
                        endIndent: 8,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: FloatingThumbnail(
                    title: Strings.personal,
                    image: AssetPaths.personalExperiencePhoto,
                    shimmer: true,
                    selfTilt: true,
                    onTap: () => context.go(Routes.personalProjects),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
