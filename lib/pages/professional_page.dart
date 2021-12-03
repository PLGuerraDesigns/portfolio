import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:plg_portfolio/constants/strings.dart';
import 'package:plg_portfolio/models/professional_experience.dart';
import 'package:plg_portfolio/view_models/control_model.dart';
import 'package:plg_portfolio/widgets/custom_widgets.dart';
import 'package:provider/provider.dart';

class ProfessionalPage extends StatelessWidget {
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
                          _professionCard(context,
                              control.professionalExperienceList[0], control),
                          _professionCard(context,
                              control.professionalExperienceList[1], control),
                        ],
                      )
                    : Row(
                        children: [
                          _professionCard(context,
                              control.professionalExperienceList[0], control),
                          const SizedBox(
                            width: 20,
                          ),
                          _professionCard(context,
                              control.professionalExperienceList[1], control),
                        ],
                      ),
              ),
            )
          ],
        ));
  }

  Widget _professionCard(BuildContext context,
      ProfessionalExperience professionalExperience, ControlModel control) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        CustomWidgets().detailsDialog(
            context,
            control.mobileScreenSize,
            _experienceDetails(
                context, professionalExperience, control.mobileScreenSize));
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
                    professionalExperience.backgroundImagePath,
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
                    professionalExperience.title,
                    textAlign: TextAlign.center,
                    style: control.mobileScreenSize
                        ? Theme.of(context).textTheme.headline5
                        : Theme.of(context).textTheme.headline3,
                  ),
                  const Divider(
                    indent: 100,
                    endIndent: 100,
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    professionalExperience.subtitle,
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
                      professionalExperience.floatingImagePath,
                      height: control.mobileScreenSize
                          ? constraints.maxWidth * 0.32
                          : constraints.maxWidth * 0.36,
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

  Widget _experienceDetails(BuildContext context,
      ProfessionalExperience professionalExperience, bool mobileScreenSize) {
    if (mobileScreenSize) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomWidgets().carouselVideoViewer(context, buttonCarouselController,
            professionalExperience.videoList, mobileScreenSize),
        const SizedBox(height: 10),
        Text(
          professionalExperience.title,
          style: Theme.of(context).textTheme.headline4,
        ),
        Text(
          professionalExperience.date,
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          professionalExperience.description,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.white60),
        ),
        professionalExperience.moreInfo.isNotEmpty
            ? const Divider(
                color: Colors.white30,
                height: 40,
              )
            : Container(),
        professionalExperience.moreInfo.isNotEmpty
            ? CustomWidgets()
                .moreInfoSection(context, professionalExperience.moreInfo)
            : Container(),
        const SizedBox(
          width: 20,
        ),
      ]);
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomWidgets().carouselVideoViewer(context, buttonCarouselController,
              professionalExperience.videoList, mobileScreenSize),
          const SizedBox(height: 10),
          Text(
            professionalExperience.title,
            style: Theme.of(context).textTheme.headline4,
          ),
          Row(children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    professionalExperience.date,
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    professionalExperience.description,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.white60),
                  ),
                  professionalExperience.moreInfo.isNotEmpty
                      ? const Divider(
                          color: Colors.white30,
                          height: 40,
                        )
                      : Container(),
                  professionalExperience.moreInfo.isNotEmpty
                      ? CustomWidgets().moreInfoSection(
                          context, professionalExperience.moreInfo)
                      : Container(),
                ],
              ),
            ),
          ])
        ],
      );
    }
  }
}
