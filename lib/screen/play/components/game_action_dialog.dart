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
// import 'package:money_cycle/screen/game_play_screen.dart';

class GameActionDialog extends StatelessWidget {
  const GameActionDialog({super.key});

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
                            style: Constants.defaultTextStyle.copyWith(
                                fontSize: 10, color: Constants.dark100))
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
                            style: Constants.defaultTextStyle.copyWith(
                                fontSize: 10, color: Constants.dark100))
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
                            style: Constants.defaultTextStyle.copyWith(
                                fontSize: 10, color: Constants.dark100))
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
                            style: Constants.defaultTextStyle.copyWith(
                                fontSize: 10, color: Constants.dark100))
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
                            style: Constants.defaultTextStyle.copyWith(
                                fontSize: 10, color: Constants.dark100))
                      ],
                    ),
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
                    Text(
                        "왼쪽의 ${model.actions.length}가지 ${model.title} 활동중 1가지를 고르세요.",
                        style:
                            Constants.defaultTextStyle.copyWith(fontSize: 16)),
                    const SizedBox(height: 16),
                    Text("소비 : 소비는 이러이러한 것입니다.",
                        style:
                            Constants.defaultTextStyle.copyWith(fontSize: 16)),
                    const SizedBox(height: 10),
                    Text("보험 : 소비는 이러이러한 것입니다.",
                        style:
                            Constants.defaultTextStyle.copyWith(fontSize: 16)),
                    const SizedBox(height: 10),
                    Text("기부 : 소비는 이러이러한 것입니다.",
                        style:
                            Constants.defaultTextStyle.copyWith(fontSize: 16)),
                  ],
                ),
              ),
            )
          else
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
                    const SizedBox(height: 10),
                    Text("어떤 ${specificActionModel?.title}를 하시겠습니까?",
                        style:
                            Constants.defaultTextStyle.copyWith(fontSize: 16)),
                    const SizedBox(height: 8),
                    Expanded(
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
                            return GameItemCard(
                              item: item,
                              accentColor: gameController.currentCardColor,
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
        ],
      );
    });
  }
}
