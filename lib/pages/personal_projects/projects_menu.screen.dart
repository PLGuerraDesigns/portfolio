import 'package:flutter/material.dart';

import '../../common/strings.dart';
import '../../widgets/generic_app_bar.dart';
import 'widgets/projects_menu.dart';

/// A screen that displays a collection of personal projects.
class ProjectsMenuScreen extends StatefulWidget {
  const ProjectsMenuScreen({super.key});

  @override
  State<ProjectsMenuScreen> createState() => _ProjectsMenuScreenState();
}

class _ProjectsMenuScreenState extends State<ProjectsMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar.build(
        context: context,
        title: Strings.personalProjects,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const ProjectsMenu(),
        ),
      ),
    );
  }
}
