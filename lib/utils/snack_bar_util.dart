import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_cycle/constants.dart';

class SnackBarUtil {
  static void showToastMessage({
    required String message,
    required String actionTitle,
    required Function()? onActionPressed,
  }) {
    Get.rawSnackbar(
      titleText: const SizedBox(),
      maxWidth: 600,
      // padding: const EdgeInsets.all(0),
      messageText: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(76), color: Colors.transparent),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(76), color: Colors.white),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                child: Row(
                  children: [
                    Text(
                      message,
                      style: Constants.defaultTextStyle
                          .copyWith(color: Colors.black, fontSize: 14),
                    ),
                    const SizedBox(width: 32),
                    CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: onActionPressed,
                        child: Text(
                          actionTitle,
                          style: Constants.defaultTextStyle.copyWith(
                              color: Constants.cardBlue, fontSize: 14),
                        ))
                  ],
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      barBlur: 0.0,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }
}
