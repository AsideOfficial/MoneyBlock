import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import '../components/mc_container.dart';
import '../constants.dart';

class LobbyScreen extends StatelessWidget {
  const LobbyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/main_illustration.png',
            fit: BoxFit.cover,
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 26),
            child: MCContainer(
              width: 544,
              child: Column(
                children: [
                  const Spacer(),
                  MCButtonBar(
                    chid: Row(
                      children: [
                        const Spacer(),
                        MCButton(
                          height: 42,
                          title: "방 만들기",
                          backgroundColor: Constants.greenNeon,
                          onPressed: () {
                            //TODO - 방만들기 로비
                          },
                        ),
                        const SizedBox(width: 12),
                        MCButton(
                          height: 42,
                          title: "방 찾기",
                          backgroundColor: Constants.blueNeon,
                          onPressed: () {
                            //TODO - 빠른 시작 로비
                          },
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}

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

class MCButtonBar extends StatelessWidget {
  const MCButtonBar({
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
