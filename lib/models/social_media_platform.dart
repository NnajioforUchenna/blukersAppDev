class SocialMediaPlatform {
  final String platformName;
  final String link;

  SocialMediaPlatform({
    required this.platformName,
    required this.link,
  });

  // Convert the object into a map
  Map<String, dynamic> toMap() {
    return {
      'platformName': platformName,
      'link': link,
    };
  }

  // Create an object from a map
  static SocialMediaPlatform fromMap(Map<String, dynamic> map) {
    return SocialMediaPlatform(
      platformName: map['platformName'],
      link: map['link'],
    );
  }

  @override
  String toString() {
    return 'SocialMediaPlatform: { platformName: $platformName, link: $link }';
  }
}
