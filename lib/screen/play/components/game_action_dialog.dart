import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/models/enums/game_action_type.dart';
import 'package:money_cycle/controller/game_controller.dart';
import 'package:money_cycle/screen/play/components/action_choice_button.dart';
import 'package:money_cycle/screen/play/components/cash_alert_dialog.dart';
import 'package:money_cycle/screen/play/components/game_item_card.dart';
import 'package:money_cycle/screen/play/components/purchase_alert_dialog.dart';
import 'package:money_cycle/utils/extension/int.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
// import 'package:money_cycle/screen/game_play_screen.dart';

class GameActionDialog extends StatefulWidget {
  const GameActionDialog({super.key});

  @override
  State<GameActionDialog> createState() => _GameActionDialogState();
}

class _GameActionDialogState extends State<GameActionDialog> {
  final gameController = Get.find<GameController>();
  double cash = 1000000;
  double currentAmount = 0;
  double currentCreditLoanAmount = 0;
  double currentMortagagesLoanAmount = 0;
  double currentCreditLoanPaybackAmount = 0;
  double currentMortgagesLoanPaybackAmount = 0;
  double height = 280;
  bool isCreditLoan = false;

  Future<void> showCashAlert() async {
    Future.delayed(const Duration(milliseconds: 200));
    Get.dialog(CashAlertDialog(
      actionTitle: "대출받기",
      primaryActionColor: Constants.cardOrange,
      children: [
        Text("현금 부족",
            style: Constants.titleTextStyle.copyWith(color: Colors.black)),
        const SizedBox(height: 10),
        Text("추천 활동 : 대출 받기",
            style: Constants.defaultTextStyle
                .copyWith(fontSize: 18, color: Colors.black)),
        const SizedBox(height: 10),
        Text("구매를 위해\n현금을 확보해야합니다.",
            textAlign: TextAlign.center,
            style: Constants.defaultTextStyle
                .copyWith(fontSize: 18, color: Colors.black)),
      ],
      onAction: () {
        Get.back();
        gameController.actionButtonTap(GameActionType.loan);
      },
    ));
  }

