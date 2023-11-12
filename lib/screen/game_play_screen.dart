import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/route_manager.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/models/enums/game_action.dart';

class GamePlayScreen extends StatefulWidget {
  const GamePlayScreen({super.key});

  @override
  State<GamePlayScreen> createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen> {
  bool isSwipeUp = true;
  bool isMyTurn = true; // TODO - 데이터 연동 필요
  bool isActionChoicing = true;
  GameActionType currentActionType = GameActionType.saving;

  void onActionButtonTap(GameActionType action) {
    setState(() {
      currentActionType = action;
      isActionChoicing = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: Constants.mainGradient,
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
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(20)),
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
                  child: Container(
                    height: 60,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFFE6E7E8), Color(0xFFB6BCC2)],
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(20)),
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
                          style: Constants.defaultTextStyle
                              .copyWith(color: Constants.dark100, fontSize: 16),
                        )
                      ]),
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
                        onActionButtonTap(GameActionType.saving);
                      },
                    ),
                    ActionButton(
                      isMyTurn: isMyTurn,
                      title: "투자",
                      backgroundColor: Constants.cardRed,
                      titleColor: const Color(0xFF97010C),
                      assetPath: "assets/icons/investment.png",
                      onPressed: () {
                        onActionButtonTap(GameActionType.investment);
                      },
                    ),
                    ActionButton(
                      isMyTurn: isMyTurn,
                      title: "지출",
                      backgroundColor: Constants.cardBlue,
                      titleColor: const Color(0xFF002D9B),
                      assetPath: "assets/icons/expend.png",
                      onPressed: () {
                        onActionButtonTap(GameActionType.expend);
                      },
                    ),
                    ActionButton(
                      isMyTurn: isMyTurn,
                      title: "대출",
                      backgroundColor: Constants.cardOrange,
                      titleColor: const Color(0xFF913B0B),
                      assetPath: "assets/icons/loan.png",
                      onPressed: () {
                        setState(() => isActionChoicing = true);
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
                        setState(() => isActionChoicing = true);
                      },
                    ),
                    ActionButton(
                      isMyTurn: isMyTurn,
                      title: "무급휴가",
                      backgroundColor: Constants.cardGreenBlue,
                      titleColor: const Color(0xFF005349),
                      assetPath: "assets/icons/vacation.png",
                      onPressed: () {
                        setState(() => isActionChoicing = true);
                      },
                    ),
                    ActionButton(
                      isMyTurn: isMyTurn,
                      title: "랜덤게임",
                      backgroundColor: Constants.cardPink,
                      titleColor: const Color(0xFFA90054),
                      assetPath: "assets/icons/random_game.png",
                      onPressed: () {
                        setState(() => isActionChoicing = true);
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
        if (isActionChoicing)
          GestureDetector(
            child: Container(color: Colors.black.withOpacity(0.3)),
            onTap: () => setState(() => isActionChoicing = false),
          ),
        if (isActionChoicing)
          Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              showActtionDialog()
            ],
          ),
        AnimatedPositioned(
            curve: Curves.decelerate,
            duration: const Duration(milliseconds: 400),
            top: !isSwipeUp ? size.height * 0.06 : size.height * 0.76,
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
                child: CustomBottomSheet(
                  isSwipeUp: isSwipeUp,
                )))
      ],
    ));
  }

  Row showActtionDialog() {
    final model = currentActionType.actionData;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            MCContainer(
              borderRadius: 20,
              gradient: Constants.blueGradient,
              strokePadding: const EdgeInsets.all(5),
              width: 170,
              height: 250,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 34),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: model.actions.map((action) {
                    return ActionChoiceButton(
                      title: action.title,
                    );
                  }).toList(),
                ),
              ),
            ),
            Bounceable(
              scaleFactor: 0.8,
              onTap: () => setState(() => isActionChoicing = false),
              child: Image.asset(
                'assets/icons/back_button.png',
                width: 46.0,
                height: 46.0,
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        MCContainer(
          borderRadius: 20,
          gradient: Constants.blueGradient,
          strokePadding: const EdgeInsets.all(5),
          width: (currentActionType != GameActionType.expend) ? 340 : 530,
          height: 250,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 24, left: 30, right: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${model.title} 활동", style: Constants.titleTextStyle),
                const SizedBox(height: 18),
                Text(
                    "왼쪽의 ${model.actions.length}가지 ${model.title} 활동중 1가지를 고르세요.",
                    style: Constants.defaultTextStyle.copyWith(fontSize: 16)),
                const SizedBox(height: 16),
                Text("소비 : 소비는 이러이러한 것입니다.",
                    style: Constants.defaultTextStyle.copyWith(fontSize: 16)),
                const SizedBox(height: 10),
                Text("보험 : 소비는 이러이러한 것입니다.",
                    style: Constants.defaultTextStyle.copyWith(fontSize: 16)),
                const SizedBox(height: 10),
                Text("기부 : 소비는 이러이러한 것입니다.",
                    style: Constants.defaultTextStyle.copyWith(fontSize: 16)),
              ],
            ),
          ),
        ),
        if (currentActionType != GameActionType.expend)
          const SizedBox(width: 10),
        if (currentActionType != GameActionType.expend)
          MCContainer(
            borderRadius: 20,
            gradient: Constants.greyGradient,
            strokePadding: const EdgeInsets.all(5),
            width: 180,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 18, left: 16, right: 16, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("현재 금리",
                      style: Constants.titleTextStyle
                          .copyWith(color: Constants.dark100)),
                  const SizedBox(height: 18),
                  Text("현재 금리는\n이러이러합니다.",
                      style: Constants.defaultTextStyle
                          .copyWith(fontSize: 16, color: Constants.dark100)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text("기간 및 금액",
                          style: Constants.defaultTextStyle.copyWith(
                              fontSize: 10, color: Constants.dark100)),
                      const Spacer(),
                      Text("금리(연)",
                          style: Constants.defaultTextStyle
                              .copyWith(fontSize: 10, color: Constants.dark100))
                    ],
                  ),
                  const SizedBox(height: 6),
                  Container(height: 1, color: const Color(0xFFABABAB)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text("3개월이상~6개월미만",
                          style: Constants.defaultTextStyle.copyWith(
                              fontSize: 10, color: Constants.dark100)),
                      const Spacer(),
                      Text("2.0",
                          style: Constants.defaultTextStyle
                              .copyWith(fontSize: 10, color: Constants.dark100))
                    ],
                  ),
                  const SizedBox(height: 6),
                  Container(height: 1, color: const Color(0xFFABABAB)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text("6개월이상~1년미만",
                          style: Constants.defaultTextStyle.copyWith(
                              fontSize: 10, color: Constants.dark100)),
                      const Spacer(),
                      Text("2.5",
                          style: Constants.defaultTextStyle
                              .copyWith(fontSize: 10, color: Constants.dark100))
                    ],
                  ),
                  const SizedBox(height: 6),
                  Container(height: 1, color: const Color(0xFFABABAB)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text("1년이상~3년미만",
                          style: Constants.defaultTextStyle.copyWith(
                              fontSize: 10, color: Constants.dark100)),
                      const Spacer(),
                      Text("2.5",
                          style: Constants.defaultTextStyle
                              .copyWith(fontSize: 10, color: Constants.dark100))
                    ],
                  ),
                  const SizedBox(height: 6),
                  Container(height: 1, color: const Color(0xFFABABAB)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text("1년이상~3년미만",
                          style: Constants.defaultTextStyle.copyWith(
                              fontSize: 10, color: Constants.dark100)),
                      const Spacer(),
                      Text("2.5",
                          style: Constants.defaultTextStyle
                              .copyWith(fontSize: 10, color: Constants.dark100))
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class ActionChoiceButton extends StatelessWidget {
  final String title;
  const ActionChoiceButton({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      duration: const Duration(seconds: 1),
      onTap: () {},
      child: SizedBox(
        width: 100,
        height: 50,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset("assets/icons/blue_button.png"),
            Text(
              title,
              style: Constants.defaultTextStyle.copyWith(fontSize: 20),
            )
          ],
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

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({Key? key, required this.isSwipeUp})
      : super(key: key);

  final bool isSwipeUp;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 2,
        width: size.width,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0xFFFFEDE0), Color(0xFFE5C4A5)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0x4C000000),
                blurRadius: widget.isSwipeUp ? 4 : 24,
                // offset: const Offset(3, 0),
                spreadRadius: widget.isSwipeUp ? 4 : 24,
              )
            ],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: handle(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "나의 자산현황",
                        style: Constants.largeTextStyle
                            .copyWith(color: Constants.dark100),
                      ),
                      const Spacer(),
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: MCContainer(
                                strokePadding: const EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 2),
                                borderRadius: 10,
                                width: 200,
                                height: 44,
                                shadows: [Constants.defaultShadow],
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    Text("100,000,000원",
                                        style: Constants
                                            .defaultTextStyle), // TODO - 자산 현황 연동
                                    const SizedBox(width: 11)
                                  ],
                                )),
                          ),
                          SizedBox(
                              height: 56,
                              child: Image.asset("assets/icons/krw_coin.png")),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Container handle() {
    return Container(
      width: 60,
      height: 5,
      decoration: ShapeDecoration(
        color: const Color(0xFF696969),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
        ),
      ),
    );
  }
}
