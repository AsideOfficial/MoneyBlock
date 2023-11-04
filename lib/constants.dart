import 'package:flutter/material.dart';

class Constants {
  static String appName = 'Money Cycle';

  //MARK: - Color
  static Color greenNeon = const Color(0xFF00D4A1);
  static Color blueNeon = const Color(0xFF34B5FF);

  // Theme
  static ThemeData theme = ThemeData(
    fontFamily: 'ONE Mobile POP OTF',
    scaffoldBackgroundColor: Colors.white,
  );

  static LinearGradient mainGradient = const LinearGradient(
    begin: Alignment(0.00, 1.00),
    end: Alignment(0, -1),
    colors: [Color(0xFF6322EE), Color(0xFF8572FF)],
  );

  static LinearGradient subGradient = const LinearGradient(
    begin: Alignment(0.00, -1.00),
    end: Alignment(0, 1),
    colors: [Color(0xFFE9E8EC), Color(0xFFD4D9E2)],
  );

  // Text Styles
  static var defaultTextStyle = const TextStyle(
    color: Colors.white,
    fontFamily: 'ONE Mobile POP OTF',
  );
}
