import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../common/strings.dart';
import '../models/app_state.dart';
import '../widgets/custom_app_bars.dart';
import '../widgets/floating_thumbnail.dart';
import '../widgets/frosted_container.dart';

/// A screen that displays a collection of professional experiences.
class ProfessionalScreen extends StatefulWidget {
  const ProfessionalScreen({super.key});

  @override
  State<ProfessionalScreen> createState() => _ProfessionalScreenState();
}

class _ProfessionalScreenState extends State<ProfessionalScreen> {
  /// The controller for the scroll view.
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (BuildContext context, AppState appState, Widget? child) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return Scaffold(
              appBar: CustomAppBars.genericAppBar(
                  context: context, title: Strings.professionalExperiences),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: FrostedContainer(
                    padding: EdgeInsets.zero,
                    child: Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        padding: orientation == Orientation.portrait
                            ? const EdgeInsets.only(right: 8)
                            : EdgeInsets.zero,
                        controller: _scrollController,
                        child: FutureBuilder<void>(
                          future: appState.loadProfessionalExperiences(context),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return GridView.custom(
                                  padding: const EdgeInsets.all(16),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        orientation == Orientation.portrait
                                            ? 1
                                            : 3,
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
                                        title: appState
                                            .professionalExperiences[index]
                                            .company,
                                        subtitle: appState
                                            .professionalExperiences[index]
                                            .role,
                                        image: appState
                                            .professionalExperiences[index]
                                            .thumbnailPath,
                                        logoPath: appState
                                            .professionalExperiences[index]
                                            .logoPath,
                                        frosted: true,
                                        onTap: () => context.go(
                                          '${Strings.homeRoute}/${Strings.professionalSubRoute}/${Strings.detailsSubRoute}/${appState.professionalExperiences[index].titleAsPath}',
                                        ),
                                      );
                                    },
                                    childCount:
                                        appState.professionalExperiences.length,
                                  ));
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(24),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height - 150,
                                  child: const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  ),
                                ),
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
      },
    );
  }
}
