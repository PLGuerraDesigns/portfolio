import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/strings.dart';
import '../models/app_state.dart';
import '../services/redirect_handler.dart';
import '../widgets/custom_app_bars.dart';
import '../widgets/frosted_container.dart';
import '../widgets/media_browser.dart';
import '../widgets/multi_media_player.dart';

/// A screen that displays details about a project/experience.
class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.appBarTitle,
    required this.description,
    required this.startDate,
    required this.finalDate,
    required this.tags,
    required this.imagePaths,
    required this.imageCaptions,
    required this.videoPaths,
    required this.externalLinks,
    required this.youtubeVideoIds,
    this.logoPath,
    this.actions,
  });

  /// The title of the app bar.
  final String appBarTitle;

  /// The actions to display in the app bar.
  final List<Widget>? actions;

  /// The path to the logo image to display.
  final String? logoPath;

  /// The title of the project/experience.
  final String title;

  /// The subtitle of the project/experience.
  final String subtitle;

  /// The start date of the project/experience.
  final String? startDate;

  /// The final date of the project/experience.
  final String? finalDate;

  /// The description of the project/experience.
  final String description;

  /// The paths to the images to display in the gallery.
  final List<String> imagePaths;

  /// The captions to display for each image in the gallery.
  final List<String> imageCaptions;

  /// The paths to the videos to display in the gallery.
  final List<String> videoPaths;

  /// The YouTube video IDs to display in the gallery.
  final List<String> youtubeVideoIds;

  /// The tags to display.
  final List<String> tags;

  /// The external links to display.
  final List<Map<String, String>> externalLinks;

  @override
  DetailsScreenState createState() => DetailsScreenState();
}

class DetailsScreenState extends State<DetailsScreen> {
  /// The controller for the scroll view.
  final ScrollController _scrollController = ScrollController();

  /// The index of the current media item.
  int _currentMediaIndex = 0;

  /// The date range text to display.
  String get dateRangeText {
    String dateRangeText = '';
    if (widget.startDate != null) {
      dateRangeText += '${widget.startDate} - ';
    }
    if (widget.finalDate != null) {
      dateRangeText += widget.finalDate!;
    } else {
      dateRangeText += Strings.present;
    }
    return dateRangeText;
  }

  /// Builds the tag chips.
  Widget _tagChips(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          Strings.tags,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            for (final String tag in widget.tags)
              Chip(
                  label: Text(tag),
                  backgroundColor:
                      Theme.of(context).colorScheme.surface.withOpacity(0.9)),
          ],
        ),
      ],
    );
  }

  /// Builds the more info section.
  Widget _moreInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(height: 8.0),
        const Divider(height: 32),
        Text(
          Strings.externalLinks,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8.0),
        for (final Map<String, String> link in widget.externalLinks)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Text(
                  '${link['title']}:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(width: 8.0),
                TextButton(
                  child: Text(
                    link['url']!,
                  ),
                  onPressed: () {
                    RedirectHandler.openUrl(link['url']!);
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }

  /// Builds the media browser.
  Widget _mediaBrowser(
      {required BuildContext context, required bool portrait}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * (portrait ? 1 : 0.3),
      child: MediaBrowser(
        youtubeVideoIds: widget.youtubeVideoIds,
        imagePaths: widget.imagePaths,
        videoPaths: widget.videoPaths,
        onTapped: (int index) {
          setState(() {
            _currentMediaIndex = index;
          });
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }

  /// Builds the header with the logo, title, subtitle, and date range.
  Widget _infoHeader({required BuildContext context, required bool compact}) {
    return Row(
      children: <Widget>[
        if (widget.logoPath != null)
          Padding(
            padding: EdgeInsets.only(right: compact ? 8.0 : 16.0),
            child: FrostedContainer(
              padding: const EdgeInsets.all(4),
              borderRadiusAmount: 100,
              child: Image.asset(
                widget.logoPath!,
                fit: BoxFit.contain,
                height: compact ? 32 : 40,
                width: compact ? 32 : 40,
              ),
            ),
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.title,
              style: compact
                  ? Theme.of(context).textTheme.titleMedium
                  : Theme.of(context).textTheme.titleLarge,
            ),
            if (widget.subtitle.isNotEmpty)
              Text(
                widget.subtitle,
                style: compact
                    ? Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.normal,
                        )
                    : Theme.of(context).textTheme.titleMedium,
              ),
            Text(
              dateRangeText,
              style: compact
                  ? Theme.of(context).textTheme.bodySmall
                  : Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  /// Arranges the widgets in a column for portrait orientation.
  Widget _portraitView(
      {required BuildContext context, required AppState appState}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 16 / 11,
          child: MultiMediaPlayer(
            key: Key('multiMediaPlayer$_currentMediaIndex'),
            currentIndex: _currentMediaIndex,
            youtubeVideoIds: widget.youtubeVideoIds,
            videoPaths: widget.videoPaths,
            imagePaths: widget.imagePaths,
            imageCaptions: widget.imageCaptions,
            onMediaBrowser: appState.toggleMediaBrowserVisibility,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _infoHeader(context: context, compact: true),
              const Divider(height: 32),
              if (appState.mediaBrowserVisible)
                _mediaBrowser(context: context, portrait: true),
              Text(
                widget.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              if (widget.externalLinks.isNotEmpty) _moreInfo(context),
              const Divider(height: 32),
              if (widget.tags.isNotEmpty)
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: _tagChips(context),
                ),
              const SizedBox(height: 100.00),
            ],
          ),
        ),
      ],
    );
  }

  /// Arranges the widgets in a row for landscape orientation.
  Widget _landscapeView(
      {required BuildContext context, required AppState appState}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: MultiMediaPlayer(
                  key: Key('multiMediaPlayer$_currentMediaIndex'),
                  currentIndex: _currentMediaIndex,
                  youtubeVideoIds: widget.youtubeVideoIds,
                  videoPaths: widget.videoPaths,
                  imagePaths: widget.imagePaths,
                  imageCaptions: widget.imageCaptions,
                  onMediaBrowser: appState.toggleMediaBrowserVisibility,
                ),
              ),
              if (appState.mediaBrowserVisible)
                _mediaBrowser(context: context, portrait: false),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _infoHeader(context: context, compact: false),
              const Divider(height: 32),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          widget.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        if (widget.externalLinks.isNotEmpty) _moreInfo(context),
                        const SizedBox(height: 100.00),
                      ],
                    ),
                  ),
                  if (widget.tags.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: _tagChips(context),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
        builder: (BuildContext context, AppState appState, Widget? child) {
      return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
        return Scaffold(
          appBar: CustomAppBars.genericAppBar(
            context: context,
            title: widget.appBarTitle,
            actions: widget.actions,
          ),
          body: FrostedContainer(
            padding: EdgeInsets.zero,
            borderRadiusAmount: 0,
            child: Scrollbar(
              thumbVisibility: true,
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.only(
                    right: orientation == Orientation.portrait ? 8.0 : 12.0),
                child: orientation == Orientation.portrait
                    ? _portraitView(context: context, appState: appState)
                    : _landscapeView(context: context, appState: appState),
              ),
            ),
          ),
        );
      });
    });
  }
}
