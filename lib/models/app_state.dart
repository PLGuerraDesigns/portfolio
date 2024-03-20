import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/strings.dart';
import 'professional_experience.dart';
import 'projects.dart';

/// The application state.
class AppState extends ChangeNotifier {
  /// The current route.
  String currentRoute = Strings.homeRoute;

  /// Whether the media browser is visible.
  bool _mediaBrowserVisible = false;

  bool get mediaBrowserVisible => _mediaBrowserVisible;

  /// Whether the projects have been loaded.
  bool projectsLoaded = false;

  /// Whether the professional experiences have been loaded.
  bool professionalExperiencesLoaded = false;

  /// The navigator key.
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  /// The navigator key.
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  /// The list of projects.
  List<Project> get projects => _projects;
  List<Project> _projects = <Project>[];

  /// Returns the project with the given title as a path.
  Project getProjectByTitlePath(String titleAsPath) {
    for (final Project project in _projects) {
      if (project.titleAsPath == titleAsPath) {
        return project;
      }
    }
    throw Exception('Project not found.');
  }

  /// The list of professional experiences.
  List<ProfessionalExperience> get professionalExperiences =>
      _professionalExperiences;
  List<ProfessionalExperience> _professionalExperiences =
      <ProfessionalExperience>[];

  /// Returns the professional experience with the given title as a path.
  ProfessionalExperience getProfessionalExperienceByTitlePath(
      String titleAsPath) {
    for (final ProfessionalExperience professionalExperience
        in _professionalExperiences) {
      if (professionalExperience.titleAsPath == titleAsPath) {
        return professionalExperience;
      }
    }
    throw Exception('Professional experience not found.');
  }

  /// Loads the projects from the JSON file.
  Future<void> loadProjects(BuildContext context) async {
    if (projectsLoaded) {
      return;
    }
    _projects = <Project>[];
    await rootBundle.loadString(Strings.projectsJsonPath).then(
      (String data) {
        final dynamic jsonResult = json.decode(data);
        for (final dynamic project in jsonResult as List<dynamic>) {
          _projects.add(Project.fromJson(project as Map<String, dynamic>));
        }
      },
    );
    projectsLoaded = true;
  }

  /// Loads the professional experiences from the JSON file.
  Future<void> loadProfessionalExperiences(BuildContext context) async {
    if (professionalExperiencesLoaded) {
      return;
    }
    _professionalExperiences = <ProfessionalExperience>[];
    await rootBundle.loadString(Strings.professionalExperienceJsonPath).then(
      (String data) {
        final dynamic jsonResult = json.decode(data);
        for (final dynamic professionalExperience
            in jsonResult as List<dynamic>) {
          _professionalExperiences.add(ProfessionalExperience.fromJson(
              professionalExperience as Map<String, dynamic>));
        }
      },
    );
    professionalExperiencesLoaded = true;
  }

  /// Toggles the visibility of the media browser.
  void toggleMediaBrowserVisibility() {
    _mediaBrowserVisible = !_mediaBrowserVisible;
    notifyListeners();
  }

  /// Whether the provided title from the path is a valid professional
  /// experience.
  bool isValidProfessionalExperience(String titleAsPath) {
    for (final ProfessionalExperience professionalExperience
        in _professionalExperiences) {
      if (professionalExperience.titleAsPath == titleAsPath) {
        return true;
      }
    }
    return false;
  }

  /// Returns the previous professional experience title as a path.
  String previousProfessionalExperience(String currentProfessionalExperience) {
    final int index = _professionalExperiences.indexWhere(
        (ProfessionalExperience element) =>
            element.titleAsPath == currentProfessionalExperience);
    if (index == 0) {
      return _professionalExperiences[_professionalExperiences.length - 1]
          .titleAsPath;
    }
    return _professionalExperiences[index - 1].titleAsPath;
  }

  /// Returns the next professional experience title as a path.
  String nextProfessionalExperience(String currentProfessionalExperience) {
    final int index = _professionalExperiences.indexWhere(
        (ProfessionalExperience element) =>
            element.titleAsPath == currentProfessionalExperience);
    if (index == _professionalExperiences.length - 1) {
      return _professionalExperiences[0].titleAsPath;
    }
    return _professionalExperiences[index + 1].titleAsPath;
  }

  /// Whether the provided title from the path is a valid project.
  bool isValidProject(String titleAsPath) {
    for (final Project project in _projects) {
      if (project.titleAsPath == titleAsPath) {
        return true;
      }
    }
    return false;
  }

  /// Returns the previous project title as a path.
  String previousProject(String currentProject) {
    final int index = _projects
        .indexWhere((Project element) => element.titleAsPath == currentProject);
    if (index == 0) {
      return _projects[_projects.length - 1].titleAsPath;
    }
    return _projects[index - 1].titleAsPath;
  }

  /// Returns the next project title as a path.
  String nextProject(String currentProject) {
    final int index = _projects
        .indexWhere((Project element) => element.titleAsPath == currentProject);
    if (index == _projects.length - 1) {
      return _projects[0].titleAsPath;
    }
    return _projects[index + 1].titleAsPath;
  }
}
