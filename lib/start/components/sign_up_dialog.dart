import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/components/mc_bounceable_button.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/components/mc_text_field.dart';

import '../../components/mc_button.dart';
import '../../constants.dart';

class SignUpDailog extends StatefulWidget {
  const SignUpDailog({super.key});

  @override
  State<SignUpDailog> createState() => _SignUpDailogState();
}

enum SignUpState { email, password, complete }

class _SignUpDailogState extends State<SignUpDailog> {
  SignUpState signUpState = SignUpState.email;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        content: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MCContainer(
                width: 400,
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: signUpPageAtIndex(),
                ),
              ),
            ),
            Row(
              children: [
                if (signUpState.index >= 1)
                  Column(
                    children: [
                      Bounceable(
                        scaleFactor: 0.8,
                        onTap: () {
                          switch (signUpState) {
                            case SignUpState.email:
                            case SignUpState.password:
                              signUpState = SignUpState.email;
                            case SignUpState.complete:
                              signUpState = SignUpState.password;
                          }
                          setState(() {});
                        },
                        child: Image.asset(
                          'assets/icons/back_button.png',
                          width: 46.0,
                          height: 46.0,
                        ),
                      ),
                      const Spacer()
                    ],
                  ),
                const Spacer(),
                Column(
                  children: [
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
                    const Spacer()
                  ],
                )
              ],
            ),
          ],
        ));
  }

  Widget signUpPageAtIndex() {
    switch (signUpState) {
      case SignUpState.email:
        return EmailNickNameInput(
          signUpState: signUpState,
          onPressed: () {
            setState(() {
              signUpState = SignUpState.password;
            });
          },
        );
      case SignUpState.password:
        return PasswordInput(
          signUpState: signUpState,
          onPressed: () {
            //TODO - 회원가입 API 요청
            setState(() {
              signUpState = SignUpState.complete;
            });
          },
        );
      case SignUpState.complete:
        return CompletionPage(
          signUpState: signUpState,
          onPressed: () {
            Get.back();
          },
        );
      default:
        throw Error();
    }
  }
}

class EmailNickNameInput extends StatelessWidget {
  final SignUpState signUpState;
  final Function()? onPressed;
  const EmailNickNameInput({
    super.key,
    required this.signUpState,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("회원가입", style: Constants.titleTextStyle),
          MCTextField(
            hintText: "이메일",
            textInputAction: TextInputAction.next,
          ),
          MCTextField(
            hintText: "닉네임",
            textInputAction: TextInputAction.done,
          ),
          MCBounceableButton(
              width: 184,
              height: 44,
              title: "다음",
              backgroundColor: Constants.blueNeon,
              onPressed: onPressed),
        ],
      ),
    );
  }
}

class PasswordInput extends StatefulWidget {
  final SignUpState signUpState;
  final Function() onPressed;

  const PasswordInput({
    super.key,
    required this.signUpState,
    required this.onPressed,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("회원가입", style: Constants.titleTextStyle),
          MCTextField(
            hintText: "비밀번호",
            textInputAction: TextInputAction.next,
          ),
          MCTextField(
            hintText: "비밀번호 확인",
            textInputAction: TextInputAction.done,
            obscureText: true,
          ),
          MCButton(
              isLoading: isLoading,
              width: 184,
              height: 44,
              title: "회원가입",
              backgroundColor: Constants.blueNeon,
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await widget.onPressed();
                setState(() {
                  isLoading = true;
                });
              }),
        ],
      ),
    );
  }
}

class CompletionPage extends StatelessWidget {
  final SignUpState signUpState;
  final Function()? onPressed;
  const CompletionPage({
    super.key,
    required this.signUpState,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("회원가입 완료", style: Constants.titleTextStyle),
          Text(
            "회원가입이 완료되었습니다.\n지금 바로 로그인하고 머니사이클을 즐겨보세요!",
            style: Constants.defaultTextStyle.copyWith(height: 1.5),
            textAlign: TextAlign.center,
          ),
          MCBounceableButton(
              width: 184,
              height: 44,
              title: "로그인하러 가기",
              backgroundColor: Constants.blueNeon,
              onPressed: onPressed),
        ],
      ),
    );
  }
}
