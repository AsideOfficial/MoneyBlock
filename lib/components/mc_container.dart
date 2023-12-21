import 'package:flutter/material.dart';
import '../constants.dart';

class MCContainer extends StatelessWidget {
  const MCContainer({
    super.key,
    this.child,
    this.width,
    this.alignment,
    this.height,
    this.borderRadius = 36,
    this.shadows,
    this.strokePadding,
    this.gradient = Constants.mainGradient,
    this.constraints,
  });

  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final Widget? child;
  final double borderRadius;
  final List<BoxShadow>? shadows;
  final EdgeInsetsGeometry? strokePadding;
  final LinearGradient? gradient;
  final BoxConstraints? constraints;

  EdgeInsetsGeometry get getStrokePadding {
    if (strokePadding == null) {
      return EdgeInsets.symmetric(
        horizontal: (width ?? 0) / 50,
        vertical: (width ?? 0) / 50,
      );
    } else {
      return strokePadding!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      constraints: constraints,
      decoration: ShapeDecoration(
        gradient: Constants.subGradient,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 2, color: Color(0xFFE6E7E8)),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        shadows: shadows,
      ),
      child: Padding(
        padding: getStrokePadding,
        child: Container(
          alignment: alignment,
          decoration: ShapeDecoration(
            gradient: gradient,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2, color: Colors.white),
              borderRadius: BorderRadius.circular(borderRadius - 4),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
