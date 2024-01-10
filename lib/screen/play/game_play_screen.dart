import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/models/enums/game_action_type.dart';
import 'package:money_cycle/models/game/lottery.dart';
import 'package:money_cycle/screen/play/components/end_round_alert_dialog.dart';
import 'package:money_cycle/screen/play/components/game_action_dialog.dart';
import 'package:money_cycle/controller/game_controller.dart';
import 'package:money_cycle/screen/play/components/my_asset_sheet.dart';
import 'package:money_cycle/screen/play/components/vacation_alert_dialog.dart';
import 'package:money_cycle/utils/extension/int.dart';
import 'package:money_cycle/utils/snack_bar_util.dart';

import '../../components/mc_button.dart';

class GamePlayScreen extends StatefulWidget {
  const GamePlayScreen({super.key});

  @override
  State<GamePlayScreen> createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen> {
  bool isSwipeUp = true;
  bool isMyTurn = true; // TODO - 데이터 연동 필요
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(body: GetX<GameController>(builder: (gameController) {
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
                          color: gameController.isMyTurn
                              ? gameController.myCharacterBackgroundColor
                              : const Color(0xFFA4A4A4),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          shadows: [Constants.defaultShadow],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SizedBox(
                                    child: Image.asset(gameController
                                        .myCharacterAvatarAssetString)),
                              ),
                              Expanded(
                                child: Marquee(
                                  text:
                                      "라운드${gameController.currentRound} '${gameController.isMyTurn ? "나" : ((gameController.currentTurnPlayer?.name?.length ?? 0) < 5) ? gameController.currentTurnPlayer?.name ?? "" : gameController.currentTurnPlayer!.name!.substring(0, 4)}'의 턴",
                                  style: Constants.largeTextStyle,
                                  scrollAxis: Axis.horizontal,
                                  blankSpace: 10.0,
                                  velocity: 30.0,
                                  pauseAfterRound: const Duration(seconds: 1),
                                  startPadding: 10.0,
                                  accelerationDuration:
                                      const Duration(seconds: 1),
                                  accelerationCurve: Curves.linear,
                                  decelerationDuration:
                                      const Duration(milliseconds: 500),
                                  decelerationCurve: Curves.easeOut,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 22),
                    Expanded(
                      flex: 530,
                      child: GestureDetector(
                        onTap: () {
                          Get.dialog(const NewsDialog(actionTitle: "닫기"),
                              useSafeArea: false);
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
                                '"${gameController.currentNews?.headline ?? ""}"', // TODO - 지난 뉴스 연동
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
                const SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ActionButton(
                          isMyTurn: gameController.isMyTurn,
                          title: "저축",
                          backgroundColor: const Color(0xFF70C14A),
                          titleColor: const Color(0xFF1F6200),
                          assetPath: "assets/icons/saving.png",
                          onPressed: () {
                            gameController
                                .actionButtonTap(GameActionType.saving);
                            // onActionButtonTap(GameActionType.saving);
                          },
                        ),
                        ActionButton(
                          isMyTurn: gameController.isMyTurn,
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
                          isMyTurn: gameController.isMyTurn,
                          title: "지출",
                          backgroundColor: Constants.cardBlue,
                          titleColor: const Color(0xFF002D9B),
                          assetPath: "assets/icons/expend.png",
                          onPressed: () {
                            gameController
                                .actionButtonTap(GameActionType.expend);
                          },
                        ),
                        ActionButton(
                          isMyTurn: true,
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
                          isMyTurn: gameController.isMyTurn,
                          title: "행운복권",
                          backgroundColor: Constants.cardYellow,
                          titleColor: const Color(0xFFB86300),
                          assetPath: "assets/icons/lottery.png",
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            final luckyItem =
                                await gameController.getRandomLuckyLottery();
                            setState(() {
                              isLoading = false;
                            });

                            if (luckyItem != null) {
                              Get.dialog(
                                LotteryAlert(
                                  luckyItem: luckyItem,
                                  skipLottery: false,
                                ),
                                barrierDismissible: false,
                                useSafeArea: false,
                              );
                              if (luckyItem.price < 0 &&
                                  gameController.myInsuranceItems!.any(
                                      (element) => (element.id == "pi1" ||
                                          element.id == "pi2"))) {
                                SnackBarUtil.showToastMessage(
                                    message: "'민영보험'을 사용해서 불운을 건너뛸까요?",
                                    actionTitle: "사용하기",
                                    duration: const Duration(seconds: 20),
                                    onActionPressed: () async {
                                      Get.back(closeOverlays: true);
                                      await gameController
                                          .usePrivateInsurance();
                                    });
                              }
                            } else {
                              Get.snackbar("행운 복권 오류", "다시 시도해주세요.",
                                  colorText: Colors.black,
                                  backgroundGradient: Constants.grey01Gradient);
                            }
                          },
                        ),
                        ActionButton(
                          isMyTurn: gameController.isMyTurn,
                          title: "무급휴가",
                          backgroundColor: Constants.cardGreenBlue,
                          titleColor: const Color(0xFF005349),
                          assetPath: "assets/icons/vacation.png",
                          onPressed: () {
                            // setState(() => isActionChoicing = true);
                            Get.dialog(const VacationAlert());
                          },
                        ),
                        ActionButton(
                          isMyTurn: gameController.isMyTurn,
                          title: "턴 종료",
                          backgroundColor: const Color(0xFFA95BE7),
                          titleColor: const Color(0xFF5B2486),
                          onPressed: () async {
                            // showToastMessage("하이");
                            // await gameController.usePrivateInsurance();
                            Get.dialog(ActionAlertDialog(
                              title: "턴 넘기기",
                              subTitle: "턴을 넘기시겠습니까?",
                              actionTitle: '턴 넘기기',
                              primaryActionColor: const Color(0xFFA95BE7),
                              onAction: () async {
                                await gameController.endTurn();
                              },
                            ));
                          },
                        ),
                        // ActionButton(
                        //   isMyTurn: true,
                        //   title: "랜덤게임",
                        //   backgroundColor: Constants.cardPink,
                        //   titleColor: const Color(0xFFA90054),
                        //   assetPath: "assets/icons/random_game.png",
                        //   onPressed: () async {
                        //     // Get.dialog(const FinalResultDialog());
                        //     // await CloudFunctionService.userAction(
                        //     //     roomData: RoomData(
                        //     //         roomId: "960877",
                        //     //         playerIndex: 1,
                        //     //         userActions: [
                        //     //       UserAction(
                        //     //           type: "shortSaving",
                        //     //           title: "예금",
                        //     //           price: 50000,
                        //     //           qty: 1),
                        //     //       UserAction(
                        //     //           type: "cash",
                        //     //           title: "예금",
                        //     //           price: -50000,
                        //     //           qty: 1),
                        //     //     ]));
                        //   },
                        // ),
                        // const Padding(
                        //   padding: EdgeInsets.all(5.0),
                        //   child: SizedBox(
                        //     width: 150,
                        //     height: 90,
                        //   ),
                        // ),
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: SizedBox(
                            width: 150,
                            height: 90,
                          ),
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
                  SizedBox(height: 30),
                  // showActtionDialog()
                  Center(child: GameActionDialog()),
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
              top: !isSwipeUp ? size.height * 0.04 : size.height * 0.83,
              child: GestureDetector(
                onTap: () {
                  // if (!isSwipeUp) {
                  //   setState(() {
                  //     isSwipeUp = true;
                  //   });
                  // } else {
                  //   setState(() {
                  //     isSwipeUp = false;
                  //   });
                  // }
                },
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
                  onTopPressed: () {
                    debugPrint("wow");
                    if (!isSwipeUp) {
                      setState(() {
                        isSwipeUp = true;
                      });
                    } else {
                      setState(() {
                        isSwipeUp = false;
                      });
                    }
                  },
                  isSwipeUp: isSwipeUp,
                ),
              ),
            ),

            if (isLoading)
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Constants.grey100.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Constants.dark100,
                  ),
                ),
              )
          ],
        );
      })),
    );
  }
}

