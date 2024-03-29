import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/components/mc_bounceable_button.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/components/mc_text_field.dart';
import 'package:money_cycle/start/components/alert_dialog.dart';
import 'package:money_cycle/start/components/sign_in_dialog.dart';
import 'package:money_cycle/start/components/sign_up_dialog.dart';

import '../../components/mc_button.dart';
import '../../constants.dart';

class FindPasswordDialog extends StatefulWidget {
  const FindPasswordDialog({super.key});

  @override
  State<FindPasswordDialog> createState() => _FindPasswordDialogState();
}

class _FindPasswordDialogState extends State<FindPasswordDialog> {
  bool isLoading = false;

  final emailController = TextEditingController();

  Future<void> sendChangePasswordEmail({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  void showSignInAlert({required String message}) {
    final dialog = MCAlertDialog(
      title: "비밀번호 찾기",
      message: message,
      primaryActionTitle: "확인",
      primaryAction: () => Get.back(),
      secondaryActionTitle: "회원가입하러 가기",
      secondaryAction: () {
        Get.back();
        Get.back();
        Get.dialog(const SignUpDailog(), name: "SignUpDailog");
      },
    );

    // Get.back();
    Get.dialog(dialog, name: "SignUpDailog");
  }

  void showMessageSendAlert(
      {required String message, String? secondaryMessage}) {
    final dialog = MCAlertDialog(
      title: "비밀번호 찾기",
      message: message,
      secondaryMessage: secondaryMessage,
      primaryActionTitle: "확인",
      primaryAction: () {
        Get.back();
        Get.back();
      },
      secondaryActionTitle: "로그인하러 가기",
      secondaryAction: () {
        Get.back();
        Get.back();
        Get.dialog(const SignInDialog(), name: "SignInDialog");
      },
    );

    // Get.back();
    Get.dialog(dialog, name: "SignUpDailog");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MCContainer(
                    width: 400,
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 22),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("비밀번호 찾기", style: Constants.titleTextStyle),
                          const Text(
                            "가입했던 이메일을 입력해주세요.\n비밀번호 재설정 메일을 보내드립니다.",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          MCTextField(
                            controller: emailController,
                            hintText: "이메일",
                            textInputAction: TextInputAction.next,
                          ),
                          MCButton(
                            isLoading: isLoading,
                            width: 184,
                            height: 44,
                            title: "재설정 메일 보내기",
                            backgroundColor: Constants.blueNeon,
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                await sendChangePasswordEmail(
                                    email: emailController.text);

                                showMessageSendAlert(
                                  message: emailController.text,
                                  secondaryMessage: "비밀번호 재설정 메일이 발송되었습니다.",
                                );
                              } catch (e) {
                                debugPrint('$e');
                              }
                              setState(() {
                                isLoading = false;
                              });
                            },
                          ),
                          MCBounceableButton(
                            padding: EdgeInsets.zero,
                            title: "로그인하러 가기",
                            titleColor: Colors.white,
                            onPressed: () {
                              Get.back();
                              showDialog(
                                context: context,
                                builder: (context) => const SignInDialog(),
                              );
                            },
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
