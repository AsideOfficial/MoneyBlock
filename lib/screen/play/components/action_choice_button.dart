import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/controller/game_controller.dart';
import 'package:money_cycle/models/enums/game_action_type.dart';

class ActionChoiceButton extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final String? buttonString;
  // bool? isSelected;
  const ActionChoiceButton({
    super.key,
    required this.title,
    this.onTap,
    this.buttonString,
  });

  @override
  Widget build(BuildContext context) {
    return GetX<GameController>(builder: (gameController) {
      return Bounceable(
        duration: const Duration(seconds: 1),
        onTap: onTap,
        child: SizedBox(
          width: 110,
          height: (gameController.currentActionType == GameActionType.saving ||
                  gameController.currentActionType == GameActionType.loan)
              ? 70
              : 50,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(gameController.currentAssetString),
              Center(
                child: Text(
                  title,
                  style: Constants.defaultTextStyle.copyWith(fontSize: 20),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
