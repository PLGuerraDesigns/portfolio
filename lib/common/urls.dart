import 'strings.dart';

/// A class that contains all the urls used in the app.
class Urls {
  Urls._();

  static const String flutter = 'https://flutter.dev/';

  static const String portfolioBase =
      'https://plguerradesigns.github.io/portfolio/#';
  static const String projectSourceCode =
      'https://github.com/PLGuerraDesigns/portfolio';
  static const String projectReadme =
      'https://github.com/PLGuerraDesigns/portfolio/blob/master/README.md';
  static const String projectIssues =
      'https://github.com/PLGuerraDesigns/portfolio/issues';
  static const String projectChangelog =
      'https://github.com/PLGuerraDesigns/portfolio/blob/master/CHANGELOG.md';

  static const String github = 'https://github.com/PLGuerraDesigns';
  static const String thingiverse =
      'https://www.thingiverse.com/plg_designs/designs';
  static const String linkedin = 'https://www.linkedin.com/in/plguerra/';
  static const String youtube = 'https://www.youtube.com/@plguerra';
  static const String openEmail = 'mailto:${Strings.contactEmail}';

  static const String googleSearchBase = 'https://www.google.com/search?q=';

  static String youTubeThumbnail(String videoId) =>
      'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
}
