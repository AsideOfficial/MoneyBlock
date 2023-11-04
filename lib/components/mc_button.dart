import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import '../constants.dart';

class MCButton extends StatelessWidget {
  const MCButton({
    super.key,
    this.width,
    this.height,
    this.title,
    this.backgroundColor,
    this.titleColor = Colors.white,
    this.onPressed,
  });

  final double? width;
  final double? height;
  final String? title;
  final Color? titleColor;
  final Color? backgroundColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Center(
              child: Text(
            title ?? "",
            style: Constants.defaultTextStyle.copyWith(color: titleColor),
          )),
        ),
      ),
    );
  }
}
