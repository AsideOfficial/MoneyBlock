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
                        "라운드1 '${isMyTurn ? "나" : "닉네임"}'의 턴", // TODO 현재 턴인 사용자의 닉네임 연동
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
          )
        ],
      ),
    ]));
  }
}
