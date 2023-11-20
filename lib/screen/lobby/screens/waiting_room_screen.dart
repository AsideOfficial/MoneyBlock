import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/controller/game_controller.dart';
import 'package:money_cycle/controller/game_controller.dart';
import 'package:money_cycle/main.dart';
import 'package:money_cycle/screen/lobby/components/setting_dialog.dart';
import 'package:money_cycle/screen/lobby/components/share_code_dialog.dart';
import 'package:money_cycle/screen/lobby/model/mc_room.dart';
import 'package:money_cycle/screen/play/game_play_screen.dart';
import 'package:money_cycle/start/model/mc_user.dart';
import 'package:money_cycle/start/model/profile_image.dart';
import 'package:money_cycle/utils/firebase_service.dart';

class WaitingRoomScreen extends StatefulWidget {
  const WaitingRoomScreen({super.key});

  @override
  State<WaitingRoomScreen> createState() => _WaitingRoomScreenState();
}

class _WaitingRoomScreenState extends State<WaitingRoomScreen> {
  final roomID = Get.arguments as String;
  final roomRef = FirebaseDatabase.instanceFor(
          app: firebaseApp!,
          databaseURL:
              'https://moneycycle-5f900-default-rtdb.asia-southeast1.firebasedatabase.app/')
      .ref('Room/${Get.arguments}');

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
              '${(label == '투자변동률' && value > 0) ? '+' : ''}${(value == value.roundToDouble()) ? value.toInt() : value}%',
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

