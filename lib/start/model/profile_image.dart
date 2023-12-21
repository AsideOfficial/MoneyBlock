import 'dart:ui';

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

  static List<Color> titleColors = [
    const Color(0xFFEA5C67),
    const Color(0xFF6969E8),
    const Color(0xFFF7C800),
    const Color(0xFF68C444),
  ];
  static List<Color> cardColors = [
    const Color(0xFFFFA2A9),
    const Color(0xFFB3B3FF),
    const Color(0xFFFFEB98),
    const Color(0xFFB5F79B),
  ];
  static List<String> characters = [
    'assets/images/character_cow.png',
    'assets/images/character_bear.png',
    'assets/images/character_pig.png',
    'assets/images/character_tiger.png'
  ];
}
