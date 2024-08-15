import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/routing/routes.dart';
import '../../common/strings.dart';
import '../../models/app_state.dart';
import '../../models/project.dart';
import '../../widgets/frosted_grid_menu.dart';
import '../../widgets/generic_app_bar.dart';
import 'widgets/filter_menu.dart';
import 'widgets/project_thumbnail.dart';

/// A screen that displays a collection of personal projects.
class ProjectsMenuScreen extends StatefulWidget {
  const ProjectsMenuScreen({super.key});

  @override
  State<ProjectsMenuScreen> createState() => _ProjectsMenuScreenState();
}

class _ProjectsMenuScreenState extends State<ProjectsMenuScreen> {
  /// The controller for the scroll view.
  static final ScrollController _pageScrollController = ScrollController();

  /// The controller for the filter menu.
  static final ScrollController _filterScrollController = ScrollController();

  /// Returns the filter menu.
  Widget _filterMenu({
    required List<String> filterOptions,
    required List<String> selectedFilters,
    required Function(String filter) onToggleFilter,
    required int itemCount,
    required int totalItemCount,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FilterMenu(
          filterOptions: filterOptions,
          selectedFilters: selectedFilters,
          onToggleFilter: onToggleFilter,
          scrollController: _filterScrollController,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            '$itemCount of $totalItemCount',
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar.build(
        context: context,
        title: Strings.personalProjects,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Consumer<AppState>(
            builder: (BuildContext context, AppState appState, Widget? child) {
              // ! This should be handled in AppRouter but redirect isn't being called
              // ! on pop, so we're handling it here until it's fixed in GoRouter.
              if (appState.currentRoute != Routes.personalProjects) {
                appState.currentRoute = Routes.personalProjects;
              }
              return FutureBuilder<void>(
                future: appState.loadProjects(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  List<Widget>? children;
                  if (snapshot.connectionState == ConnectionState.done) {
                    children = appState.filteredProjects
                        .map(
                          (Project project) => ProjectThumbnail(
                            project: project,
                          ),
                        )
                        .toList();
                  }

                  return FrostedGridMenu(
                    title: Strings.personalProjectsExplained,
                    scrollController: _pageScrollController,
                    crossAxisCount: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 1
                        : 5,
                    aspectRatio: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 1.175
                        : 1.0,
                    subtitle: _filterMenu(
                      filterOptions: appState.projectFilterOptions,
                      selectedFilters: appState.selectedProjectFilters,
                      onToggleFilter: appState.toggleSelectedProjectFilter,
                      itemCount: appState.filteredProjects.length,
                      totalItemCount: appState.projects.length,
                    ),
                    children: children,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
