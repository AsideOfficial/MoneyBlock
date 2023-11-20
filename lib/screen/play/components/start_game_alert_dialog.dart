import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_cycle/components/mc_button.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/controller/game_controller.dart';
import 'package:money_cycle/screen/play/components/end_round_alert_dialog.dart';

class StartGameAlertDialog extends StatefulWidget {
  const StartGameAlertDialog({
    super.key,
  });

  @override
  State<StartGameAlertDialog> createState() => _StartGameAlertDialogState();
}

class _StartGameAlertDialogState extends State<StartGameAlertDialog> {
  final gameController = Get.find<GameController>();
  bool isLoading = false;
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
              const Spacer(),
              Text("라운드 1이 시작됩니다.",
                  style: Constants.defaultTextStyle.copyWith(fontSize: 18)),
              const SizedBox(height: 6),
              Text("+ 2,000,000 원",
                  style: Constants.defaultTextStyle.copyWith(fontSize: 22)),
              const SizedBox(height: 6),
              Text("플레이어는 모두 월급을 받습니다.",
                  style: Constants.defaultTextStyle.copyWith(fontSize: 14)),
              const Spacer(),
              SizedBox(
                width: 184,
                height: 44,
                child: MCButton(
                    isLoading: isLoading,
                    title: "확인",
                    backgroundColor: Constants.blueNeon,
                    onPressed: isLoading
                        ? null
                        : () async {
                            setState(() => isLoading = true);
                            await gameController.firstSalary();
                            setState(() => isLoading = false);
                            Get.back();
                            Get.dialog(
                              const FirstNewsDialog(),
                              barrierDismissible: false,
                            );
                          }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FirstNewsDialog extends StatefulWidget {
  const FirstNewsDialog({
    super.key,
  });

  @override
  State<FirstNewsDialog> createState() => _FirstNewsDialogState();
}

class _FirstNewsDialogState extends State<FirstNewsDialog> {
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
              Text("뉴스", style: Constants.titleTextStyle),
              const Spacer(),
              Text("뉴스를 보며,",
                  style: Constants.defaultTextStyle.copyWith(fontSize: 18)),
              const SizedBox(height: 6),
              Text("자산의 증감을 예측해서",
                  style: Constants.defaultTextStyle.copyWith(fontSize: 18)),
              const SizedBox(height: 6),
              Text("게임을 플레이해보세요.",
                  style: Constants.defaultTextStyle.copyWith(fontSize: 18)),
              const Spacer(),
              SizedBox(
                width: 184,
                height: 44,
                child: MCButton(
                    title: "확인",
                    backgroundColor: Constants.blueNeon,
                    onPressed: () {
                          setState(() => isLoading = true);
                            await gameController.firstSalary();
                            setState(() => isLoading = false);
                            Get.back();
                      Get.back();
                      Get.dialog(
                        const NewsDialog(),
                        useSafeArea: false,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
