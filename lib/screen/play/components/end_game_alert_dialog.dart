import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_cycle/screen/play/components/custom_alert_dialog.dart';

class EndGameAlertDialog extends StatefulWidget {
  const EndGameAlertDialog({super.key});

  @override
  State<EndGameAlertDialog> createState() => _EndGameAlertDialogState();
}

class _EndGameAlertDialogState extends State<EndGameAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: "게임!",
      description: "게임이 종료되었습니다.",
      instruction: "게임의 결과를 확인해보세요.",
      acionButtonTitle: "결과보기",
      onPressed: () {
        Get.back();
      },
    );
  }
}
