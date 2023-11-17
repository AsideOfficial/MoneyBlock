import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/models/enums/game_action_type.dart';
import 'package:money_cycle/controller/game_controller.dart';
import 'package:money_cycle/screen/play/components/action_choice_button.dart';
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
  double cash = 1000000;
  double currentAmount = 700000;

  @override
  Widget build(BuildContext context) {
    return GetX<GameController>(builder: (gameController) {
      final model = gameController.currentActionTypeModel;
      final specificActionModel = gameController.curretnSpecificActionModel;
      return Row(
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
                height: 250,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Center(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: model.actions.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ActionChoiceButton(
                            title: model.actions[index].title,
                            onTap: () {
                              gameController.specificActionButtonTap(index);
                            },
                          ),
                        );
                      },
                    ),
                  ),
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
          if (gameController.currentActionType != GameActionType.expend &&
              gameController.curretnSpecificActionModel == null)
            MCContainer(
              borderRadius: 20,
              gradient: Constants.greyGradient,
              strokePadding: const EdgeInsets.all(5),
              width: 180,
              height: 250,
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
                        itemCount: gameController
                                .currentActionTypeModel.rates?.length ??
                            0,
                        itemBuilder: (context, index) {
                          final rate = gameController
                              .currentActionTypeModel.rates?[index];
                          final bool isHigherThanBefore;
                          if (rate != null) {
                            if (rate.rateFluctuation.length >= 2) {
                              isHigherThanBefore = true;
                            } else {
                              isHigherThanBefore = false;
                            }
                          } else {
                            isHigherThanBefore = false;
                          }

                          return RateListTile2(
                              title: rate?.title ?? "",
                              rate: rate?.rateFluctuation.first ?? 0,
                              isHigherThanBefore: isHigherThanBefore);
                        }),
                  ],
                ),
              ),
            ),
          if (gameController.currentActionType != GameActionType.expend &&
              gameController.curretnSpecificActionModel == null)
            const SizedBox(
              width: 12,
            ),
          if (gameController.curretnSpecificActionModel == null)
            MCContainer(
              borderRadius: 20,
              gradient: gameController.currentBackgroundGradient,
              strokePadding: const EdgeInsets.all(5),
              width: (gameController.currentActionType != GameActionType.expend)
                  ? 340
                  : 530,
              height: 250,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 24, left: 30, right: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${model.title} 활동", style: Constants.titleTextStyle),
                    const SizedBox(height: 18),
                    Text(model.description,
                        maxLines: 3,
                        style: Constants.defaultTextStyle
                            .copyWith(fontSize: 16, height: 2)),
                  ],
                ),
              ),
            )
          else if (gameController.currentActionType == GameActionType.expend ||
              gameController.currentActionType == GameActionType.investment)
            MCContainer(
              borderRadius: 20,
              gradient: gameController.currentBackgroundGradient,
              strokePadding: const EdgeInsets.all(5),
              width:
                  (gameController.currentActionType != GameActionType.expend &&
                          gameController.curretnSpecificActionModel == null)
                      ? 340
                      : 530,
              height: 250,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 24, left: 30, right: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(specificActionModel?.title ?? "",
                        style: Constants.titleTextStyle),
                    const SizedBox(height: 6),
                    Text("어떤 ${specificActionModel?.title}를 하시겠습니까?",
                        style:
                            Constants.defaultTextStyle.copyWith(fontSize: 16)),
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
                            return Bounceable(
                              onTap: () {
                                if (gameController.currentActionType ==
                                    GameActionType.investment) {
                                  Get.dialog(PurchaseAlertDialog(
                                    isMultiple: (gameController
                                                .curretnSpecificActionModel
                                                ?.title ==
                                            "부동산")
                                        ? false
                                        : true,
                                    title:
                                        "${gameController.curretnSpecificActionModel?.title} 매수",
                                    subTitle: item?.title ?? "",
                                    perPrice: item?.price ?? 0,
                                    actionTitle: "매수",
                                    onPurchase: (count) {
                                      //TODO - 투자 API 연동 필요
                                    },
                                  ));
                                } else {
                                  Get.dialog(PurchaseAlertDialog(
                                    title: "구입",
                                    subTitle: item?.title ?? "",
                                    perPrice: item?.price ?? 0,
                                    actionTitle: "구입",
                                    onPurchase: (count) {
                                      //TODO - 지출 API 연동 필요
                                    },
                                  ));
                                }
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
            )
          else if (gameController.currentActionType == GameActionType.saving)
            MCContainer(
              borderRadius: 20,
              gradient: gameController.currentBackgroundGradient,
              strokePadding: const EdgeInsets.all(5),
              width: 530,
              height: 250,
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
                        Text("금리: 4%",
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
                              amountTile(amount: cash),
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
                                            max: cash,
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
                                      "${((currentAmount / cash) * 100).toInt()}%",
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
                                            amount: currentAmount * 0.04,
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
                                            amount: currentAmount * 0.04 * 3,
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
                                          amount: currentAmount * 0.04,
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
                                            .curretnSpecificActionModel
                                            ?.title ??
                                        "",
                                    subTitle:
                                        "${gameController.curretnSpecificActionModel?.title} 하시겠습니까?",
                                    perPrice: currentAmount.toInt(),
                                    primaryActionColor: Constants.cardGreen,
                                    actionTitle:
                                        "${gameController.curretnSpecificActionModel?.title}하기",
                                    onPurchase: (count) {
                                      // TODO - 예금, 적금 API 연동 필요 금액 = currentAmout
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
          else
            MCContainer(
              borderRadius: 20,
              gradient: gameController.currentBackgroundGradient,
              strokePadding: const EdgeInsets.all(5),
              width: 530,
              height: 250,
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
                        Text("금리: 4%",
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
                              amountTile(amount: cash),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 170,
                                    child: Column(
                                      children: [
                                        SfSliderTheme(
                                          data: SfSliderThemeData(
                                            activeTrackHeight: 3,
                                            inactiveTrackHeight: 3,
                                            trackCornerRadius: 2,
                                            activeTrackColor:
                                                Colors.white.withOpacity(0.8),
                                            inactiveTrackColor:
                                                const Color(0xFF8A3200),
                                          ),
                                          child: SfSlider(
                                            value: currentAmount,
                                            min: cash / 2,
                                            max: cash * 2,
                                            stepSize: 10000,
                                            enableTooltip: false,
                                            showLabels: false,
                                            showTicks: false,
                                            thumbIcon: Container(
                                              width: 18,
                                              height: 18,
                                              decoration: const ShapeDecoration(
                                                gradient:
                                                    Constants.orangeGradient,
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
                                            Text("0.5배",
                                                style: Constants
                                                    .defaultTextStyle
                                                    .copyWith(fontSize: 10)),
                                            const Spacer(),
                                            Text("2배",
                                                style: Constants
                                                    .defaultTextStyle
                                                    .copyWith(fontSize: 10)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Text("${((currentAmount / cash))}배",
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("대출금액",
                                        style: Constants.defaultTextStyle),
                                    const SizedBox(width: 8),
                                    amountTile(
                                        amount: currentAmount, width: 100),
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
                                    title:
                                        "${gameController.curretnSpecificActionModel?.title}",
                                    subTitle:
                                        "${gameController.curretnSpecificActionModel?.title} 하시겠습니까?",
                                    perPrice: currentAmount.toInt(),
                                    actionTitle: "대출하기",
                                    primaryActionColor: Constants.cardOrange,
                                    onPurchase: (count) {
                                      //TODO - API - 대출 실행 금액 = currentAmount
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
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
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
  final double rate;
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
