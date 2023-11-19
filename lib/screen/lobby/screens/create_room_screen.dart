import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/controller/user_controller.dart';
import 'package:money_cycle/screen/lobby/model/game_mode.dart';
import 'package:money_cycle/screen/lobby/model/game_variable.dart';
import 'package:money_cycle/utils/firebase_service.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  GameMode gameMode = GameMode.officeWorker;
  TeamMode teamMode = TeamMode.solo;

  double savingRate = 5.0;
  double loanRate = 3.0;
  double changeRate = 10.0;

  double generateRandomDouble({required double min, required double max}) {
    Random random = Random();
    double minValue = min;
    double maxValue = max;
    double step = 0.5;

    int numSteps = ((maxValue - minValue) / step).ceil();
    int randomIndex = random.nextInt(numSteps + 1);
    double result = minValue + randomIndex * step;

    return result;
  }

  Widget modeCard() {
    return Bounceable(
      onTap: () {
        setState(() {
          if (gameMode == GameMode.entrepreneur) {
            gameMode = GameMode.officeWorker;
          } else {
            gameMode = GameMode.entrepreneur;
          }
        });
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: 170,
            height: 214,
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: const Alignment(0.00, -1.00),
                end: const Alignment(0, 1),
                colors: gameMode == GameMode.officeWorker
                    ? [const Color(0xFFA69EFF), const Color(0xFF8B80FF)]
                    : [Colors.grey, Colors.grey],
              ),
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                )
              ],
            ),
          ),
          Container(
            width: 170,
            height: 58,
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              color: Colors.black.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              gameMode.convertToString,
              style: Constants.defaultTextStyle.copyWith(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget variableSettingBox() {
    return Container(
      width: 316,
      height: 150,
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: Alignment(0.00, -1.00),
          end: Alignment(0, 1),
          colors: [Color(0xFFA69EFF), Color(0xFF8B80FF)],
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 2),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          variableSlideBar(
            variable: GameVariable.savingsInterestRate,
            value: savingRate,
            min: 2.0,
            max: 10.0,
            onChange: (newValue) {
              setState(() => savingRate = newValue);
            },
          ),
          variableSlideBar(
            variable: GameVariable.loanInterestRate,
            value: loanRate,
            min: 1.0,
            max: 9.0,
            onChange: (newValue) {
              setState(() => loanRate = newValue);
            },
          ),
          variableSlideBar(
            variable: GameVariable.investmentChangeRate,
            value: changeRate,
            min: -20.0,
            max: 30.0,
            onChange: (newValue) {
              setState(() => changeRate = newValue);
            },
          ),
        ],
      ),
    );
  }

  Widget variableSlideBar({
    required GameVariable variable,
    double min = 0.0,
    double max = 5.0,
    required double value,
    required Function(dynamic) onChange,
  }) {
    return Row(
      children: [
        const SizedBox(width: 6.0),
        Image.asset(
          variable.sourceUrl,
          width: 96,
          height: 42,
        ),
        SizedBox(
          width: 140,
          child: SfSliderTheme(
            data: SfSliderThemeData(
              activeTrackHeight: 2,
              inactiveTrackHeight: 2,
              trackCornerRadius: 2,
              activeTrackColor: Colors.white.withOpacity(0.8),
              inactiveTrackColor: const Color(0xFF7062AD),
              overlayRadius: 10,
            ),
            child: SfSlider(
              value: value,
              min: min,
              max: max,
              stepSize: 0.5,
              thumbIcon: Container(
                width: 18,
                height: 18,
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.00, 1.00),
                    end: Alignment(0, -1),
                    colors: [Color(0xFF6322EE), Color(0xFF8572FF)],
                  ),
                  shape: OvalBorder(
                    side: BorderSide(width: 1, color: Colors.white),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 1,
                      offset: Offset(0, 1),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
              onChanged: onChange,
            ),
          ),
        ),
        const SizedBox(width: 4.0),
        Text(
          '${value.toStringAsFixed(1)}%',
          textAlign: TextAlign.right,
          style: Constants.defaultTextStyle.copyWith(fontSize: 16),
        )
      ],
    );
  }

  Widget teamModeBox() {
    return Bounceable(
      onTap: () {
        setState(() {
          if (teamMode == TeamMode.solo) {
            teamMode = TeamMode.team;
          } else {
            teamMode = TeamMode.solo;
          }
        });
      },
      child: Container(
        width: 316,
        height: 58,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.00, -1.00),
            end: const Alignment(0, 1),
            colors: teamMode == TeamMode.solo
                ? [const Color(0xFFA69EFF), const Color(0xFF8B80FF)]
                : [Colors.grey, Colors.grey],
          ),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Text(
          teamMode.convertToString,
          style: Constants.defaultTextStyle.copyWith(fontSize: 16),
        ),
      ),
    );
  }

  @override
  void initState() {
    savingRate = generateRandomDouble(min: 2.0, max: 10.0);
    loanRate = generateRandomDouble(min: 1.0, max: 9.0);
    changeRate = generateRandomDouble(min: -10.0, max: 10.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    children: [
                      Bounceable(
                        child: SizedBox(
                          height: 46,
                          width: 46,
                          child: Image.asset(
                            "assets/icons/back_button.png",
                          ),
                        ),
                        onTap: () => Get.back(),
                      ),
                      const SizedBox(width: 24),
                      Text(
                        "방 설정하기",
                        style: Constants.largeTextStyle,
                      ),
                      const Spacer(),
                      Bounceable(
                        onTap: (gameMode == GameMode.officeWorker &&
                                teamMode == TeamMode.solo)
                            ? () async {
                                final roomData =
                                    await FirebaseService.createRoom(
                                  savingRate: savingRate,
                                  loanRate: loanRate,
                                  investmentRate: changeRate,
                                  uid: FirebaseAuth.instance.currentUser!.uid,
                                  characterIndex: Get.find<MCUserController>()
                                      .user!
                                      .value
                                      .profileImageIndex,
                                );

                                if (roomData != null) {
                                  Get.offAndToNamed(
                                    '/waiting_room',
                                    arguments: roomData.roomId,
                                  );
                                }
                              }
                            : null,
                        child: Image.asset(
                          'assets/components/m_create_room_button${(gameMode == GameMode.officeWorker && teamMode == TeamMode.solo) ? '' : '_inactive'}.png',
                          width: 170,
                          height: 50,
                        ),
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
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          Text(
                            '테마',
                            style: Constants.defaultTextStyle
                                .copyWith(fontSize: 24),
                          ),
                          const SizedBox(height: 8.0),
                          modeCard(),
                        ],
                      ),
                      const SizedBox(width: 8.0),
                      Column(
                        children: [
                          Text(
                            '초기설정',
                            style: Constants.defaultTextStyle
                                .copyWith(fontSize: 24),
                          ),
                          const SizedBox(height: 8.0),
                          variableSettingBox(),
                          const SizedBox(height: 8.0),
                          teamModeBox(),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 11.0),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
