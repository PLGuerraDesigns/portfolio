import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/strings.dart';
import '../services/redirect_handler.dart';
import '../widgets/custom_app_bars.dart';
import '../widgets/custom_icon_button.dart';
import '../widgets/floating_thumbnail.dart';
import '../widgets/frosted_container.dart';
import '../widgets/header_banner.dart';
import '../widgets/social_icon_button.dart';
import '../widgets/time_line_entry.dart';

/// A screen that displays the home page.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
    return FrostedContainer(
      padding: EdgeInsets.zero,
      child: Scrollbar(
        controller: scrollController,
        thumbVisibility: true,
        child: ListView.custom(
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          childrenDelegate: SliverChildListDelegate(
            <Widget>[
              const TimelineEntry(
                logoPath: Strings.gmuLogoPath,
                title: 'George Mason University',
                description: 'M.S. in Software Engineering',
                timeFrame: 'AUG 2022 - MAY 2024 (EXPECTED)',
                urlString: Strings.gmuUrl,
              ),
              const Divider(
                indent: 8,
                endIndent: 8,
              ),
              const TimelineEntry(
                logoPath: Strings.ambotsLogoPath,
                title: 'AMBOTS Inc.',
                description: 'Lead Robotics Engineer',
                timeFrame: 'FEB 2021 - OCT 2021',
                urlString: Strings.ambotsUrl,
              ),
              const Divider(
                indent: 8,
                endIndent: 8,
              ),
              const TimelineEntry(
                logoPath: Strings.aicLogoPath,
                title: 'Atlantic Insurance Co. Ltd.',
                description:
                    'Contract Software Engineer\nAIC Mobile App & Management Portal',
                timeFrame: 'JUN 2020 - PRESENT',
                urlString: Strings.aicUrl,
              ),
              const Divider(
                indent: 8,
                endIndent: 8,
              ),
              const TimelineEntry(
                logoPath: Strings.uarkLogoPath,
                title: 'University of Arkansas (AM³ Lab)',
                description: 'Graduate Research Assistant',
                timeFrame: 'APR 2019 - DEC 2020',
                urlString: Strings.am3LabUrl,
              ),
              const Divider(
                indent: 8,
                endIndent: 8,
              ),
              const TimelineEntry(
                logoPath: Strings.uarkLogoPath,
                title: 'University of Arkansas',
                description: 'B.S. in Computer Science',
                timeFrame: 'AUG 2017 - DEC 2020',
                urlString: Strings.uarkUrl,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// A menu that allows the user to navigate to the professional experience
  /// and personal projects screens.
  Widget _professionalVsPersonalMenu(BuildContext context) {
    return FrostedContainer(
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
                context
                    .go('${Strings.homeRoute}/${Strings.professionalSubRoute}');
              },
            ),
          ),
          const VerticalDivider(
            indent: 8,
            endIndent: 8,
          ),
          Expanded(
            child: FloatingThumbnail(
              title: Strings.personal,
              image: Strings.personalExperiencePhotoPath,
              shimmer: true,
              onTap: () {
                context.go('${Strings.homeRoute}/${Strings.personalSubRoute}');
              },
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
        const SizedBox(height: 8, width: 8),
        Flexible(child: _professionalVsPersonalMenu(context)),
        const SizedBox(height: 8, width: 8),
        Flexible(flex: 2, child: _timeline(context)),
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
              Expanded(child: _timeline(context)),
              const SizedBox(width: 8),
              Expanded(
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
