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
        Get.dialog(const EconomicNewsDialog());
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
                  Get.dialog(const RoundCalculateDialog());
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
