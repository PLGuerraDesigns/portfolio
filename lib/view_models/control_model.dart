import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plg_portfolio/constants/project_list.dart';
import 'package:plg_portfolio/models/project.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:ui' as ui;

class ControlModel extends ChangeNotifier {
  bool mobileScreenSize = true;
  late double windowHeight;
  late double windowWidth;
  List<Project> projectList = [];

  ControlModel(BuildContext context) {
    _determineScreenType();
    html.window.addEventListener('resize', (event) {
      _determineScreenType();
    });
    for (var eachJsonProject in projectMapList) {
      Project project = Project.fromJson(eachJsonProject);
      projectList.add(project);
    }
  }

  void launchURL(url) async {
    try {
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void _determineScreenType() {
    double devicePixelRatio = ui.window.devicePixelRatio;
    ui.Size size = ui.window.physicalSize;
    double width = size.width;
    double height = size.height;

    if (devicePixelRatio < 2 && (width >= 1000 || height >= 1000)) {
      mobileScreenSize = false;
    } else if (devicePixelRatio == 2 && (width >= 1920 || height >= 1920)) {
      mobileScreenSize = false;
    } else {
      mobileScreenSize = true;
    }
    notifyListeners();
  }

  // Future<String> getAppVersion() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   return 'V${packageInfo.version} (${packageInfo.buildNumber})';
  // }
}
