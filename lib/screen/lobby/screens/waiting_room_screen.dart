import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/screen/lobby/components/setting_dialog.dart';
import 'package:money_cycle/screen/lobby/components/share_code_dialog.dart';
import 'package:money_cycle/screen/lobby/model/mc_room.dart';
import 'package:money_cycle/start/model/mc_user.dart';
import 'package:money_cycle/start/model/profile_image.dart';
import 'package:money_cycle/utils/firebase_service.dart';

class WaitingRoomScreen extends StatefulWidget {
  const WaitingRoomScreen({super.key});

  @override
  State<WaitingRoomScreen> createState() => _WaitingRoomScreenState();
}

class _WaitingRoomScreenState extends State<WaitingRoomScreen> {
  final roomID = Get.arguments;
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

  Future<void> tapBackButton({required MCRoom? roomData}) async {
    if (roomData?.participants.keys.length == 1) {
      FirebaseService.removeRoom(roomID: roomID);
    } else {
      var currentParticipants = roomData?.participants;
      currentParticipants?.remove(FirebaseAuth.instance.currentUser!.uid);

      if (roomData?.hostId == FirebaseAuth.instance.currentUser!.uid) {
        String? newHostId = currentParticipants?.keys.first;
        currentParticipants?[newHostId!] = true;

        await FirebaseService.updateRoom(
          roomId: roomID,
          key: 'hostId',
          value: newHostId,
        );
      }

      await FirebaseService.updateRoom(
        roomId: roomID,
        key: 'participants',
        value: currentParticipants,
      );
    }
  }

  Future<void> toggleReady(
      {required MCRoom? roomData, required bool current}) async {
    var currentParticipants = roomData?.participants;
    currentParticipants?[FirebaseAuth.instance.currentUser!.uid] = !current;

    await FirebaseService.updateRoom(
      roomId: roomID,
      key: 'participants',
      value: currentParticipants,
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
                            onTap: () async {
                              tapBackButton(roomData: roomData);
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
                            roomData?.roomName ?? '',
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
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      if (roomData != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              List<String>.from(roomData.participants.keys)
                                  .reversed
                                  .map((uid) {
                            return PlayerCard(
                              key: UniqueKey(),
                              userId: uid,
                              isHost: roomData.hostId == uid,
                              isReady: roomData.participants[uid]!,
                            );
                          }).toList(),
                        )
                      else
                        PlayerCard(
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          isHost: true,
                          isReady: true,
                        ),
                      if (roomData?.hostId ==
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
                                              roomData!.savingsInterestRate,
                                          loanRate: roomData.loanInterestRate,
                                          changeRate:
                                              roomData.investmentChangeRate,
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
                                          roomCode: roomData!.roomCode,
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
                  if (roomData != null)
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
                          onTap: (roomData.hostId !=
                                  FirebaseAuth.instance.currentUser?.uid)
                              ? () {
                                  toggleReady(
                                    roomData: roomData,
                                    current: roomData.participants[
                                        FirebaseAuth.instance.currentUser?.uid],
                                  );
                                }
                              : (roomData.participants.keys.length > 1 &&
                                      !roomData.participants
                                          .containsValue(false))
                                  ? () {
                                      //TODO: 게임 시작
                                    }
                                  : null,
                          child: Image.asset(
                            (roomData.hostId !=
                                    FirebaseAuth.instance.currentUser?.uid)
                                ? 'assets/components/game_ready_button${roomData.participants[FirebaseAuth.instance.currentUser?.uid] ? '_already' : ''}.png'
                                : 'assets/components/game_start_button${(roomData.participants.keys.length == 1 || roomData.participants.containsValue(false)) ? '_inactive' : ''}.png',
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
    required this.isHost,
    required this.isReady,
  });

  final String userId;
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
                  : ProfileImage.cardColors[userData.profileImageIndex],
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
                    ProfileImage.characters[userData.profileImageIndex],
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
                            : ProfileImage
                                .titleColors[userData.profileImageIndex],
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
                            : widget.isReady
                                ? ProfileImage
                                    .titleColors[userData.profileImageIndex]
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
