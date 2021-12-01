import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plg_portfolio/constants/globals.dart';
import 'package:plg_portfolio/constants/strings.dart';
import 'package:plg_portfolio/constants/theme.dart';
import 'package:plg_portfolio/models/inline_page.dart';
import 'package:plg_portfolio/pages/about_page.dart';
import 'package:plg_portfolio/pages/contact_page.dart';
import 'package:plg_portfolio/pages/home_page.dart';
import 'package:plg_portfolio/pages/professional_page.dart';
import 'package:plg_portfolio/pages/projects_page.dart';
import 'package:plg_portfolio/pages/resume_page.dart';
import 'package:plg_portfolio/view_models/control_model.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

final List<InlinePage> _pageList = [
  InlinePage(Strings.home, const HomePage(), Icons.home),
  InlinePage(Strings.about, AboutPage(), Icons.emoji_people),
  InlinePage(Strings.professional, ProfessionalPage(), Icons.engineering),
  InlinePage(Strings.projects, ProjectsPage(), Icons.construction),
  InlinePage(Strings.contact, ContactPage(), Icons.contacts),
  InlinePage(Strings.resume, const ResumePage(), Icons.description),
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ControlModel(context),
      child: MaterialApp(
          scaffoldMessengerKey: snackbarKey,
          debugShowCheckedModeBanner: false,
          title: Strings.applicationName,
          theme: AppTheme.darkTheme,
          home: const PortfolioMainPage()),
    );
  }
}

class PortfolioMainPage extends StatefulWidget {
  const PortfolioMainPage({Key? key}) : super(key: key);

  @override
  _PortfolioMainPageState createState() => _PortfolioMainPageState();
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class _PortfolioMainPageState extends State<PortfolioMainPage> {
  final ScrollController controller = ScrollController();
  static const String _profilePicture =
      'assets/images/home_page/profile_picture.png';

  static const int developmentStartPageIndex = 4;

  @override
  Widget build(BuildContext context) {
    final control = Provider.of<ControlModel>(context);
    control.windowHeight = MediaQuery.of(context).size.height;
    control.windowWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            Strings.applicationName,
            style: control.mobileScreenSize
                ? Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white)
                : Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.white),
          ),
          actions: control.mobileScreenSize
              ? []
              : [
                  for (int i = 0; i < _pageList.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextButton(
                        onPressed: () {
                          control.buttonCarouselController.animateToPage(i);
                        },
                        child: Text(
                          _pageList[i].title,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),
                ],
        ),
        drawer: control.mobileScreenSize
            ? Drawer(
                child: Container(
                  height: control.windowHeight,
                  color: Colors.black45,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: const CircleAvatar(
                              backgroundImage: AssetImage(_profilePicture),
                            ),
                          ),
                        ),
                      ),
                      for (int i = 0; i < _pageList.length; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              control.buttonCarouselController.animateToPage(i);
                            },
                            child: ListTile(
                              leading: Icon(
                                _pageList[i].icon,
                                color: Colors.white,
                              ),
                              title: Text(
                                _pageList[i].title,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              )
            : null,
        body: CarouselSlider(
          items: [
            for (int iterator = 0; iterator < _pageList.length; iterator++)
              Container(
                  alignment: Alignment.center, child: _pageList[iterator].page),
          ],
          carouselController: control.buttonCarouselController,
          options: CarouselOptions(
              initialPage:
                  foundation.kReleaseMode ? 0 : developmentStartPageIndex,
              viewportFraction: 1,
              aspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height - 55),
              autoPlay: false,
              enableInfiniteScroll: false,
              scrollDirection: Axis.vertical),
        ),
      ),
    );
  }
}
