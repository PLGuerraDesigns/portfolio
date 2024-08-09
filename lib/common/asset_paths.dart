/// The paths to the assets used in the app.
class AssetPaths {
  AssetPaths._();

  static const String projectsJsonData = 'assets/json/projects.json';
  static const String professionalExperienceJsonData =
      'assets/json/professional_experience.json';
  static const String educationJsonData = 'assets/json/education.json';

  static const String monogram = 'assets/images/icons/monogram.webp';
  static const String profilePhoto = 'assets/images/home/profile_dark.webp';
  static const String professionalExperiencePhoto =
      'assets/images/home/professional.webp';
  static const String personalExperiencePhoto =
      'assets/images/home/personal.webp';

  static String socialMediaIcon(String socialMedia) =>
      'assets/images/icons/$socialMedia.webp';
}
