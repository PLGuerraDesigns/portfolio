import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/color_schemes.dart';
import '../common/strings.dart';
import '../models/app_state.dart';
import '../models/media_item.dart';
import '../services/redirect_handler.dart';
import '../widgets/custom_app_bars.dart';
import '../widgets/frosted_container.dart';
import '../widgets/hover_scale_handler.dart';
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
    required this.externalLinks,
    required this.onPreviousPressed,
    required this.onNextPressed,
    required this.mediaItems,
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

  /// The list of media items to display.
  final List<MediaItem> mediaItems;

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

  /// The list of media items.
  List<MediaItem> get mediaItems => widget.mediaItems;

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
    return Stack(
      children: <Widget>[
        AnimatedOpacity(
          opacity: appState.mediaBrowserVisible ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 250),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16 / 9,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(
                height: 64,
              ),
              Expanded(
                child: Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    clipBehavior: Clip.none,
                    controller: _scrollController,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 8.0,
                        right: 16.0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          _infoHeader(context: context, compact: true),
                          const Divider(height: 32),
                          SelectableText(
                            widget.description,
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.justify,
                          ),
                          if (widget.externalLinks.isNotEmpty)
                            _moreInfo(context),
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
                  ),
                ),
              ),
            ],
          ),
        ),
        // A gradient overlay to fade out the text under the media player.
        Container(
          height: MediaQuery.of(context).size.width * 0.69 + 24,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.surface.withOpacity(0.95),
                Theme.of(context).colorScheme.surface.withOpacity(0.001),
              ],
              stops: const <double>[0.0, 0.8, 1.0],
            ),
          ),
        ),
        // The media player.
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: MediaPlayer(
            key: ValueKey<int>(_currentMediaIndex),
            currentIndex: _currentMediaIndex,
            browserAxis: Axis.vertical,
            mediaList: mediaItems,
            isMediaBrowserVisible: appState.mediaBrowserVisible,
            onMediaSelected: (int index) {
              setState(() {
                _currentMediaIndex = index;
              });
            },
            onMediaBrowserToggle: appState.toggleMediaBrowserVisibility,
          ),
        ),
      ],
    );
  }

  /// Arranges the widgets in a row for landscape orientation.
  Widget _landscapeView(
      {required BuildContext context, required AppState appState}) {
    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: true,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: MediaPlayer(
                key: ValueKey<int>(_currentMediaIndex),
                browserAxis: Axis.horizontal,
                currentIndex: _currentMediaIndex,
                mediaList: mediaItems,
                isMediaBrowserVisible: appState.mediaBrowserVisible,
                onMediaSelected: (int index) {
                  setState(() {
                    _currentMediaIndex = index;
                  });
                },
                onMediaBrowserToggle: appState.toggleMediaBrowserVisibility,
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
                  SelectableText(
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
    );
  }

  /// Actions to navigate to the previous and next details screens.
  List<Widget> _appBarActions() {
    return <Widget>[
      OutlinedButton(
        onPressed: () {
          setState(() {
            _currentMediaIndex = 0;
          });
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
          key: ValueKey<String>(widget.title),
          appBar: CustomAppBars.genericAppBar(
            context: context,
            title: widget.appBarTitle,
            actions: _appBarActions(),
          ),
          body: FrostedContainer(
            padding: EdgeInsets.zero,
            borderRadiusAmount: 0,
            child: orientation == Orientation.portrait
                ? _portraitView(context: context, appState: appState)
                : _landscapeView(context: context, appState: appState),
          ),
        );
      });
    });
  }
}
