import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/controller/game_controller.dart';

class MyAssetSheet extends StatefulWidget {
  const MyAssetSheet({Key? key, required this.isSwipeUp}) : super(key: key);

  final bool isSwipeUp;

  @override
  State<MyAssetSheet> createState() => _MyAssetSheetState();
}

class _MyAssetSheetState extends State<MyAssetSheet> {
  @override
  Widget build(BuildContext context) {
    return GetX<GameController>(builder: (gameController) {
      Size size = MediaQuery.of(context).size;
      final wow = gameController.currentActionType;
      return Container(
          height: size.height * 2,
          width: size.width,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [Color(0xFFE9E7FF), Color(0xFFB8B5D4)],
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
                                child:
                                    Image.asset("assets/icons/krw_coin.png")),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),

                    //MARK :- 보유 자산 현황
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MCContainer(
                          borderRadius: 20,
                          gradient: Constants.greyGradient,
                          strokePadding: const EdgeInsets.all(5),
                          width: 220,
                          height: 270,
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
                                    style: Constants.defaultTextStyle.copyWith(
                                        fontSize: 16,
                                        color: Constants.dark100)),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Text("기간 및 금액",
                                        style: Constants.defaultTextStyle
                                            .copyWith(
                                                fontSize: 10,
                                                color: Constants.dark100)),
                                    const Spacer(),
                                    Text("금리(연)",
                                        style: Constants.defaultTextStyle
                                            .copyWith(
                                                fontSize: 10,
                                                color: Constants.dark100))
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Container(
                                    height: 1, color: const Color(0xFFABABAB)),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Text("3개월이상~6개월미만",
                                        style: Constants.defaultTextStyle
                                            .copyWith(
                                                fontSize: 10,
                                                color: Constants.dark100)),
                                    const Spacer(),
                                    Text("2.0",
                                        style: Constants.defaultTextStyle
                                            .copyWith(
                                                fontSize: 10,
                                                color: Constants.dark100))
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Container(
                                    height: 1, color: const Color(0xFFABABAB)),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Text("6개월이상~1년미만",
                                        style: Constants.defaultTextStyle
                                            .copyWith(
                                                fontSize: 10,
                                                color: Constants.dark100)),
                                    const Spacer(),
                                    Text("2.5",
                                        style: Constants.defaultTextStyle
                                            .copyWith(
                                                fontSize: 10,
                                                color: Constants.dark100))
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Container(
                                    height: 1, color: const Color(0xFFABABAB)),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Text("1년이상~3년미만",
                                        style: Constants.defaultTextStyle
                                            .copyWith(
                                                fontSize: 10,
                                                color: Constants.dark100)),
                                    const Spacer(),
                                    Text("2.5",
                                        style: Constants.defaultTextStyle
                                            .copyWith(
                                                fontSize: 10,
                                                color: Constants.dark100))
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Container(
                                    height: 1, color: const Color(0xFFABABAB)),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Text("1년이상~3년미만",
                                        style: Constants.defaultTextStyle
                                            .copyWith(
                                                fontSize: 10,
                                                color: Constants.dark100)),
                                    const Spacer(),
                                    Text("2.5",
                                        style: Constants.defaultTextStyle
                                            .copyWith(
                                                fontSize: 10,
                                                color: Constants.dark100))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: Constants.greyGradient),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 28, left: 28, bottom: 20),
                                    child: Text(
                                      "저축",
                                      style: Constants.titleTextStyle
                                          .copyWith(color: Constants.dark100),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 400,
                                      width: 600,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: 3,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10, top: 1, bottom: 1),
                                              child: Container(
                                                  clipBehavior: Clip.antiAlias,
                                                  width: 110,
                                                  height: 148,
                                                  decoration: ShapeDecoration(
                                                    color: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: const BorderSide(
                                                          width: 1,
                                                          color: Colors.white,
                                                          strokeAlign: BorderSide
                                                              .strokeAlignOutside),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    shadows: const [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x4C000000),
                                                        blurRadius: 6,
                                                        offset: Offset(3, 3),
                                                        spreadRadius: 1,
                                                      )
                                                    ],
                                                  ),
                                                  child: Column(children: [
                                                    Container(
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                          color: gameController
                                                              .currentCardColor),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .bottomLeft,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            "테스트",
                                                            style: Constants
                                                                .defaultTextStyle
                                                                .copyWith(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: 74,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 6,
                                                                  horizontal:
                                                                      8),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "100000원",
                                                                style: Constants
                                                                    .defaultTextStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            16,
                                                                        color: Constants
                                                                            .dark100),
                                                              ),
                                                              const SizedBox(
                                                                height: 4,
                                                              ),
                                                              Text(
                                                                "테스트 설명 설명",
                                                                style: Constants
                                                                    .defaultTextStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            10,
                                                                        color: Constants
                                                                            .dark100),
                                                              ),
                                                            ],
                                                          ),
                                                        ))
                                                  ])));
                                        },
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        )
                      ],
                    ),

                    //MARK: - 자산 보유 아이템 창
                  ],
                ),
              )
            ],
          ));
    });
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
