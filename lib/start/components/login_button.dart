import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:money_block/constants.dart';

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
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/components/login_button.png',
            width: 218,
            height: 61,
          ),
          Text(
            '게임 로그인',
            style: Constants.defaultTextStyle.copyWith(
              fontSize: 16.0,
              letterSpacing: 0.20,
            ),
          )
        ],
      ),
    );
  }
}
