import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/routing/routes.dart';
import '../../../models/app_state.dart';
import '../../../widgets/frosted_container.dart';
import '../../../widgets/spinner.dart';
import 'project_thumbnail.dart';

class ProjectsMenu extends StatelessWidget {
  const ProjectsMenu({
    super.key,
  });

  /// The controller for the scroll view.
  static final ScrollController _scrollController = ScrollController();

  /// Returns a [GridView] with the projects.
  GridView _gridView({
    required AppState appState,
    required Orientation orientation,
  }) {
    const int landscapeCrossAxisCount = 5;
    const int portraitCrossAxisCount = 1;
    const double portraitAspectRatio = 1.175;
    const double landscapeAspectRatio = 1.0;

    return GridView.custom(
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: orientation == Orientation.portrait
            ? portraitCrossAxisCount
            : landscapeCrossAxisCount,
        crossAxisSpacing: 8,
        childAspectRatio: orientation == Orientation.portrait
            ? portraitAspectRatio
            : landscapeAspectRatio,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childrenDelegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return ProjectThumbnail(
            title: appState.projects[index].title,
            subtitle: appState.projects[index].subtitle,
            imagePath: appState.projects[index].thumbnailPath,
            onTap: () => context.go(
              Routes.projectDetails(
                titleAsPath: appState.projects[index].titleAsPath,
              ),
            ),
          );
        },
        childCount: appState.projects.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return Consumer<AppState>(
          builder: (BuildContext context, AppState appState, Widget? child) {
            // ! This should be handled in AppRouter but redirect isn't being called
            // ! on pop, so we're handling it here until it's fixed in GoRouter.
            if (appState.currentRoute != Routes.personalProjects) {
              appState.currentRoute = Routes.personalProjects;
            }

            return FrostedContainer(
              padding: EdgeInsets.zero,
              child: FutureBuilder<void>(
                future: appState.loadProjects(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        padding: orientation == Orientation.portrait
                            ? const EdgeInsets.only(right: 8)
                            : EdgeInsets.zero,
                        controller: _scrollController,
                        child: _gridView(
                          appState: appState,
                          orientation: orientation,
                        ),
                      ),
                    );
                  } else {
                    return const Spinner();
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}
