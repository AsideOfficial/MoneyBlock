import 'package:flutter/material.dart';
import 'package:money_cycle/components/mc_button.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/constants.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String description;
  final String instruction;
  final String acionButtonTitle;
  final Function()? onActionButtonPressed;
  final Function()? onSecondaryButtonPressed;
  final bool? isLoading;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.description,
    required this.instruction,
    this.onActionButtonPressed,
    required this.acionButtonTitle,
    this.isLoading,
    this.onSecondaryButtonPressed,
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
                height: 44,
                child: Row(
                  children: [
                    if (onSecondaryButtonPressed != null)
                      Expanded(
                        child: MCButton(
                          isLoading: isLoading,
                          title: acionButtonTitle,
                          titleColor: Constants.grey03,
                          gradient: Constants.grey01Gradient,
                          onPressed: onSecondaryButtonPressed,
                        ),
                      ),
                    if (onSecondaryButtonPressed != null)
                      const SizedBox(width: 12),
                    Expanded(
                      child: MCButton(
                        isLoading: isLoading,
                        title: acionButtonTitle,
                        backgroundColor: Constants.blueNeon,
                        onPressed: onActionButtonPressed,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
