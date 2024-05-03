import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/strings.dart';
import '../widgets/time_line_entry.dart';
import 'education.dart';
import 'professional_experience.dart';
import 'project.dart';

/// The application state.
class AppState extends ChangeNotifier {
  /// The current route.
  String currentRoute = Strings.homeRoute;

  /// Whether the media browser is visible.
  bool _mediaBrowserVisible = false;

  bool get mediaBrowserVisible => _mediaBrowserVisible;

  /// The navigator key.
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  /// The navigator key.
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  /// Whether the projects have been loaded.
  bool _projectsLoaded = false;
  bool get projectsLoaded => _projectsLoaded;

  /// The list of projects.
  List<Project> get projects => _projects;
  List<Project> _projects = <Project>[];

  /// Whether the professional experiences are visible in the timeline.
  bool _professionalExperiencesVisible = true;
  bool get professionalExperiencesVisible => _professionalExperiencesVisible;

  /// Whether the projects are visible in the timeline.
  bool _projectsVisible = false;
  bool get projectsVisible => _projectsVisible;

  /// Whether the education is visible in the timeline.
  bool _educationVisible = true;
  bool get educationVisible => _educationVisible;

  /// Returns the project with the given title as a path.
  Project getProjectByTitlePath(String titleAsPath) {
    for (final Project project in _projects) {
      if (project.titleAsPath == titleAsPath) {
        return project;
      }
    }
    throw Exception('Project not found.');
  }

  /// Whether the professional experiences have been loaded.
  bool professionalExperiencesLoaded = false;

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

  /// Whether the education has been loaded.
  bool _educationLoaded = false;
  bool get educationLoaded => _educationLoaded;

  /// The list of education.
  List<Education> get education => _education;
  List<Education> _education = <Education>[];

  /// Loads the education from the JSON file.
  Future<void> loadEducation() async {
    _education = <Education>[];
    await rootBundle.loadString(Strings.educationJsonPath).then(
      (String data) {
        final dynamic jsonResult = json.decode(data);
        for (final dynamic education in jsonResult as List<dynamic>) {
          _education.add(Education.fromJson(education as Map<String, dynamic>));
        }
      },
    );
    _education.sort((Education a, Education b) {
      return b.startDate.compareTo(a.startDate);
    });
    _educationLoaded = true;
  }

  /// Loads the projects from the JSON file.
  Future<void> loadProjects() async {
    _projects = <Project>[];
    await rootBundle.loadString(Strings.projectsJsonPath).then(
      (String data) {
        final dynamic jsonResult = json.decode(data);
        for (final dynamic project in jsonResult as List<dynamic>) {
          _projects.add(Project.fromJson(project as Map<String, dynamic>));
        }
      },
    );
    _projects.sort((Project a, Project b) {
      return b.startDate.compareTo(a.startDate);
    });
    _projectsLoaded = true;
  }

  /// Loads the professional experiences from the JSON file.
  Future<void> loadProfessionalExperiences() async {
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

    _professionalExperiences
        .sort((ProfessionalExperience a, ProfessionalExperience b) {
      return b.startDate.compareTo(a.startDate);
    });

    professionalExperiencesLoaded = true;
  }

  /// Loads the timeline entries.
  Future<List<TimelineEntry>> loadTimelineEntries() async {
    final List<TimelineEntry> entries = <TimelineEntry>[];

    await loadProfessionalExperiences();
    if (_professionalExperiencesVisible) {
      entries.addAll(_professionalExperiences.map(
          (ProfessionalExperience professionalExperience) =>
              professionalExperience.timelineEntry));
    }

    await loadEducation();
    if (_educationVisible) {
      entries.addAll(
          _education.map((Education education) => education.timelineEntry));
    }

    await loadProjects();
    if (_projectsVisible) {
      entries.addAll(_projects.map((Project project) => project.timelineEntry));
    }

    entries.sort((TimelineEntry a, TimelineEntry b) {
      return b.startDate.compareTo(a.startDate);
    });

    return entries;
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

  /// Toggles the visibility of the professional experiences.
  void toggleProfessionalExperienceVisibility() {
    _professionalExperiencesVisible = !_professionalExperiencesVisible;
    notifyListeners();
  }

  /// Toggles the visibility of the projects.
  void toggleProjectsVisibility() {
    _projectsVisible = !_projectsVisible;
    notifyListeners();
  }

  /// Toggles the visibility of the education.
  void toggleEducationVisibility() {
    _educationVisible = !_educationVisible;
    notifyListeners();
  }
}
