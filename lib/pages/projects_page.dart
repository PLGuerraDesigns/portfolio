import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plg_portfolio/constants/strings.dart';
import 'package:plg_portfolio/models/project.dart';
import 'package:plg_portfolio/view_models/control_model.dart';
import 'package:plg_portfolio/widgets/custom_widgets.dart';
import 'package:provider/provider.dart';

class ProjectsPage extends StatelessWidget {
  ProjectsPage({Key? key}) : super(key: key);

  final CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final control = Provider.of<ControlModel>(context);

    return SizedBox(
        height: control.windowHeight - 60,
        width: control.windowWidth,
        child: Column(
          children: [
            CustomWidgets().pageTitle(
                context, Strings.projectsPageTitle, control.mobileScreenSize),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(40),
                scrollDirection: Axis.horizontal,
                itemCount: control.projectList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: control.mobileScreenSize ? 3 : 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: (1 / 1.7),
                ),
                itemBuilder: (
                  context,
                  index,
                ) {
                  return _projectPreview(context, index,
                      control.mobileScreenSize, control.projectList[index]);
                },
              ),
            ),
          ],
        ));
  }

  Widget _projectPreview(
      BuildContext context, int index, bool mobileScreenSize, Project project) {
    return GestureDetector(
      onTap: () {
        CustomWidgets().projectDetailsDialog(context, project, mobileScreenSize,
            _projectDetails(context, project, mobileScreenSize));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          fit: StackFit.expand,
          children: [
            project.thumbnailPath == ''
                ? Container(
                    color: Colors.grey[900],
                  )
                : Image.asset(
                    project.thumbnailPath,
                    fit: BoxFit.cover,
                  ),
            CustomWidgets().imageCaption(
              caption: project.title,
              mobileScreenSize: mobileScreenSize,
              trialingIcon: const Icon(
                Icons.chevron_right,
                color: Colors.white38,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _projectDetails(
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
                color: Colors.white38,
                height: 40,
                thickness: 3,
              )
            : Container(),
        project.moreInfo.isNotEmpty
            ? CustomWidgets().moreInfoSection(context, project)
            : Container(),
        const SizedBox(
          width: 20,
        ),
        const Divider(
          color: Colors.white38,
          height: 40,
          thickness: 3,
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
                          color: Colors.white38,
                          height: 40,
                          thickness: 3,
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
