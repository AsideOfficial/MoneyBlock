import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../constants.dart';

class WaitingRoomScreen extends StatelessWidget {
  const WaitingRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: Constants.mainGradient,
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Row(
                    children: [
                      CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: SizedBox(
                            height: 46,
                            width: 46,
                            child: Image.asset(
                              "assets/icons/back_button.png",
                            ),
                          ),
                          onPressed: () {
                            //TODO - 대기실 퇴장 API 연동
                            Get.back();
                          }),
                      const SizedBox(width: 24),
                      Text(
                        "3학년 4반 토끼팀",
                        style: Constants.largeTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              Container(height: 1),
              Container(
                height: 13,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: const Alignment(0.00, -1.00),
                    end: const Alignment(0, 1),
                    colors: [
                      Colors.black.withOpacity(0.30000001192092896),
                      Colors.black.withOpacity(0)
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
