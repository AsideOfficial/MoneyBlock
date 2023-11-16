import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
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
  final emailController = TextEditingController();
  final nickNameController = TextEditingController();
  final passwordController = TextEditingController();
  final verifyPasswordController = TextEditingController();

  void signUpWithFirebase({required String email, password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      debugPrint('sign up failed: $e');
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
                      child: signUpPageAtIndex(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 415,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (signUpState.index >= 1 &&
                          signUpState != SignUpState.complete)
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
                          ],
                        ),
                      const Spacer(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signUpPageAtIndex() {
    switch (signUpState) {
      case SignUpState.email:
        return EmailNickNameInput(
          emailController: emailController,
          nickNameController: nickNameController,
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
          passwordController: passwordController,
          verifyPasswordController: verifyPasswordController,
          onPressed: () {
            signUpWithFirebase(
              email: emailController.text,
              password: passwordController.text,
            );

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
            Get.back();
          },
        );
      default:
        throw Error();
    }
  }
}

class EmailNickNameInput extends StatefulWidget {
  final SignUpState signUpState;
  final Function()? onPressed;
  final TextEditingController emailController;
  final TextEditingController nickNameController;
  const EmailNickNameInput({
    super.key,
    required this.signUpState,
    this.onPressed,
    required this.emailController,
    required this.nickNameController,
  });

  @override
  State<EmailNickNameInput> createState() => _EmailNickNameInputState();
}

class _EmailNickNameInputState extends State<EmailNickNameInput> {
  bool isValid = false;
  bool isValidEmail = true;
  bool isValidNickName = true;
  final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+');

  void verifyApplyData() {
    setState(() {
      isValid = false;
    });

    // 이메일 점검
    if (!isValidEmail) return;
    if (!isValidNickName) return;
    if (widget.emailController.text.isEmpty ||
        widget.nickNameController.text.isEmpty) return;

    setState(() {
      isValid = true;
    });
  }

  @override
  void initState() {
    verifyApplyData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("회원가입", style: Constants.titleTextStyle),
          SizedBox(
            height: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MCTextField(
                  hintText: "이메일",
                  textInputAction: TextInputAction.next,
                  controller: widget.emailController,
                  onChanged: (p0) {
                    setState(() {
                      isValidEmail = false;
                      if (emailRegex.hasMatch(widget.emailController.text)) {
                        isValidEmail = true;
                      } else {
                        isValidEmail = false;
                      }
                    });
                    verifyApplyData();
                  },
                ),
                if (!isValidEmail)
                  const Padding(
                    padding: EdgeInsets.only(left: 24, top: 2),
                    child: Text(
                      "올바른 이메일 형식을 입력해주세요.",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(
            height: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MCTextField(
                  controller: widget.nickNameController,
                  hintText: "이름",
                  textInputAction: TextInputAction.done,
                  maxLength: 20,
                  onChanged: (p0) {
                    setState(() {
                      isValidNickName = false;
                      if (p0.length >= 3) {
                        isValidNickName = true;
                      }
                    });
                    verifyApplyData();
                  },
                ),
                if (!isValidNickName)
                  const Padding(
                    padding: EdgeInsets.only(left: 24, top: 2),
                    child: Text(
                      "3~20자 사이의 이름을 입력해주세요.",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
              ],
            ),
          ),
          MCButton(
            isLoading: false,
            width: 184,
            height: 44,
            title: "다음",
            backgroundColor: isValid ? Constants.blueNeon : Constants.grey100,
            onPressed: isValid ? widget.onPressed : null,
          ),
        ],
      ),
    );
  }
}

class PasswordInput extends StatefulWidget {
  final SignUpState signUpState;
  final Function() onPressed;
  final TextEditingController passwordController;
  final TextEditingController verifyPasswordController;

  const PasswordInput({
    super.key,
    required this.signUpState,
    required this.onPressed,
    required this.passwordController,
    required this.verifyPasswordController,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isLoading = false;
  bool isValid = false;
  bool isValidPassword = true;
  bool isSamePassword = true;
  RegExp regex = RegExp(r'(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$%^&*]).{8,}$');

  void verifyApplyData() {
    setState(() {
      isValid = false;
    });

    // 이메일 점검
    if (!isValidPassword) return;
    if (!isSamePassword) return;
    if (widget.passwordController.text.isEmpty ||
        widget.verifyPasswordController.text.isEmpty) return;

    setState(() {
      isValid = true;
    });
  }

  @override
  void initState() {
    verifyApplyData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("회원가입", style: Constants.titleTextStyle),
          SizedBox(
            height: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MCTextField(
                  obscureText: true,
                  hintText: "비밀번호",
                  textInputAction: TextInputAction.next,
                  controller: widget.passwordController,
                  onChanged: (p0) {
                    setState(() {
                      isValidPassword = false;
                      if (regex.hasMatch(p0)) {
                        isValidPassword = true;
                      } else {
                        isValidPassword = false;
                      }
                    });

                    verifyApplyData();
                  },
                ),
                if (!isValidPassword)
                  const Padding(
                    padding: EdgeInsets.only(left: 24, top: 2),
                    child: Text(
                      "8~20자리 영문자, 숫자, 특수문자로 조합. ",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(
            height: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MCTextField(
                  obscureText: true,
                  controller: widget.verifyPasswordController,
                  hintText: "비밀번호 확인",
                  textInputAction: TextInputAction.done,
                  maxLength: 20,
                  onChanged: (p0) {
                    setState(() {
                      isSamePassword = false;
                      if (p0 == widget.passwordController.text) {
                        isSamePassword = true;
                      }
                    });
                    verifyApplyData();
                  },
                ),
                if (!isSamePassword)
                  const Padding(
                    padding: EdgeInsets.only(left: 24, top: 2),
                    child: Text(
                      "비밀번호가 다릅니다.",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
              ],
            ),
          ),
          MCButton(
            isLoading: isLoading,
            width: 184,
            height: 44,
            title: "회원가입",
            backgroundColor: isValid ? Constants.blueNeon : Constants.grey100,
            onPressed: !isValid
                ? null
                : () async {
                    setState(() {
                      isLoading = true;
                    });
                    await widget.onPressed();
                    setState(() {
                      isLoading = true;
                    });
                  },
          ),
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
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("회원가입 완료", style: Constants.titleTextStyle),
          Text(
            "회원가입이 완료되었습니다.\n추가정보를 입력하고 머니사이클을 즐겨보세요!",
            style: Constants.defaultTextStyle.copyWith(height: 1.5),
            textAlign: TextAlign.center,
          ),
          MCButton(
            isLoading: false,
            width: 184,
            height: 44,
            title: "입력하러 가기",
            backgroundColor: Constants.blueNeon,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
