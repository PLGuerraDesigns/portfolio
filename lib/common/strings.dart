import 'package:flutter/material.dart';

class Strings {
  Strings._();

  static const String currentLocation = 'VA, USA';
  static const String lastUpdated = 'Updated JAN 2024';

  // Routes
  static const String loadingRoute = '/loading';
  static const String homeRoute = '/home';
  static const String professionalSubRoute = 'professional';
  static const String personalSubRoute = 'personal';
  static const String detailsSubRoute = 'details';

  // URLs
  static const String flutterUrl = 'https://flutter.dev/';
  static const String githubUrl = 'https://github.com/PLGuerraDesigns';
  static const String thingiverseUrl =
      'https://www.thingiverse.com/plg_designs/designs';
  static const String linkedinUrl = 'https://www.linkedin.com/in/plguerra/';
  static const String gmuUrl =
      'https://catalog.gmu.edu/colleges-schools/engineering-computing/school-computing/computer-science/software-engineering-ms/';
  static const String aicUrl = 'https://aicbelize.com/AIC-Mobile-App';
  static const String ambotsUrl = 'https://www.ambots.net/';
  static const String am3LabUrl = 'https://wordpressua.uark.edu/am3/';
  static const String uarkUrl =
      'https://catalog.uark.edu/plangrids/computerscience_bs/';
  static const String sponsorUrl = 'https://www.buymeacoffee.com/plguerra';
  static const String contactEmailUrl = 'mailto:plguerra@outlook.com';
  static const String sourceCodeUrl =
      'https://github.com/PLGuerraDesigns/portfolio';
  static const String flutterResumeBuilderUrl =
      'https://plguerradesigns.github.io/flutter_resume_builder/';

  // Assets
  static const String projectsJsonPath = 'assets/json/projects.json';
  static const String professionalExperienceJsonPath =
      'assets/json/professional_experience.json';
  static const String socialAssetsBasePath = 'assets/images/icons';
  static const String resumeBuilderIconPath =
      '$socialAssetsBasePath/resume_builder.png';
  static String profilePhotoPath(Brightness brightness) =>
      'assets/images/home/profile_${brightness == Brightness.dark ? 'dark' : 'light'}.jpg';
  static const String professionalExperiencePhotoPath =
      'assets/images/home/professional.png';
  static const String personalExperiencePhotoPath =
      'assets/images/home/personal.png';
  static const String gmuLogoPath = 'assets/images/home/gmu_logo.png';
  static const String aicLogoPath =
      'assets/images/professional/atlantic_insurance/logo.png';
  static const String ambotsLogoPath =
      'assets/images/professional/ambots/logo.png';
  static const String uarkLogoPath = 'assets/images/home/uark_logo.png';

  // General
  static const String github = 'GitHub';
  static const String thingiverse = 'Thingiverse';
  static const String linkedin = 'LinkedIn';
  static const String appName = 'PLG Portfolio';
  static const String name = 'Pablo L. Guerra';
  static const String subtitle =
      'Software Engineer  •  Innovator  •  Technologist';
  static const String poweredByFlutter = 'Powered by Flutter';
  static const String professional = 'Professional';
  static const String personal = 'Personal';
  static const String projects = 'Projects';
  static const String or = 'or';
  static const String toggleBrightness = 'Toggle the Brightness';
  static const String youTubeVideos = 'YouTube Videos';
  static const String videos = 'Videos';
  static const String images = 'Images';
  static const String previous = 'Previous';
  static const String prev = 'Prev.';
  static const String next = 'Next';
  static const String viewAllMedia = 'View all Media';
  static const String viewSourceCode = 'View the Source Code';
  static const String professionalExperiences = 'Professional Experiences';
  static const String previousProject = 'Previous Project';
  static const String nextProject = 'Next Project';
  static const String personalProjects = 'Personal Projects';
  static const String contactMe = 'Contact Me';
  static const String sponsor = 'Sponsor';
  static const String moreInfo = 'More Info';
  static const String present = 'Present';
  static const String tags = 'Tags';
  static const String resumeBuilder = 'Resume Builder';
  static const String uhOh = 'Uh oh!';
  static const String looksLikeSomethingWentWrong =
      'Looks like something went wrong.';
  static const String goToTheHomePage = 'Go to the Home Page';
}