import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/constants.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  Widget actionButton({
    required Color shadowColor,
    Color? color,
    LinearGradient? gradient,
    required String label,
    required Color labelColor,
    required Function() onTap,
  }) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        width: 110,
        height: 44,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: color,
          gradient: gradient,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Colors.white),
            borderRadius: BorderRadius.circular(30),
          ),
          shadows: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Text(
          label,
          style: Constants.defaultTextStyle.copyWith(
            color: labelColor,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: MCContainer(
          width: 306,
          height: 256,
          gradient: const LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFFE9E8EC), Color(0xFFD4D9E2)],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '로그아웃',
                textAlign: TextAlign.center,
                style: Constants.defaultTextStyle.copyWith(
                  color: const Color(0xFF303030),
                  fontSize: 24,
                  letterSpacing: 0.20,
                ),
              ),
              const SizedBox(height: 48.0),
              Text(
                '로그아웃 하시겠습니까?',
                textAlign: TextAlign.center,
                style: Constants.defaultTextStyle.copyWith(
                  color: const Color(0xFF303030),
                  fontSize: 20,
                  letterSpacing: 0.20,
                ),
              ),
              const SizedBox(height: 40.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  actionButton(
                    shadowColor: const Color(0x26000000),
                    gradient: const LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [Color(0xFFE9E8EC), Color(0xFFD4D9E2)],
                    ),
                    label: '닫기',
                    labelColor: const Color(0xFF696969),
                    onTap: () => Get.back(),
                  ),
                  const SizedBox(width: 10.0),
                  actionButton(
                    shadowColor: const Color(0x3F000000),
                    color: const Color(0xFF41ADEB),
                    label: '로그아웃',
                    labelColor: Colors.white,
                    onTap: () {
                      Get.back();
                      FirebaseAuth.instance.signOut();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
