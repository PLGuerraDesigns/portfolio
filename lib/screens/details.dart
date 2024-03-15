import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/color_schemes.dart';
import '../common/enums.dart';
import '../common/strings.dart';
import '../models/app_state.dart';
import '../models/media_item.dart';
import '../services/redirect_handler.dart';
import '../widgets/custom_app_bars.dart';
import '../widgets/frosted_container.dart';
import '../widgets/hover_scale_handler.dart';
import '../widgets/media_browser.dart';
import '../widgets/media_player.dart';

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
    required this.mediaCaptions,
    required this.videoPaths,
    required this.externalLinks,
    required this.youtubeVideoIds,
    required this.webImagePaths,
    required this.onPreviousPressed,
    required this.onNextPressed,
    this.logoPath,
  });

  /// The title of the app bar.
  final String appBarTitle;

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

  /// The paths to the web images to display in the gallery.
  final List<String> webImagePaths;

  /// The captions to display for each image in the gallery.
  final List<String> mediaCaptions;

  /// The paths to the videos to display in the gallery.
  final List<String> videoPaths;

  /// The YouTube video IDs to display in the gallery.
  final List<String> youtubeVideoIds;

  /// The tags to display.
  final List<String> tags;

  /// The external links to display.
  final List<Map<String, String>> externalLinks;

  /// The callback to call when the app bar's previous button is pressed.
  final Function()? onPreviousPressed;

  /// The callback to call when the app bar's next button is pressed.
  final Function()? onNextPressed;

  @override
  DetailsScreenState createState() => DetailsScreenState();
}

class DetailsScreenState extends State<DetailsScreen> {
  /// The controller for the scroll view.
  final ScrollController _scrollController = ScrollController();

  /// The list of media items to display.
  List<MediaItem> get mediaItems {
    final List<MediaItem> mediaItems = <MediaItem>[];
    for (int i = 0; i < widget.youtubeVideoIds.length; i++) {
      mediaItems.add(MediaItem(
        type: MediaType.youTubeVideo,
        path: widget.youtubeVideoIds[i],
        caption: '',
      ));
    }
    for (int i = 0; i < widget.videoPaths.length; i++) {
      mediaItems.add(MediaItem(
        type: MediaType.localVideo,
        path: widget.videoPaths[i],
        caption: widget.mediaCaptions[i],
      ));
    }

    for (int i = 0; i < widget.imagePaths.length; i++) {
      mediaItems.add(MediaItem(
        type: MediaType.localImage,
        path: widget.imagePaths[i],
        caption: widget.mediaCaptions[i + widget.videoPaths.length],
      ));
    }
    for (int i = 0; i < widget.webImagePaths.length; i++) {
      mediaItems.add(MediaItem(
        type: MediaType.networkImage,
        path: widget.webImagePaths[i],
        caption: widget.mediaCaptions[
            i + widget.videoPaths.length + widget.imagePaths.length],
      ));
    }
    return mediaItems;
  }

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
              HoverScaleHandler(
                onTap: () {
                  RedirectHandler.openUrl(
                      'https://www.google.com/search?q=$tag');
                },
                child: Chip(
                    label: Text(tag),
                    backgroundColor:
                        Theme.of(context).colorScheme.surface.withOpacity(0.9)),
              ),
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
          Strings.moreInfo,
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
  Widget _mediaBrowser({required BuildContext context}) {
    return MediaBrowser(
      youtubeVideoIds: widget.youtubeVideoIds,
      imagePaths: widget.imagePaths,
      videoPaths: widget.videoPaths,
      webImagePaths: widget.webImagePaths,
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
    );
  }

  /// Builds the header with the logo, title, subtitle, and date range.
  Widget _infoHeader({required BuildContext context, required bool compact}) {
    return Row(
      children: <Widget>[
        if (widget.logoPath != null)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: lightColorScheme.surface,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  widget.logoPath!,
                  fit: BoxFit.contain,
                  height: 40,
                  width: 40,
                ),
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
          child: MediaPlayer(
            currentIndex: _currentMediaIndex,
            mediaList: mediaItems,
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
                _mediaBrowser(
                  context: context,
                ),
              Text(
                widget.description,
                style: Theme.of(context).textTheme.bodyMedium,
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                child: MediaPlayer(
                  currentIndex: _currentMediaIndex,
                  mediaList: mediaItems,
                  onMediaBrowser: appState.toggleMediaBrowserVisibility,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _infoHeader(context: context, compact: false),
                    const Divider(height: 32),
                    Text(
                      widget.description,
                      style: Theme.of(context).textTheme.bodyMedium,
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
          ),
        ),
        if (appState.mediaBrowserVisible)
          Flexible(
              child: _mediaBrowser(
            context: context,
          )),
      ],
    );
  }

  /// Actions to navigate to the previous and next details screens.
  List<Widget> _appBarActions() {
    return <Widget>[
      OutlinedButton(
        onPressed: () {
          _currentMediaIndex = 0;
          widget.onPreviousPressed?.call();
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          foregroundColor: Theme.of(context).colorScheme.onSurface,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.chevron_left,
            ),
            Text(
              Strings.prev.toUpperCase(),
            ),
            const SizedBox(width: 8.0),
          ],
        ),
      ),
      const SizedBox(width: 8.0),
      OutlinedButton(
        onPressed: () {
          _currentMediaIndex = 0;
          widget.onNextPressed?.call();
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          foregroundColor: Theme.of(context).colorScheme.onSurface,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(width: 8.0),
            Text(
              Strings.next.toUpperCase(),
            ),
            const Icon(
              Icons.chevron_right,
            ),
          ],
        ),
      ),
      const SizedBox(width: 20.0),
    ];
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
            actions: _appBarActions(),
          ),
          body: FrostedContainer(
            padding: EdgeInsets.zero,
            borderRadiusAmount: 0,
            child: Scrollbar(
              thumbVisibility: true,
              controller: _scrollController,
              child: SingleChildScrollView(
                key: UniqueKey(),
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
