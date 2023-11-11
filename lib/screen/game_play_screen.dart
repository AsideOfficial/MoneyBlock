import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_cycle/constants.dart';

class GamePlayScreen extends StatefulWidget {
  const GamePlayScreen({super.key});

  @override
  State<GamePlayScreen> createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen> {
  bool isMyTurn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(alignment: Alignment.center, children: [
      Container(
        decoration: BoxDecoration(
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
                    title: "저축",
                    backgroundColor: const Color(0xFF70C14A),
                    titleColor: const Color(0xFF1F6200),
                    assetPath: "assets/icons/saving.png",
                    onPressed: () {},
                  ),
                  ActionButton(
                    title: "투자",
                    backgroundColor: Constants.cardRed,
                    titleColor: const Color(0xFF97010C),
                    assetPath: "assets/icons/investment.png",
                    onPressed: () {},
                  ),
                  ActionButton(
                    title: "지출",
                    backgroundColor: Constants.cardBlue,
                    titleColor: const Color(0xFF002D9B),
                    assetPath: "assets/icons/expend.png",
                    onPressed: () {},
                  ),
                  ActionButton(
                    title: "대출",
                    backgroundColor: Constants.cardOrange,
                    titleColor: const Color(0xFF913B0B),
                    assetPath: "assets/icons/loan.png",
                    onPressed: () {},
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ActionButton(
                    title: "행운복권",
                    backgroundColor: Constants.cardYellow,
                    titleColor: const Color(0xFFB86300),
                    assetPath: "assets/icons/lottery.png",
                    onPressed: () {},
                  ),
                  ActionButton(
                    title: "무급휴가",
                    backgroundColor: Constants.cardGreenBlue,
                    titleColor: const Color(0xFF005349),
                    assetPath: "assets/icons/vacation.png",
                    onPressed: () {},
                  ),
                  ActionButton(
                    title: "랜덤게임",
                    backgroundColor: Constants.cardPink,
                    titleColor: const Color(0xFFA90054),
                    assetPath: "assets/icons/random_game.png",
                    onPressed: () {},
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
            color: Colors.white,
          )
        ],
      ),
    ]));
  }
}

class ActionButton extends StatelessWidget {
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
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          child: Container(
            width: 150,
            height: 90,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: backgroundColor,
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
                    child: Text(title,
                        style: Constants.titleTextStyle
                            .copyWith(color: titleColor)),
                  ),
                  Expanded(
                    child: Image.asset(assetPath, fit: BoxFit.fitHeight),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
