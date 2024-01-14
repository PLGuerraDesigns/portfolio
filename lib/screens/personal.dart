import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../common/strings.dart';
import '../models/app_state.dart';
import '../widgets/custom_app_bars.dart';
import '../widgets/frosted_container.dart';
import '../widgets/thumbnail_item.dart';

/// A screen that displays a collection of personal projects.
class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
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
                  context: context, title: Strings.personalProjects),
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
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            FutureBuilder<void>(
                              future: appState.loadProjects(context),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return GridView.custom(
                                    padding: const EdgeInsets.all(8),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          orientation == Orientation.portrait
                                              ? 1
                                              : 5,
                                      crossAxisSpacing: 8,
                                      childAspectRatio:
                                          orientation == Orientation.portrait
                                              ? 1.175
                                              : 1.0,
                                    ),
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    childrenDelegate:
                                        SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                        return ProjectThumbnail(
                                          title: appState.projects[index].title,
                                          subtitle:
                                              appState.projects[index].subtitle,
                                          imagePath: appState
                                              .projects[index].thumbnailPath,
                                          onTap: () => context.go(
                                            '${Strings.homeRoute}/${Strings.personalSubRoute}/${Strings.detailsSubRoute}/${appState.projects[index].titleAsPath}',
                                          ),
                                        );
                                      },
                                      childCount: appState.projects.length,
                                    ),
                                  );
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.all(24),
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              150,
                                      child: const Center(
                                        child: CircularProgressIndicator
                                            .adaptive(),
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
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
