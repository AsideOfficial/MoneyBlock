import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                            FirebaseAuth.instance.signOut();
                          },
                        ),
                        const SizedBox(width: 12),
                        MCBounceableButton(
                          height: 42,
                          title: "방 찾기",
                          backgroundColor: Constants.blueNeon,
                          onPressed: () {
                            //TODO - 빠른 시작 로비
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
