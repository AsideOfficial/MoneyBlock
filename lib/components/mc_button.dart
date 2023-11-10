import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.isLoading,
  });

  final double? width;
  final double? height;
  final EdgeInsets padding;
  final String? title;
  final bool? isLoading;
  final Color? titleColor;
  final Color? backgroundColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
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
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (isLoading == null || isLoading == false)
              Text(
                title ?? "",
                style: Constants.defaultTextStyle.copyWith(color: titleColor),
              )
            else
              const SizedBox(
                width: 16.0,
                height: 16.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  color: Colors.white,
                ),
              )
          ]),
        ),
      ),
    );
  }
}
