import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:plg_portfolio/constants/strings.dart';
import 'package:plg_portfolio/models/project.dart';
import 'package:plg_portfolio/view_models/control_model.dart';
import 'package:plg_portfolio/widgets/custom_widgets.dart';
import 'package:provider/provider.dart';

class ProfessionalPage extends StatelessWidget {
  static const String _ambFloatingImage =
      'assets/images/professional_page/ambots_floating.png';
  static const String _flutterFloatingImage =
      'assets/images/professional_page/flutter_floating.png';
  static const String _ambBackgroundImage =
      'assets/images/professional_page/ambots_background.png';
  static const String _flutterBackgroundImage =
      'assets/images/professional_page/flutter_background.png';
  final CarouselController buttonCarouselController = CarouselController();

  ProfessionalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final control = Provider.of<ControlModel>(context);

    return SizedBox(
        height: control.windowHeight - 60,
        width: control.windowWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomWidgets().pageTitle(context, Strings.professionalPageTitle,
                control.mobileScreenSize),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
                child: control.mobileScreenSize
                    ? Column(
                        children: [
                          _professionCard(
                              context,
                              _ambFloatingImage,
                              _ambBackgroundImage,
                              Strings.ambotsInc,
                              Strings.leadRoboticsEngineer,
                              control),
                          _professionCard(
                              context,
                              _flutterFloatingImage,
                              _flutterBackgroundImage,
                              Strings.flutterDeveloper,
                              Strings.publishedApps,
                              control),
                        ],
                      )
                    : Row(
                        children: [
                          _professionCard(
                              context,
                              _ambFloatingImage,
                              _ambBackgroundImage,
                              Strings.ambotsInc,
                              Strings.leadRoboticsEngineer,
                              control),
                          const SizedBox(
                            width: 20,
                          ),
                          _professionCard(
                              context,
                              _flutterFloatingImage,
                              _flutterBackgroundImage,
                              Strings.flutterDeveloper,
                              Strings.publishedApps,
                              control),
                        ],
                      ),
              ),
            )
          ],
        ));
  }

  Widget _professionCard(
      BuildContext context,
      String floatingImagePath,
      String backgroundImagePath,
      String title,
      String subtitle,
      ControlModel control) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        control.unavailableSnackBar();
        // TODO: DISPLAY JOB INFO
      },
      child: AspectRatio(
        aspectRatio: control.mobileScreenSize ? 2 / 1.6 : 1 / 1,
        child: SizedBox(
          height: MediaQuery.of(context).size.width / 2,
          child: Stack(
            children: [
              // Background image
              Align(
                alignment: control.mobileScreenSize
                    ? Alignment.bottomCenter
                    : Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    backgroundImagePath,
                    color: Colors.black38,
                    colorBlendMode: BlendMode.darken,
                  ),
                ),
              ),
              // Foreground content
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Spacer(flex: control.mobileScreenSize ? 5 : 3),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: control.mobileScreenSize
                        ? Theme.of(context).textTheme.headline5
                        : Theme.of(context).textTheme.headline3,
                  ),
                  const Divider(
                    indent: 50,
                    endIndent: 50,
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: control.mobileScreenSize
                        ? Theme.of(context).textTheme.headline6
                        : Theme.of(context).textTheme.headline4,
                  ),
                  Spacer(flex: control.mobileScreenSize ? 2 : 1),
                  Text(
                    'Click for more info',
                    textAlign: TextAlign.center,
                    style: control.mobileScreenSize
                        ? Theme.of(context).textTheme.bodyText2
                        : Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.white38),
                  ),
                  Spacer(flex: control.mobileScreenSize ? 1 : 2),
                ],
              ),
              // Floating image
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return Image.asset(
                      floatingImagePath,
                      height: control.mobileScreenSize
                          ? constraints.maxWidth * 0.32
                          : constraints.maxWidth * 0.4,
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _experienceDetails(
      BuildContext context, Project project, bool mobileScreenSize) {
    if (mobileScreenSize) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomWidgets().carouselMediaViewer(
            context, buttonCarouselController, project, mobileScreenSize),
        const SizedBox(height: 10),
        Text(
          project.title,
          style: Theme.of(context).textTheme.headline4,
        ),
        Text(
          project.date,
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          project.description,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.white60),
        ),
        project.moreInfo.isNotEmpty
            ? const Divider(
                color: Colors.white30,
                height: 40,
              )
            : Container(),
        project.moreInfo.isNotEmpty
            ? CustomWidgets().moreInfoSection(context, project)
            : Container(),
        const SizedBox(
          width: 20,
        ),
        const Divider(
          color: Colors.white30,
          height: 40,
        ),
        CustomWidgets().tagSection(context, project),
      ]);
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomWidgets().carouselMediaViewer(
              context, buttonCarouselController, project, mobileScreenSize),
          const SizedBox(height: 10),
          Text(
            project.title,
            style: Theme.of(context).textTheme.headline4,
          ),
          Row(children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.date,
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    project.description,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.white60),
                  ),
                  project.moreInfo.isNotEmpty
                      ? const Divider(
                          color: Colors.white30,
                          height: 40,
                        )
                      : Container(),
                  project.moreInfo.isNotEmpty
                      ? CustomWidgets().moreInfoSection(context, project)
                      : Container(),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(child: CustomWidgets().tagSection(context, project)),
          ])
        ],
      );
    }
  }
}
