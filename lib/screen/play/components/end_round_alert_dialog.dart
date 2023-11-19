import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/components/mc_button.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/controller/game_controller.dart';
import 'package:money_cycle/models/game/news_article.dart';
import 'package:money_cycle/screen/play/components/custom_alert_dialog.dart';
import 'package:money_cycle/utils/extension/int.dart';

class EndRoundAlertDialog extends StatefulWidget {
  const EndRoundAlertDialog({super.key});

  @override
  State<EndRoundAlertDialog> createState() => _EndRoundAlertDialogState();
}

class _EndRoundAlertDialogState extends State<EndRoundAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return GetX<GameController>(builder: (controller) {
      return CustomAlertDialog(
        title: "라운드${controller.currentRound - 1} 종료!",
        description: "${controller.currentRound - 1}라운드가 종료되었습니다.",
        instruction: "게임의 결과를 확인해보세요.",
        acionButtonTitle: "결과보기",
        onPressed: () {
          Get.back();
          Get.dialog(const EconomicNewsDialog(), useSafeArea: false);
        },
      );
    });
  }
}

class EconomicNewsDialog extends StatefulWidget {
  const EconomicNewsDialog({
    super.key,
  });

  @override
  State<EconomicNewsDialog> createState() => _EconomicNewsDialogState();
}

