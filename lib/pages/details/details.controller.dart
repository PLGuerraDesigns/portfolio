import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/routing/routes.dart';
import '../../common/strings.dart';
import '../../models/app_state.dart';
import '../../models/media_item.dart';
import 'details.model.dart';
import 'widgets/media_player/multi_media_player.controller.dart';

class DetailsController extends ChangeNotifier {
  DetailsController({
    required Details details,
    required AppState appState,
  }) {
    _details = details;
    _appState = appState;
    mediaController = MultiMediaPlayerController(
      mediaItems: _details.mediaItems,
      isMediaBrowserOpen: _appState.mediaBrowserOpen,
      updateMediaBrowserVisibilityState: _appState.toggleMediaBrowserVisibility,
    );
  }

  /// The application state.
  late final AppState _appState;

  /// The content details.
  late final Details _details;

  /// The controller for the scroll view.
  final ScrollController screenScrollController = ScrollController();

  /// The controller for the media player.
  late final MultiMediaPlayerController mediaController;

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

  @override
  void dispose() {
    screenScrollController.dispose();
    mediaController.dispose();
    super.dispose();
  }
}
