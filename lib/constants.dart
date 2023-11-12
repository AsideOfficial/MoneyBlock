import 'package:flutter/material.dart';

class Constants {
  static String appName = 'Money Cycle';

  //MARK: - Color
  static Color grey100 = const Color(0xFF8C8C8C);
  static Color dark100 = const Color(0xFF303030);

  static Color greenNeon = const Color(0xFF00D4A1);
  static Color blueNeon = const Color(0xFF34B5FF);

  // 카드 배경 (7가지 액션)
  static Color cardGreen = const Color(0xFF70C14A);
  static Color cardRed = const Color(0xFFF2515D);
  static Color cardBlue = const Color(0xFF507EEB);
  static Color cardOrange = const Color(0xFFF68F17);
  static Color cardYellow = const Color(0xFFFFD31F);
  static Color cardGreenBlue = const Color(0xFF00AA96);
  static Color cardPink = const Color(0xFFF65CA9);

  // Theme
  static ThemeData theme = ThemeData(
    fontFamily: 'ONE Mobile POP OTF',
    scaffoldBackgroundColor: Colors.white,
  );

  static const LinearGradient mainGradient = LinearGradient(
    begin: Alignment(0.00, 1.00),
    end: Alignment(0, -1),
    colors: [Color(0xFF6322EE), Color(0xFF8572FF)],
  );

  static const LinearGradient subGradient = LinearGradient(
    begin: Alignment(0.00, -1.00),
    end: Alignment(0, 1),
    colors: [Color(0xFFE9E8EC), Color(0xFFD4D9E2)],
  );

  static const LinearGradient blueGradient = LinearGradient(
    begin: Alignment(0, 1),
    end: Alignment(0.00, -1.00),
    colors: [Color(0xFF1E4CBB), Color(0xFF507EEB)],
  );
  static const LinearGradient redGradient = LinearGradient(
    begin: Alignment(0, 1),
    end: Alignment(0.00, -1.00),
    colors: [Color(0xFFD40817), Color(0xFFF3515D)],
  );
  static const LinearGradient greenGradient = LinearGradient(
    begin: Alignment(0, 1),
    end: Alignment(0.00, -1.00),
    colors: [Color(0xFF37AB00), Color(0xFF87D861)],
  );

  static BoxShadow defaultShadow = const BoxShadow(
    color: Color(0x3F000000),
    blurRadius: 4,
    offset: Offset(0, 4),
  );

  // Text Styles
  static var defaultTextStyle = const TextStyle(
    color: Colors.white,
    fontFamily: 'ONE Mobile POP OTF',
  );

  static var titleTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontFamily: 'ONE Mobile POP OTF',
    fontWeight: FontWeight.w400,
  );

  static var largeTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'ONE Mobile POP OTF',
    fontWeight: FontWeight.w400,
  );

  static var dialogSecondaryTextStyle = const TextStyle(
    color: Color(0xFF52B6FF),
    fontSize: 12,
    fontFamily: 'Noto Sans KR',
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.underline,
    height: 0,
  );
}
