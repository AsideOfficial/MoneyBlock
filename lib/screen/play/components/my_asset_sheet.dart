import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/controller/game_controller.dart';
import 'package:money_cycle/models/enums/game_action_type.dart';
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
                        const AssetBar(assetType: AssetType.cash),
                        const SizedBox(
                          width: 6,
                        ),
                        const AssetBar(assetType: AssetType.saving),
                        const SizedBox(
                          width: 6,
                        ),
                        const AssetBar(assetType: AssetType.loan),
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
                                              initialScrollOffset: 30),
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
                                              initialScrollOffset: 30),
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
                                              initialScrollOffset: 30),
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: handle(),
                  ),
                ],
              ),
            ],
          ));
    });
  }

  Container handle() {
    return Container(
      width: 30,
      height: 3,
      decoration: ShapeDecoration(
        color: const Color(0xFF482BC5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
        ),
      ),
    );
  }
}

enum AssetType { cash, saving, loan }

extension AssetTypeExtension on AssetType {
  LinearGradient get gradient {
    switch (this) {
      case AssetType.cash:
        return Constants.yellowGradient;
      case AssetType.saving:
        return Constants.greenGradient;
      case AssetType.loan:
        return Constants.orangeGradient;
    }
  }

  String get badgeAssetPath {
    switch (this) {
      case AssetType.cash:
        return "assets/icons/badge_cash.png";
      case AssetType.saving:
        return "assets/icons/badge_saving.png";
      case AssetType.loan:
        return "assets/icons/badge_loan.png";
    }
  }
}

class AssetBar extends StatelessWidget {
  final AssetType assetType;
  const AssetBar({
    super.key,
    required this.assetType,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: MCContainer(
              gradient: assetType.gradient,
              strokePadding:
                  const EdgeInsets.symmetric(horizontal: 0.5, vertical: 0.5),
              borderRadius: 10,
              width: 116,
              height: 30,
              shadows: [Constants.defaultShadow],
              child: Row(
                children: [
                  const Spacer(),
                  Text("3,000,000",
                      style: Constants.defaultTextStyle
                          .copyWith(fontSize: 12)), // TODO - 자산 현황 연동
                  const SizedBox(width: 11)
                ],
              )),
        ),
        Tooltip(
          preferBelow: false,
          message: "Hi",
          showDuration: const Duration(seconds: 3),
          triggerMode: TooltipTriggerMode.tap,
          child: SizedBox(
              height: 38, child: Image.asset(assetType.badgeAssetPath)),
        )
      ],
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
