import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class KakaoLoginService {
  static void loginWithKakaoTalk() async {
    try {
      await kakao.UserApi.instance.loginWithKakaoTalk();
      debugPrint('카카오톡으로 로그인 성공');
    } catch (error) {
      debugPrint('카카오톡으로 로그인 실패 $error');

      // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
      // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }
      // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
      loginWithKakaoAccount();
    }
  }

  static void loginWithKakaoAccount() async {
    try {
      await kakao.UserApi.instance.loginWithKakaoAccount();
      debugPrint('카카오계정으로 로그인 성공');
    } catch (error) {
      debugPrint('카카오계정으로 로그인 실패 $error');
    }
  }

  // 카카오 로그인
  static Function() kakaoLogin() {
    return () async {
      // 카카오톡 설치 여부 확인
      // 카카오톡이 설치되어 있으면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
      if (await kakao.isKakaoTalkInstalled()) {
        loginWithKakaoTalk();
        try {
          kakao.User user = await kakao.UserApi.instance.me();
          debugPrint('사용자 정보 요청 성공'
              '\n회원번호: ${user.id}'
              '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
              '\n이메일: ${user.kakaoAccount?.email}');
        } catch (error) {
          debugPrint('사용자 정보 요청 실패 $error');
        }
      } else {
        loginWithKakaoAccount();
      }
    };
  }
}

class AppleLoginService {
  static Future<void> loginApp() async {
    final AuthorizationCredentialAppleID appleCredential =
        await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final OAuthCredential credential = OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
