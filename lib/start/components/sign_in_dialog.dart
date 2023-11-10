import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/components/mc_bounceable_button.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/components/mc_text_field.dart';
import 'package:money_cycle/start/components/alert_dialog.dart';
import 'package:money_cycle/start/components/find_password_dialog.dart';
import 'package:money_cycle/start/components/sign_up_dialog.dart';

import '../../components/mc_button.dart';
import '../../constants.dart';

class SignInDialog extends StatefulWidget {
  const SignInDialog({super.key});

  @override
  State<SignInDialog> createState() => _SignInDialogState();
}

class _SignInDialogState extends State<SignInDialog> {
  bool isLoading = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void showSignInAlert(String message) {
    final dialog = MCAlertDialog(
        title: "이메일 로그인",
        message: message,
        primaryAction: () => Get.back(),
        primaryActionTitle: "다시 로그인하기");

    Get.back();
    showDialog(
      context: context,
      builder: (context) => dialog,
    );
  }

  bool isValidEmail(String email) {
    RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return regex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    String pattern = r'^(?=.*[0-9])(?=.*[!@#\$%^&*])(?=.*[a-zA-Z]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(password);
  }

  Future<void> signInWithFirebase({required String email, password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Get.back();
      Get.back();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        showSignInAlert('아이디 또는 비밀번호가 틀렸습니다.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MCContainer(
                    width: 400,
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          const SizedBox(height: 22),
                          Text("이메일 로그인", style: Constants.titleTextStyle),
                          const SizedBox(height: 16),
                          MCTextField(
                            controller: emailController,
                            hintText: "이메일",
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 8),
                          MCTextField(
                            controller: passwordController,
                            hintText: "비밀번호",
                            textInputAction: TextInputAction.done,
                            obscureText: true,
                          ),
                          const SizedBox(height: 12),
                          MCButton(
                            isLoading: isLoading,
                            width: 184,
                            height: 44,
                            title: "로그인",
                            backgroundColor: Constants.blueNeon,
                            onPressed: () async {
                              setState(() => isLoading = true);
                              if (isValidEmail(emailController.text)) {
                                if (isValidPassword(passwordController.text)) {
                                  await signInWithFirebase(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                } else {
                                  showSignInAlert(
                                      '올바른 비밀번호 형식이 아닙니다.\n8~20자리 영문자, 숫자, 특수문자\n조합을 입력해주세요.');
                                }
                              } else {
                                showSignInAlert("잘못된 로그인 형식입니다.");
                              }
                              setState(() => isLoading = false);
                            },
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MCBounceableButton(
                                height: 44,
                                title: "비밀번호를 잊어버리셧나요?",
                                onPressed: () {
                                  Get.back();
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const FindPasswordDialog(),
                                  );
                                },
                              ),
                              Text(
                                '또는',
                                style: Constants.dialogSecondaryTextStyle
                                    .copyWith(decoration: null),
                              ),
                              MCBounceableButton(
                                height: 44,
                                title: "회원가입하기?",
                                onPressed: () {
                                  Get.back();
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => const SignUpDailog(),
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Bounceable(
                  scaleFactor: 0.8,
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(
                    'assets/icons/x_button.png',
                    width: 46.0,
                    height: 46.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
