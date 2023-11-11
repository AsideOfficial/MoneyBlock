import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/start/components/sign_in_dialog.dart';
import 'package:money_cycle/start/model/sns_platform.dart';

class SNSLoginButton extends StatefulWidget {
  const SNSLoginButton({
    super.key,
    required this.platform,
    required this.onLogin,
  });

  final SNSPlatform platform;
  final Function(bool) onLogin;

  @override
  State<SNSLoginButton> createState() => _SNSLoginButtonState();
}

class _SNSLoginButtonState extends State<SNSLoginButton> {
  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () async {
        widget.onLogin(true);

        await widget.platform.onTap;

        if (!mounted) return;
        if (widget.platform == SNSPlatform.email) {
          showDialog(
            context: context,
            builder: (context) {
              return const SignInDialog();
            },
          );
        } else {
          Get.back();
        }
        widget.onLogin(false);
      },
      child: Container(
        width: 184,
        height: 44,
        decoration: BoxDecoration(
          color: widget.platform.color,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          children: [
            const SizedBox(width: 14.0),
            widget.platform.logo,
            const SizedBox(width: 28.0),
            Text(
              widget.platform.label,
              style: Constants.defaultTextStyle.copyWith(
                fontSize: 14.0,
                color: widget.platform.labelColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
