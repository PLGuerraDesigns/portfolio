import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:plg_portfolio/constants/colors.dart';
import 'package:plg_portfolio/models/project.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

/// The CustomWidgets class contains general customs widgets
/// that are used throughout the application.
class CustomWidgets {
  /// Returns an [Column] containing a [Text] widget and a [Divider].
  Widget pageTitle(BuildContext context, String title) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 20),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      const Divider(
        indent: 20,
        endIndent: 20,
        color: Colors.white30,
      )
    ]);
  }

  Widget imageCaption(
      {required String caption,
      Icon? trialingIcon,
      required bool mobileScreenSize}) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
        return Container(
          width: constraints.maxWidth,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: trialingIcon == null
                ? Text(
                    caption,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: Colors.white70),
                  )
                : Row(
                    children: [
                      Text(
                        caption,
                        style: mobileScreenSize
                            ? Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(color: Colors.white70)
                            : Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: Colors.white70),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.white38,
                      )
                    ],
                  ),
          ),
          color: Colors.black54,
        );
      }),
    );
  }

  Widget circularIconButton(
      {required Icon icon, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      child: icon,
      style: ButtonStyle(
          shape: MaterialStateProperty.all(const CircleBorder()),
          padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
          backgroundColor: MaterialStateProperty.all(Colors.black54),
          elevation: MaterialStateProperty.all(0)),
    );
  }

  projectDetailsDialog(BuildContext context, Project project,
      bool mobileScreenSize, Widget child) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            insetPadding: EdgeInsets.symmetric(
              vertical: 40,
              horizontal: mobileScreenSize ? 20 : 100,
            ),
            elevation: 5,
            contentPadding: EdgeInsets.symmetric(
                vertical: 10, horizontal: mobileScreenSize ? 20 : 40),
            content: Stack(
              children: [
                SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: child,
                  ),
                ),
                // Exit Button
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.all(mobileScreenSize ? 0 : 8.0),
                    child: CustomWidgets().circularIconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 20,
                        ),
                        onPressed: () => Navigator.of(context).pop()),
                  ),
                ),
              ],
            ),
            backgroundColor: themeGrey,
          );
        });
  }

  Widget carouselMediaViewer(
      BuildContext context,
      CarouselController buttonCarouselController,
      Project project,
      bool mobileScreenSize) {
    return AspectRatio(
      aspectRatio: 2 / 1.2,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Stack(
          children: [
            CarouselSlider(
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                  autoPlay: false,
                  enableInfiniteScroll: false,
                  pauseAutoPlayOnTouch: true,
                  enlargeCenterPage: true,
                  aspectRatio: 1.8,
                  viewportFraction: 0.82),
              items: [
                project.demoVideo
                    ? Chewie(
                        controller: ChewieController(
                          videoPlayerController: VideoPlayerController.asset(
                            project.videoPathList[0],
                          ),
                          autoInitialize: true,
                        ),
                      )
                    : Image.asset(
                        project.thumbnailPath,
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomCenter,
                      ),
                for (int iterator = 0;
                    iterator < project.photoCount;
                    iterator++)
                  Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        color: Colors.black12,
                      ),
                      Image.asset(
                        project.imagePathList[iterator],
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomCenter,
                      ),
                      CustomWidgets().imageCaption(
                        mobileScreenSize: mobileScreenSize,
                        caption: project.photoCaptionList[iterator],
                      )
                    ],
                  ),
                for (int iterator = project.demoVideo ? 1 : 0;
                    iterator < project.videoCount;
                    iterator++)
                  Chewie(
                    controller: ChewieController(
                      videoPlayerController: VideoPlayerController.asset(
                        project.videoPathList[iterator],
                      ),
                      autoInitialize: true,
                      autoPlay: false,
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      size: 20,
                    ),
                    onPressed: () => buttonCarouselController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () => buttonCarouselController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget moreInfoSection(BuildContext context, Project project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'More Info',
          style: Theme.of(context).textTheme.headline6,
        ),
        for (var moreInfoList in project.moreInfo)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: moreInfoList['text'],
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.white60),
                  ),
                  TextSpan(
                    text: '\n     ${moreInfoList['link']}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launch(moreInfoList['link']!);
                      },
                  ),
                ],
              ),
            ),
          )
      ],
    );
  }

  Widget tagSection(BuildContext context, Project project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tags',
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List<Widget>.generate(
            project.tags.length,
            (int idx) {
              return Chip(
                label: Text(
                  project.tags[idx],
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.black),
                ),
                backgroundColor: Colors.white54,
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}