class _EconomicNewsDialogState extends State<EconomicNewsDialog> {
  @override
  Widget build(BuildContext context) {
    return GetX<GameController>(builder: (controller) {
      return AlertDialog(
        shadowColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        content: SizedBox(
          height: 310,
          child: Row(
            children: [
              Container(
                width: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: Constants.grey00Gradient,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, bottom: 17, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("지난 뉴스",
                          style: Constants.defaultTextStyle
                              .copyWith(fontSize: 24, color: Colors.black)),
                      const SizedBox(height: 15),
                      Text(controller.previousNews?.headline ?? "",
                          style: Constants.defaultTextStyle
                              .copyWith(fontSize: 16, color: Colors.black)),
                      const SizedBox(height: 23),
                      Container(
                        height: 1,
                        color: Constants.grey100,
                      ),
                      const SizedBox(height: 10),
                      Text("금리 증감 결과",
                          style: Constants.defaultTextStyle
                              .copyWith(fontSize: 24, color: Colors.black)),
                      const SizedBox(height: 8),
                      Text("저축금리",
                          style: Constants.defaultTextStyle.copyWith(
                              fontSize: 16, color: Constants.cardGreen)),
                      const SizedBox(height: 2),
                      RateVariationTile(
                          before: controller.previousSavingInterest ?? 0.0,
                          after: controller.currentSavingInterest ?? 0.0),
                      const SizedBox(height: 10),
                      Text("대출금리",
                          style: Constants.defaultTextStyle.copyWith(
                              fontSize: 16, color: Constants.cardOrange)),
                      const SizedBox(height: 2),
                      RateVariationTile(
                          before: controller.previousLoanInterest ?? 0.0,
                          after: controller.currentLoanInterest ?? 0.0),
                      const SizedBox(height: 10),
                      Text("투자변동률",
                          style: Constants.defaultTextStyle.copyWith(
                              fontSize: 16, color: Constants.cardRed)),
                      const SizedBox(height: 2),
                      RateVariationTile(
                          before: controller.previousInvestInterest ?? 0.0,
                          after: controller.currentInvestInterest ?? 0.0),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: Constants.grey00Gradient,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, bottom: 23, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("라운드 정산",
                          style: Constants.defaultTextStyle
                              .copyWith(fontSize: 24, color: Colors.black)),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Text("지난 총 잔액",
                              style: Constants.defaultTextStyle
                                  .copyWith(fontSize: 14, color: Colors.black)),
                          const Spacer(),
                          Text("1000000원",
                              style: Constants.defaultTextStyle
                                  .copyWith(fontSize: 14, color: Colors.black)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Container(height: 1, color: Constants.grey100),
                      const SizedBox(height: 20),
                      const AssetVariationListTile(
                          title: "현금", variation: 100000),
                      const SizedBox(height: 4),
                      Container(height: 1, color: Constants.grey100),
                      const SizedBox(height: 4),
                      const AssetVariationListTile(
                          title: "저축", variation: 300000),
                      const SizedBox(height: 4),
                      Container(height: 1, color: Constants.grey100),
                      const SizedBox(height: 4),
                      const AssetVariationListTile(
                          title: "투자", variation: 500000),
                      const SizedBox(height: 4),
                      Container(height: 1, color: Constants.grey100),
                      const SizedBox(height: 4),
                      const AssetVariationListTile(
                          title: "대출", variation: -500000),
                      const SizedBox(height: 4),
                      Container(height: 1, color: Constants.grey100),
                      const SizedBox(height: 4),
                      const AssetVariationListTile(
                          title: "세금", variation: -200000),
                      const SizedBox(height: 4),
                      Container(height: 1, color: Constants.grey100),
                      const SizedBox(height: 4),
                      const AssetVariationListTile(
                          title: "인센티브", variation: 400000),
                      const SizedBox(height: 4),
                      Container(height: 1, color: Constants.grey100),
                      const Spacer(),
                      Row(
                        children: [
                          Text("현재 총 잔액",
                              style: Constants.defaultTextStyle
                                  .copyWith(fontSize: 14, color: Colors.black)),
                          const Spacer(),
                          Text("${controller.totalCash?.commaString}원",
                              style: Constants.defaultTextStyle
                                  .copyWith(fontSize: 14, color: Colors.black)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Container(height: 1, color: Constants.grey100),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    width: 210,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: Constants.grey00Gradient,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, top: 20, bottom: 23, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("현재 순위",
                              style: Constants.defaultTextStyle
                                  .copyWith(fontSize: 24, color: Colors.black)),
                          const SizedBox(height: 15),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  controller.currentRoomData?.player?.length ??
                                      0,
                              itemBuilder: (context, index) {
                                //TODO - 순위 데이터 리스트 연동 및 정렬
                                final player =
                                    controller.currentRoomData!.player![index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                        child: Text("${index + 1}.",
                                            style: Constants.defaultTextStyle
                                                .copyWith(
                                                    fontSize: 20,
                                                    color: Colors.black)),
                                      ),
                                      const SizedBox(width: 6),
                                      SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Image.asset(
                                              "assets/images/profile_cow.png")), // TODO - 캐릭터 인덱스 연결
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        width: 86,
                                        child: Text(player.name ?? "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: Constants.defaultTextStyle
                                                .copyWith(
                                                    fontSize: 20,
                                                    color: Colors.black)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(14, -14),
                    child: Bounceable(
                      scaleFactor: 0.8,
                      onTap: () {
                        Get.back();
                        Get.dialog(const NewRoundDialog());
                      },
                      child: Image.asset(
                        "assets/icons/button_forward.png",
                        width: 46.0,
                        height: 46.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

class AssetVariationListTile extends StatelessWidget {
  final String title;
  final int variation;
  const AssetVariationListTile({
    super.key,
    required this.title,
    required this.variation,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,
            style: Constants.defaultTextStyle
                .copyWith(fontSize: 14, color: Colors.black)),
        const Spacer(),
        Text("${(variation >= 0) ? "+" : ""}${variation.commaString}원",
            style: Constants.defaultTextStyle.copyWith(
                fontSize: 14,
                color: (variation < 0)
                    ? Constants.accentRed
                    : Constants.accentBlue)),
      ],
    );
  }
}

class RateVariationTile extends StatelessWidget {
  final double before;
  final double after;
  const RateVariationTile({
    super.key,
    required this.before,
    required this.after,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 64,
          child: Text("$before%",
              style: Constants.defaultTextStyle
                  .copyWith(fontSize: 20, color: Constants.grey100)),
        ),
        SizedBox(
            width: 14,
            height: 14,
            child: Image.asset("assets/icons/arrow_forward.png")),
        const SizedBox(width: 14),
        Text("$after%",
            style: Constants.defaultTextStyle.copyWith(
                fontSize: 20,
                color: (before < after)
                    ? Constants.accentRed
                    : Constants.accentBlue)),
      ],
    );
  }
}

class NewRoundDialog extends StatefulWidget {
  const NewRoundDialog({
    super.key,
  });

  @override
  State<NewRoundDialog> createState() => _NewRoundDialogState();
}

class _NewRoundDialogState extends State<NewRoundDialog> {
  int incentive = 2400000;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: MCContainer(
        strokePadding: const EdgeInsets.all(8),
        gradient: Constants.mainGradient,
        width: 306,
        height: 256,
        child: Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 22),
          child: GetX<GameController>(builder: (controller) {
            return Column(
              children: [
                Text("새로운 라운드", style: Constants.titleTextStyle),
                const SizedBox(height: 14),
                Text("라운드 ${controller.currentRound}가 시작됩니다.",
                    style: Constants.defaultTextStyle.copyWith(fontSize: 18)),
                const SizedBox(height: 10),
                Text("+ ${incentive.commaString} 원",
                    style: Constants.defaultTextStyle.copyWith(fontSize: 22)),
                const SizedBox(height: 10),
                Text("플레이어는 월급과 인센티브를 받습니다.",
                    style: Constants.defaultTextStyle.copyWith(fontSize: 14)),
                const Spacer(),
                SizedBox(
                  width: 184,
                  height: 44,
                  child: MCButton(
                    title: "확인",
                    backgroundColor: Constants.blueNeon,
                    onPressed: () {
                      Get.back();
                      Get.dialog(const NewsDialog(),
                          useSafeArea: false, name: "뉴스");
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class NewsDialog extends StatefulWidget {
  const NewsDialog({
    super.key,
  });

  @override
  State<NewsDialog> createState() => _NewsDialogState();
}

class _NewsDialogState extends State<NewsDialog> {
  bool isVacation = false;
  bool isVacationFinished = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      shadowColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 50),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 750),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: Constants.grey00Gradient,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 30, right: 30, bottom: 18),
              child: GetX<GameController>(builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("뉴스",
                        style: Constants.titleTextStyle
                            .copyWith(color: Colors.black)),
                    const SizedBox(height: 24),
                    Text('"${controller.currentNews?.headline}"',
                        style: Constants.defaultTextStyle
                            .copyWith(color: Colors.black, fontSize: 18)),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(controller.currentNews?.article1 ?? "",
                              style: Constants.defaultTextStyle.copyWith(
                                  color: Colors.black,
                                  fontSize: 14,
                                  height: 1.25)),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: Text(controller.currentNews?.article2 ?? '',
                              style: Constants.defaultTextStyle.copyWith(
                                  color: Colors.black,
                                  fontSize: 14,
                                  height: 1.25)),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: Text(controller.currentNews?.article3 ?? "",
                              style: Constants.defaultTextStyle.copyWith(
                                  color: Colors.black,
                                  fontSize: 14,
                                  height: 1.25)),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Spacer(),
                        Bounceable(
                          onTap: () {
                            Get.back();
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                  width: 230,
                                  height: 50,
                                  child: Image.asset(
                                      "assets/components/continue_button.png")),
                              Text("이어서 플레이",
                                  style: Constants.titleTextStyle
                                      .copyWith(fontSize: 22)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
