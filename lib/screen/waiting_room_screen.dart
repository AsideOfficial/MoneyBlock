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
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PlayerCard(character: PlayerCharacter.cow),
                  PlayerCard(character: PlayerCharacter.bear),
                  PlayerCard(character: PlayerCharacter.pig),
                  PlayerCard(character: PlayerCharacter.tiger)
                ],
              ),
              const SizedBox(height: 8),
              Container(
                height: 13,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: const Alignment(0.00, -1.00),
                    end: const Alignment(0, 1),
                    colors: [
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(0.30000001192092896),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum PlayerCharacter { cow, bear, pig, tiger }

extension CharacterExtension on PlayerCharacter {
  Color get backgroundColor {
    switch (this) {
      case PlayerCharacter.cow:
        return const Color(0xFFFFA2A9);
      case PlayerCharacter.bear:
        return const Color(0xFFB3B3FF);
      case PlayerCharacter.pig:
        return const Color(0xFFFFEB98);
      case PlayerCharacter.tiger:
        return const Color(0xFFB5F79B);
    }
  }

  Color get primaryColor {
    switch (this) {
      case PlayerCharacter.cow:
        return const Color(0xFFEA5C67);
      case PlayerCharacter.bear:
        return const Color(0xFF6969E8);
      case PlayerCharacter.pig:
        return const Color(0xFFF7C800);
      case PlayerCharacter.tiger:
        return const Color(0xFF68C444);
    }
  }
}

class PlayerCard extends StatelessWidget {
  final PlayerCharacter character;

  const PlayerCard({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: character.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x4C000000),
              blurRadius: 6,
              offset: Offset(3, 3),
              spreadRadius: 1,
            )
          ],
        ),
        width: 150,
        height: 190,
        child: Column(
          children: [
            Container(
                height: 34,
                color: character.primaryColor,
                child: Center(
                  child: Text(
                    "죠습니다",
                    style: Constants.defaultTextStyle.copyWith(fontSize: 18),
                  ),
                )),
            Container(
              height: 2,
              color: Colors.white,
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 75,
                        height: 34,
                        decoration: ShapeDecoration(
                          color: character.primaryColor,
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20)),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "준비",
                            style: Constants.defaultTextStyle
                                .copyWith(fontSize: 18),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SizedBox(
                          width: 34,
                          height: 34,
                          child: Image.asset("assets/icons/host.png"),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
