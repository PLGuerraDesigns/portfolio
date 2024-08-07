import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/app_state.dart';
import '../../widgets/frosted_container.dart';
import '../../widgets/generic_app_bar.dart';
import 'details.controller.dart';
import 'details.model.dart';
import 'widgets/app_bar_actions.dart';
import 'widgets/info_header.dart';
import 'widgets/media_player/media_player.dart';
import 'widgets/more_info.dart';
import 'widgets/tags_menu.dart';

/// A screen that displays details about a project/experience.
class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
    required this.details,
  });

  final Details details;

  @override
  DetailsScreenState createState() => DetailsScreenState();
}

class DetailsScreenState extends State<DetailsScreen> {
  late DetailsController _controller;

  /// Arranges the widgets in a column for portrait orientation.
  Widget _portraitView() {
    return Consumer<DetailsController>(
      builder:
          (BuildContext context, DetailsController controller, Widget? child) {
        return Stack(
          children: <Widget>[
            AnimatedOpacity(
              opacity: controller.mediaBrowserOpen ? 0.0 : 1.0,
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
                      controller: controller.screenScrollController,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        clipBehavior: Clip.none,
                        controller: controller.screenScrollController,
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
                              InfoHeader(
                                details: widget.details,
                                compact: true,
                              ),
                              const Divider(height: 32),
                              SelectableText(
                                controller.description,
                                style: Theme.of(context).textTheme.bodyMedium,
                                textAlign: TextAlign.justify,
                              ),
                              if (controller.externalLinks.isNotEmpty)
                                MoreInfo(
                                    externalLinks: controller.externalLinks),
                              const Divider(height: 32),
                              if (controller.tags.isNotEmpty)
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: TagsMenu(tags: controller.tags),
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
                key: ValueKey<int>(controller.currentMediaIndex),
                currentIndex: controller.currentMediaIndex,
                browserAxis: Axis.vertical,
                mediaList: controller.mediaItems,
                isMediaBrowserVisible: controller.mediaBrowserOpen,
                onMediaSelected: controller.onMediaItemSelected,
                onMediaBrowserToggle: controller.toggleMediaBrowser,
              ),
            ),
          ],
        );
      },
    );
  }

  /// Arranges the widgets in a row for landscape orientation.
  Widget _landscapeView() {
    return Consumer<DetailsController>(
      builder:
          (BuildContext context, DetailsController controller, Widget? child) {
        return Scrollbar(
          controller: controller.screenScrollController,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: controller.screenScrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: MediaPlayer(
                    key: ValueKey<int>(controller.currentMediaIndex),
                    browserAxis: Axis.horizontal,
                    currentIndex: controller.currentMediaIndex,
                    mediaList: controller.mediaItems,
                    isMediaBrowserVisible: controller.mediaBrowserOpen,
                    onMediaSelected: controller.onMediaItemSelected,
                    onMediaBrowserToggle: controller.toggleMediaBrowser,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      InfoHeader(
                        details: widget.details,
                        compact: false,
                      ),
                      const Divider(height: 32),
                      SelectableText(
                        controller.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      if (controller.externalLinks.isNotEmpty)
                        MoreInfo(externalLinks: controller.externalLinks),
                      const Divider(height: 32),
                      if (controller.tags.isNotEmpty)
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: TagsMenu(tags: controller.tags),
                        ),
                      const SizedBox(height: 100.00),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = DetailsController(
      details: widget.details,
      appState: Provider.of<AppState>(context, listen: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailsController>.value(
      value: _controller,
      builder: (BuildContext context, Widget? child) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return Scaffold(
              appBar: GenericAppBar.build(
                context: context,
                title: _controller.appBarTitle,
                actions: <Widget>[
                  DetailsAppBarActions(
                    onPreviousPressed: () =>
                        _controller.onPreviousPressed(context),
                    onNextPressed: () => _controller.onNextPressed(context),
                  ),
                ],
              ),
              body: FrostedContainer(
                padding: EdgeInsets.zero,
                borderRadiusAmount: 0,
                child: orientation == Orientation.portrait
                    ? _portraitView()
                    : _landscapeView(),
              ),
            );
          },
        );
      },
    );
  }
}
