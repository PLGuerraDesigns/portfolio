import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/asset_paths.dart';
import '../common/routing/routes.dart';
import '../common/strings.dart';
import 'education.dart';
import 'professional_experience.dart';
import 'project.dart';

/// The application state.
class AppState extends ChangeNotifier {
  /// The current route.
  String currentRoute = Routes.home;

  /// Whether the media browser is open.
  bool _mediaBrowserOpen = false;
  bool get mediaBrowserOpen => _mediaBrowserOpen;

  /// The navigator key.
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  /// The list of project filter options.
  final List<String> projectFilterOptions = <String>[
    Strings.software,
    Strings.electronics,
    Strings.threeDPrinting,
    Strings.academic,
  ];

  /// The list of selected project filters.
  List<String> get selectedProjectFilters => _selectedProjectFilters;
  final List<String> _selectedProjectFilters = <String>[
    Strings.software,
    Strings.electronics,
    Strings.threeDPrinting,
    Strings.academic,
  ];

  /// Toggles the selected project filter.
  void toggleSelectedProjectFilter(String filter) {
    if (selectedProjectFilters.length == projectFilterOptions.length) {
      _selectedProjectFilters.clear();
    }

    if (_selectedProjectFilters.contains(filter)) {
      _selectedProjectFilters.remove(filter);
    } else {
      _selectedProjectFilters.add(filter);
    }
    notifyListeners();
  }

  /// Whether the project data has been loaded.
  bool _projectsLoaded = false;
  bool get projectsLoaded => _projectsLoaded;

  /// The list of projects.
  List<Project> get projects => _projects;
  List<Project> _projects = <Project>[];

  /// The list of filtered projects.
  List<Project> get filteredProjects {
    final List<Project> filteredProjects = <Project>[];
    for (final Project project in _projects) {
      for (final String filter in selectedProjectFilters) {
        if (project.tags.contains(filter)) {
          filteredProjects.add(project);
          break;
        }
      }
    }
    return filteredProjects;
  }

  /// Returns the project for the given title in path format.
  Project getProjectByTitlePath(String titleAsPath) {
    for (final Project project in _projects) {
      if (project.titleAsPath == titleAsPath) {
        return project;
      }
    }
    throw Exception('Project not found.');
  }

  /// Whether the professional experience data has been loaded.
  bool _professionalExperiencesLoaded = false;
  bool get professionalExperiencesLoaded => _professionalExperiencesLoaded;

  /// The list of professional experiences.
  List<ProfessionalExperience> get professionalExperiences =>
      _professionalExperiences;
  List<ProfessionalExperience> _professionalExperiences =
      <ProfessionalExperience>[];

  /// Returns the professional experience for the given title in path format.
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

  /// Whether the education data has been loaded.
  bool _educationLoaded = false;
  bool get educationLoaded => _educationLoaded;

  /// The list of education.
  List<Education> get education => _education;
  List<Education> _education = <Education>[];

  /// Loads the education data from the JSON file.
  Future<void> loadEducation() async {
    if (_educationLoaded) {
      return;
    }

    _education = <Education>[];
    await rootBundle.loadString(AssetPaths.educationJsonData).then(
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

  /// Loads the project data from the JSON file.
  Future<void> loadProjects() async {
    if (projectsLoaded) {
      return;
    }

    _projects = <Project>[];
    await rootBundle.loadString(AssetPaths.projectsJsonData).then(
      (String data) {
        final dynamic jsonResult = json.decode(data);
        for (final dynamic projectAsJson in jsonResult as List<dynamic>) {
          _projects
              .add(Project.fromJson(projectAsJson as Map<String, dynamic>));
        }
      },
    );
    _projects.sort((Project a, Project b) {
      return b.startDate.compareTo(a.startDate);
    });

    _projectsLoaded = true;
  }

  /// Loads the professional experience data from the JSON file.
  Future<void> loadProfessionalExperiences() async {
    if (_professionalExperiencesLoaded) {
      return;
    }

    _professionalExperiences = <ProfessionalExperience>[];
    await rootBundle.loadString(AssetPaths.professionalExperienceJsonData).then(
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

    _professionalExperiencesLoaded = true;
  }

  /// Toggles the visibility of the media browser.
  void toggleMediaBrowserVisibility() {
    _mediaBrowserOpen = !_mediaBrowserOpen;
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
