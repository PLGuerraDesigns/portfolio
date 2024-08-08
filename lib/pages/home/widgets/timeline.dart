import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/strings.dart';
import '../../../widgets/custom_filter_chip.dart';
import '../../../widgets/frosted_container.dart';
import '../home.controller.dart';
import 'time_line_entry.dart';

/// A list of notable events, projects, and experiences.
class Timeline extends StatelessWidget {
  const Timeline({
    super.key,
    required this.timelineExpanded,
    required this.onToggleExpanded,
  });

  /// Whether the timeline should take up more space.
  final bool timelineExpanded;

  /// A function that toggles the timeline's expansion.
  final Function() onToggleExpanded;

  /// A controller for the scroll view.
  static final ScrollController _scrollController = ScrollController();

  Widget _filterChipMenu({
    required BuildContext context,
    required HomeController homeController,
  }) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Text(
            Strings.show.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Theme.of(context).hintColor.withOpacity(0.5),
                ),
          ),
          const SizedBox(width: 8),
          CustomFilterChip(
            label: Strings.education,
            selected: homeController.showEducation,
            onSelected: (bool value) {
              homeController.toggleEducationVisibility();
            },
          ),
          CustomFilterChip(
            label: Strings.professional,
            selected: homeController.showProfessionalExperiences,
            onSelected: (bool value) {
              homeController.toggleProfessionalExperienceVisibility();
            },
          ),
          CustomFilterChip(
            label: Strings.projects,
            selected: homeController.showProjects,
            onSelected: (bool value) {
              homeController.toggleProjectsVisibility();
            },
          ),
          const SizedBox(width: 52),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder:
          (BuildContext context, HomeController homeController, Widget? child) {
        return FrostedContainer(
          padding: EdgeInsets.zero,
          child: FutureBuilder<List<TimelineEntry>>(
            future: homeController.loadTimelineEntries(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              List<TimelineEntry> entries = <TimelineEntry>[];
              if (snapshot.connectionState == ConnectionState.done) {
                entries = snapshot.data as List<TimelineEntry>;
              }

              return AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: homeController.timelineEntriesLoaded ? 1 : 0,
                child: Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  child: ListView.custom(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    childrenDelegate: SliverChildListDelegate(
                      <Widget>[
                        Stack(
                          children: <Widget>[
                            _filterChipMenu(
                              context: context,
                              homeController: homeController,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                tooltip: timelineExpanded
                                    ? Strings.collapse
                                    : Strings.expand,
                                visualDensity: VisualDensity.compact,
                                color: Theme.of(context).colorScheme.onSurface,
                                onPressed: onToggleExpanded,
                                icon: Icon(
                                  timelineExpanded
                                      ? Icons.zoom_in_map
                                      : Icons.zoom_out_map,
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.5),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${entries.length} ${Strings.entries}',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.5),
                                ),
                          ),
                        ),
                        if (entries.isEmpty)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              Strings.selectACategoryToViewTheEntries,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.5),
                              ),
                            ),
                          ),
                        ...entries.map(
                          (TimelineEntry entry) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              entry,
                              const Divider(
                                indent: 8,
                                endIndent: 8,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
