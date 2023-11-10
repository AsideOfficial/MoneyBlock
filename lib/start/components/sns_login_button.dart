import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/start/components/sign_in_dialog.dart';
import 'package:money_cycle/start/model/sns_platform.dart';

class SNSLoginButton extends StatelessWidget {
  const SNSLoginButton({
    super.key,
    required this.platform,
  });

  final SNSPlatform platform;

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {
        platform.onTap();
        if (platform == SNSPlatform.email) {
          showDialog(
            context: context,
            builder: (context) {
              return const SignInDialog();
            },
          );
        } else {
          Get.back();
        }
      },
      child: Container(
        width: 184,
        height: 44,
        decoration: BoxDecoration(
          color: platform.color,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          children: [
            const SizedBox(width: 14.0),
            platform.logo,
            const SizedBox(width: 28.0),
            Text(
              platform.label,
              style: Constants.defaultTextStyle.copyWith(
                fontSize: 14.0,
                color: platform.labelColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
