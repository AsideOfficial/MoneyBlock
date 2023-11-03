import 'package:flutter/material.dart';
import 'package:money_cycle/utils/sns_login_service.dart';

enum SNSPlatform { kakao, apple, google, email }

extension SNSPlatformExtension on SNSPlatform {
  // Background Color
  Color get color {
    switch (this) {
      case SNSPlatform.kakao:
        return const Color(0xFFFEE500);
      case SNSPlatform.apple:
        return Colors.white;
      case SNSPlatform.google:
        return Colors.white;
      case SNSPlatform.email:
        return const Color(0xFF41ADEB);
    }
  }

  // Logo
  Image get logo {
    switch (this) {
      case SNSPlatform.kakao:
        return Image.asset(
          'assets/logos/kakao_logo.png',
          width: 18.0,
          fit: BoxFit.fitWidth,
        );
      case SNSPlatform.apple:
        return Image.asset(
          'assets/logos/apple_logo.png',
          width: 18.0,
          fit: BoxFit.fitWidth,
        );
      case SNSPlatform.google:
        return Image.asset(
          'assets/logos/google_logo.png',
          width: 18.0,
          fit: BoxFit.fitWidth,
        );
      case SNSPlatform.email:
        return Image.asset(
          'assets/logos/email_logo.png',
          width: 18.0,
          fit: BoxFit.fitWidth,
        );
    }
  }

  // Label
  String get label {
    switch (this) {
      case SNSPlatform.kakao:
        return '카카오 로그인';
      case SNSPlatform.apple:
        return 'Apple로 로그인';
      case SNSPlatform.google:
        return '구글로 로그인';
      case SNSPlatform.email:
        return '이메일로 로그인';
    }
  }

  // Label Color
  Color get labelColor {
    switch (this) {
      case SNSPlatform.kakao:
        return Colors.black.withOpacity(0.8500000238418579);
      case SNSPlatform.apple:
        return Colors.black;
      case SNSPlatform.google:
        return Colors.black;
      case SNSPlatform.email:
        return Colors.white;
    }
  }

  // Action
  Function() get onTap {
    switch (this) {
      case SNSPlatform.kakao:
        return KakaoLoginService.kakaoLogin();
      case SNSPlatform.apple:
        return () {};
      case SNSPlatform.google:
        return () {};
      case SNSPlatform.email:
        return () {};
    }
  }
}