class LotteryAlert extends StatefulWidget {
  final Lottery luckyItem;
  final bool skipLottery;

  const LotteryAlert({
    super.key,
    required this.luckyItem,
    required this.skipLottery,
  });

  @override
  State<LotteryAlert> createState() => _LotteryAlertState();
}

class _LotteryAlertState extends State<LotteryAlert> {
  bool isLoading = false;
  final gameController = Get.find<GameController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: MCContainer(
        strokePadding: const EdgeInsets.all(3),
        gradient: (widget.luckyItem.price > 0)
            ? Constants.yellowGradient
            : Constants.purpleGreyGradient,
        width: 330,
        height: 330,
        child: Padding(
          padding: const EdgeInsets.only(top: 28, bottom: 12),
          child: Column(
            children: [
              Text(widget.luckyItem.title, style: Constants.titleTextStyle),
              const SizedBox(height: 6),
              Text(widget.luckyItem.description,
                  style: Constants.defaultTextStyle.copyWith(fontSize: 14)),
              const SizedBox(height: 10),
              SizedBox(
                  height: 70,
                  child: Image.asset(
                      gameController.luckyItemAssetString(widget.luckyItem))),
              const SizedBox(height: 4),
              Text("현금 ${widget.luckyItem.price.commaString}원",
                  style: Constants.titleTextStyle),
              const SizedBox(height: 6),
              Text(widget.luckyItem.guide,
                  style: Constants.defaultTextStyle.copyWith(fontSize: 14)),
              const SizedBox(height: 12),
              Bounceable(
                duration: const Duration(seconds: 1),
                onTap: isLoading
                    ? null
                    : () async {
                        setState(() {
                          isLoading = true;
                        });

                        if (!widget.skipLottery) {
                          await gameController.luckyDrawAction(
                              lotteryItem: widget.luckyItem);
                        }

                        setState(() {
                          isLoading = false;
                        });
                        Get.back();
                      },
                child: SizedBox(
                  width: 180,
                  height: 50,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset((widget.luckyItem.price > 0)
                          ? "assets/icons/button_long_yellow.png"
                          : "assets/icons/button_long_purple_grey.png"),
                      if (!isLoading)
                        Text(
                          "확인",
                          style:
                              Constants.defaultTextStyle.copyWith(fontSize: 20),
                        )
                      else
                        const Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          ),
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
  final String? assetPath;
  final Function()? onPressed;

  const ActionButton({
    super.key,
    required this.backgroundColor,
    required this.titleColor,
    this.assetPath,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 4),
                        child: Text(widget.title,
                            style: Constants.titleTextStyle
                                .copyWith(color: widget.titleColor)),
                      ),
                      if (widget.assetPath != null)
                        Expanded(
                          child: Image.asset(widget.assetPath!,
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

class ActionAlertDialog extends StatefulWidget {
  final String title;
  final String subTitle;
  final String actionTitle;
  final Color? primaryActionColor;
  final Future<void> Function()? onAction;

  const ActionAlertDialog({
    super.key,
    this.primaryActionColor = Constants.accentRed,
    required this.title,
    required this.subTitle,
    required this.actionTitle,
    this.onAction,
  });

  @override
  State<ActionAlertDialog> createState() => _ActionAlertDialogState();
}

class _ActionAlertDialogState extends State<ActionAlertDialog> {
  bool isLoading = false;
  int count = 1;
  int totalAmount = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: MCContainer(
        strokePadding: const EdgeInsets.all(8),
        gradient: Constants.grey01Gradient,
        width: 306,
        height: 256,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 24, bottom: 22, left: 30, right: 30),
          child: Column(
            children: [
              Text(widget.title,
                  style:
                      Constants.titleTextStyle.copyWith(color: Colors.black)),
              const SizedBox(height: 10),
              Text(widget.subTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Constants.defaultTextStyle
                      .copyWith(fontSize: 18, color: Colors.black)),
              // const SizedBox(height: 10),

              const Spacer(),
              SizedBox(
                height: 48,
                child: Row(
                  children: [
                    Expanded(
                      child: MCButton(
                          title: "취소",
                          fontSize: 20,
                          titleColor: Constants.grey03,
                          gradient: Constants.grey01Gradient,
                          shadows: const [Constants.buttonShadow],
                          onPressed: () {
                            Get.back();
                          }),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MCButton(
                        isLoading: isLoading,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 6),
                        fontSize: 20,
                        title: widget.actionTitle,
                        backgroundColor: widget.primaryActionColor,
                        shadows: const [Constants.buttonShadow],
                        onPressed: isLoading
                            ? null
                            : () async {
                                if (widget.onAction != null) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await widget.onAction!();
                                  Get.back();
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
