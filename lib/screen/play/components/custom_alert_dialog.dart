import 'package:flutter/material.dart';
import 'package:money_cycle/components/mc_button.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/constants.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String description;
  final String instruction;
  final String acionButtonTitle;
  final Function() onPressed;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.description,
    required this.instruction,
    required this.onPressed,
    required this.acionButtonTitle,
  });

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
              Text(title, style: Constants.titleTextStyle),
              const SizedBox(height: 30),
              Text(description,
                  style: Constants.defaultTextStyle.copyWith(fontSize: 18)),
              const SizedBox(height: 10),
              Text(instruction,
                  style: Constants.defaultTextStyle.copyWith(fontSize: 18)),
              const Spacer(),
              SizedBox(
                width: 184,
                height: 44,
                child: MCButton(
                    title: acionButtonTitle,
                    backgroundColor: Constants.blueNeon,
                    onPressed: onPressed),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
