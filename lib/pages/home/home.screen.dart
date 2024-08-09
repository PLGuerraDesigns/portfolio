import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/app_state.dart';
import 'home.controller.dart';
import 'widgets/action_menu.dart';
import 'widgets/app_bar.dart';
import 'widgets/drawer.dart';
import 'widgets/header.dart';
import 'widgets/professional_vs_personal_menu.dart';
import 'widgets/timeline.dart';

/// A screen that displays the home page.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// The controller for the home screen.
  late final HomeController _controller;

  /// Arranges the widgets in a column for portrait orientation.
  Widget _portraitView() {
    final double collapsedHeight = MediaQuery.of(context).size.height * 0.001;
    final double expandedHeight = MediaQuery.of(context).size.height * 0.26;

    return Consumer<HomeController>(
      builder:
          (BuildContext context, HomeController controller, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Header(compact: true),
            AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: controller.timelineExpanded
                    ? collapsedHeight
                    : expandedHeight,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 150),
                  opacity: controller.timelineExpanded ? 0 : 1,
                  child: const Column(
                    children: <Widget>[
                      SizedBox(height: 8, width: 8),
                      Expanded(
                        child: ProfessionalVsPersonalMenu(),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 8, width: 8),
            Expanded(
              child: Timeline(
                timelineExpanded: controller.timelineExpanded,
                onToggleExpanded: controller.toggleTimelineExpanded,
              ),
            ),
          ],
        );
      },
    );
  }

  /// Arranges the widgets in a row for landscape orientation.
  Widget _landscapeView() {
    final double collapsedWidth = MediaQuery.of(context).size.width * 0.001;
    final double expandedWidth = MediaQuery.of(context).size.width * 0.5;

    return Consumer<HomeController>(
      builder:
          (BuildContext context, HomeController controller, Widget? child) {
        return Column(
          children: <Widget>[
            const Header(compact: false),
            const SizedBox(height: 8),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    child: Timeline(
                      timelineExpanded: controller.timelineExpanded,
                      onToggleExpanded: controller.toggleTimelineExpanded,
                    ),
                  ),
                  if (!controller.timelineExpanded) const SizedBox(width: 8),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    transformAlignment: Alignment.centerRight,
                    width: controller.timelineExpanded
                        ? collapsedWidth
                        : expandedWidth,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 150),
                      opacity: controller.timelineExpanded ? 0.01 : 1,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: ProfessionalVsPersonalMenu(),
                          ),
                          SizedBox(height: 8),
                          Expanded(
                            child: ActionMenu(compact: false),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _controller = HomeController(
      appState: Provider.of<AppState>(context, listen: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return Scaffold(
          appBar: HomeAppBar.build(
            context: context,
            compact: orientation == Orientation.portrait,
          ),
          drawer:
              orientation == Orientation.landscape ? null : const HomeDrawer(),
          body: ChangeNotifierProvider<HomeController>.value(
            value: _controller,
            builder: (BuildContext context, Widget? child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: orientation == Orientation.portrait
                    ? _portraitView()
                    : _landscapeView(),
              );
            },
          ),
        );
      },
    );
  }
}
