import 'package:flutter/material.dart';

import '../constants.dart';

class MCCapsuleContainer extends StatelessWidget {
  const MCCapsuleContainer({
    super.key,
    this.chid,
  });

  final Widget? chid;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      decoration: ShapeDecoration(
        gradient: Constants.mainGradient,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 2, color: Colors.white),
          borderRadius: BorderRadius.circular(36),
        ),
      ),
      child: chid,
    );
  }
}
