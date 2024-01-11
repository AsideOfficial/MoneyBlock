import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/controller/game_controller.dart';
import 'package:money_cycle/screen/play/components/game_item_card.dart';
import 'package:money_cycle/utils/extension/int.dart';

class MyAssetSheet extends StatefulWidget {
  const MyAssetSheet(
      {super.key, required this.isSwipeUp, required this.onTopPressed});

  final bool isSwipeUp;
  final Function() onTopPressed;

  @override
  State<MyAssetSheet> createState() => _MyAssetSheetState();
}

class _MyAssetSheetState extends State<MyAssetSheet> {
  @override
  Widget build(BuildContext context) {
    return GetX<GameController>(builder: (gameController) {
      Size size = MediaQuery.of(context).size;
      return Container(
          height: size.height * 2,
          width: size.width,
          decoration: const BoxDecoration(
              gradient: Constants.assetSheetGradient,
              // boxShadow: [
              //   BoxShadow(
              //     color: const Color(0x4C000000),
              //     blurRadius: widget.isSwipeUp ? 4 : 24,
              //     // offset: const Offset(3, 0),
              //     spreadRadius: widget.isSwipeUp ? 4 : 24,
              //   )
              // ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
                child: Column(
                  children: [
                    Stack(
                      // fit: StackFit.expand,
                      children: [
                        GestureDetector(
                          onTap: widget.onTopPressed,
                          child: Container(
                            color: Colors.transparent,
                            width: 1000,
                            height: 38,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "나의 자산현황",
                              style: Constants.largeTextStyle
                                  .copyWith(color: const Color(0xFF583590)),
                            ),
                            const Spacer(),
                            AssetBar(
                              assetType: AssetType.cash,
                              amount: gameController.totalCash ?? 0,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            AssetBar(
                              assetType: AssetType.saving,
                              amount: gameController.totalSaving ?? 0,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            AssetBar(
                              assetType: AssetType.loan,
                              amount: gameController.totalLoan ?? 0,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),

                    //MARK :- 보유 자산 현황
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: ShapeDecoration(
                            gradient: Constants.grey00BottomGradient,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 2, color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          width: 220,
                          height: 292,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 18, left: 16, right: 16, bottom: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("보유 자산",
                                    style: Constants.titleTextStyle
                                        .copyWith(color: Constants.black)),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text("돈으로 바꿀 수 있는 재산",
                                    style: Constants.largeTextStyle.copyWith(
                                        color: Constants.black, fontSize: 16)),
                                const Spacer(),
                                AssetListTile(
                                    title: "현금",
                                    price: gameController.totalCash),
                                const SizedBox(height: 10),
                                Container(
                                    height: 1, color: const Color(0xFFC5C5C5)),
                                const SizedBox(height: 10),
                                AssetListTile(
                                    title: "투자",
                                    price: gameController.totalInvestment),
                                const SizedBox(height: 10),
                                Container(
                                    height: 1, color: const Color(0xFFC5C5C5)),
                                const SizedBox(height: 10),
                                AssetListTile(
                                    title: "저축",
                                    price: gameController.totalSaving),
                                const SizedBox(height: 10),
                                Container(
                                    height: 1, color: const Color(0xFFC5C5C5)),
                                const SizedBox(height: 10),
                                AssetListTile(
                                    title: "대출",
                                    price: -(gameController.totalLoan ?? 0)),
                                const SizedBox(height: 10),
                                Container(
                                    height: 1, color: const Color(0xFFC5C5C5)),
                                const SizedBox(height: 10),
                                AssetListTile(
                                    title: "총",
                                    price: gameController.totalAsset),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 292,
                            decoration: ShapeDecoration(
                              gradient: Constants.grey00BottomGradient,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 2, color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
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
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 28),
                                        child: Row(
                                          children: [
                                            SavingCard(
                                                accentColor:
                                                    Constants.cardGreen,
                                                title: "예금",
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 6,
                                                          left: 8,
                                                          bottom: 0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Row(
                                                        children: [Spacer()],
                                                      ),
                                                      Text(
                                                        "예금잔고",
                                                        style: Constants
                                                            .defaultTextStyle
                                                            .copyWith(
                                                                fontSize: 12,
                                                                color: Constants
                                                                    .black),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        "${(gameController.totalShortSaving)?.commaString} 원",
                                                        style: Constants
                                                            .defaultTextStyle
                                                            .copyWith(
                                                                fontSize: 16,
                                                                color: Constants
                                                                    .black),
                                                      ),
                                                      const Row(
                                                        children: [Spacer()],
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        "예상이자 (턴마다)",
                                                        style: Constants
                                                            .defaultTextStyle
                                                            .copyWith(
                                                                fontSize: 12,
                                                                color: Constants
                                                                    .black),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        "${(gameController.totalShortSaving! * gameController.currentSavingRate.toInt() ~/ 100).commaString} 원",
                                                        style: Constants
                                                            .defaultTextStyle
                                                            .copyWith(
                                                                fontSize: 16,
                                                                color: Constants
                                                                    .black),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            const SizedBox(width: 10),
                                            SavingCard(
                                                accentColor:
                                                    Constants.cardGreen,
                                                title: "적금",
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 6,
                                                          left: 8,
                                                          bottom: 0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Row(
                                                        children: [Spacer()],
                                                      ),
                                                      Text(
                                                        "적금잔고",
                                                        style: Constants
                                                            .defaultTextStyle
                                                            .copyWith(
                                                                fontSize: 12,
                                                                color: Constants
                                                                    .black),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        "${gameController.totalLongSaving?.commaString} 원",
                                                        style: Constants
                                                            .defaultTextStyle
                                                            .copyWith(
                                                                fontSize: 16,
                                                                color: Constants
                                                                    .black),
                                                      ),
                                                      const Row(
                                                        children: [Spacer()],
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        "예상이자 (라운드 마다)",
                                                        style: Constants
                                                            .defaultTextStyle
                                                            .copyWith(
                                                                fontSize: 12,
                                                                color: Constants
                                                                    .black),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        "${(gameController.totalLongSaving! * (gameController.currentSavingRate.toInt() + 2) ~/ 100 * 3).commaString} 원",
                                                        style: Constants
                                                            .defaultTextStyle
                                                            .copyWith(
                                                                fontSize: 16,
                                                                color: Constants
                                                                    .black),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            const Spacer(),
                                          ],
                                        ),
                                      ),
                                      if (gameController
                                              .myInvestmentItems?.isNotEmpty ??
                                          false)
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
                                      if (gameController
                                              .myInvestmentItems?.isNotEmpty ??
                                          false)
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 28),
                                            child: GridView.builder(
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                      childAspectRatio:
                                                          110 / 136,
                                                      crossAxisCount: 4,
                                                      crossAxisSpacing: 10.0,
                                                      mainAxisSpacing: 20),
                                              shrinkWrap: true,
                                              itemCount: gameController
                                                      .myInvestmentItems
                                                      ?.length ??
                                                  0,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                final item = gameController
                                                    .myInvestmentItems?[index];
                                                return InvestItemCard(
                                                  accentColor:
                                                      Constants.cardRed,
                                                  count: item?.qty ?? 1,
                                                  title: item?.title ?? "",
                                                  child: SizedBox(
                                                    height: 70,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4),
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            // const Spacer(),
                                                            Text(
                                                              "평가금액",
                                                              style: Constants
                                                                  .defaultTextStyle
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12,
                                                                      color: Constants
                                                                          .black),
                                                            ),
                                                            const SizedBox(
                                                                height: 4),
                                                            Text(
                                                              "${gameController.getEstimatedPrice(purchasedPrice: item!.price, purchaseRoundIndex: item.purchaseRoundIndex!, currentRoundIndex: gameController.currentRoundIndex!).commaString} 원",
                                                              style: Constants
                                                                  .defaultTextStyle
                                                                  .copyWith(
                                                                      fontSize:
                                                                          14,
                                                                      color: Constants
                                                                          .black),
                                                            ),
                                                            const Row(
                                                              children: [
                                                                Spacer()
                                                              ],
                                                            ),
                                                            // const Spacer(),
                                                          ]),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      if (gameController
                                              .myExpendItems?.isNotEmpty ??
                                          false)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 28, left: 28, bottom: 20),
                                          child: Text(
                                            "지출",
                                            style: Constants.titleTextStyle
                                                .copyWith(
                                                    color: Constants.dark100),
                                          ),
                                        ),
                                      if (gameController
                                              .myExpendItems?.isNotEmpty ??
                                          false)
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 28),
                                            child: GridView.builder(
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                      childAspectRatio:
                                                          110 / 136,
                                                      crossAxisCount: 4,
                                                      crossAxisSpacing: 10.0,
                                                      mainAxisSpacing: 20),
                                              shrinkWrap: true,
                                              itemCount: gameController
                                                      .myExpendItems?.length ??
                                                  0,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                final item = gameController
                                                    .myExpendItems?[index];

                                                return GameItemCard(
                                                  accentColor:
                                                      Constants.cardBlue,
                                                  item: item,
                                                );
                                                // return GameItemCard(item: item);
                                              },
                                            ),
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
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 28),
                                        child: Row(
                                          children: [
                                            LoanItemCard(
                                                accentColor:
                                                    Constants.cardGreen,
                                                title: "신용대출",
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 6,
                                                          left: 8,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Row(
                                                        children: [Spacer()],
                                                      ),
                                                      Text(
                                                        "대출잔액",
                                                        style: Constants
                                                            .defaultTextStyle
                                                            .copyWith(
                                                                fontSize: 12,
                                                                color: Constants
                                                                    .black),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        "${(gameController.totalCreditLoan)?.commaString} 원",
                                                        style: Constants
                                                            .defaultTextStyle
                                                            .copyWith(
                                                                fontSize: 16,
                                                                color: Constants
                                                                    .black),
                                                      ),
                                                      const Row(
                                                        children: [Spacer()],
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            const SizedBox(width: 10),
                                            LoanItemCard(
                                                accentColor:
                                                    Constants.cardGreen,
                                                title: "담보대출",
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 6,
                                                          left: 8,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Row(
                                                        children: [Spacer()],
                                                      ),
                                                      Text(
                                                        "대출잔액",
                                                        style: Constants
                                                            .defaultTextStyle
                                                            .copyWith(
                                                                fontSize: 12,
                                                                color: Constants
                                                                    .black),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        "${(gameController.totalMortgagesLoan)?.commaString} 원",
                                                        style: Constants
                                                            .defaultTextStyle
                                                            .copyWith(
                                                                fontSize: 16,
                                                                color: Constants
                                                                    .black),
                                                      ),
                                                      const Row(
                                                        children: [Spacer()],
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            const Spacer(),
                                          ],
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

  String get title {
    switch (this) {
      case AssetType.cash:
        return "보유현금";
      case AssetType.saving:
        return "저축금액";
      case AssetType.loan:
        return "대출금액";
    }
  }

  String get description {
    switch (this) {
      case AssetType.cash:
        return "물건을 살 때 치르는 돈";
      case AssetType.saving:
        return "돈을 모으는 것";
      case AssetType.loan:
        return "돈을 빌리는 것";
    }
  }
}

class AssetBar extends StatelessWidget {
  final AssetType assetType;
  final int amount;
  const AssetBar({
    super.key,
    required this.assetType,
    required this.amount,
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
                  Text(amount.commaString,
                      style: Constants.defaultTextStyle
                          .copyWith(fontSize: 12)), // TODO - 자산 현황 연동
                  const SizedBox(width: 11)
                ],
              )),
        ),
        JustTheTooltip(
          content: SizedBox(
              height: 72,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      assetType.title,
                      style: Constants.largeTextStyle
                          .copyWith(color: Constants.dark100),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      assetType.description,
                      style: Constants.defaultTextStyle
                          .copyWith(color: Constants.dark100),
                    ),
                  ],
                ),
              )),
          fadeInDuration: const Duration(milliseconds: 300),
          fadeOutDuration: const Duration(microseconds: 500),
          showDuration: const Duration(seconds: 2),
          triggerMode: TooltipTriggerMode.tap,
          backgroundColor: const Color(0xFFF2F2F2),
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
                .copyWith(fontSize: 14, color: Constants.black)),
        const Spacer(),
        Text("${(price ?? 0).commaString}원",
            style: Constants.defaultTextStyle
                .copyWith(fontSize: 14, color: Constants.black))
      ],
    );
  }
}