  Widget buttonColumn({
    required String buttonImage,
    required String label,
    required Function() onTap,
  }) {
    return Bounceable(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            buttonImage,
            width: 46,
            height: 46,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: Constants.defaultTextStyle.copyWith(fontSize: 10),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: roomRef.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/main_illustration.png',
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
                Column(
                  children: [
                    Text(
                      '오류가 발생했습니다',
                      style: Constants.defaultTextStyle,
                    ),
                    const SizedBox(height: 16.0),
                    Bounceable(
                      onTap: () => Get.back(),
                      child: MCContainer(
                        width: 218.0,
                        height: 61.0,
                        alignment: Alignment.center,
                        child: Text(
                          '뒤로 가기',
                          style: Constants.defaultTextStyle.copyWith(
                            fontSize: 16.0,
                            letterSpacing: 0.20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.active) {
          final Map<String, dynamic> json = Map<String, dynamic>.from(
              snapshot.data?.snapshot.value as Map<dynamic, dynamic>);
          final roomData = RoomData.fromJson(json);

          Map<String, bool> participantsState = {};

          for (Player player in roomData.player!) {
            participantsState[player.uid] = player.isReady;
          }

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
                              onTap: () async {
                                await FirebaseService.exitRoom(
                                  roomId: roomID,
                                  uid: FirebaseAuth.instance.currentUser!.uid,
                                );

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
                              roomID,
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
                    const Spacer(),
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: roomData.player!.map((p) {
                            return PlayerCard(
                              key: UniqueKey(),
                              userId: p.uid,
                              characterIndex: p.characterIndex,
                              isHost: roomData.player!.indexOf(p) == 0,
                              isReady: p.isReady,
                            );
                          }).toList(),
                        ),
                        if (roomData.player![0].uid ==
                            FirebaseAuth.instance.currentUser?.uid)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                children: [
                                  buttonColumn(
                                    buttonImage:
                                        'assets/icons/setting_button.png',
                                    label: '환경설정',
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return SettingDialog(
                                            roomID: roomID,
                                            savingRate:
                                                roomData.savingRateInfo[0],
                                            loanRate: roomData.loanRateInfo[0],
                                            changeRate:
                                                roomData.investmentRateInfo[0],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 10.0),
                                  buttonColumn(
                                    buttonImage: 'assets/icons/qr_button.png',
                                    label: '코드공유',
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return ShareCodeDialog(
                                            roomCode: roomID,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(width: 53.0),
                            ],
                          ),
                      ],
                    ),
                    const Spacer(),
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
                    SafeArea(
                      left: false,
                      right: false,
                      child: Row(
                        children: [
                          const SizedBox(width: 120.0),
                          variableColumn(
                            rateType: 'assets/components/saving_rate_box.png',
                            label: '저축금리',
                            value: roomData.savingRateInfo[0],
                          ),
                          const SizedBox(width: 10.0),
                          variableColumn(
                            rateType: 'assets/components/loan_rate_box.png',
                            label: '대출금리',
                            value: roomData.loanRateInfo[0],
                          ),
                          const SizedBox(width: 10.0),
                          variableColumn(
                            rateType:
                                'assets/components/investment_change_rate_box.png',
                            label: '투자변동률',
                            value: roomData.investmentRateInfo[0],
                          ),
                          const Spacer(),
                          Bounceable(
                            onTap: (roomData.player![0].uid !=
                                    FirebaseAuth.instance.currentUser?.uid)
                                ? () {
                                    FirebaseService.readyToggle(
                                        roomId: roomID,
                                        uid: FirebaseAuth
                                            .instance.currentUser!.uid);
                                  }
                                : (roomData.player!.length > 1 &&
                                        !participantsState.values
                                            .toList()
                                            .contains(false))
                                    ? () async {
                                        //TODO: 게임 시작
                                        final myIndex = participantsState.keys
                                            .toList()
                                            .indexOf(FirebaseAuth
                                                .instance.currentUser!.uid);

                                        await FirebaseService.startGame(
                                            roomId: roomID);
                                        Get.to(const GamePlayScreen(),
                                            binding: BindingsBuilder(() {
                                          Get.put(GameController(
                                              roomId: roomID,
                                              myIndex: myIndex));
                                        }));
                                      }
                                    : null,
                            child: Image.asset(
                              (roomData.player![0].uid !=
                                      FirebaseAuth.instance.currentUser?.uid)
                                  ? 'assets/components/game_ready_button${participantsState[FirebaseAuth.instance.currentUser!.uid]! ? '_already' : ''}.png'
                                  : 'assets/components/game_start_button${(roomData.player!.length == 1 || participantsState.values.toList().contains(false)) ? '_inactive' : ''}.png',
                              width: 230,
                              height: 50,
                            ),
                          ),
                          const SizedBox(width: 80.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        return Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/main_illustration.png',
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(height: 200),
                    const SizedBox(
                      width: 32.0,
                      height: 32.0,
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      '방 정보를 불러오는 중...',
                      style: Constants.defaultTextStyle.copyWith(shadows: [
                        const Shadow(
                          blurRadius: 16.0,
                          color: Colors.black,
                        ),
                      ]),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
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
    required this.characterIndex,
    required this.isHost,
    required this.isReady,
  });

  final String userId;
  final int characterIndex;
  final bool isHost;
  final bool isReady;

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  bool isLoading = true;
  late MCUser userData;

  @override
  void initState() {
    FirebaseService.getUserData(userID: widget.userId).then((value) {
      if (mounted) {
        setState(() {
          userData = value!;
          isLoading = false;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: isLoading
                  ? Colors.grey
                  : ProfileImage.cardColors[widget.characterIndex],
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Colors.white.withOpacity(0.3),
                ),
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
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                if (!isLoading)
                  Image.asset(
                    ProfileImage.characters[widget.characterIndex],
                    width: 150,
                    height: 190,
                    fit: BoxFit.cover,
                  ),
                Column(
                  children: [
                    Container(
                      height: 34,
                      decoration: ShapeDecoration(
                        color: isLoading
                            ? Colors.grey
                            : ProfileImage.titleColors[widget.characterIndex],
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
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
                      child: Center(
                        child: Text(
                          isLoading ? '???' : userData.nickNm,
                          style:
                              Constants.defaultTextStyle.copyWith(fontSize: 18),
                        ),
                      ),
                    ),
                    Container(
                      height: 2,
                      color: Colors.white,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 75,
                      height: 34,
                      decoration: ShapeDecoration(
                        color: isLoading
                            ? Colors.grey
                            : widget.isHost
                                ? ProfileImage
                                    .titleColors[widget.characterIndex]
                                : widget.isReady
                                    ? ProfileImage
                                        .titleColors[widget.characterIndex]
                                    : const Color(0xFFA5A5A5),
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                            width: 2,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          isLoading
                              ? '준비전'
                              : widget.isHost
                                  ? '방장'
                                  : widget.isReady
                                      ? '준비'
                                      : '준비전',
                          style:
                              Constants.defaultTextStyle.copyWith(fontSize: 18),
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (!isLoading &&
                        userData.uid == FirebaseAuth.instance.currentUser?.uid)
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SizedBox(
                          width: 34,
                          height: 34,
                          child: Image.asset("assets/icons/me.png"),
                        ),
                      )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
