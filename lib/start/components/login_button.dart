import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/constants.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.onPressed,
  });

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onPressed,
      child: MCContainer(
        width: 218.0,
        height: 61.0,
        alignment: Alignment.center,
        child: Text(
          '게임 로그인',
          style: Constants.defaultTextStyle.copyWith(
            fontSize: 16.0,
            letterSpacing: 0.20,
          ),
        ),
      ),
    );
  }
}
