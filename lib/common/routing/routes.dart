/// The routes of the application.
class Routes {
  Routes._();

  static const String home = '/home';
  static const String loading = '/loading';
  static const String professional = 'professional-experiences';
  static const String personal = 'personal-projects';
  static const String details = 'details';

  static const String professionalExperiences = '$home/$professional';
  static const String personalProjects = '$home/$personal';

  static String loadingRedirect({required String from, required String to}) =>
      '$home/$from/$details/$to';

  static String projectDetails({required String titleAsPath}) =>
      '$home/$personal/$details/$titleAsPath';

  static String professionalExpDetails({required String titleAsPath}) =>
      '$home/$professional/$details/$titleAsPath';
}
