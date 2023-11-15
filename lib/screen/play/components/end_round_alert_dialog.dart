import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/components/mc_button.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/constants.dart';
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
    return CustomAlertDialog(
      title: "1라운드 종료!",
      description: "1라운드가 종료되었습니다.",
      instruction: "게임의 결과를 확인해보세요.",
      acionButtonTitle: "결과보기",
      onPressed: () {
        Get.back();
        Get.dialog(const EconomicNewsDialog(), useSafeArea: false);
      },
    );
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
  bool isVacation = false;
  bool isVacationFinished = false;

  @override
  Widget build(BuildContext context) {
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
                            .copyWith(fontSize: 24, color: Constants.dark100)),
                    const SizedBox(height: 15),
                    Text("한국은행 기준금이 0.5% 인상",
                        style: Constants.defaultTextStyle
                            .copyWith(fontSize: 16, color: Constants.dark100)),
                    const SizedBox(height: 23),
                    Container(
                      height: 1,
                      color: Constants.grey100,
                    ),
                    const SizedBox(height: 10),
                    Text("금리 증감 결과",
                        style: Constants.defaultTextStyle
                            .copyWith(fontSize: 24, color: Constants.dark100)),
                    const SizedBox(height: 8),
                    Text("저축금리",
                        style: Constants.defaultTextStyle.copyWith(
                            fontSize: 16, color: Constants.cardGreen)),
                    const SizedBox(height: 2),
                    const RateVariationTile(before: 3, after: 5),
                    const SizedBox(height: 10),
                    Text("저축금리",
                        style: Constants.defaultTextStyle.copyWith(
                            fontSize: 16, color: Constants.cardOrange)),
                    const SizedBox(height: 2),
                    const RateVariationTile(before: 5, after: 4),
                    const SizedBox(height: 10),
                    Text("저축금리",
                        style: Constants.defaultTextStyle
                            .copyWith(fontSize: 16, color: Constants.cardRed)),
                    const SizedBox(height: 2),
                    const RateVariationTile(
                      before: 10,
                      after: -10,
                    ),
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
                            .copyWith(fontSize: 24, color: Constants.dark100)),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Text("지난 총 잔액",
                            style: Constants.defaultTextStyle.copyWith(
                                fontSize: 14, color: Constants.dark100)),
                        const Spacer(),
                        Text("1000000원",
                            style: Constants.defaultTextStyle.copyWith(
                                fontSize: 14, color: Constants.dark100)),
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
                            style: Constants.defaultTextStyle.copyWith(
                                fontSize: 14, color: Constants.dark100)),
                        const Spacer(),
                        Text("1000000원",
                            style: Constants.defaultTextStyle.copyWith(
                                fontSize: 14, color: Constants.dark100)),
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
                        left: 20, top: 20, bottom: 23, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("현재 순위",
                            style: Constants.defaultTextStyle.copyWith(
                                fontSize: 24, color: Constants.dark100)),
                        const SizedBox(height: 15),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              //TODO - 순위 데이터 리스트 연동 및 정렬
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
                                                  color: Constants.dark100)),
                                    ),
                                    const SizedBox(width: 13),
                                    SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: Image.asset(
                                            "assets/images/profile_cow.png")),
                                    const SizedBox(width: 10),
                                    Text("닉네임",
                                        style: Constants.defaultTextStyle
                                            .copyWith(
                                                fontSize: 20,
                                                color: Constants.dark100)),
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
                .copyWith(fontSize: 14, color: Constants.dark100)),
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

class RoundCalculateDialog extends StatefulWidget {
  const RoundCalculateDialog({
    super.key,
  });

  @override
  State<RoundCalculateDialog> createState() => _RoundCalculateDialogState();
}

class _RoundCalculateDialogState extends State<RoundCalculateDialog> {
  bool isVacation = false;
  bool isVacationFinished = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shadowColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: Row(
        children: [
          const SizedBox(width: 50),
          Container(
            width: 230,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: Constants.grey00Gradient,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 230,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: Constants.grey00Gradient,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Bounceable(
                duration: const Duration(seconds: 1),
                onTap: () {
                  Get.back();
                  Get.dialog(const NewRoundDialog());
                },
                child: SizedBox(
                  width: 100,
                  height: 50,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset("assets/components/confirm_button.png"),
                      Text(
                        "확인",
                        style:
                            Constants.defaultTextStyle.copyWith(fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
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
          child: Column(
            children: [
              Text("새로운 라운드", style: Constants.titleTextStyle),
              const SizedBox(height: 14),
              Text("라운드 2가 시작됩니다.",
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
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
