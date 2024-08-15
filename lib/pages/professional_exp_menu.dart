import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../common/routing/routes.dart';
import '../common/strings.dart';
import '../models/app_state.dart';
import '../models/professional_experience.dart';
import '../widgets/floating_thumbnail.dart';
import '../widgets/frosted_grid_menu.dart';
import '../widgets/generic_app_bar.dart';

/// A screen that displays a collection of professional experiences.
class ProfessionalExperienceMenuScreen extends StatefulWidget {
  const ProfessionalExperienceMenuScreen({super.key});

  @override
  State<ProfessionalExperienceMenuScreen> createState() =>
      _ProfessionalExperienceMenuScreenState();
}

class _ProfessionalExperienceMenuScreenState
    extends State<ProfessionalExperienceMenuScreen> {
  /// The controller for the scroll view.
  static final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar.build(
        context: context,
        title: Strings.professionalExperiences,
      ),
      body: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Consumer<AppState>(
              builder:
                  (BuildContext context, AppState appState, Widget? child) {
                // ! This should be handled in AppRouter but redirect isn't being called
                // ! on pop, so we're handling it here until it's fixed in GoRouter.
                if (appState.currentRoute != Routes.professionalExperiences) {
                  appState.currentRoute = Routes.professionalExperiences;
                }
                return FutureBuilder<void>(
                  future: appState.loadProfessionalExperiences(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    List<Widget>? children;
                    if (snapshot.connectionState == ConnectionState.done) {
                      children = appState.professionalExperiences
                          .map(
                            (ProfessionalExperience exp) => FloatingThumbnail(
                              title: exp.company,
                              subtitle: exp.role,
                              image: exp.thumbnailPath,
                              logoPath: exp.logoPath,
                              frosted: true,
                              onTap: () => context.go(
                                Routes.professionalExpDetails(
                                  titleAsPath: exp.titleAsPath,
                                ),
                              ),
                            ),
                          )
                          .toList();
                    }

                    return FrostedGridMenu(
                      title: Strings.professionalExperiencesExplained,
                      scrollController: _scrollController,
                      mainAxisSpacing:
                          orientation == Orientation.portrait ? 16 : 0,
                      crossAxisSpacing: 16.0,
                      crossAxisCount:
                          orientation == Orientation.portrait ? 1 : 3,
                      children: children,
                    );
                  },
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
