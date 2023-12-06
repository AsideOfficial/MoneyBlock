import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/controller/game_controller.dart';
import 'package:money_cycle/screen/play/components/custom_alert_dialog.dart';
import 'package:money_cycle/utils/extension/int.dart';

class EndGameAlertDialog extends StatefulWidget {
  const EndGameAlertDialog({super.key});

  @override
  State<EndGameAlertDialog> createState() => _EndGameAlertDialogState();
}

class _EndGameAlertDialogState extends State<EndGameAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: "게임종료!",
      description: "게임이 종료되었습니다.",
      instruction: "게임의 결과를 확인해보세요.",
      acionButtonTitle: "결과보기",
      onPressed: () {
        Get.back();
        Get.dialog(
          const FinalCalculateDialog(),
          barrierDismissible: false,
        );
      },
    );
  }
}

class FinalCalculateDialog extends StatefulWidget {
  const FinalCalculateDialog({
    super.key,
  });

  @override
  State<FinalCalculateDialog> createState() => _FinalCalculateDialogState();
}

class _FinalCalculateDialogState extends State<FinalCalculateDialog> {
  int cash = 5000000;
  int saving = 1000000;
  int asset = 2000000;
  int loan = -1000000;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shadowColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          height: 330,
          child: Row(
            children: [
              const SizedBox(width: 100),
              Container(
                width: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: Constants.grey00Gradient,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, bottom: 12, right: 20),
                  child: GetX<GameController>(builder: (controller) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("최종 정산 금액",
                            style: Constants.defaultTextStyle.copyWith(
                                fontSize: 24, color: Constants.dark100)),
        
                        const SizedBox(height: 6),
        
                        Text("보유현금",
                            style: Constants.defaultTextStyle.copyWith(
                                fontSize: 16, color: Constants.dark100)),
                        const SizedBox(height: 2),
                        Text(controller.totalCash?.commaString ?? "",
                            style: Constants.defaultTextStyle.copyWith(
                                fontSize: 16, color: const Color(0xFFEA8C00))),
                        const SizedBox(height: 6),
                        Text("저축자산",
                            style: Constants.defaultTextStyle.copyWith(
                                fontSize: 16, color: Constants.dark100)),
                        const SizedBox(height: 2),
                        Text("+${controller.totalSaving?.commaString}",
                            style: Constants.defaultTextStyle.copyWith(
                                fontSize: 16, color: Constants.accentRed)),
                        const SizedBox(height: 6),
                        Text("투자자산",
                            style: Constants.defaultTextStyle.copyWith(
                                fontSize: 16, color: Constants.dark100)),
                        const SizedBox(height: 2),
                        Text("+${controller.totalInvestment?.commaString}",
                            style: Constants.defaultTextStyle.copyWith(
                                fontSize: 16, color: Constants.accentRed)),
                        const SizedBox(height: 6),
                        Text("대출금",
                            style: Constants.defaultTextStyle.copyWith(
                                fontSize: 16, color: Constants.dark100)),
                        const SizedBox(height: 2),
                        Text("-${controller.totalLoan?.commaString}",
                            style: Constants.defaultTextStyle.copyWith(
                                fontSize: 16, color: Constants.accentBlue)),
                        // const RateVariationTile(before: 3, after: 5),
        
                        const SizedBox(height: 6),
                        // const RateVariationTile(before: 5, after: 4),
                        // const SizedBox(height: 10),
                        Container(height: 1, color: Constants.grey100),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text("총",
                                style: Constants.defaultTextStyle.copyWith(
                                    fontSize: 20, color: Constants.dark100)),
                            const Spacer(),
                            Text("${controller.totalAsset?.commaString}원",
                                style: Constants.defaultTextStyle.copyWith(
                                    fontSize: 20, color: Constants.dark100)),
                          ],
                        ),
                      ],
                    );
                  }),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  const Spacer(),
                  Bounceable(
                      onTap: () {
                        Get.back();
                        Get.dialog(const FinalResultDialog(),
                            barrierDismissible: false, useSafeArea: false);
                      },
                      child: SizedBox(
                        width: 110,
                        height: 50,
                        child: Stack(
                          children: [
                            Image.asset("assets/components/confirm_button.png"),
                            Center(
                              child: Text(
                                "확인",
                                style: Constants.largeTextStyle,
                              ),
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FinalResultDialog extends StatefulWidget {
  const FinalResultDialog({
    super.key,
  });

  @override
  State<FinalResultDialog> createState() => _FinalResultDialogState();
}

class _FinalResultDialogState extends State<FinalResultDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shadowColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: 540,
          height: 330,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                  image:
                      AssetImage("assets/components/final_result_container.png"),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Container(
              decoration: ShapeDecoration(
                color: Colors.white.withOpacity(0.800000011920929),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                    spreadRadius: 1,
                  )
                ],
              ),
              child: GetX<GameController>(builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 8, left: 21, right: 21),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("최종 결과",
                          style: Constants.titleTextStyle
                              .copyWith(color: Colors.black)),
                      const SizedBox(height: 18),
                      Expanded(
                        child: SizedBox(
                          height: 72,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListView.separated(
                                padding: EdgeInsets.zero,
                                separatorBuilder: (context, index) {
                                  return Container(
                                    // color: Colors.blue,
                                    width: 40,
                                  );
                                },
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    (controller.currentRoom!.player!.length < 4)
                                        ? controller.currentRoom!.player!.length
                                        : 3,
                                itemBuilder: (context, index) {
                                  final player = controller.currentRanking[index];
                                  final asset =
                                      controller.currentRankingAssetList[index];
                                  return VictoryStandCard(
                                    name: player.name ?? "",
                                    ranking: index + 1,
                                    totalAsset: asset,
                                    assetString:
                                        controller.characterAvatarAssetString(
                                            characterIndex:
                                                player.characterIndex ?? 0),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      // const SizedBox(height: 10),
                      Container(height: 1, color: Constants.grey100),
                      const SizedBox(height: 10),
                      if ((controller.currentRoom?.player?.length ?? 0) > 3)
                        Row(
                          children: [
                            Text("4위",
                                style: Constants.largeTextStyle
                                    .copyWith(color: Colors.black)),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 34,
                              // height: 70,
                              child: Image.asset(
                                  controller.characterAvatarAssetString(
                                      characterIndex: controller
                                          .currentRanking[3].characterIndex!)),
                            ),
                            const SizedBox(width: 10),
                            Text(controller.currentRanking[3].name ?? "",
                                style: Constants.largeTextStyle
                                    .copyWith(color: Colors.black)),
                            const SizedBox(width: 10),
                            Text(
                                "${(controller.currentRankingAssetList[3]).commaString}원",
                                style: Constants.largeTextStyle
                                    .copyWith(color: Colors.black)),
                            const SizedBox(width: 10),
                          ],
                        ),
                      const SizedBox(
                        height: 4,
                      ),
                      Bounceable(
                        onTap: () {
                          Get.back();
                          Get.back();
                          Get.back();
                        },
                        child: SizedBox(
                          width: 230,
                          height: 50,
                          child: Stack(
                            children: [
                              Image.asset(
                                "assets/components/continue_button.png",
                                fit: BoxFit.cover,
                              ),
                              Center(
                                child: Text("확인",
                                    style: Constants.largeTextStyle
                                        .copyWith(fontSize: 22)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      )
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class VictoryStandCard extends StatelessWidget {
  final String name;
  final int ranking;
  final int totalAsset;
  final String assetString;
  const VictoryStandCard({
    super.key,
    required this.name,
    required this.ranking,
    required this.totalAsset,
    required this.assetString,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 110,
          height: 60,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              SizedBox(
                width: 58,
                height: 70,
                // clipBehavior: Clip.antiAlias,
                // decoration: ShapeDecoration(
                //   color: const Color(0xFFB2B2FF),
                //   shape: RoundedRectangleBorder(
                //     side: const BorderSide(width: 2, color: Color(0xFFE6E7E8)),
                //     borderRadius: BorderRadius.circular(49),
                //   ),
                //   shadows: const [
                //     BoxShadow(
                //       color: Color(0x3F000000),
                //       blurRadius: 3,
                //       offset: Offset(0, 3),
                //       spreadRadius: 0,
                //     )
                //   ],
                // ),
                child: Image.asset(assetString),
              ),
              Positioned(
                left: 0,
                child: Text("$ranking위",
                    style:
                        Constants.largeTextStyle.copyWith(color: Colors.black)),
              ),
              Positioned(
                bottom: 0,
                right: 20,
                child: SizedBox(
                  width: 24,
                  child: Image.asset("assets/icons/medal_$ranking.png"),
                ),
              )
            ],
          ),
        ),
        Text(name,
            style: Constants.largeTextStyle.copyWith(color: Colors.black)),
        const SizedBox(height: 8),
        Text("${totalAsset.commaString}원",
            style: Constants.defaultTextStyle
                .copyWith(fontSize: 16, color: Colors.black)),
      ],
    );
  }
}
