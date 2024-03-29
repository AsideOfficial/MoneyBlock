import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:money_cycle/constants.dart';

class MCBounceableButton extends StatelessWidget {
  const MCBounceableButton({
    super.key,
    this.width,
    this.height,
    this.title,
    this.backgroundColor,
    this.titleColor = Colors.white,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
  });

  final double? width;
  final double? height;
  final EdgeInsets padding;
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
          padding: padding,
          child: Center(
            child: Text(
              title ?? "",
              style: Constants.dialogSecondaryTextStyle.copyWith(),
            ),
          ),
        ),
      ),
    );
  }
}
