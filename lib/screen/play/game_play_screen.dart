import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/models/enums/game_action_type.dart';
import 'package:money_cycle/screen/play/components/end_game_alert_dialog.dart';
import 'package:money_cycle/screen/play/components/end_round_alert_dialog.dart';
import 'package:money_cycle/screen/play/components/game_action_container.dart';
import 'package:money_cycle/screen/play/components/game_action_dialog.dart';
import 'package:money_cycle/controller/game_controller.dart';
import 'package:money_cycle/screen/play/components/my_asset_sheet.dart';
import 'package:money_cycle/screen/play/components/purchase_alert_dialog.dart';

class GamePlayScreen extends StatefulWidget {
  const GamePlayScreen({super.key});

  @override
  State<GamePlayScreen> createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen> {
  final GameController gameController = Get.put(GameController());
  bool isSwipeUp = true;
  bool isMyTurn = true; // TODO - 데이터 연동 필요
  // bool isActionChoicing = true;
  // GameActionType currentActionType = GameActionType.saving;

  // void onActionButtonTap(GameActionType action) {
  //   setState(() {
  //     currentActionType = action;
  //     isActionChoicing = true;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(body: GetX<GameController>(builder: (gameController) {
      return Stack(
        alignment: Alignment.center,
        children: [
          //MARK: - Back Layer
          Container(
            decoration: BoxDecoration(
              color: Constants.background,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 300,
                    child: Container(
                      height: 60,
                      decoration: ShapeDecoration(
                        color: isMyTurn
                            ? const Color(0xFFEA5C67)
                            : const Color(0xFFA4A4A4),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20)),
                        ),
                        shadows: [Constants.defaultShadow],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Row(children: [
                          Text(
                            "라운드1 '${isMyTurn ? "나" : "닉네임"}'의 턴", // TODO - 현재 턴인 사용자의 닉네임 연동
                            style: Constants.largeTextStyle,
                          )
                        ]),
                      ),
                    ),
                  ),
                  const SizedBox(width: 22),
                  Expanded(
                    flex: 530,
                    child: GestureDetector(
                      onTap: () {
                        Get.dialog(const NewsDialog());
                      },
                      child: Container(
                        height: 60,
                        decoration: ShapeDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment(0.00, -1.00),
                            end: Alignment(0, 1),
                            colors: [Color(0xFFE6E7E8), Color(0xFFB6BCC2)],
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20)),
                          ),
                          shadows: [Constants.defaultShadow],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Row(children: [
                            Text(
                              "뉴스",
                              style: Constants.largeTextStyle
                                  .copyWith(color: Constants.dark100),
                            ),
                            const SizedBox(width: 25),
                            Text(
                              '"한국 은행이 기준 금리를 0.5%p 추가 인상했습니다."', // TODO - 지난 뉴스 연동
                              style: Constants.defaultTextStyle.copyWith(
                                  color: Constants.dark100, fontSize: 16),
                            )
                          ]),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ActionButton(
                        isMyTurn: isMyTurn,
                        title: "저축",
                        backgroundColor: const Color(0xFF70C14A),
                        titleColor: const Color(0xFF1F6200),
                        assetPath: "assets/icons/saving.png",
                        onPressed: () {
                          gameController.actionButtonTap(GameActionType.saving);
                          // onActionButtonTap(GameActionType.saving);
                        },
                      ),
                      ActionButton(
                        isMyTurn: isMyTurn,
                        title: "투자",
                        backgroundColor: Constants.cardRed,
                        titleColor: const Color(0xFF97010C),
                        assetPath: "assets/icons/investment.png",
                        onPressed: () {
                          gameController
                              .actionButtonTap(GameActionType.investment);
                          // onActionButtonTap(GameActionType.investment);
                        },
                      ),
                      ActionButton(
                        isMyTurn: isMyTurn,
                        title: "지출",
                        backgroundColor: Constants.cardBlue,
                        titleColor: const Color(0xFF002D9B),
                        assetPath: "assets/icons/expend.png",
                        onPressed: () {
                          gameController.actionButtonTap(GameActionType.expend);
                        },
                      ),
                      ActionButton(
                        isMyTurn: isMyTurn,
                        title: "대출",
                        backgroundColor: Constants.cardOrange,
                        titleColor: const Color(0xFF913B0B),
                        assetPath: "assets/icons/loan.png",
                        onPressed: () {
                          gameController.actionButtonTap(GameActionType.loan);
                          // gameController.actionButtonTap(GameActionType.loan);
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ActionButton(
                        isMyTurn: isMyTurn,
                        title: "행운복권",
                        backgroundColor: Constants.cardYellow,
                        titleColor: const Color(0xFFB86300),
                        assetPath: "assets/icons/lottery.png",
                        onPressed: () {
                          Get.dialog(
                            const LotteryAlert(),
                          );
                          // setState(() => isActionChoicing = true);
                        },
                      ),
                      ActionButton(
                        isMyTurn: isMyTurn,
                        title: "무급휴가",
                        backgroundColor: Constants.cardGreenBlue,
                        titleColor: const Color(0xFF005349),
                        assetPath: "assets/icons/vacation.png",
                        onPressed: () {
                          // setState(() => isActionChoicing = true);
                          Get.dialog(
                            const VacationAlert(),
                          );
                        },
                      ),
                      ActionButton(
                        isMyTurn: isMyTurn,
                        title: "랜덤게임",
                        backgroundColor: Constants.cardPink,
                        titleColor: const Color(0xFFA90054),
                        assetPath: "assets/icons/random_game.png",
                        onPressed: () {
                          Get.dialog(const FinalResultDialog());
                        },
                      ),
                      const SizedBox(
                        width: 150,
                        height: 90,
                      )
                    ],
                  )
                ],
              ),
              Container(
                height: 90,
                // color: Colors.white,
              )
            ],
          ),
          //MARK : - Middle Layer (게임 액션)
          if (gameController.isActionChoicing)
            GestureDetector(
              child: Container(color: Colors.black.withOpacity(0.3)),
              onTap: () => gameController.isActionChoicing = false,
            ),
          if (gameController.isActionChoicing)
            const Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                // showActtionDialog()
                GameActionDialog(),
              ],
            ),
          // else if (gameController.isActionChoicing &&
          //     (gameController.currentActionType == GameActionType.saving ||
          //         gameController.currentActionType == GameActionType.loan))
          //   const GameActionContainer(),

          //MARK : - Top Layer (나의 자산 현황 테이블)
          AnimatedPositioned(
              curve: Curves.decelerate,
              duration: const Duration(milliseconds: 400),
              top: !isSwipeUp ? size.height * 0.04 : size.height * 0.85,
              child: GestureDetector(
                  onPanEnd: (details) {
                    if (details.velocity.pixelsPerSecond.dy > -100) {
                      setState(() {
                        isSwipeUp = true;
                      });
                    } else {
                      setState(() {
                        isSwipeUp = false;
                      });
                    }
                  },
                  child: MyAssetSheet(
                    isSwipeUp: isSwipeUp,
                  )))
        ],
      );
    }));
  }
}

