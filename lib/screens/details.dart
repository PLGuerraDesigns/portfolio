import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../common/color_schemes.g.dart';
import '../common/strings.dart';
import '../services/redirect_handler.dart';
import '../widgets/custom_app_bars.dart';
import '../widgets/frosted_container.dart';
import '../widgets/gallery_controls.dart';
import '../widgets/media_browser.dart';

/// A screen that displays details about a project/experience.
class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
    required this.title,
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

  /// The controller for the image gallery.
  late PageController _imagePageController;

  /// The video player controllers for the videos to display in the gallery.
  final List<VideoPlayerController> _videoPlayerControllers =
      <VideoPlayerController>[];

  /// Whether the media browser is visible.
  bool _mediaBrowserVisible = false;

  /// The index of the current media item.
  int _currentMediaIndex = 0;

  /// The number of YouTube videos to display in the gallery.
  int get youtubeCount => widget.youtubeVideoIds.length;

  /// The number of images to display in the gallery.
  int get imageCount => widget.imagePaths.length;

  /// The number of videos to display in the gallery.
  int get videoCount => widget.videoPaths.length;

  /// The total number of media items to display in the gallery.
  int get totalMediaCount => youtubeCount + imageCount + videoCount;

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

  /// Handles opening the next media item in the gallery.
  Future<void> _nextMedia() async {
    if (_currentMediaIndex < youtubeCount ||
        (_currentMediaIndex >= imageCount + youtubeCount - 1 &&
            _currentMediaIndex < totalMediaCount - 1)) {
      setState(() {
        _currentMediaIndex++;
      });
      return;
    }

    if (_currentMediaIndex == totalMediaCount - 1) {
      if (videoCount == 0 && youtubeCount == 0) {
        _imagePageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeIn,
        );
        return;
      }
      setState(() {
        _currentMediaIndex = 0;
      });
      _setupImagePageController();
      return;
    } else {
      await _imagePageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeIn,
      );
    }
  }

  /// Handles opening the previous media item in the gallery.
  void _previousMedia() {
    if (_currentMediaIndex > imageCount) {
      setState(() {
        _currentMediaIndex--;
      });
      return;
    } else if (_currentMediaIndex == imageCount) {
      setState(() {
        _currentMediaIndex--;
      });
      _setupImagePageController();
      return;
    }
    if (_currentMediaIndex == 0) {
      if (videoCount == 0 && youtubeCount == 0) {
        _imagePageController.animateToPage(
          imageCount - 1,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeIn,
        );
        return;
      }
      setState(() {
        _currentMediaIndex = totalMediaCount - 1;
      });
      return;
    }
    _imagePageController.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeIn,
    );
  }

  /// Sets up the image page controller.
  void _setupImagePageController() {
    _imagePageController = PageController(
      initialPage: _currentMediaIndex,
    );
    _imagePageController.addListener(() {
      if (_imagePageController.page == null) {
        return;
      }
      setState(() {
        _currentMediaIndex = _imagePageController.page!.round();
      });
    });
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

  /// Builds the image to be displayed in the gallery.
  PhotoViewGalleryPageOptions _galleryImageItem(
      BuildContext context, int index) {
    return PhotoViewGalleryPageOptions(
      gestureDetectorBehavior: HitTestBehavior.opaque,
      imageProvider: AssetImage(widget.imagePaths[index]),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * 0.1,
      maxScale: PhotoViewComputedScale.covered * 5,
      filterQuality: FilterQuality.high,
      heroAttributes: PhotoViewHeroAttributes(
        tag: index.toString(),
      ),
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        return const Icon(
          Icons.error_outline,
          color: Colors.black12,
          size: 100,
        );
      },
    );
  }

  /// Arranges the widgets in a column for portrait orientation.
  Widget _portraitView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 64.0),
                child: _currentMediaIndex < youtubeCount
                    ? ColoredBox(
                        color: darkColorScheme.surface.withOpacity(0.9),
                        child: Center(
                          child: YoutubePlayer(
                            key: Key('yt$_currentMediaIndex'),
                            controller: YoutubePlayerController.fromVideoId(
                                videoId:
                                    widget.youtubeVideoIds[_currentMediaIndex]),
                          ),
                        ),
                      )
                    : _currentMediaIndex < imageCount + youtubeCount
                        ? PhotoViewGallery.builder(
                            scrollPhysics: const ClampingScrollPhysics(),
                            builder: _galleryImageItem,
                            pageController: _imagePageController,
                            itemCount: imageCount,
                            backgroundDecoration: BoxDecoration(
                              color: darkColorScheme.surface.withOpacity(0.9),
                            ),
                            onPageChanged: (_) {},
                          )
                        : Chewie(
                            controller: ChewieController(
                              autoPlay: true,
                              videoPlayerController: _videoPlayerControllers[
                                  _currentMediaIndex - imageCount],
                            ),
                          ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: FrostedContainer(
                  borderRadiusAmount: 0,
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      if (widget.imageCaptions.isNotEmpty &&
                          _currentMediaIndex <= imageCount - 1)
                        Flexible(
                          child: Text(
                            widget.imageCaptions[_currentMediaIndex],
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      if (widget.imageCaptions.isEmpty ||
                          _currentMediaIndex > imageCount - 1)
                        Container(),
                      GalleryControls(
                        currentIndex: _currentMediaIndex,
                        totalMediaCount: totalMediaCount,
                        onPrevious: _previousMedia,
                        onNext: _nextMedia,
                        onMediaBrowser: () {
                          setState(() {
                            _mediaBrowserVisible = !_mediaBrowserVisible;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        if (_mediaBrowserVisible)
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: MediaBrowser(
              youtubeVideoIds: widget.youtubeVideoIds,
              imagePaths: widget.imagePaths,
              playerControllers: _videoPlayerControllers,
              onTapped: (int index) {
                if (index >= imageCount) {
                  setState(() {
                    _currentMediaIndex = index;
                  });
                  return;
                }
                if (_currentMediaIndex >= imageCount) {
                  setState(() {
                    _currentMediaIndex = index;
                  });
                  _setupImagePageController();
                  return;
                }
                _imagePageController.jumpToPage(
                  index,
                );
              },
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  if (widget.logoPath != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: FrostedContainer(
                        padding: const EdgeInsets.all(4),
                        borderRadiusAmount: 100,
                        child: Image.asset(
                          widget.logoPath!,
                          fit: BoxFit.contain,
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.title,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Text(
                        dateRangeText,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(height: 32),
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
  Widget _landscapeView(BuildContext context) {
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
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 56.0),
                      child: _currentMediaIndex < youtubeCount
                          ? ColoredBox(
                              color: darkColorScheme.surface.withOpacity(0.9),
                              child: Center(
                                child: YoutubePlayer(
                                  key: Key('yt$_currentMediaIndex'),
                                  controller:
                                      YoutubePlayerController.fromVideoId(
                                          videoId: widget.youtubeVideoIds[
                                              _currentMediaIndex]),
                                ),
                              ),
                            )
                          : _currentMediaIndex < imageCount + youtubeCount
                              ? PhotoViewGallery.builder(
                                  scrollPhysics: const ClampingScrollPhysics(),
                                  builder: _galleryImageItem,
                                  pageController: _imagePageController,
                                  itemCount: imageCount,
                                  backgroundDecoration: BoxDecoration(
                                    color: darkColorScheme.surface
                                        .withOpacity(0.9),
                                  ),
                                  onPageChanged: (_) {},
                                )
                              : Chewie(
                                  controller: ChewieController(
                                    autoPlay: true,
                                    videoPlayerController:
                                        _videoPlayerControllers[
                                            _currentMediaIndex - imageCount],
                                  ),
                                ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        child: FrostedContainer(
                          borderRadiusAmount: 0,
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              if (widget.imageCaptions.isNotEmpty &&
                                  _currentMediaIndex <= imageCount - 1)
                                Text(
                                  widget.imageCaptions[_currentMediaIndex],
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              const Spacer(),
                              GalleryControls(
                                currentIndex: _currentMediaIndex,
                                totalMediaCount: totalMediaCount,
                                onPrevious: _previousMedia,
                                onNext: _nextMedia,
                                onMediaBrowser: () {
                                  setState(() {
                                    _mediaBrowserVisible =
                                        !_mediaBrowserVisible;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              if (_mediaBrowserVisible)
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: MediaBrowser(
                    youtubeVideoIds: widget.youtubeVideoIds,
                    imagePaths: widget.imagePaths,
                    playerControllers: _videoPlayerControllers,
                    onTapped: (int index) {
                      if (index >= imageCount) {
                        setState(() {
                          _currentMediaIndex = index;
                        });
                        return;
                      }
                      if (_currentMediaIndex >= imageCount) {
                        setState(() {
                          _currentMediaIndex = index;
                        });
                        _setupImagePageController();
                        return;
                      }
                      _imagePageController.jumpToPage(
                        index,
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  if (widget.logoPath != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: FrostedContainer(
                        padding: const EdgeInsets.all(4),
                        borderRadiusAmount: 100,
                        child: Image.asset(
                          widget.logoPath!,
                          fit: BoxFit.contain,
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.title,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        dateRangeText,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ],
              ),
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
  void initState() {
    super.initState();
    // Initialize the image page controller.
    _setupImagePageController();

    // Initialize the video player controllers.
    for (final String videoPath in widget.videoPaths) {
      _videoPlayerControllers.add(
        VideoPlayerController.asset(
          videoPath,
        )..initialize(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.only(right: 12.0),
              child: orientation == Orientation.portrait
                  ? _portraitView(context)
                  : _landscapeView(context),
            ),
          ),
        ),
      );
    });
  }
}
