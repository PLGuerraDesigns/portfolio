import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/strings.dart';
import '../models/app_state.dart';
import '../services/redirect_handler.dart';
import '../widgets/custom_app_bars.dart';
import '../widgets/custom_filter_chip.dart';
import '../widgets/custom_icon_button.dart';
import '../widgets/floating_thumbnail.dart';
import '../widgets/frosted_container.dart';
import '../widgets/header_banner.dart';
import '../widgets/social_icon_button.dart';
import '../widgets/time_line_entry.dart';

/// A screen that displays the home page.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// A boolean that determines whether the timeline should take up more space.
  bool _timelineExpanded = false;

  /// A button that redirects to the Flutter website.
  Widget _poweredByFlutterButton(BuildContext context) {
    return TextButton(
        onPressed: () async {
          if (await canLaunchUrl(Uri.parse(Strings.flutterUrl))) {
            launchUrl(
              Uri.parse(Strings.flutterUrl),
            );
          }
        },
        child: Text(Strings.poweredByFlutter.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                )));
  }

  /// A header banner with a profile photo, name, subtitle, and social media
  /// buttons.
  Widget _header(BuildContext context, {bool compact = false}) {
    Widget location() {
      return Row(
        children: <Widget>[
          Icon(
            Icons.pin_drop,
            size: compact ? 14 : 18,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          ),
          const SizedBox(width: 4.0),
          Text(
            Strings.currentLocation,
            style: compact
                ? Theme.of(context).textTheme.labelSmall
                : Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(width: 18.0),
        ],
      );
    }

    return HeaderBanner(
      leading: CircleAvatar(
        radius: compact ? 38 : 55,
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        backgroundImage: AssetImage(
          Strings.profilePhotoPath(Theme.of(context).brightness),
        ),
      ),
      title: Row(
        crossAxisAlignment:
            compact ? CrossAxisAlignment.center : CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            Strings.name,
            style: compact
                ? Theme.of(context).textTheme.titleLarge
                : Theme.of(context).textTheme.headlineLarge,
          ),
          const Spacer(),
          if (!compact) _socialMediaButtons(context),
          const SizedBox(width: 8.0),
          if (compact) location(),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          DefaultTextStyle(
            style: compact
                ? Theme.of(context).textTheme.labelSmall!
                : Theme.of(context).textTheme.titleMedium!,
            textAlign: TextAlign.left,
            child: AnimatedTextKit(
              repeatForever: true,
              pause: const Duration(milliseconds: 250),
              animatedTexts: <AnimatedText>[
                RotateAnimatedText(
                  Strings.subtitle,
                  duration: const Duration(seconds: 7),
                ),
                RotateAnimatedText(
                  Strings.motto,
                  duration: const Duration(seconds: 7),
                ),
              ],
            ),
          ),
          SizedBox(
            height: compact ? 40 : 55,
          ),
          if (!compact) location(),
        ],
      ),
    );
  }

  /// A list of social media buttons that redirect to the respective URLs.
  Widget _socialMediaButtons(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SocialIconButton(
          title: Strings.github,
          socialAssetBasePath: Strings.socialAssetsBasePath,
          urlString: Strings.githubUrl,
        ),
        SocialIconButton(
          title: Strings.linkedin,
          socialAssetBasePath: Strings.socialAssetsBasePath,
          urlString: Strings.linkedinUrl,
        ),
        SocialIconButton(
          title: Strings.thingiverse,
          socialAssetBasePath: Strings.socialAssetsBasePath,
          urlString: Strings.thingiverseUrl,
        ),
      ],
    );
  }

  /// A list of notable events, projects, and experiences.
  Widget _timeline(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Consumer<AppState>(
      builder: (BuildContext context, AppState appState, Widget? child) {
        return FrostedContainer(
          padding: EdgeInsets.zero,
          child: FutureBuilder<List<TimelineEntry>>(
              future: appState.loadTimelineEntries(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                List<TimelineEntry> entries = <TimelineEntry>[];
                if (snapshot.connectionState == ConnectionState.done) {
                  entries = snapshot.data as List<TimelineEntry>;
                }

                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: entries.isEmpty ? 0.001 : 1,
                  child: Scrollbar(
                    controller: scrollController,
                    thumbVisibility: true,
                    child: ListView.custom(
                      controller: scrollController,
                      padding: const EdgeInsets.all(16),
                      childrenDelegate: SliverChildListDelegate(<Widget>[
                        Stack(
                          children: <Widget>[
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    Strings.show.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .hintColor
                                              .withOpacity(0.5),
                                        ),
                                  ),
                                  const SizedBox(width: 8),
                                  CustomFilterChip(
                                    label: Strings.education,
                                    selected: appState.educationVisible,
                                    onSelected: (bool value) {
                                      appState.toggleEducationVisibility();
                                    },
                                  ),
                                  CustomFilterChip(
                                    label: Strings.professional,
                                    selected:
                                        appState.professionalExperiencesVisible,
                                    onSelected: (bool value) {
                                      appState
                                          .toggleProfessionalExperienceVisibility();
                                    },
                                  ),
                                  CustomFilterChip(
                                    label: Strings.projects,
                                    selected: appState.projectsVisible,
                                    onSelected: (bool value) {
                                      appState.toggleProjectsVisibility();
                                    },
                                  ),
                                  const SizedBox(width: 52),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                tooltip: _timelineExpanded
                                    ? Strings.collapse
                                    : Strings.expand,
                                visualDensity: VisualDensity.compact,
                                color: Theme.of(context).colorScheme.onSurface,
                                onPressed: () {
                                  setState(() {
                                    _timelineExpanded = !_timelineExpanded;
                                  });
                                },
                                icon: Icon(
                                  _timelineExpanded
                                      ? Icons.zoom_in_map
                                      : Icons.zoom_out_map,
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.5),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${entries.length} ${Strings.entries}',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.5),
                                ),
                          ),
                        ),
                        if (entries.isEmpty)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              Strings.selectACategoryToViewTheEntries,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.5),
                              ),
                            ),
                          ),
                        ...entries.map(
                          (TimelineEntry entry) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              entry,
                              const Divider(
                                indent: 8,
                                endIndent: 8,
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }

  /// A menu that allows the user to navigate to the professional experience
  /// and personal projects screens.
  Widget _professionalVsPersonalMenu(BuildContext context) {
    return FrostedContainer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              Strings.explore.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Theme.of(context).hintColor.withOpacity(0.75),
                  ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: FloatingThumbnail(
                    title: Strings.professional,
                    image: Strings.professionalExperiencePhotoPath,
                    shimmer: true,
                    onTap: () {
                      context.go(
                          '${Strings.homeRoute}/${Strings.professionalSubRoute}');
                    },
                  ),
                ),
                Column(
                  children: <Widget>[
                    const Expanded(
                      child: VerticalDivider(
                        indent: 8,
                        endIndent: 8,
                      ),
                    ),
                    Text(
                      Strings.or.toUpperCase(),
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Theme.of(context).hintColor.withOpacity(0.5),
                          ),
                    ),
                    const Expanded(
                      child: VerticalDivider(
                        indent: 8,
                        endIndent: 8,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: FloatingThumbnail(
                    title: Strings.personal,
                    image: Strings.personalExperiencePhotoPath,
                    shimmer: true,
                    onTap: () {
                      context.go(
                          '${Strings.homeRoute}/${Strings.personalSubRoute}');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// A menu that provides various action buttons.
  Widget _actionMenu(BuildContext context, {bool compact = false}) {
    Widget icon(IconData iconData) {
      return Icon(
        iconData,
        size: 46,
        color: Theme.of(context).colorScheme.onSurface,
      );
    }

    return FrostedContainer(
      borderRadiusAmount: compact ? 0 : 16.0,
      child: GridView.custom(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: compact ? 2 : 4,
          childAspectRatio: 0.9,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        childrenDelegate: SliverChildListDelegate(
          <Widget>[
            FrostedActionButton(
              icon: icon(Icons.quick_contacts_mail_rounded),
              title: Strings.contactMe,
              onTap: () => RedirectHandler.openUrl(Strings.contactEmailUrl),
            ),
            FrostedActionButton(
              icon: icon(Icons.bug_report_rounded),
              title: Strings.reportAnIssue,
              onTap: () => RedirectHandler.openUrl(Strings.issuesUrl),
            ),
          ],
        ),
      ),
    );
  }

  /// Arranges the widgets in a column for portrait orientation.
  Widget _portraitView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _header(context, compact: true),
        AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            height: _timelineExpanded
                ? MediaQuery.of(context).size.height * 0.001
                : MediaQuery.of(context).size.height * 0.26,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: _timelineExpanded ? 0.001 : 1,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 8, width: 8),
                  Expanded(child: _professionalVsPersonalMenu(context)),
                ],
              ),
            )),
        const SizedBox(height: 8, width: 8),
        Expanded(child: _timeline(context)),
      ],
    );
  }

  /// Arranges the widgets in a row for landscape orientation.
  Widget _landscapeView(BuildContext context) {
    return Column(
      children: <Widget>[
        _header(context),
        const SizedBox(height: 8),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: _timeline(context),
              ),
              if (!_timelineExpanded) const SizedBox(width: 8),
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                transformAlignment: Alignment.centerRight,
                width: _timelineExpanded
                    ? MediaQuery.of(context).size.width * 0.001
                    : MediaQuery.of(context).size.width * 0.5,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 100),
                  opacity: _timelineExpanded ? 0.001 : 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: _professionalVsPersonalMenu(context),
                      ),
                      const SizedBox(height: 8),
                      Expanded(child: _actionMenu(context)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// A drawer that provides various action buttons.
  Widget _drawer(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Column(
          children: <Widget>[
            DrawerHeader(
              margin: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () =>
                            RedirectHandler.openUrl(Strings.sourceCodeUrl),
                        icon: const Icon(Icons.code),
                        tooltip: Strings.viewSourceCode,
                      ),
                      _socialMediaButtons(context),
                    ],
                  ),
                  _poweredByFlutterButton(context),
                  Text(
                    Strings.lastUpdated,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.5),
                        ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: _actionMenu(
                context,
                compact: true,
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return Scaffold(
          appBar: CustomAppBars.homeAppBar(
            context: context,
            poweredByFlutterButton: _poweredByFlutterButton(context),
            lastUpdated: Strings.lastUpdated,
            compact: orientation == Orientation.portrait,
          ),
          drawer:
              orientation == Orientation.landscape ? null : _drawer(context),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: orientation == Orientation.portrait
                ? _portraitView(context)
                : _landscapeView(context),
          ),
        );
      },
    );
  }
}
