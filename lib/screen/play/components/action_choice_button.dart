import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/controller/game_controller.dart';

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
          width: 100,
          height: 50,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(gameController.currentAssetString),
              Text(
                title,
                style: Constants.defaultTextStyle.copyWith(fontSize: 20),
              )
            ],
          ),
        ),
      );
    });
  }
}
