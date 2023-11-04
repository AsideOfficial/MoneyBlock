import 'package:flutter/material.dart';
import '../constants.dart';

class MCContainer extends StatelessWidget {
  const MCContainer({
    super.key,
    this.child,
    this.width,
    this.height,
  });
  final double? width;
  final double? height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        gradient: Constants.subGradient,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 2, color: Color(0xFFE6E7E8)),
          borderRadius: BorderRadius.circular(41),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Container(
          decoration: ShapeDecoration(
            gradient: Constants.mainGradient,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2, color: Colors.white),
              borderRadius: BorderRadius.circular(36),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
