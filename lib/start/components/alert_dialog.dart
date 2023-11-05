import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/components/mc_bounceable_button.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/components/mc_text_field.dart';

import '../../constants.dart';

class MCAlertDialog extends StatelessWidget {
  const MCAlertDialog(
      {super.key,
      required this.title,
      required this.message,
      required this.primaryAction,
      required this.primaryActionTitle});

  final String title;
  final String message;
  final String primaryActionTitle;
  final Function()? primaryAction;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        content: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MCContainer(
                width: 400,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: Constants.titleTextStyle),
                      Text(message, style: Constants.defaultTextStyle),
                      MCBounceableButton(
                        width: 184,
                        height: 44,
                        title: primaryActionTitle,
                        backgroundColor: Constants.blueNeon,
                        onPressed: primaryAction,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                const Spacer(),
                Column(
                  children: [
                    Bounceable(
                      scaleFactor: 0.8,
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset(
                        'assets/icons/x_button.png',
                        width: 46.0,
                        height: 46.0,
                      ),
                    ),
                    const Spacer()
                  ],
                )
              ],
            ),
          ],
        ));
  }
}
