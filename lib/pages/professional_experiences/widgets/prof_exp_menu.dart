import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/routing/routes.dart';
import '../../../models/app_state.dart';
import '../../../widgets/floating_thumbnail.dart';
import '../../../widgets/frosted_container.dart';
import '../../../widgets/spinner.dart';

class ProfessionalExpMenu extends StatelessWidget {
  const ProfessionalExpMenu({
    super.key,
  });

  /// The controller for the scroll view.
  static final ScrollController _scrollController = ScrollController();

  /// Returns a [GridView] with the professional experiences.
  GridView _gridView(Orientation orientation, AppState appState) {
    return GridView.custom(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: orientation == Orientation.portrait ? 1 : 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: orientation == Orientation.portrait ? 16 : 0,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childrenDelegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return FloatingThumbnail(
              title: appState.professionalExperiences[index].company,
              subtitle: appState.professionalExperiences[index].role,
              image: appState.professionalExperiences[index].thumbnailPath,
              logoPath: appState.professionalExperiences[index].logoPath,
              frosted: true,
              onTap: () => context.go(
                Routes.professionalExpDetails(
                  titleAsPath:
                      appState.professionalExperiences[index].titleAsPath,
                ),
              ),
            );
          },
          childCount: appState.professionalExperiences.length,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return Consumer<AppState>(
          builder: (BuildContext context, AppState appState, Widget? child) {
            // ! This should be handled in AppRouter but redirect isn't being called
            // ! on pop, so we're handling it here until it's fixed in GoRouter.
            if (appState.currentRoute != Routes.professionalExperiences) {
              appState.currentRoute = Routes.professionalExperiences;
            }

            return FrostedContainer(
              padding: EdgeInsets.zero,
              child: FutureBuilder<void>(
                future: appState.loadProfessionalExperiences(),
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
                        child: _gridView(orientation, appState),
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
