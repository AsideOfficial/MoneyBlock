import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_cycle/start/components/alert_dialog.dart';
import 'package:money_cycle/start/components/sign_in_dialog.dart';
import 'package:money_cycle/start/components/sign_up_dialog.dart';

import '../components/mc_bounceable_button.dart';
import '../components/mc_capsule_container.dart';
import '../components/mc_container.dart';
import '../constants.dart';

class LobbyScreen extends StatelessWidget {
  const LobbyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/main_illustration.png',
            fit: BoxFit.cover,
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 26),
            child: MCContainer(
              width: 544,
              child: Column(
                children: [
                  const Spacer(),
                  MCCapsuleContainer(
                    chid: Row(
                      children: [
                        const Spacer(),
                        MCBounceableButton(
                          height: 42,
                          title: "방 만들기",
                          backgroundColor: Constants.greenNeon,
                          onPressed: () {
                            //TODO - 방만들기 로비
                            showDialog(
                              useSafeArea: false,
                              context: context,
                              builder: (context) => const SignUpDailog(),
                            );
                          },
                        ),
                        const SizedBox(width: 12),
                        MCBounceableButton(
                          height: 42,
                          title: "방 찾기",
                          backgroundColor: Constants.blueNeon,
                          onPressed: () {
                            //TODO - 빠른 시작 로비
                            showDialog(
                              context: context,
                              builder: (context) => MCAlertDialog(
                                  title: "이메일 로그인",
                                  message: "해당 아이디로 가입된 정보가 없습니다.",
                                  primaryAction: () {
                                    Get.back();
                                  },
                                  primaryActionTitle: "다시 로그인하기"),
                            );
                          },
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
