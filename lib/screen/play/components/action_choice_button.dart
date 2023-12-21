import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/controller/game_controller.dart';
import 'package:money_cycle/models/enums/game_action_type.dart';

// ignore: must_be_immutable
class ActionChoiceButton extends StatefulWidget {
  final String title;
  final Function()? onTap;
  final String? buttonString;
  bool? isSelected;

  ActionChoiceButton({
    super.key,
    required this.title,
    this.onTap,
    this.buttonString,
    this.isSelected,
  });

  @override
  State<ActionChoiceButton> createState() => _ActionChoiceButtonState();
}

class _ActionChoiceButtonState extends State<ActionChoiceButton> {
  @override
  Widget build(BuildContext context) {
    return GetX<GameController>(builder: (gameController) {
      return Bounceable(
        duration: const Duration(seconds: 1),
        onTap: widget.onTap,
        child: SizedBox(
          width: 110,
          height: (gameController.currentActionType == GameActionType.saving ||
                  gameController.currentActionType == GameActionType.loan)
              ? 70
              : 50,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (widget.isSelected == null)
                Image.asset(gameController.currentAssetString)
              else
                Image.asset(widget.isSelected!
                    ? gameController.currentAssetString
                    : gameController.currentDisabledAssetString),
              Center(
                child: Text(
                  widget.title,
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
