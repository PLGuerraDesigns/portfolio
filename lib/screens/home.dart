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
        backgroundImage: const AssetImage(
          Strings.profilePhotoPath,
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
          if (compact) location(),
          const SizedBox(width: 8.0),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              Strings.subtitle,
              style: compact
                  ? Theme.of(context).textTheme.labelSmall
                  : Theme.of(context).textTheme.titleMedium,
            ),
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
                timeFrame: '2022 - PRESENT',
                urlString: Strings.gmuUrl,
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
                timeFrame: '2020 - PRESENT',
                urlString: Strings.aicUrl,
              ),
              const Divider(
                indent: 8,
                endIndent: 8,
              ),
              const TimelineEntry(
                logoPath: Strings.ambotsLogoPath,
                title: 'AMBOTS Inc.',
                description: 'Lead Robotics Engineer',
                timeFrame: '2020 - 2021',
                urlString: Strings.ambotsUrl,
              ),
              const Divider(
                indent: 8,
                endIndent: 8,
              ),
              const TimelineEntry(
                logoPath: Strings.uarkLogoPath,
                title: 'University of Arkansas (AM³ Lab)',
                description: 'Graduate Research Assistant',
                timeFrame: '2019 - 2020',
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
                timeFrame: '2017 - 2020',
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
    return FrostedContainer(
      borderRadiusAmount: compact ? 0 : 24,
      child: GridView.custom(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: compact ? 2 : 5,
          childAspectRatio: 0.9,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        childrenDelegate: SliverChildListDelegate(
          <Widget>[
            FrostedIconButton(
              icon: Icons.quick_contacts_mail_rounded,
              title: Strings.contact,
              onTap: () => RedirectHandler.openUrl(Strings.contactEmailUrl),
            ),
            FrostedIconButton(
              icon: Icons.monetization_on_rounded,
              title: Strings.sponsor,
              onTap: () => RedirectHandler.openUrl(Strings.sponsorUrl),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _header(context),
              const SizedBox(height: 8, width: 8),
              Expanded(child: _timeline(context))
            ],
          ),
        ),
        const SizedBox(height: 8, width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: _professionalVsPersonalMenu(context)),
              const SizedBox(height: 8, width: 8),
              Expanded(child: _actionMenu(context)),
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
            padding: const EdgeInsets.all(16.0),
            child: orientation == Orientation.portrait
                ? _portraitView(context)
                : _landscapeView(context),
          ),
        );
      },
    );
  }
}
