import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:money_cycle/utils/firebase_auth_remote_data_source.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class KakaoLoginService {
  static final firebaseAuthDataSource = FirebaseAuthRemoteDataSource();

  static Future<void> loginWithKakaoTalk() async {
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

  static Future<void> loginWithKakaoAccount() async {
    try {
      kakao.UserApi.instance.loginWithKakaoAccount();
      debugPrint('카카오계정으로 로그인 성공');
    } catch (error) {
      debugPrint('카카오계정으로 로그인 실패 $error');
    }
  }

  static Future<void> loginWithScopes(List<String> scopes) async {
    if (scopes.isNotEmpty) {
      kakao.OAuthToken token;

      try {
        token = await kakao.UserApi.instance.loginWithNewScopes(scopes);
        debugPrint('현재 사용자가 동의한 동의항목: ${token.scopes}');
      } catch (error) {
        debugPrint('추가 동의 요청 실패 $error');
        return;
      }
    }
  }

  // 카카오 로그인
  static Future<void> kakaoLogin() async {
    // 카카오톡 설치 여부 확인
    // 카카오톡이 설치되어 있으면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (await kakao.isKakaoTalkInstalled()) {
      await loginWithKakaoTalk();
    } else {
      await loginWithKakaoAccount();
    }

    kakao.User user = await kakao.UserApi.instance.me();

    final customToken = await firebaseAuthDataSource.createCustomToken({
      'uid': user.id.toString(),
      'displayName': user.kakaoAccount?.profile?.nickname ?? '',
      'email': user.kakaoAccount?.email,
    });

    final userID =
        await FirebaseAuth.instance.signInWithCustomToken(customToken);
    debugPrint('Login Succeed: $userID');
  }
}

class GoogleLoginService {
  static Future<void> loginWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        GoogleSignInAuthentication authentication =
            await account.authentication;
        OAuthCredential googleCredential = GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken,
        );

        final userID =
            await FirebaseAuth.instance.signInWithCredential(googleCredential);
        debugPrint('Login Succeed: $userID');
      }
    } catch (e) {
      debugPrint('google login error: $e');
    }
  }
}

class AppleLoginService {
  static Future<void> loginWithApple() async {
    try {
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

      final userID =
          await FirebaseAuth.instance.signInWithCredential(credential);
      debugPrint('Login Succeed: $userID');
    } catch (e) {
      debugPrint('apple login error: $e');
    }
  }
}
