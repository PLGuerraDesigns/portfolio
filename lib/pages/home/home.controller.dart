import 'package:flutter/material.dart';

import '../../models/app_state.dart';
import '../../models/education.dart';
import '../../models/professional_experience.dart';
import '../../models/project.dart';
import 'widgets/time_line_entry.dart';

class HomeController extends ChangeNotifier {
  HomeController({required this.appState});

  /// The application state.
  final AppState appState;

  /// Whether the timeline should take up more space.
  bool _timelineExpanded = false;
  bool get timelineExpanded => _timelineExpanded;

  /// Whether the professional experiences are visible in the timeline.
  bool _showProfessionalExperiences = true;
  bool get showProfessionalExperiences => _showProfessionalExperiences;

  /// Whether the projects are visible in the timeline.
  bool _showProjects = false;
  bool get showProjects => _showProjects;

  /// Whether the education is visible in the timeline.
  bool _showEducation = true;
  bool get showEducation => _showEducation;

  /// Whether the timeline entries have been loaded.
  bool get timelineEntriesLoaded =>
      appState.professionalExperiencesLoaded &&
      appState.educationLoaded &&
      appState.projectsLoaded;

  /// Loads the timeline entries.
  Future<List<TimelineEntry>> loadTimelineEntries() async {
    final List<TimelineEntry> entries = <TimelineEntry>[];

    // Load the data if it hasn't been loaded yet.
    if (!appState.professionalExperiencesLoaded) {
      await appState.loadProfessionalExperiences();
    }
    if (!appState.educationLoaded) {
      await appState.loadEducation();
    }
    if (!appState.projectsLoaded) {
      await appState.loadProjects();
    }

    // Add the entries to the list.
    if (_showProfessionalExperiences) {
      entries.addAll(appState.professionalExperiences.map(
          (ProfessionalExperience professionalExperience) =>
              professionalExperience.timelineEntry));
    }
    if (_showEducation) {
      entries.addAll(appState.education
          .map((Education education) => education.timelineEntry));
    }
    if (_showProjects) {
      entries.addAll(
          appState.projects.map((Project project) => project.timelineEntry));
    }

    // Sort the entries by date.
    entries.sort((TimelineEntry a, TimelineEntry b) {
      return b.startDate.compareTo(a.startDate);
    });

    return entries;
  }

  /// A function that toggles the timeline's expansion.
  void toggleTimelineExpanded() {
    _timelineExpanded = !_timelineExpanded;
    notifyListeners();
  }

  /// Toggles the visibility of the professional experiences.
  void toggleProfessionalExperienceVisibility() {
    _showProfessionalExperiences = !_showProfessionalExperiences;
    notifyListeners();
  }

  /// Toggles the visibility of the projects.
  void toggleProjectsVisibility() {
    _showProjects = !_showProjects;
    notifyListeners();
  }

  /// Toggles the visibility of the education.
  void toggleEducationVisibility() {
    _showEducation = !_showEducation;
    notifyListeners();
  }
}
