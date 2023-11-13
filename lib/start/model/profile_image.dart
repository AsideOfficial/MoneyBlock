class ProfileImage {
  final int index;
  final String profileUrl;

  ProfileImage({
    required this.index,
    required this.profileUrl,
  });

  static List<String> profileImages = [
    'assets/images/profile_cow.png',
    'assets/images/profile_bear.png',
    'assets/images/profile_pig.png',
    'assets/images/profile_tiger.png'
  ];
}
