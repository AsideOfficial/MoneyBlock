import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/controller/user_controller.dart';
import 'package:money_cycle/screen/lobby/components/user_delete_dialog.dart';

class UserDeleteScreen extends StatefulWidget {
  const UserDeleteScreen({super.key});

  @override
  State<UserDeleteScreen> createState() => _UserDeleteScreenState();
}

class _UserDeleteScreenState extends State<UserDeleteScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: Constants.mainGradient,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 113.0),
                Text(
                  '${MCUserController.to.user!.value.name} 회원님, 친구들과 함께 \n쌓아온 소중한 추억을 포기하실 건가요?',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'ONE Mobile POP OTF',
                  ),
                ),
                const SizedBox(height: 30.0),
                const Text(
                  '- 계정 및 프로필 정보 삭제\n- 그동안 해온 게임 정보 삭제\n-  누적된 플레이 피드백 삭제',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'ONE Mobile POP OTF',
                  ),
                ),
                const SizedBox(height: 37.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Bounceable(
                      onTap: () {
                        setState(() => isChecked = !isChecked);
                      },
                      child: Image.asset(
                        'assets/icons/check_circle${isChecked ? '_filled' : ''}.png',
                        width: 18.0,
                        height: 18.0,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    const Text(
                      '위 내용을 확인하였으며, 회원 탈퇴 시 모든 정보가 복구 불가능함을 동의합니다.',
                      style: TextStyle(
                        color: Color(0xFFFDFDFD),
                        fontSize: 12,
                        fontFamily: 'Noto Sans KR',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                Bounceable(
                  onTap: isChecked
                      ? () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const UserDeleteDialog();
                            },
                          );
                        }
                      : null,
                  child: Image.asset(
                    'assets/components/user_delete_button${isChecked ? '' : '_disable'}.png',
                    width: 264.0,
                    height: 50.0,
                  ),
                )
              ],
            ),
          ),
          Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.00, 1.00),
                    end: Alignment(0, -1),
                    colors: [Color(0xFF8065FC), Color(0xFF8572FF)],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 10.0),
                      child: Row(
                        children: [
                          Bounceable(
                            child: SizedBox(
                              height: 46.0,
                              width: 46.0,
                              child: Image.asset(
                                "assets/icons/back_button.png",
                              ),
                            ),
                            onTap: () => Get.back(),
                          ),
                          const SizedBox(width: 24),
                          Text(
                            "회원탈퇴",
                            style: Constants.largeTextStyle,
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    Container(height: 1.0),
                  ],
                ),
              ),
              Container(
                height: 13.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: const Alignment(0.00, -1.00),
                    end: const Alignment(0.0, 1.0),
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
