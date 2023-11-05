import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/components/mc_bounceable_button.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/components/mc_text_field.dart';

import '../../constants.dart';

class SignInDialog extends StatefulWidget {
  const SignInDialog({super.key});

  @override
  State<SignInDialog> createState() => _SignInDialogState();
}

class _SignInDialogState extends State<SignInDialog> {
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
                  child: Column(
                    children: [
                      const SizedBox(height: 22),
                      Text("이메일 로그인", style: Constants.titleTextStyle),
                      const SizedBox(height: 16),
                      MCTextField(
                        hintText: "이메일",
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 8),
                      MCTextField(
                        hintText: "비밀번호",
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                      ),
                      const SizedBox(height: 12),
                      MCBounceableButton(
                        width: 184,
                        height: 44,
                        title: "로그인",
                        backgroundColor: Constants.blueNeon,
                        onPressed: () {},
                      ),
                      MCBounceableButton(
                        height: 44,
                        title: "비밀번호를 잊어버리셧나요?",
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
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
}
