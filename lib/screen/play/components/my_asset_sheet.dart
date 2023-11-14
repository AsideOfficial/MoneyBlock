import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/controller/game_controller.dart';
import 'package:money_cycle/models/game_action.dart';
import 'package:money_cycle/screen/play/components/game_item_card.dart';

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
              gradient: Constants.purpleGradient,
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
                              .copyWith(color: Colors.white),
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
                          gradient: Constants.grey00Gradient,
                          strokePadding: const EdgeInsets.all(0.4),
                          width: 220,
                          height: 270,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 18, left: 16, right: 16, bottom: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("보유 자산",
                                    style: Constants.titleTextStyle
                                        .copyWith(color: Constants.dark100)),
                                const Spacer(),
                                const AssetListTile(
                                    title: "현금", price: 5000000),
                                const SizedBox(height: 10),
                                Container(
                                    height: 1, color: const Color(0xFFD9D9D9)),
                                const SizedBox(height: 10),
                                const AssetListTile(
                                    title: "투자", price: 2340000),
                                const SizedBox(height: 10),
                                Container(
                                    height: 1, color: const Color(0xFFD9D9D9)),
                                const SizedBox(height: 10),
                                const AssetListTile(
                                    title: "저축", price: 2400000),
                                const SizedBox(height: 10),
                                Container(
                                    height: 1, color: const Color(0xFFD9D9D9)),
                                const SizedBox(height: 10),
                                const AssetListTile(
                                    title: "대출", price: -3000000),
                                const SizedBox(height: 10),
                                Container(
                                    height: 1, color: const Color(0xFFD9D9D9)),
                                const SizedBox(height: 10),
                                const AssetListTile(
                                    title: "총", price: 1000000000),
                                const SizedBox(height: 10),
                                Container(
                                    height: 1, color: const Color(0xFFD9D9D9)),
                                const SizedBox(height: 6),
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
                                gradient: Constants.grey00Gradient),
                            child: SingleChildScrollView(
                              child: SizedBox(
                                height: 1000,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 28, left: 28, bottom: 20),
                                        child: Text(
                                          "저축",
                                          style: Constants.titleTextStyle
                                              .copyWith(
                                                  color: Constants.dark100),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 140,
                                        width: 600,
                                        child: ListView.builder(
                                          controller: ScrollController(
                                              initialScrollOffset: 58),
                                          shrinkWrap: true,
                                          itemCount: savingModel
                                              .actions[0].items.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return GameItemCard(
                                                accentColor: gameController
                                                    .currentCardColor,
                                                item: savingModel
                                                    .actions[0].items[index]);
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 28, left: 28, bottom: 20),
                                        child: Text(
                                          "투자",
                                          style: Constants.titleTextStyle
                                              .copyWith(
                                                  color: Constants.dark100),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 140,
                                        width: 600,
                                        child: ListView.builder(
                                          controller: ScrollController(
                                              initialScrollOffset: 58),
                                          shrinkWrap: true,
                                          itemCount: savingModel
                                              .actions[0].items.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return GameItemCard(
                                                accentColor: Constants.cardRed,
                                                item: investmentModel
                                                    .actions[1].items[index]);
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 28, left: 28, bottom: 20),
                                        child: Text(
                                          "대출",
                                          style: Constants.titleTextStyle
                                              .copyWith(
                                                  color: Constants.dark100),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 140,
                                        width: 600,
                                        child: ListView.builder(
                                          controller: ScrollController(
                                              initialScrollOffset: 58),
                                          shrinkWrap: true,
                                          itemCount: savingModel
                                              .actions[0].items.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return GameItemCard(
                                                accentColor:
                                                    Constants.cardOrange,
                                                item: loanModel
                                                    .actions[1].items[index]);
                                          },
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
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

class AssetListTile extends StatelessWidget {
  final String title;
  final int? price;

  const AssetListTile({
    super.key,
    required this.title,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,
            style: Constants.defaultTextStyle
                .copyWith(fontSize: 14, color: Constants.dark100)),
        const Spacer(),
        Text("${price ?? 0}원",
            style: Constants.defaultTextStyle
                .copyWith(fontSize: 14, color: Constants.dark100))
      ],
    );
  }
}
