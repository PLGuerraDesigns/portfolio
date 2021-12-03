class ProfessionalExperience {
  String title;
  String subtitle;
  String date;
  String description;
  String floatingImagePath;
  String backgroundImagePath;
  List<String> videoList = [];
  List<dynamic> moreInfo = [];

  ProfessionalExperience(
      this.title,
      this.subtitle,
      this.date,
      this.description,
      this.floatingImagePath,
      this.backgroundImagePath,
      this.videoList,
      this.moreInfo);

  factory ProfessionalExperience.fromJson(Map<String, dynamic> json) {
    return ProfessionalExperience(
      json['title'],
      json['subtitle'],
      json['date'],
      json['description'],
      json['floatingImagePath'],
      json['backgroundImagePath'],
      json['videoList'],
      json['moreInfo'],
    );
  }
}
