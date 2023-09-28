import 'dart:convert';

import 'package:flutter/material.dart';

import '../common/strings.dart';
import '../models/professional_experience.dart';
import '../widgets/custom_app_bars.dart';
import '../widgets/floating_thumbnail.dart';
import '../widgets/frosted_container.dart';
import 'details.dart';

/// A screen that displays a collection of professional experiences.
class ProfessionalScreen extends StatefulWidget {
  const ProfessionalScreen({super.key});

  @override
  State<ProfessionalScreen> createState() => _ProfessionalScreenState();
}

class _ProfessionalScreenState extends State<ProfessionalScreen> {
  /// The controller for the scroll view.
  final ScrollController _scrollController = ScrollController();

  /// The list of professional experiences to display.
  final List<ProfessionalExperience> _professionalExperience =
      <ProfessionalExperience>[];

  /// Loads the professional experience from the JSON file.
  Future<List<ProfessionalExperience>> _loadProfessionalExperience() async {
    await DefaultAssetBundle.of(context)
        .loadString(Strings.professionalExperienceJsonPath)
        .then(
      (String data) {
        final dynamic jsonResult = json.decode(data);
        for (final dynamic professionalExperience
            in jsonResult as List<dynamic>) {
          _professionalExperience.add(ProfessionalExperience.fromJson(
              professionalExperience as Map<String, dynamic>));
        }
      },
    );
    return _professionalExperience;
  }

  /// Navigates to the details screen for the given professional experience.
  void _navigateToExperienceDetails(
      {required BuildContext context,
      required ProfessionalExperience professionalExperience,
      required bool replace}) {
    final Widget detailScreen = DetailsScreen(
      appBarTitle: Strings.professionalExperiences,
      logoPath: professionalExperience.logoPath,
      title: professionalExperience.company,
      description: professionalExperience.description,
      imagePaths: <String>[professionalExperience.thumbnailPath],
      videoPaths: const <String>[],
      youtubeVideoIds: professionalExperience.youtubeVideoIds,
      imageCaptions: const <String>[],
      externalLinks: professionalExperience.externalLinks,
      startDate: professionalExperience.startDateString,
      finalDate: professionalExperience.finalDateString,
      tags: const <String>[],
    );
    if (replace) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder<Widget>(
          pageBuilder: (BuildContext context, Animation<double> animation1,
                  Animation<double> animation2) =>
              detailScreen,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => detailScreen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return Scaffold(
          appBar: CustomAppBars.genericAppBar(
              context: context, title: Strings.professionalExperiences),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: FrostedContainer(
                padding: EdgeInsets.zero,
                child: Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(12.0),
                    controller: _scrollController,
                    child: FutureBuilder<List<dynamic>>(
                      future: _loadProfessionalExperience(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return GridView.custom(
                              padding: const EdgeInsets.all(10),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    orientation == Orientation.portrait ? 1 : 3,
                                crossAxisSpacing: 16,
                                mainAxisSpacing:
                                    orientation == Orientation.portrait
                                        ? 16
                                        : 0,
                              ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              childrenDelegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return FloatingThumbnail(
                                    title:
                                        _professionalExperience[index].company,
                                    subtitle:
                                        _professionalExperience[index].role,
                                    image: _professionalExperience[index]
                                        .thumbnailPath,
                                    logoPath:
                                        _professionalExperience[index].logoPath,
                                    frosted: true,
                                    onTap: () => _navigateToExperienceDetails(
                                      context: context,
                                      professionalExperience:
                                          _professionalExperience[index],
                                      replace: false,
                                    ),
                                  );
                                },
                                childCount: _professionalExperience.length,
                              ));
                        } else {
                          return const Padding(
                            padding: EdgeInsets.all(24),
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
