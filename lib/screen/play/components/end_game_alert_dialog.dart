import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/constants.dart';
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
        Get.dialog(const FinalCalculateDialog());
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
      content: SizedBox(
        height: 310,
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
                    left: 20, top: 20, bottom: 17, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("최종 정산 금액",
                        style: Constants.defaultTextStyle
                            .copyWith(fontSize: 24, color: Constants.dark100)),

                    const SizedBox(height: 16),

                    Text("보유현금",
                        style: Constants.defaultTextStyle
                            .copyWith(fontSize: 16, color: Constants.dark100)),
                    const SizedBox(height: 2),
                    Text(cash.commaString,
                        style: Constants.defaultTextStyle.copyWith(
                            fontSize: 16, color: Constants.cardYellow)),
                    const SizedBox(height: 8),
                    Text("저축자산",
                        style: Constants.defaultTextStyle
                            .copyWith(fontSize: 16, color: Constants.dark100)),
                    const SizedBox(height: 2),
                    Text("+${saving.commaString}",
                        style: Constants.defaultTextStyle.copyWith(
                            fontSize: 16, color: Constants.accentRed)),
                    const SizedBox(height: 8),
                    Text("투자자산",
                        style: Constants.defaultTextStyle
                            .copyWith(fontSize: 16, color: Constants.dark100)),
                    const SizedBox(height: 2),
                    Text("+${asset.commaString}",
                        style: Constants.defaultTextStyle.copyWith(
                            fontSize: 16, color: Constants.accentRed)),
                    const SizedBox(height: 8),
                    Text("저축자산",
                        style: Constants.defaultTextStyle
                            .copyWith(fontSize: 16, color: Constants.dark100)),
                    const SizedBox(height: 2),
                    Text(loan.commaString,
                        style: Constants.defaultTextStyle.copyWith(
                            fontSize: 16, color: Constants.accentBlue)),
                    // const RateVariationTile(before: 3, after: 5),

                    const SizedBox(height: 2),
                    // const RateVariationTile(before: 5, after: 4),
                    const SizedBox(height: 10),
                    Container(height: 1, color: Constants.grey100),
                    Row(
                      children: [
                        Text("총",
                            style: Constants.defaultTextStyle.copyWith(
                                fontSize: 24, color: Constants.dark100)),
                        const Spacer(),
                        Text("${(cash + saving + asset + loan).commaString}원",
                            style: Constants.defaultTextStyle.copyWith(
                                fontSize: 24, color: Constants.dark100)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              children: [
                const Spacer(),
                Bounceable(
                    onTap: () {
                      Get.back();
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
    );
  }
}
