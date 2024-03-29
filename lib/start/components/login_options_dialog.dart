import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/start/components/sns_login_button.dart';
import 'package:money_cycle/start/model/sns_platform.dart';

class LoginOptionsDialogs extends StatefulWidget {
  const LoginOptionsDialogs({super.key});

  @override
  State<LoginOptionsDialogs> createState() => _LoginOptionsDialogsState();
}

class _LoginOptionsDialogsState extends State<LoginOptionsDialogs> {
  bool isLoading = false;

  List<SNSPlatform> platforms = [SNSPlatform.kakao, SNSPlatform.email];

  @override
  void initState() {
    if (foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS) {
      platforms.insert(1, SNSPlatform.apple);
    } else {
      platforms.insert(1, SNSPlatform.google);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              MCContainer(
                width: 251.0,
                height: 256.0,
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DefaultTextStyle(
                          style: Constants.defaultTextStyle.copyWith(
                            fontSize: 24,
                            letterSpacing: 0.20,
                          ),
                          child: Text(
                            '게임 로그인',
                            style: Constants.defaultTextStyle.copyWith(
                              fontSize: 24,
                              letterSpacing: 0.20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 13.0),
                        DefaultTextStyle(
                          style: Constants.defaultTextStyle,
                          child: SizedBox(
                            width: 184.0,
                            child: Wrap(
                              direction: Axis.vertical,
                              spacing: 8.0,
                              children: platforms.map((e) {
                                return SNSLoginButton(
                                  platform: e,
                                  onLogin: (p0) {
                                    setState(() => isLoading = p0);
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (isLoading)
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(36.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(100.0),
                          child: CircularProgressIndicator(
                            color: Constants.blueNeon,
                          ),
                        ),
                      )
                  ],
                ),
              ),
              const SizedBox(width: 10.0),
            ],
          ),
          Bounceable(
            scaleFactor: 0.8,
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/icons/x_button.png',
              width: 46.0,
              height: 46.0,
            ),
          ),
        ],
      ),
    );
  }
}
