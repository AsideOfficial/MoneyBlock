import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/screen/lobby/model/mc_room.dart';
import 'package:money_cycle/start/model/mc_user.dart';
import 'package:money_cycle/utils/firebase_service.dart';

class WaitingRoomScreen extends StatefulWidget {
  const WaitingRoomScreen({super.key});

  @override
  State<WaitingRoomScreen> createState() => _WaitingRoomScreenState();
}

class _WaitingRoomScreenState extends State<WaitingRoomScreen> {
  final roomStream = FirebaseFirestore.instance
      .collection('Room')
      .doc(Get.arguments)
      .withConverter(
        fromFirestore: MCRoom.fromFirestore,
        toFirestore: (MCRoom room, _) => room.toFirestore(),
      )
      .snapshots();

  Widget variableColumn({
    required String rateType,
    required String label,
    required double value,
  }) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              rateType,
              width: 50,
              height: 50,
            ),
            Text(
              '${(label == '투자변동률' && value > 0) ? '+' : ''}$value%',
              style: Constants.defaultTextStyle.copyWith(fontSize: 14.0),
            )
          ],
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: Constants.defaultTextStyle.copyWith(fontSize: 10),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: roomStream,
      builder: ((context, snapshot) {
        final roomData = snapshot.data?.data();

        return Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
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
                          Bounceable(
                            onTap: () {
                              Get.back();
                            },
                            child: SizedBox(
                              height: 46,
                              width: 46,
                              child: Image.asset(
                                "assets/icons/back_button.png",
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                          Text(
                            roomData?.roomName ?? '방 정보 없음',
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
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: roomData!.participantsIds.map((id) {
                      return PlayerCard(
                        userId: id,
                        character: PlayerCharacter.cow,
                      );
                    }).toList(),
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
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const SizedBox(width: 120.0),
                      variableColumn(
                        rateType: 'assets/components/saving_rate_box.png',
                        label: '저축금리',
                        value: roomData.savingsInterestRate,
                      ),
                      const SizedBox(width: 10.0),
                      variableColumn(
                        rateType: 'assets/components/loan_rate_box.png',
                        label: '대출금리',
                        value: roomData.loanInterestRate,
                      ),
                      const SizedBox(width: 10.0),
                      variableColumn(
                        rateType:
                            'assets/components/investment_change_rate_box.png',
                        label: '투자변동률',
                        value: roomData.investmentChangeRate,
                      ),
                      const Spacer(),
                      Bounceable(
                        onTap: () {},
                        child: Image.asset(
                          'assets/components/game_start_button.png',
                          width: 230,
                          height: 50,
                        ),
                      ),
                      const SizedBox(width: 80.0),
                    ],
                  )
                ],
              ),
            ],
          ),
        );
      }),
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

class PlayerCard extends StatefulWidget {
  const PlayerCard({
    super.key,
    required this.userId,
    required this.character,
  });

  final PlayerCharacter character;
  final String userId;

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  late MCUser userData;

  @override
  void initState() {
    FirebaseService.getUserData(userID: widget.userId).then((value) {
      setState(() => userData = value!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: widget.character.backgroundColor,
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
                color: widget.character.primaryColor,
                child: Center(
                  child: Text(
                    userData.nickNm,
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
                          color: widget.character.primaryColor,
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            (userData.uid ==
                                    FirebaseAuth.instance.currentUser?.uid)
                                ? '방장'
                                : '준비',
                            style: Constants.defaultTextStyle
                                .copyWith(fontSize: 18),
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (userData.uid ==
                          FirebaseAuth.instance.currentUser?.uid)
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