class LotteryAlert extends StatelessWidget {
  const LotteryAlert({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: MCContainer(
        strokePadding: const EdgeInsets.all(3),
        gradient: Constants.yellowGradient,
        width: 300,
        height: 300,
        child: Padding(
          padding: const EdgeInsets.only(top: 28, bottom: 18),
          child: Column(
            children: [
              Text("행운복권 당첨!", style: Constants.titleTextStyle),
              const SizedBox(height: 6),
              Text("복권에 당첨되었습니다.",
                  style: Constants.defaultTextStyle.copyWith(fontSize: 14)),
              const SizedBox(height: 10),
              SizedBox(
                  height: 70, child: Image.asset("assets/icons/lottery.png")),
              const SizedBox(height: 4),
              Text("현금 +6,000,000원", style: Constants.titleTextStyle),
              const SizedBox(height: 6),
              Text("당첨금을 받아가세요.",
                  style: Constants.defaultTextStyle.copyWith(fontSize: 14)),
              const SizedBox(height: 12),
              Bounceable(
                duration: const Duration(seconds: 1),
                onTap: () {
                  Get.back();
                },
                child: SizedBox(
                  width: 180,
                  height: 50,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset("assets/icons/button_long_yellow.png"),
                      Text(
                        "확인",
                        style:
                            Constants.defaultTextStyle.copyWith(fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VacationAlert extends StatefulWidget {
  const VacationAlert({
    super.key,
  });

  @override
  State<VacationAlert> createState() => _VacationAlertState();
}

class _VacationAlertState extends State<VacationAlert> {
  bool isVacation = false;
  bool isVacationFinished = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: MCContainer(
        strokePadding: const EdgeInsets.all(3),
        gradient: Constants.greenBlueGradient,
        width: 300,
        height: 300,
        child: Padding(
          padding: const EdgeInsets.only(top: 28, bottom: 18),
          child: Column(
            children: [
              Text("무급휴가", style: Constants.titleTextStyle),
              const SizedBox(height: 6),
              Text("지금 바로 휴가를 즐기세요.",
                  style: Constants.defaultTextStyle.copyWith(fontSize: 14)),
              const SizedBox(height: 10),
              SizedBox(
                  height: 70, child: Image.asset("assets/icons/vacation.png")),
              const SizedBox(height: 4),
              Text("휴가를 떠난 당신, 2턴을 쉬게 됩니다..",
                  style: Constants.defaultTextStyle.copyWith(fontSize: 14)),
              const SizedBox(height: 6),
              Text("다만 마지막 라운드라면 1턴만 쉽니다.",
                  style: Constants.defaultTextStyle.copyWith(fontSize: 14)),
              const SizedBox(height: 12),
              Bounceable(
                duration: const Duration(seconds: 1),
                onTap: () {
                  // Get.back();
                  if (!isVacation) {
                    setState(() {
                      isVacation = true;
                    });
                    return;
                  }
                  if (isVacationFinished) {
                    Get.back();
                    return;
                  }

                  setState(() {
                    isVacationFinished = true;
                  });
                },
                child: SizedBox(
                  width: 180,
                  height: 50,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset((isVacation && !isVacationFinished)
                          ? "assets/icons/button_long_green_blue_disabled.png"
                          : "assets/icons/button_long_green_blue.png"),
                      Text(
                        isVacation ? "휴가종료" : "확인",
                        style:
                            Constants.defaultTextStyle.copyWith(fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActionButton extends StatefulWidget {
  final bool isMyTurn;

  final String title;
  final Color backgroundColor;
  final Color titleColor;
  final String assetPath;
  final Function()? onPressed;

  const ActionButton({
    super.key,
    required this.backgroundColor,
    required this.titleColor,
    required this.assetPath,
    this.onPressed,
    required this.title,
    required this.isMyTurn,
  });

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: widget.isMyTurn ? widget.onPressed : null,
          child: Stack(
            children: [
              Container(
                width: 150,
                height: 90,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: widget.backgroundColor,
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
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 4),
                        child: Text(widget.title,
                            style: Constants.titleTextStyle
                                .copyWith(color: widget.titleColor)),
                      ),
                      Expanded(
                        child: Image.asset(widget.assetPath,
                            fit: BoxFit.fitHeight),
                      )
                    ],
                  ),
                ),
              ),
              if (!widget.isMyTurn)
                Container(
                  width: 150,
                  height: 90,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0x996D6D6D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                )
            ],
          )),
    );
  }
}
