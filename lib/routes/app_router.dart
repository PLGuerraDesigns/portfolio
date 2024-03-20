import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../common/strings.dart';
import '../models/app_state.dart';
import '../models/professional_experience.dart';
import '../models/projects.dart';
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
      navigatorKey: appState.navigatorKey,
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
          pageBuilder: (BuildContext context, GoRouterState state) =>
              CustomTransitionPage<Widget>(
            child: const HomeScreen(),
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) =>
                FadeTransition(opacity: animation, child: child),
          ),
          routes: <GoRoute>[
            GoRoute(
              path: Strings.professionalSubRoute,
              builder: (BuildContext context, GoRouterState state) =>
                  const ProfessionalScreen(),
              routes: <GoRoute>[
                GoRoute(
                    path: '${Strings.detailsSubRoute}/:title',
                    builder: (BuildContext context, GoRouterState state) {
                      final ProfessionalExperience professionalExperience =
                          appState.getProfessionalExperienceByTitlePath(
                              state.pathParameters['title']!);
                      return DetailsScreen(
                        appBarTitle: Strings.professionalExperiences,
                        subtitle: professionalExperience.role,
                        logoPath: professionalExperience.logoPath,
                        title: professionalExperience.company,
                        description: professionalExperience.description,
                        externalLinks: professionalExperience.externalLinks,
                        startDate: professionalExperience.startDateString,
                        finalDate: professionalExperience.finalDateString,
                        mediaItems: professionalExperience.mediaItems,
                        tags: const <String>[],
                        onPreviousPressed: () {
                          context.go(
                            '${Strings.homeRoute}/${Strings.professionalSubRoute}/${Strings.detailsSubRoute}/'
                            '${appState.previousProfessionalExperience(professionalExperience.titleAsPath)}',
                          );
                        },
                        onNextPressed: () {
                          context.go(
                            '${Strings.homeRoute}/${Strings.professionalSubRoute}/${Strings.detailsSubRoute}/'
                            '${appState.nextProfessionalExperience(professionalExperience.titleAsPath)}',
                          );
                        },
                      );
                    }),
              ],
            ),
            GoRoute(
              path: Strings.personalSubRoute,
              builder: (BuildContext context, GoRouterState state) =>
                  const PersonalScreen(),
              routes: <GoRoute>[
                GoRoute(
                  path: '${Strings.detailsSubRoute}/:title',
                  builder: (BuildContext context, GoRouterState state) {
                    final Project project = appState
                        .getProjectByTitlePath(state.pathParameters['title']!);
                    return DetailsScreen(
                      appBarTitle: Strings.personalProjects,
                      title: project.title,
                      subtitle: project.subtitle,
                      description: project.description,
                      externalLinks: project.externalLinks,
                      startDate: project.startDateString,
                      finalDate: project.finalDateString,
                      mediaItems: project.mediaItems,
                      tags: project.tags,
                      onPreviousPressed: () {
                        context.go(
                          '${Strings.homeRoute}/${Strings.personalSubRoute}/${Strings.detailsSubRoute}/'
                          '${appState.previousProject(project.titleAsPath)}',
                        );
                      },
                      onNextPressed: () {
                        context.go(
                          '${Strings.homeRoute}/${Strings.personalSubRoute}/${Strings.detailsSubRoute}/'
                          '${appState.nextProject(project.titleAsPath)}',
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
      redirect: (BuildContext context, GoRouterState state) {
        final String location = state.uri.toString();
        final String goto = location.split('/').last;

        final bool isAtProfessionalDetails =
            location.contains(Strings.professionalSubRoute) &&
                location.contains(Strings.detailsSubRoute);
        // Redirect to loading screen if the user is trying to access the
        // professional experience details page and the professional experiences
        // haven't been loaded yet.
        if (isAtProfessionalDetails &&
            !appState.professionalExperiencesLoaded) {
          return '${Strings.loadingRoute}/${Strings.professionalSubRoute}/$goto';
        }

        // Redirect to professional experience menu if the professional
        // experience route doesn't exist.
        if (isAtProfessionalDetails &&
            appState.professionalExperiencesLoaded &&
            !appState.isValidProfessionalExperience(goto)) {
          return '${Strings.homeRoute}/${Strings.professionalSubRoute}';
        }

        final bool isAtPersonalDetails =
            location.contains(Strings.personalSubRoute) &&
                location.contains(Strings.detailsSubRoute);
        // Redirect to loading screen if the user is trying to access the
        // personal project details page and the projects haven't been
        // loaded yet.
        if (isAtPersonalDetails && !appState.projectsLoaded) {
          return '${Strings.loadingRoute}/${Strings.personalSubRoute}/$goto';
        }

        // Redirect to personal projects menu if the personal projects route
        // doesn't exist.
        // print(goto);
        if (location.contains(Strings.personalSubRoute) &&
            !appState.isValidProject(goto) &&
            appState.projectsLoaded) {
          return '${Strings.homeRoute}/${Strings.personalSubRoute}';
        }

        return null;
      },
      errorBuilder: (BuildContext context, GoRouterState state) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  Strings.uhOh,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  Strings.looksLikeSomethingWentWrong,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {
                    context.go(Strings.homeRoute);
                  },
                  child: Text(
                    Strings.goToTheHomePage.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
