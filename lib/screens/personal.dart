import 'dart:convert';

import 'package:flutter/material.dart';

import '../common/strings.dart';
import '../models/projects.dart';
import '../widgets/custom_app_bars.dart';
import '../widgets/frosted_container.dart';
import '../widgets/thumbnail_item.dart';
import 'details.dart';

/// A screen that displays a collection of personal projects.
class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  /// The controller for the scroll view.
  final ScrollController _scrollController = ScrollController();

  /// The list of projects to display.
  final List<Project> _projects = <Project>[];

  /// Loads the projects from the JSON file.
  Future<List<Project>> _loadProjects() async {
    await DefaultAssetBundle.of(context)
        .loadString(Strings.projectsJsonPath)
        .then(
      (String data) {
        final dynamic jsonResult = json.decode(data);
        for (final dynamic project in jsonResult as List<dynamic>) {
          _projects.add(Project.fromJson(project as Map<String, dynamic>));
        }
      },
    );
    return _projects;
  }

  /// Navigates to the details screen for the given project.
  void _navigateToPersonalProject({
    required BuildContext context,
    required Project project,
    required int index,
    required bool compact,
    required bool replace,
  }) {
    final Widget detailScreen = DetailsScreen(
      appBarTitle: Strings.personalProjects,
      title: project.title,
      description: project.description,
      imagePaths: project.imagePaths,
      imageCaptions: project.imageCaptions,
      videoPaths: project.videoPaths,
      startDate: project.startDateString,
      finalDate: project.finalDateString,
      tags: project.tags,
      youtubeVideoIds: const <String>[],
      externalLinks: project.externalLinks,
      actions: <Widget>[
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: index > 0
              ? () => _navigateToPersonalProject(
                    context: context,
                    project: _projects[index - 1],
                    index: index - 1,
                    compact: compact,
                    replace: true,
                  )
              : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.chevron_left),
              Text(
                compact
                    ? Strings.previous.toUpperCase()
                    : Strings.previousProject.toUpperCase(),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        OutlinedButton(
          onPressed: index < _projects.length - 1
              ? () => _navigateToPersonalProject(
                    context: context,
                    project: _projects[index + 1],
                    index: index + 1,
                    compact: compact,
                    replace: true,
                  )
              : null,
          style: OutlinedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onSurface,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                compact
                    ? Strings.next.toUpperCase()
                    : Strings.nextProject.toUpperCase(),
              ),
              const Icon(Icons.chevron_right)
            ],
          ),
        ),
      ],
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
            context: context, title: Strings.personalProjects),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FrostedContainer(
            padding: EdgeInsets.zero,
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12.0),
                controller: _scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FutureBuilder<List<dynamic>>(
                      future: _loadProjects(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return GridView.custom(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    orientation == Orientation.portrait ? 1 : 5,
                                crossAxisSpacing: 8,
                              ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              childrenDelegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return ProjectThumbnail(
                                    title: _projects[index].title,
                                    subtitle: _projects[index].imageCaptions[0],
                                    imagePath: _projects[index].thumbnailPath,
                                    onTap: () => _navigateToPersonalProject(
                                      context: context,
                                      project: _projects[index],
                                      index: index,
                                      compact:
                                          orientation == Orientation.portrait,
                                      replace: false,
                                    ),
                                  );
                                },
                                childCount: _projects.length,
                              ));
                        } else {
                          return const Padding(
                            padding: EdgeInsets.all(24),
                            child: CircularProgressIndicator(),
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
      );
    });
  }
}
