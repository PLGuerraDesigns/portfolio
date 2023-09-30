import 'dart:convert';

import 'package:flutter/material.dart';

import '../common/strings.dart';
import 'professional_experience.dart';
import 'projects.dart';

/// The application state.
class AppState extends ChangeNotifier {
  /// The current route.
  String currentRoute = Strings.homeRoute;

  /// Whether the media browser is visible.
  bool mediaBrowserVisible = false;

  /// Whether the projects have been loaded.
  bool projectsLoaded = false;

  /// Whether the professional experiences have been loaded.
  bool professionalExperiencesLoaded = false;

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
    await DefaultAssetBundle.of(context)
        .loadString(Strings.projectsJsonPath)
        .then(
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
    await DefaultAssetBundle.of(context)
        .loadString(Strings.professionalExperienceJsonPath)
        .then(
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
    mediaBrowserVisible = !mediaBrowserVisible;
    notifyListeners();
  }
}
