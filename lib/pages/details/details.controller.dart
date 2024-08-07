import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/routing/routes.dart';
import '../../common/strings.dart';
import '../../models/app_state.dart';
import '../../models/media_item.dart';
import 'details.model.dart';

class DetailsController extends ChangeNotifier {
  DetailsController({
    required Details details,
    required AppState appState,
  }) {
    _details = details;
    _appState = appState;
  }

  /// The application state.
  late final AppState _appState;

  /// The content details.
  late final Details _details;

  /// The controller for the scroll view.
  final ScrollController screenScrollController = ScrollController();

  /// The index of the current media item.
  int _currentMediaIndex = 0;
  int get currentMediaIndex => _currentMediaIndex;

  /// The title of the app bar.
  String get appBarTitle => _details.appBarTitle;

  /// The title of the project/experience.
  String get title => _details.title;

  /// The description of the project/experience.
  String get description => _details.description;

  /// The external links to display.
  List<Map<String, String>> get externalLinks => _details.externalLinks;

  /// The tags to display.
  List<String> get tags => _details.tags;

  /// The list of media items to display.
  List<MediaItem> get mediaItems => _details.mediaItems;

  /// Whether the media browser is open.
  bool get mediaBrowserOpen => _appState.mediaBrowserOpen;

  /// Callback to toggle the media browser.
  void toggleMediaBrowser() {
    _appState.toggleMediaBrowserVisibility();
    notifyListeners();
  }

  /// The callback for navigating to the previous project/experience.
  void onPreviousPressed(BuildContext context) {
    String route = '';
    if (_details.appBarTitle == Strings.professionalExperiences) {
      route = Routes.professionalExpDetails(
        titleAsPath:
            _appState.previousProfessionalExperience(_details.titleAsPath),
      );
    } else {
      route = Routes.projectDetails(
        titleAsPath: _appState.previousProject(_details.titleAsPath),
      );
    }

    context.go(route);
  }

  /// The callback for navigating to the next project/experience.
  void onNextPressed(BuildContext context) {
    String route = '';
    if (_details.appBarTitle == Strings.professionalExperiences) {
      route = Routes.professionalExpDetails(
        titleAsPath: _appState.nextProfessionalExperience(_details.titleAsPath),
      );
    } else {
      route = Routes.projectDetails(
        titleAsPath: _appState.nextProject(_details.titleAsPath),
      );
    }

    context.go(route);
  }

  /// The callback for selecting a media item.
  void onMediaItemSelected(int index) {
    _currentMediaIndex = index;
    notifyListeners();
  }
}
