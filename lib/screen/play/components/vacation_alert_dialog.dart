import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/controller/game_controller.dart';

class VacationAlert extends StatefulWidget {
  const VacationAlert({
    super.key,
  });

  @override
  State<VacationAlert> createState() => _VacationAlertState();
}

class _VacationAlertState extends State<VacationAlert> {
  bool isVacation = false;
  bool isVacationFinished = false;
  bool isLoading = false;
  final gameController = Get.find<GameController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: MCContainer(
        strokePadding: const EdgeInsets.all(3),
        gradient: Constants.greenBlueGradient,
        width: 300,
        height: 320,
        child: Padding(
          padding: const EdgeInsets.only(top: 28, bottom: 18),
          child: Column(
            children: [
              Text("무급휴가", style: Constants.titleTextStyle),
              const SizedBox(height: 6),
              Text("경기가 어려워 무급으로 쉬게 되었습니다.",
                  style: Constants.defaultTextStyle.copyWith(fontSize: 14)),
              const SizedBox(height: 10),
              SizedBox(
                  height: 70, child: Image.asset("assets/icons/vacation.png")),
              const SizedBox(height: 4),
              Text("무급휴가 동안, 당신은 2턴을 쉬게 됩니다.",
                  style: Constants.defaultTextStyle.copyWith(fontSize: 14)),
              const SizedBox(height: 6),
              Text("단, 마지막 라운드는 1턴만 쉽니다.",
                  style: Constants.defaultTextStyle.copyWith(fontSize: 14)),
              const SizedBox(height: 12),
              Bounceable(
                duration: const Duration(seconds: 1),
                onTap: isLoading
                    ? null
                    : () async {
                        setState(() {
                          isLoading = true;
                        });
                        await gameController.startVacation();

                        Get.back();

                        const inVacationAlert = InVacationAlert();
                        Get.dialog(inVacationAlert,
                            barrierDismissible: false, useSafeArea: false);
                        setState(() {
                          isLoading = false;
                        });
                      },
                child: SizedBox(
                  width: 180,
                  height: 50,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset("assets/icons/button_long_green_blue.png"),
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
          ),
        ),
      ),
    );
  }
}

class InVacationAlert extends StatefulWidget {
  const InVacationAlert({
    super.key,
  });

  @override
  State<InVacationAlert> createState() => _InVacationAlertState();
}

class _InVacationAlertState extends State<InVacationAlert> {
  bool isVacation = false;
  bool isVacationFinished = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: MCContainer(
        strokePadding: const EdgeInsets.all(3),
        gradient: Constants.greenBlueGradient,
        width: 300,
        height: 320,
        child: GetX<GameController>(builder: (gameController) {
          return Padding(
            padding: const EdgeInsets.only(top: 28, bottom: 18),
            child: Column(
              children: [
                Text("휴가중", style: Constants.titleTextStyle),
                const SizedBox(height: 6),
                Text("편안한 휴가 되세요~!",
                    style: Constants.defaultTextStyle.copyWith(fontSize: 14)),
                const SizedBox(height: 10),
                SizedBox(
                    height: 70,
                    child: Image.asset("assets/icons/vacation.png")),
                const SizedBox(height: 4),
                Text("휴가 종료 버튼이 활성화되면",
                    style: Constants.defaultTextStyle.copyWith(fontSize: 14)),
                const SizedBox(height: 6),
                Text("휴가 종료 후 일상으로 돌아갈 수 있어요.",
                    style: Constants.defaultTextStyle.copyWith(fontSize: 14)),
                const SizedBox(height: 12),
                Bounceable(
                  duration: const Duration(seconds: 1),
                  onTap: (!gameController.isMyTurn || isLoading)
                      ? null
                      : () async {
                          setState(() {
                            isLoading = true;
                          });

                          if (isVacation) {
                            // await gameController.useVacation();
                          } else {
                            Get.back();
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                  child: SizedBox(
                    width: 180,
                    height: 50,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(gameController.isMyTurn
                            ? "assets/icons/button_long_green_blue.png"
                            : "assets/icons/button_long_green_blue_disabled.png"),
                        if (!isLoading)
                          Text(
                            isVacation ? "턴 넘기기" : "휴가 종료",
                            style: Constants.defaultTextStyle
                                .copyWith(fontSize: 20),
                          )
                        else
                          const SizedBox(
                            width: 44,
                            height: 44,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
