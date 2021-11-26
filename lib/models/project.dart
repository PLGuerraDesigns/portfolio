class Project {
  String title;
  String description;
  String date;
  int photoCount;
  int videoCount;
  bool demoVideo;
  List<String> tags;
  late String directory;
  late String photosPath;
  late String thumbnailPath;
  List<String> imagePathList = [];
  List<String> photoCaptionList = [];
  List<String> videoPathList = [];
  List<dynamic> moreInfo = [];

  Project(
      this.title,
      this.description,
      this.date,
      this.photoCount,
      this.videoCount,
      this.demoVideo,
      this.photoCaptionList,
      this.moreInfo,
      this.tags) {
    directory = title.toLowerCase().replaceAll(' ', '_');
    photosPath = 'assets/images/projects/$directory';
    thumbnailPath = '$photosPath/thumbnail.png';
    for (int iterator = 1; iterator < photoCount + 1; iterator++) {
      imagePathList.add('$photosPath/image_$iterator.png');
    }
    for (int iterator = 1; iterator < videoCount + 1; iterator++) {
      videoPathList.add('$photosPath/video_$iterator.mp4');
    }
  }

  factory Project.fromJson(Map<String, dynamic> json) {
    List<String> photoCaptionList = [];
    for (var photoCaptions in json['photoCaptions']) {
      photoCaptionList.add(photoCaptions);
    }
    bool demoVideo = false;
    if (json['demoVideo'] && json['videoCount'] > 0) {
      demoVideo = true;
    }

    return Project(
      json['title'],
      json['description'],
      json['date'],
      json['photoCount'],
      json['videoCount'],
      demoVideo,
      photoCaptionList,
      json['moreInfo'],
      json['tags'],
    );
  }
}
