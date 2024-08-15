import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/app_state.dart';
import '../../models/professional_experience.dart';
import '../../models/project.dart';
import '../../pages/details/details.screen.dart';
import '../../pages/error.dart';
import '../../pages/home/home.screen.dart';
import '../../pages/loading.dart';
import '../../pages/personal_projects/projects_menu.dart';
import '../../pages/professional_exp_menu.dart';
import 'routes.dart';

/// A class that configures the app's routing.
class AppRouter {
  AppRouter(
    this.appState,
  );

  /// The application state.
  AppState appState;

  /// Returns a [GoRouter] instance with the app's routing configuration.
  GoRouter configureRouter() {
    return GoRouter(
      navigatorKey: appState.navigatorKey,
      initialLocation: appState.currentRoute,
      refreshListenable: appState,
      routes: <GoRoute>[
        GoRoute(
          path: '${Routes.loading}/:from/:goto',
          builder: (BuildContext context, GoRouterState state) => LoadingScreen(
            from: state.pathParameters['from']!,
            to: state.pathParameters['goto']!,
            loadFunction: (BuildContext context) async {
              if (state.pathParameters['from'] == Routes.professional &&
                  !appState.professionalExperiencesLoaded) {
                await appState.loadProfessionalExperiences();
              }
              if (state.pathParameters['from'] == Routes.personal &&
                  !appState.projectsLoaded &&
                  context.mounted) {
                await appState.loadProjects();
              }
            },
          ),
        ),
        GoRoute(
          path: Routes.home,
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
              path: Routes.professional,
              builder: (BuildContext context, GoRouterState state) =>
                  const ProfessionalExperienceMenuScreen(),
              routes: <GoRoute>[
                GoRoute(
                    path: '${Routes.details}/:title',
                    builder: (BuildContext context, GoRouterState state) {
                      final ProfessionalExperience professionalExperience =
                          appState.getProfessionalExperienceByTitlePath(
                              state.pathParameters['title']!);
                      return DetailsScreen(
                        key: UniqueKey(),
                        details: professionalExperience.details,
                      );
                    }),
              ],
            ),
            GoRoute(
              path: Routes.personal,
              builder: (BuildContext context, GoRouterState state) =>
                  const ProjectsMenuScreen(),
              routes: <GoRoute>[
                GoRoute(
                  path: '${Routes.details}/:title',
                  builder: (BuildContext context, GoRouterState state) {
                    final Project project = appState
                        .getProjectByTitlePath(state.pathParameters['title']!);
                    return DetailsScreen(
                      key: UniqueKey(),
                      details: project.details,
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

        appState.currentRoute = location;

        final bool isAtProfessionalDetails =
            location.contains(Routes.professional) &&
                location.contains(Routes.details);
        // Redirect to loading screen if the user is trying to access the
        // professional experience details page and the professional experiences
        // haven't been loaded yet.
        if (isAtProfessionalDetails &&
            !appState.professionalExperiencesLoaded) {
          return '${Routes.loading}/${Routes.professional}/$goto';
        }

        // Redirect to professional experience menu if the professional
        // experience route doesn't exist.
        if (isAtProfessionalDetails &&
            appState.professionalExperiencesLoaded &&
            !appState.isValidProfessionalExperience(goto)) {
          return '${Routes.home}/${Routes.professional}';
        }

        final bool isAtPersonalDetails = location.contains(Routes.personal) &&
            location.contains(Routes.details);
        // Redirect to loading screen if the user is trying to access the
        // personal project details page and the projects haven't been
        // loaded yet.
        if (isAtPersonalDetails && !appState.projectsLoaded) {
          return '${Routes.loading}/${Routes.personal}/$goto';
        }

        // Redirect to personal projects menu if the personal projects route
        // doesn't exist.
        if (location.contains(Routes.personal) &&
            !appState.isValidProject(goto) &&
            appState.projectsLoaded) {
          return '${Routes.home}/${Routes.personal}';
        }

        return null;
      },
      errorBuilder: (BuildContext context, GoRouterState state) {
        return const ErrorScreen();
      },
    );
  }
}
