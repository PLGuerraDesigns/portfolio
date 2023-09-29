import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../common/strings.dart';
import '../models/app_state.dart';
import '../screens/details.dart';
import '../screens/home.dart';
import '../screens/loading.dart';
import '../screens/personal.dart';
import '../screens/professional.dart';

class AppRouter {
  AppRouter(
    this.appState,
  );

  AppState appState;

  /// Returns a [GoRouter] instance with the app's routing configuration.
  GoRouter configureRouter() {
    return GoRouter(
      initialLocation: appState.currentRoute,
      refreshListenable: appState,
      routes: <GoRoute>[
        GoRoute(
          path: '${Strings.loadingRoute}/:from/:goto',
          builder: (BuildContext context, GoRouterState state) => LoadingScreen(
            fromRoute: state.pathParameters['from']!,
            nextRoute: state.pathParameters['goto']!,
            loadFunction: (BuildContext context) async {
              if (state.pathParameters['from'] ==
                      Strings.professionalSubRoute &&
                  !appState.professionalExperiencesLoaded) {
                await appState.loadProfessionalExperiences(context);
              }
              if (state.pathParameters['from'] == Strings.personalSubRoute &&
                  !appState.projectsLoaded &&
                  context.mounted) {
                await appState.loadProjects(context);
              }
            },
          ),
        ),
        GoRoute(
          path: Strings.homeRoute,
          builder: (BuildContext context, GoRouterState state) =>
              const HomeScreen(),
          routes: <GoRoute>[
            GoRoute(
              path: Strings.professionalSubRoute,
              builder: (BuildContext context, GoRouterState state) =>
                  const ProfessionalScreen(),
              routes: <GoRoute>[
                GoRoute(
                  path: '${Strings.detailsSubRoute}/:title',
                  builder: (BuildContext context, GoRouterState state) =>
                      DetailsScreen(
                    appBarTitle: Strings.professionalExperiences,
                    logoPath: appState
                        .getProfessionalExperienceByTitlePath(
                            state.pathParameters['title']!)
                        .logoPath,
                    title: appState
                        .getProfessionalExperienceByTitlePath(
                            state.pathParameters['title']!)
                        .company,
                    description: appState
                        .getProfessionalExperienceByTitlePath(
                            state.pathParameters['title']!)
                        .description,
                    imagePaths: <String>[
                      appState
                          .getProfessionalExperienceByTitlePath(
                              state.pathParameters['title']!)
                          .thumbnailPath
                    ],
                    videoPaths: const <String>[],
                    youtubeVideoIds: appState
                        .getProfessionalExperienceByTitlePath(
                            state.pathParameters['title']!)
                        .youtubeVideoIds,
                    imageCaptions: const <String>[],
                    externalLinks: appState
                        .getProfessionalExperienceByTitlePath(
                            state.pathParameters['title']!)
                        .externalLinks,
                    startDate: appState
                        .getProfessionalExperienceByTitlePath(
                            state.pathParameters['title']!)
                        .startDateString,
                    finalDate: appState
                        .getProfessionalExperienceByTitlePath(
                            state.pathParameters['title']!)
                        .finalDateString,
                    tags: const <String>[],
                  ),
                ),
              ],
            ),
            GoRoute(
              path: Strings.personalSubRoute,
              builder: (BuildContext context, GoRouterState state) =>
                  const PersonalScreen(),
              routes: <GoRoute>[
                GoRoute(
                  path: '${Strings.detailsSubRoute}/:title',
                  builder: (BuildContext context, GoRouterState state) =>
                      DetailsScreen(
                    appBarTitle: Strings.personalProjects,
                    title: appState
                        .getProjectByTitlePath(state.pathParameters['title']!)
                        .title,
                    description: appState
                        .getProjectByTitlePath(state.pathParameters['title']!)
                        .description,
                    imagePaths: appState
                        .getProjectByTitlePath(state.pathParameters['title']!)
                        .imagePaths,
                    imageCaptions: appState
                        .getProjectByTitlePath(state.pathParameters['title']!)
                        .imageCaptions,
                    videoPaths: appState
                        .getProjectByTitlePath(state.pathParameters['title']!)
                        .videoPaths,
                    startDate: appState
                        .getProjectByTitlePath(state.pathParameters['title']!)
                        .startDateString,
                    finalDate: appState
                        .getProjectByTitlePath(state.pathParameters['title']!)
                        .finalDateString,
                    tags: appState
                        .getProjectByTitlePath(state.pathParameters['title']!)
                        .tags,
                    youtubeVideoIds: const <String>[],
                    externalLinks: appState
                        .getProjectByTitlePath(state.pathParameters['title']!)
                        .externalLinks,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
      redirect: (BuildContext context, GoRouterState state) {
        final String location = state.uri.toString();

        final bool isAtProfessionalDetails =
            location.contains(Strings.professionalSubRoute) &&
                location.contains(Strings.detailsSubRoute);
        if (isAtProfessionalDetails &&
            !appState.professionalExperiencesLoaded) {
          final String goto = location.split('/').last;
          return '${Strings.loadingRoute}/${Strings.professionalSubRoute}/$goto';
        }

        final bool isAtPersonalDetails =
            location.contains(Strings.personalSubRoute) &&
                location.contains(Strings.detailsSubRoute);
        if (isAtPersonalDetails && !appState.projectsLoaded) {
          final String goto = location.split('/').last;
          return '${Strings.loadingRoute}/${Strings.personalSubRoute}/$goto';
        }

        appState.currentRoute = location;
        return null;
      },
    );
  }
}