  //MARK: - 플레이어 개인 활동 선택 화면
  List<Widget> actionChoiceContainer(
      GameActionType actionType, GameController gameController) {
    switch (actionType) {
      case GameActionType.expend:
        return [
          MCContainer(
            borderRadius: 20,
            gradient: gameController.currentBackgroundGradient,
            strokePadding: const EdgeInsets.all(5),
            width: 530,
            height: height,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 24, left: 30, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(gameController.curretnSpecificActionModel?.title ?? "",
                      style: Constants.titleTextStyle),
                  const SizedBox(height: 6),
                  Text(
                      "어떤 ${gameController.curretnSpecificActionModel?.title}를 하시겠습니까?",
                      style: Constants.defaultTextStyle.copyWith(fontSize: 16)),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 140,
                    width: 600,
                    child: ListView.builder(
                        controller: ScrollController(initialScrollOffset: 58),
                        scrollDirection: Axis.horizontal,
                        key: UniqueKey(),
                        itemCount: gameController
                            .curretnSpecificActionModel?.items.length,
                        // itemExtent: 120,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final item = gameController
                              .curretnSpecificActionModel?.items[index];
                          if (item == null) return const SizedBox();
                          return Bounceable(
                            onTap: () {
                              Get.dialog(PurchaseAlertDialog(
                                title: "구입",
                                subTitle: item.title,
                                perPrice: item.price,
                                actionTitle: "구입",
                                onPurchase: (count) async {
                                  if (gameController.totalCash! <
                                      (item.price * count)) {
                                    Get.back();
                                    await showCashAlert();
                                    return;
                                  }
                                  switch (gameController
                                      .curretnSpecificActionModel!.title) {
                                    case "소비":
                                      //TODO - 소비 액션 작업중 🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧
                                      await gameController.consumeAction(
                                        gameContentItem: item,
                                      );
                                    case "보험":
                                      await gameController.insuranceAction(
                                        title: item.title,
                                        price: item.price,
                                        description: item.description,
                                      );

                                    case "기부":
                                      {}
                                  }

                                  gameController.isActionChoicing = false;
                                  Get.back();
                                },
                              ));
                            },
                            child: GameItemCard(
                              item: item,
                              accentColor: gameController.currentCardColor,
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ];
      case GameActionType.investment:
        return [
          MCContainer(
            borderRadius: 20,
            gradient: gameController.currentBackgroundGradient,
            strokePadding: const EdgeInsets.all(5),
            width: 530,
            height: height,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 24, left: 30, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(gameController.curretnSpecificActionModel?.title ?? "",
                      style: Constants.titleTextStyle),
                  const SizedBox(height: 6),
                  Text(
                      "어떤 ${gameController.curretnSpecificActionModel?.title}를 하시겠습니까?",
                      style: Constants.defaultTextStyle.copyWith(fontSize: 16)),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 140,
                    width: 600,
                    child: ListView.builder(
                        controller: ScrollController(initialScrollOffset: 58),
                        scrollDirection: Axis.horizontal,
                        key: UniqueKey(),
                        itemCount: gameController
                            .curretnSpecificActionModel?.items.length,
                        // itemExtent: 120,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final item = gameController
                              .curretnSpecificActionModel?.items[index];
                          final evaluatedPrice = (item!.price *
                                  gameController.currentTotalInvestmentRate)
                              .toInt();
                          return Bounceable(
                              onTap: () {
                                Get.dialog(PurchaseAlertDialog(
                                  isMultiple: (gameController
                                              .curretnSpecificActionModel
                                              ?.title ==
                                          "부동산")
                                      ? false
                                      : true,
                                  title:
                                      "${gameController.curretnSpecificActionModel?.title} 매수",
                                  subTitle: item.title,
                                  perPrice: evaluatedPrice,
                                  actionTitle: "매수",
                                  onPurchase: (count) async {
                                    if (gameController.totalCash! <
                                        (item.price * count)) {
                                      Get.back();
                                      await showCashAlert();
                                      return;
                                    }

                                    await gameController.investAction(
                                        title: item.title,
                                        price: item.price,
                                        evealuatedPrice: (item.price *
                                                gameController
                                                    .currentTotalInvestmentRate)
                                            .toInt(),
                                        qty: count);

                                    gameController.isActionChoicing = false;
                                    Get.back();
                                  },
                                ));
                              },
                              child: GameItemCard(
                                item: item,
                                evaluatedPrice: evaluatedPrice,
                                priceTitle: gameController
                                        .curretnSpecificActionModel
                                        ?.priceTitle ??
                                    "",
                                accentColor: gameController.currentCardColor,
                              ));
                        }),
                  ),
                ],
              ),
            ),
          ),
        ];
      case GameActionType.loan:
        //TODO 대출 실행
        if (gameController.curretnSpecificActionModel?.title == "대출") {
          return [
            MCContainer(
              borderRadius: 20,
              gradient: gameController.currentBackgroundGradient,
              strokePadding: const EdgeInsets.all(5),
              width: 530,
              height: height,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 24, left: 18, right: 10, bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                  gameController
                                          .curretnSpecificActionModel?.title ??
                                      "",
                                  style: Constants.titleTextStyle),
                              const SizedBox(width: 12),
                              Text(
                                  "금리: ${isCreditLoan ? gameController.currentLoanRate : gameController.currentLoanRate - 1}%",
                                  style: Constants.defaultTextStyle
                                      .copyWith(fontSize: 18)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 230,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        singleChoiceButton(
                                            title: "신용 대출",
                                            isSelected: isCreditLoan,
                                            onPressed: () {
                                              setState(() {
                                                isCreditLoan = true;
                                              });
                                            }),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        singleChoiceButton(
                                            title: "담보 대출",
                                            isSelected: !isCreditLoan,
                                            onPressed: () {
                                              setState(() {
                                                isCreditLoan = false;
                                              });
                                            }),
                                      ],
                                    ),
                                    Text(isCreditLoan ? "보유현금" : "자산가치",
                                        style: Constants.defaultTextStyle
                                            .copyWith(fontSize: 16)),
                                    const SizedBox(height: 4),
                                    amountTile(
                                        amount: isCreditLoan
                                            ? gameController.totalCash!
                                                .toDouble()
                                            : gameController
                                                .mortgageLoanAvailableAmount
                                                .toDouble()),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 22),
                              if ((isCreditLoan &&
                                      gameController.totalCash! > 0) ||
                                  (!isCreditLoan &&
                                      gameController
                                              .mortgageLoanAvailableAmount >
                                          0))
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 170,
                                      child: Column(
                                        // crossAxisAlignment:
                                        //     CrossAxisAlignment.start,
                                        children: [
                                          if ((isCreditLoan &&
                                                  (gameController.totalCash! /
                                                          2 <
                                                      gameController
                                                              .totalCash! *
                                                          2)) ||
                                              (!isCreditLoan &&
                                                  (gameController
                                                          .mortgageLoanAvailableAmount !=
                                                      0)))
                                            SizedBox(
                                              width: 170,
                                              child: SfSliderTheme(
                                                data: SfSliderThemeData(
                                                  overlayRadius: 18,
                                                  activeTrackHeight: 3,
                                                  inactiveTrackHeight: 3,
                                                  trackCornerRadius: 2,
                                                  activeTrackColor: Colors.white
                                                      .withOpacity(0.8),
                                                  inactiveTrackColor:
                                                      const Color(0xFF8A3200),
                                                ),
                                                child: SfSlider(
                                                  value: isCreditLoan
                                                      ? currentCreditLoanAmount
                                                      : currentMortagagesLoanAmount,
                                                  min: isCreditLoan
                                                      ? gameController
                                                              .totalCash! /
                                                          2
                                                      : gameController
                                                              .mortgageLoanAvailableAmount *
                                                          0.1,
                                                  max: isCreditLoan
                                                      ? gameController
                                                              .totalCash! *
                                                          2
                                                      : gameController
                                                              .mortgageLoanAvailableAmount *
                                                          0.9,
                                                  stepSize: 10000,
                                                  enableTooltip: false,
                                                  showLabels: false,
                                                  showTicks: false,
                                                  thumbIcon: Container(
                                                    width: 18,
                                                    height: 18,
                                                    decoration:
                                                        const ShapeDecoration(
                                                      gradient: Constants
                                                          .orangeGradient,
                                                      shape: OvalBorder(
                                                        side: BorderSide(
                                                            width: 0.5,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      shadows: [
                                                        BoxShadow(
                                                          color:
                                                              Color(0x3F000000),
                                                          blurRadius: 1,
                                                          offset: Offset(0, 1),
                                                          spreadRadius: 0,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      if (isCreditLoan) {
                                                        currentCreditLoanAmount =
                                                            value;
                                                      } else {
                                                        currentMortagagesLoanAmount =
                                                            value;
                                                      }
                                                    });

                                                    debugPrint(
                                                        value.toString());
                                                  },
                                                ),
                                              ),
                                            ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Row(
                                              children: [
                                                Text(
                                                    isCreditLoan
                                                        ? "0.5배"
                                                        : "10%",
                                                    style: Constants
                                                        .defaultTextStyle
                                                        .copyWith(
                                                            fontSize: 10)),
                                                const Spacer(),
                                                Text(
                                                    isCreditLoan ? "2배" : "90%",
                                                    style: Constants
                                                        .defaultTextStyle
                                                        .copyWith(
                                                            fontSize: 10)),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    if (isCreditLoan)
                                      Text(
                                          "${((currentCreditLoanAmount / gameController.totalCash!).toStringAsFixed(1))}배",
                                          style: Constants.defaultTextStyle
                                              .copyWith(fontSize: 18))
                                    else
                                      Text(
                                          "${((currentMortagagesLoanAmount / gameController.mortgageLoanAvailableAmount * 100).toStringAsFixed(1))}%",
                                          style: Constants.defaultTextStyle
                                              .copyWith(fontSize: 18)),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          width: 1,
                          height: 150,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 26),
                        //MARK: - 대출 실행
                        SizedBox(
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Text("대출금액",
                                          style: Constants.defaultTextStyle),
                                      const SizedBox(width: 8),
                                      amountTile(
                                          amount: isCreditLoan
                                              ? currentCreditLoanAmount
                                              : currentMortagagesLoanAmount,
                                          width: 100),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              Bounceable(
                                  onTap: () {
                                    Get.dialog(PurchaseAlertDialog(
                                      title:
                                          "${gameController.curretnSpecificActionModel?.title}",
                                      subTitle:
                                          "${gameController.curretnSpecificActionModel?.title} 하시겠습니까?",
                                      perPrice: isCreditLoan
                                          ? currentCreditLoanAmount.toInt()
                                          : currentMortagagesLoanAmount.toInt(),
                                      actionTitle: "대출하기",
                                      primaryActionColor: Constants.cardOrange,
                                      onPurchase: (count) async {
                                        //TODO - API - 대출 실행 금액 = currentAmount
                                        final item = gameController
                                            .curretnSpecificActionModel;
                                        if (item == null) return;
                                        if (item.title == "대출") {
                                          // TODO - 대출 액션
                                          if (isCreditLoan) {
                                            if (gameController.totalCash! < 0) {
                                              return;
                                            }
                                            debugPrint("신용 대출 실행");
                                            await gameController
                                                .creditLoanAction(
                                              title: item.title,
                                              price: currentCreditLoanAmount
                                                  .toInt(),
                                            );
                                          } else {
                                            debugPrint("담보 대출 실행");
                                            if (gameController.totalAsset! <
                                                0) {
                                              return;
                                            }

                                            await gameController
                                                .mortgagesLoanAction(
                                              title: item.title,
                                              price: currentMortagagesLoanAmount
                                                  .toInt(),
                                            );
                                            Get.back();
                                          }
                                        }

                                        gameController.isActionChoicing = false;
                                      },
                                    ));
                                  },
                                  child: SizedBox(
                                    width: 184,
                                    height: 50,
                                    child: Stack(
                                      children: [
                                        Image.asset(
                                            "assets/icons/button_long_orange.png"),
                                        Center(
                                          child: Text("대출하기",
                                              style: Constants.largeTextStyle),
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ];
        } else {
          //TODO 대출 상환
          return [
            MCContainer(
              borderRadius: 20,
              gradient: gameController.currentBackgroundGradient,
              strokePadding: const EdgeInsets.all(5),
              width: 530,
              height: height,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 24, left: 30, right: 10, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            gameController.curretnSpecificActionModel?.title ??
                                "",
                            style: Constants.titleTextStyle),
                        const SizedBox(width: 12),
                        Text(
                            "금리: ${isCreditLoan ? gameController.currentLoanRate : gameController.currentLoanRate - 1}%",
                            style: Constants.defaultTextStyle
                                .copyWith(fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 230,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  singleChoiceButton(
                                      title: "신용 상환",
                                      isSelected: isCreditLoan,
                                      onPressed: () {
                                        setState(() {
                                          isCreditLoan = true;
                                        });
                                      }),
                                  const SizedBox(width: 12),
                                  singleChoiceButton(
                                      title: "담보 상환",
                                      isSelected: !isCreditLoan,
                                      onPressed: () {
                                        setState(() {
                                          isCreditLoan = false;
                                        });
                                      }),
                                ],
                              ),
                              Text("대출총액",
                                  style: Constants.defaultTextStyle
                                      .copyWith(fontSize: 16)),
                              const SizedBox(height: 4),
                              amountTile(
                                  amount: isCreditLoan
                                      ? gameController.totalCreditLoan!
                                          .toDouble()
                                      : gameController.totalMortgagesLoan!
                                          .toDouble()),
                              const SizedBox(height: 6),
                              if ((isCreditLoan &&
                                      gameController.totalCreditLoan! > 0) ||
                                  (!isCreditLoan &&
                                      gameController.totalMortgagesLoan! > 0))
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 170,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          if ((isCreditLoan &&
                                                  (gameController
                                                              .totalCreditLoan ??
                                                          0) !=
                                                      0) ||
                                              (!isCreditLoan &&
                                                  (gameController
                                                              .totalMortgagesLoan ??
                                                          0) !=
                                                      0))
                                            Text("상환금액 정도",
                                                style: Constants
                                                    .defaultTextStyle
                                                    .copyWith(fontSize: 16)),
                                          if ((isCreditLoan &&
                                                  (gameController
                                                              .totalCreditLoan ??
                                                          0) >
                                                      0) ||
                                              (!isCreditLoan &&
                                                  (gameController
                                                              .totalMortgagesLoan ??
                                                          0) >
                                                      0))
                                            SfSliderTheme(
                                              data: SfSliderThemeData(
                                                overlayRadius: 12,
                                                activeTrackHeight: 3,
                                                inactiveTrackHeight: 3,
                                                trackCornerRadius: 2,
                                                activeTrackColor: Colors.white
                                                    .withOpacity(0.8),
                                                inactiveTrackColor:
                                                    const Color(0xFF8A3200),
                                              ),
                                              child: SfSlider(
                                                value: isCreditLoan
                                                    ? currentCreditLoanPaybackAmount
                                                    : currentMortgagesLoanPaybackAmount,
                                                min: 0,
                                                max: isCreditLoan
                                                    ? gameController
                                                        .totalCreditLoan!
                                                    : gameController
                                                        .totalMortgagesLoan!,
                                                stepSize: 10000,
                                                enableTooltip: false,
                                                showLabels: false,
                                                showTicks: false,
                                                thumbIcon: Container(
                                                  width: 18,
                                                  height: 18,
                                                  decoration:
                                                      const ShapeDecoration(
                                                    gradient: Constants
                                                        .orangeGradient,
                                                    shape: OvalBorder(
                                                      side: BorderSide(
                                                          width: 0.5,
                                                          color: Colors.white),
                                                    ),
                                                    shadows: [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x3F000000),
                                                        blurRadius: 1,
                                                        offset: Offset(0, 1),
                                                        spreadRadius: 0,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (isCreditLoan) {
                                                      currentCreditLoanPaybackAmount =
                                                          value;
                                                    } else {
                                                      currentMortgagesLoanPaybackAmount =
                                                          value;
                                                    }
                                                  });

                                                  debugPrint(value.toString());
                                                },
                                              ),
                                            ),
                                          Row(
                                            children: [
                                              Text("0%",
                                                  style: Constants
                                                      .defaultTextStyle
                                                      .copyWith(fontSize: 10)),
                                              const Spacer(),
                                              Text("100%",
                                                  style: Constants
                                                      .defaultTextStyle
                                                      .copyWith(fontSize: 10)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Text(
                                        "${(((isCreditLoan ? currentCreditLoanPaybackAmount : currentMortgagesLoanPaybackAmount) / (isCreditLoan ? gameController.totalCreditLoan! : gameController.totalMortgagesLoan!) * 100).toStringAsFixed(1))}%",
                                        style: Constants.defaultTextStyle
                                            .copyWith(fontSize: 18)),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          width: 1,
                          height: 150,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 26),
                        SizedBox(
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("상환금액",
                                      style: Constants.defaultTextStyle),
                                  const SizedBox(height: 2),
                                  amountTile(
                                      amount: isCreditLoan
                                          ? currentCreditLoanPaybackAmount
                                          : currentMortgagesLoanPaybackAmount,
                                      width: 156),
                                ],
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              if ((isCreditLoan &&
                                      gameController.totalCreditLoan! > 0) ||
                                  (!isCreditLoan &&
                                      gameController.totalMortgagesLoan! > 0))
                                Bounceable(
                                    onTap: () {
                                      Get.dialog(PurchaseAlertDialog(
                                        title:
                                            "${gameController.curretnSpecificActionModel?.title}",
                                        subTitle:
                                            "${gameController.curretnSpecificActionModel?.title} 하시겠습니까?",
                                        perPrice: isCreditLoan
                                            ? currentCreditLoanPaybackAmount
                                                .toInt()
                                            : currentMortgagesLoanPaybackAmount
                                                .toInt(),
                                        actionTitle: "상환하기",
                                        primaryActionColor:
                                            Constants.cardOrange,
                                        onPurchase: (count) async {
                                          //TODO - API - 대출 실행 금액 = currentAmount
                                          final item = gameController
                                              .curretnSpecificActionModel;
                                          if (item == null) return;

                                          // TODO - 상환 액션
                                          if (isCreditLoan) {
                                            if (gameController.totalCash! <
                                                currentCreditLoanPaybackAmount
                                                    .toInt()) return;
                                            debugPrint("신용 대출 상환");
                                            await gameController
                                                .creditLoanPaybackAction(
                                              title: item.title,
                                              price:
                                                  currentCreditLoanPaybackAmount
                                                      .toInt(),
                                            );
                                          } else {
                                            if (gameController.totalCash! <
                                                currentMortgagesLoanPaybackAmount
                                                    .toInt()) return;
                                            debugPrint("담보 대출 상환");
                                            await gameController
                                                .mortgagesLoanPaybackAction(
                                              title: item.title,
                                              price:
                                                  currentMortgagesLoanPaybackAmount
                                                      .toInt(),
                                            );
                                          }

                                          // TODO - 상환 액션

                                          gameController.isActionChoicing =
                                              false;
                                          Get.back();
                                        },
                                      ));
                                    },
                                    child: SizedBox(
                                      width: 184,
                                      height: 50,
                                      child: Stack(
                                        children: [
                                          Image.asset(
                                              "assets/icons/button_long_orange.png"),
                                          Center(
                                            child: Text("상환하기",
                                                style:
                                                    Constants.largeTextStyle),
                                          )
                                        ],
                                      ),
                                    ))
                              else
                                SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      "상환 가능한 대출이 없습니다.",
                                      style: Constants.defaultTextStyle,
                                    ),
                                  ),
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ];
        }
      case GameActionType.saving:
        return [
          //MARK: - 저축 활동
          MCContainer(
            borderRadius: 20,
            gradient: gameController.currentBackgroundGradient,
            strokePadding: const EdgeInsets.all(5),
            width: 530,
            height: height,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 24, left: 30, right: 10, bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                          gameController.curretnSpecificActionModel?.title ??
                              "",
                          style: Constants.titleTextStyle),
                      const SizedBox(width: 12),
                      // TODO - API - 금리 연동
                      Text(
                          "금리: ${gameController.curretnSpecificActionModel?.title == "예금" ? "${gameController.currentSavingRate}%" : "${gameController.currentSavingRate + 2}%"}",
                          style: Constants.defaultTextStyle
                              .copyWith(fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 230,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("보유현금",
                                style: Constants.defaultTextStyle
                                    .copyWith(fontSize: 16)),
                            const SizedBox(height: 4),
                            amountTile(
                                amount: gameController.totalCash!.toDouble()),
                            const SizedBox(height: 10),
                            Text(
                                "${gameController.curretnSpecificActionModel?.title}금액",
                                style: Constants.defaultTextStyle
                                    .copyWith(fontSize: 16)),
                            const SizedBox(height: 4),
                            amountTile(amount: currentAmount),
                            Row(
                              children: [
                                SizedBox(
                                  width: 180,
                                  child: Column(
                                    children: [
                                      if (gameController.totalCash! > 0)
                                        SfSliderTheme(
                                          data: SfSliderThemeData(
                                            activeTrackHeight: 3,
                                            inactiveTrackHeight: 3,
                                            trackCornerRadius: 2,
                                            activeTrackColor:
                                                Colors.white.withOpacity(0.8),
                                            inactiveTrackColor:
                                                const Color(0xFF257300),
                                          ),
                                          child: SfSlider(
                                            value: currentAmount,
                                            min: 0,
                                            max: gameController.totalCash,
                                            stepSize: 10000,
                                            enableTooltip: false,
                                            showLabels: false,
                                            showTicks: false,
                                            thumbIcon: Container(
                                              width: 18,
                                              height: 18,
                                              decoration: const ShapeDecoration(
                                                gradient:
                                                    Constants.greenGradient,
                                                shape: OvalBorder(
                                                  side: BorderSide(
                                                      width: 0.5,
                                                      color: Colors.white),
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
                                            onChanged: (value) {
                                              setState(() {
                                                currentAmount = value;
                                              });

                                              debugPrint(value.toString());
                                            },
                                          ),
                                        ),
                                      Row(
                                        children: [
                                          Text("0%",
                                              style: Constants.defaultTextStyle
                                                  .copyWith(fontSize: 10)),
                                          const Spacer(),
                                          Text("100%",
                                              style: Constants.defaultTextStyle
                                                  .copyWith(fontSize: 10)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                    "${((currentAmount / gameController.totalCash!) * 100).toInt()}%",
                                    style: Constants.defaultTextStyle
                                        .copyWith(fontSize: 18)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        width: 1,
                        height: 150,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 26),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (gameController
                                  .curretnSpecificActionModel?.title ==
                              "적금")
                            SizedBox(
                              width: 190,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text("턴당 이자",
                                          style: Constants.defaultTextStyle),
                                      const Spacer(),
                                      amountTile(
                                          amount: currentAmount *
                                              (gameController
                                                      .currentSavingRate +
                                                  2) /
                                              100,
                                          width: 100),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("총 이자",
                                          style: Constants.defaultTextStyle),
                                      amountTile(
                                          amount: currentAmount *
                                              (gameController
                                                      .currentSavingRate +
                                                  2) /
                                              100 *
                                              3,
                                          width: 100),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  const Text(
                                    "※다음 라운드에 주어지는 이자입니다.",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ],
                              ),
                            )
                          else
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("예상 이자",
                                        style: Constants.defaultTextStyle),
                                    const SizedBox(width: 8),
                                    amountTile(
                                        amount: currentAmount *
                                            (gameController.currentSavingRate) /
                                            100,
                                        width: 100),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  "※다음 턴에 주어지는 이자입니다.",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                          const SizedBox(height: 32),
                          Bounceable(
                              onTap: () {
                                Get.dialog(PurchaseAlertDialog(
                                  title: gameController
                                          .curretnSpecificActionModel?.title ??
                                      "",
                                  subTitle:
                                      "${gameController.curretnSpecificActionModel?.title} 하시겠습니까?",
                                  perPrice: currentAmount.toInt(),
                                  primaryActionColor: Constants.cardGreen,
                                  actionTitle:
                                      "${gameController.curretnSpecificActionModel?.title}하기",
                                  onPurchase: (count) async {
                                    // TODO - 예금, 적금 API 연동 필요 금액 = currentAmout
                                    final item = gameController
                                        .curretnSpecificActionModel;
                                    if (item == null) return;
                                    if (gameController.totalCash! <
                                        (currentAmount)) return;
                                    if (item.title == "예금") {
                                      await gameController.shortSavingAction(
                                        title: item.title,
                                        price: currentAmount.toInt(),
                                      );

                                      gameController.isActionChoicing = false;
                                    } else if (item.title == "적금") {
                                      await gameController.longSavingAction(
                                        title: item.title,
                                        price: currentAmount.toInt(),
                                      );

                                      gameController.isActionChoicing = false;
                                      Get.back();
                                    }
                                  },
                                ));
                              },
                              child: SizedBox(
                                width: 184,
                                height: 50,
                                child: Stack(
                                  children: [
                                    Image.asset(
                                        "assets/icons/button_long_green.png"),
                                    Center(
                                      child: Text(
                                          "${gameController.curretnSpecificActionModel?.title}하기",
                                          style: Constants.largeTextStyle),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ];
    }
  }

  CupertinoButton singleChoiceButton(
      {required String title,
      required bool isSelected,
      required Function() onPressed}) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          Container(
              width: 20.0,
              height: 20.0,
              decoration: const ShapeDecoration(
                shape: CircleBorder(
                  side: BorderSide(width: 1.5, color: Colors.white),
                ),
              ),
              child: Center(
                child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? Colors.white : Colors.transparent)),
              )),
          const SizedBox(width: 16.0),
          Text(title,
              style: Constants.defaultTextStyle.copyWith(
                color: Colors.white,
                decorationColor: Constants.grey03,
                decorationThickness: 2,
              )),
        ],
      ),
    );
  }

  //MARK: - 플레이어 개인 활동 설명 화면
  List<Widget> actionDescriptionContainer(
      GameActionType actionType, GameController gameController) {
    switch (actionType) {
      case GameActionType.expend:
        return [
          MCContainer(
            borderRadius: 20,
            gradient: gameController.currentBackgroundGradient,
            strokePadding: const EdgeInsets.all(5),
            width: 530,
            height: height,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 24, left: 30, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${gameController.currentActionTypeModel.title} 활동",
                      style: Constants.titleTextStyle),
                  const SizedBox(height: 18),
                  Text(gameController.currentActionTypeModel.description,
                      maxLines: 3,
                      style: Constants.defaultTextStyle
                          .copyWith(fontSize: 16, height: 2)),
                ],
              ),
            ),
          )
        ];
      case GameActionType.investment:
      case GameActionType.loan:
      case GameActionType.saving:
        return [
          MCContainer(
            borderRadius: 20,
            gradient: Constants.greyGradient,
            strokePadding: const EdgeInsets.all(5),
            width: 180,
            height: height,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 18, left: 10, right: 10, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(gameController.currentActionTypeModel.rateTitle ?? "",
                      style: Constants.titleTextStyle
                          .copyWith(color: Constants.dark100)),
                  const SizedBox(height: 18),
                  Text(
                      "${gameController.currentActionTypeModel.rateTitle ?? ""}란?",
                      style: Constants.defaultTextStyle
                          .copyWith(fontSize: 16, color: Constants.dark100)),
                  const SizedBox(height: 8),
                  Text(
                      gameController.currentActionTypeModel.rateDescription ??
                          "",
                      style: Constants.defaultTextStyle
                          .copyWith(fontSize: 16, color: Constants.dark100)),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        flex: 90,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("지난 라운드",
                                style: Constants.defaultTextStyle.copyWith(
                                    fontSize: 10, color: Constants.dark100)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Container(
                            width: 1, height: 16, color: Constants.dark100),
                      ),
                      Expanded(
                        flex: 60,
                        child: Text("이번 라운드",
                            style: Constants.defaultTextStyle.copyWith(
                                fontSize: 10, color: Constants.dark100)),
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(height: 1, color: const Color(0xFFABABAB)),
                  const SizedBox(height: 4),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          gameController.currentActionTypeModel.rates?.length ??
                              0,
                      itemBuilder: (context, index) {
                        final rate =
                            gameController.currentActionTypeModel.rates?[index];
                        final actionType = gameController.currentActionType;
                        double? before =
                            gameController.previousRate(actionType: actionType);
                        double after =
                            gameController.currentRate(actionType: actionType);
                        if (before != null) {
                          if (rate?.title == "저축금리") {
                            before += 2;
                          } else if (rate?.title == "담보대출") {
                            before -= 1;
                          }
                        }

                        return RateListTile2(
                            title: rate?.title ?? "",
                            rate: before,
                            isHigherThanBefore: (before != null)
                                ? (before < after)
                                : (0 < after));
                      }),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          MCContainer(
            borderRadius: 20,
            gradient: gameController.currentBackgroundGradient,
            strokePadding: const EdgeInsets.all(5),
            width: 340,
            height: height,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 24, left: 30, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${gameController.currentActionTypeModel.title} 활동",
                      style: Constants.titleTextStyle),
                  const SizedBox(height: 18),
                  Text(gameController.currentActionTypeModel.description,
                      maxLines: 3,
                      style: Constants.defaultTextStyle
                          .copyWith(fontSize: 16, height: 2)),
                ],
              ),
            ),
          )
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetX<GameController>(builder: (gameController) {
      final model = gameController.currentActionTypeModel;

      if (currentCreditLoanAmount < gameController.totalCash! / 2 ||
          currentCreditLoanAmount > gameController.totalCash! * 2) {
        currentCreditLoanAmount = gameController.totalCash! / 2;
      }

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  //MARK: - 액션 종류 선택
                  MCContainer(
                    borderRadius: 20,
                    gradient: gameController.currentBackgroundGradient,
                    strokePadding: const EdgeInsets.all(5),
                    width: 170,
                    height: height,
                    // alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: model.actions.length,
                          // padding: const EdgeInsets.symmetric(vertical: 12),
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final specificAction = model.actions[index];
                            bool? isSelected = false;

                            if (specificAction.title ==
                                gameController
                                    .curretnSpecificActionModel?.title) {
                              isSelected = true;
                            } else {
                              isSelected = false;
                            }

                            return Padding(
                              padding: const EdgeInsets.all(2.5),
                              child: ActionChoiceButton(
                                isSelected: isSelected,
                                title: model.actions[index].title,
                                onTap: () {
                                  gameController.specificActionButtonTap(index);
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-14, -14),
                    child: Bounceable(
                      scaleFactor: 0.8,
                      onTap: () => gameController.isActionChoicing = false,
                      child: Image.asset(
                        gameController.currentBackButtonAssetString,
                        width: 46.0,
                        height: 46.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              if (gameController.curretnSpecificActionModel == null)
                ...actionDescriptionContainer(
                    gameController.currentActionType, gameController)
              else
                ...actionChoiceContainer(
                    gameController.currentActionType, gameController),
            ],
          ),
        ),
      );
    });
  }

  Row amountTile({required double amount, double? width}) {
    return Row(
      children: [
        SizedBox(
          width: width ?? 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 2),
                child: Text(amount.toInt().commaString,
                    style: Constants.defaultTextStyle),
              ),
              const SizedBox(height: 3.5),
              Container(
                // width: 80,
                height: 2,
                color: Colors.white,
              )
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text("원", style: Constants.defaultTextStyle),
      ],
    );
  }
}

class RateListTile2 extends StatelessWidget {
  final String title;
  final double? rate;
  final bool isHigherThanBefore;
  const RateListTile2({
    super.key,
    required this.title,
    required this.rate,
    required this.isHigherThanBefore,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: Constants.defaultTextStyle
                          .copyWith(fontSize: 10, color: Constants.dark100)),
                  Text(rate != null ? "$rate%" : "",
                      style: Constants.defaultTextStyle
                          .copyWith(fontSize: 10, color: Constants.dark100)),
                  const SizedBox(width: 0),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Container(width: 1, height: 16, color: Constants.dark100),
            ),
            Expanded(
              flex: 60,
              child: Center(
                child: SizedBox(
                  width: 12,
                  height: 12,
                  child: Image.asset(isHigherThanBefore
                      ? "assets/icons/arrow_up_red.png"
                      : "assets/icons/arrow_down_blue.png"),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 4),
        Container(height: 1, color: const Color(0xFFABABAB)),
        const SizedBox(height: 4),
      ],
    );
  }
}

class RateListTile extends StatelessWidget {
  final String title;
  final double rate;
  final bool isHigherThanBefore;
  const RateListTile({
    super.key,
    required this.title,
    required this.rate,
    required this.isHigherThanBefore,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: Constants.defaultTextStyle
                      .copyWith(fontSize: 10, color: Constants.dark100)),
              Text("$rate%",
                  style: Constants.defaultTextStyle
                      .copyWith(fontSize: 10, color: Constants.dark100)),
              const SizedBox(width: 0),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Container(width: 1, height: 16, color: Constants.dark100),
        ),
        Expanded(
          flex: 60,
          child: Center(
            child: SizedBox(
              width: 12,
              height: 12,
              child: Image.asset(isHigherThanBefore
                  ? "assets/icons/arrow_up_red.png"
                  : "assets/icons/arrow_down_blue.png"),
            ),
          ),
        )
      ],
    );
  }
}

class SliderCustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
