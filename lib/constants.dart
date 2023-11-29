import 'package:flutter/material.dart';

class Constants {
  static String appName = 'Money Cycle';

  //MARK: - Color
  static Color black = const Color(0xFF303030);
  static Color grey100 = const Color(0xFF8C8C8C);
  static Color grey03 = const Color(0xFF8C8C8C);
  static Color dark100 = const Color(0xFF6A6A6A);

  static Color greenNeon = const Color(0xFF00D4A1);
  static Color blueNeon = const Color(0xFF34B5FF);

  static const Color accentRed = Color(0xFFE32222);
  static Color accentBlue = const Color(0xFF272EDB);

  // 카드 배경 (7가지 액션)
  static Color cardGreen = const Color(0xFF70C14A);
  static Color cardRed = const Color(0xFFF2515D);
  static Color cardBlue = const Color(0xFF507EEB);
  static Color cardOrange = const Color(0xFFF68F17);
  static Color cardYellow = const Color(0xFFFFD31F);
  static Color cardGreenBlue = const Color(0xFF00AA96);
  static Color cardPink = const Color(0xFFF65CA9);

  static Color background = const Color(0xFFEBE8FE);

  // Theme
  static ThemeData theme = ThemeData(
    fontFamily: 'ONE Mobile POP OTF',
    scaffoldBackgroundColor: Colors.white,
  );

  //MARK :- Gradient
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

  static const LinearGradient redGradient = LinearGradient(
    begin: Alignment(0, 1),
    end: Alignment(0.00, -1.00),
    colors: [Color(0xFFD40817), Color(0xFFF3515D)],
  );

  static const LinearGradient orangeGradient = LinearGradient(
    begin: Alignment(0.00, 1.00),
    end: Alignment(0, -1),
    colors: [Color(0xFFFF9950), Color(0xFFFA5A00)],
  );

  static const LinearGradient yellowGradient = LinearGradient(
    begin: Alignment(0.00, -1.00),
    end: Alignment(0, 1),
    colors: [Color(0xFFFA9B0C), Color(0xFFFFD31F)],
  );

  static const LinearGradient greenGradient = LinearGradient(
    begin: Alignment(0, 1),
    end: Alignment(0.00, -1.00),
    colors: [Color(0xFF37AB00), Color(0xFF87D861)],
  );

  static const LinearGradient greenBlueGradient = LinearGradient(
    begin: Alignment(0.00, -1.00),
    end: Alignment(0, 1),
    colors: [Color(0xFF6AD6C9), Color(0xFF009B88)],
  );

  static const LinearGradient blueGradient = LinearGradient(
    begin: Alignment(0, 1),
    end: Alignment(0.00, -1.00),
    colors: [Color(0xFF1E4CBB), Color(0xFF507EEB)],
  );

  static const LinearGradient purpleGradient = LinearGradient(
    begin: Alignment(0.00, 1.00),
    end: Alignment(0, -1),
    colors: [Color(0xFF6322EE), Color(0xFF8572FF)],
  );

  static const LinearGradient assetSheetGradient = LinearGradient(
    begin: Alignment(0.00, 1.00),
    end: Alignment(0, -1),
    colors: [Color(0xFFBEAEFF), Color(0xFFD3C8FE)],
  );

  static const LinearGradient greyGradient = LinearGradient(
    begin: Alignment(0, 1),
    end: Alignment(0.00, -1.00),
    colors: [Color(0xFFE9E8EC), Color(0xFFD4D9E2)],
  );

  static const LinearGradient grey00Gradient = LinearGradient(
    begin: Alignment(0, 1),
    end: Alignment(0.00, -1.00),
    colors: [Color(0xFFF2F2F2), Color(0xFFE2E2E2)],
  );

  static const LinearGradient grey00BottomGradient = LinearGradient(
    begin: Alignment(0.00, -1.00),
    end: Alignment(0, 1),
    colors: [Color(0xFFF2F2F2), Color(0xFFE2E2E2)],
  );

  static const LinearGradient grey01Gradient = LinearGradient(
    begin: Alignment(0.00, -1.00),
    end: Alignment(0, 1),
    colors: [Color(0xFFEAE8EC), Color(0xFFD4DAE2)],
  );

  static const LinearGradient grey02Gradient = LinearGradient(
    begin: Alignment(0, 1),
    end: Alignment(0.00, -1.00),
    colors: [Color(0xFFF2F2F2), Color(0xFFE2E2E2)],
  );

  static const LinearGradient purpleGreyGradient = LinearGradient(
    begin: Alignment(0.00, -1.00),
    end: Alignment(0, 1),
    colors: [Color(0xFF9298CA), Color(0xFFBEC2E0)],
  );

  //MARK: - Shadow

  static BoxShadow defaultShadow = const BoxShadow(
    color: Color(0x3F000000),
    blurRadius: 4,
    offset: Offset(0, 4),
  );

  static const BoxShadow buttonShadow = BoxShadow(
    color: Color(0x26000000),
    blurRadius: 4,
    offset: Offset(0, 2),
    spreadRadius: 0,
  );

  // MARK: - Text Styles
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
