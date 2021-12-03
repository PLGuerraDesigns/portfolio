import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:plg_portfolio/constants/globals.dart';
import 'package:plg_portfolio/constants/professional_experience_list.dart';
import 'package:plg_portfolio/constants/project_list.dart';
import 'package:plg_portfolio/constants/strings.dart';
import 'package:plg_portfolio/models/professional_experience.dart';
import 'package:plg_portfolio/models/project.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:ui' as ui;

class ControlModel extends ChangeNotifier {
  bool mobileScreenSize = true;
  late double windowHeight;
  late double windowWidth;
  List<Project> projectList = [];
  List<ProfessionalExperience> professionalExperienceList = [];
  CarouselController buttonCarouselController = CarouselController();

  ControlModel(BuildContext context) {
    _determineScreenType();
    html.window.addEventListener('resize', (event) {
      _determineScreenType();
    });
    for (var eachJsonProject in projectMapList) {
      Project project = Project.fromJson(eachJsonProject);
      projectList.add(project);
    }
    for (var eachJsonProfessionalExp in professionalExperienceMapList) {
      ProfessionalExperience professionalExperience =
          ProfessionalExperience.fromJson(eachJsonProfessionalExp);
      professionalExperienceList.add(professionalExperience);
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
    } else if (height < width) {
      mobileScreenSize = false;
    } else {
      mobileScreenSize = true;
    }
    notifyListeners();
  }

  unavailableSnackBar() {
    snackbarKey.currentState?.showSnackBar(SnackBar(
      behavior: SnackBarBehavior.fixed,
      backgroundColor: Colors.orange.withOpacity(0.7),
      duration: const Duration(milliseconds: 750),
      content: const Text(
        Strings.unavailable,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    ));
    notifyListeners();
  }

  scrollSnackBar() {
    snackbarKey.currentState?.showSnackBar(SnackBar(
      behavior: SnackBarBehavior.fixed,
      backgroundColor: Colors.white.withOpacity(0.5),
      duration: const Duration(milliseconds: 2000),
      content: const Text(
        Strings.scrollOrUseMenu,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
    ));
    notifyListeners();
  }

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return '${packageInfo.version} ${packageInfo.buildNumber}';
  }
}
