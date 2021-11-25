import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:ui' as ui;

void main() {
  runApp(MyApp());
}

final List<InlinePage> _pageList = [
  InlinePage(Strings.home, const HomePage(), Icons.home),
  InlinePage(Strings.about, const AboutPage(), Icons.emoji_people),
  InlinePage(Strings.professional, ProfessionalPage(), Icons.engineering),
  InlinePage(Strings.projects, ProjectsPage(), Icons.construction),
  InlinePage(Strings.contact, const ContactPage(), Icons.contacts),
  InlinePage(Strings.resume, const ResumePage(), Icons.description),
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ControlModel(context),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Strings.applicationName,
          theme: AppTheme.darkTheme,
          home: const PortfolioMainPage()),
    );
  }
}

class PortfolioMainPage extends StatefulWidget {
  const PortfolioMainPage() : super();

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
  CarouselController buttonCarouselController = CarouselController();
  static const String _profilePicture = 'images/home_page/profile_picture.png';

  @override
  Widget build(BuildContext context) {
    final control = Provider.of<ControlModel>(context);
    control.windowHeight = MediaQuery.of(context).size.height;
    control.windowWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          Strings.applicationName,
          style: Theme.of(context)
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
                        buttonCarouselController.animateToPage(i);
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
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            buttonCarouselController.animateToPage(i);
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
        carouselController: buttonCarouselController,
        options: CarouselOptions(
            initialPage: 0,
            viewportFraction: 1,
            aspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height - 55),
            autoPlay: false,
            enableInfiniteScroll: false,
            scrollDirection: Axis.vertical),
      ),
    );
  }
}
