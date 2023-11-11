import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/controller/user_controller.dart';
import 'package:money_cycle/start/add_information_screen.dart';
import 'package:money_cycle/utils/firebase_service.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({super.key, required this.userID});

  final String userID;

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  bool isFetching = true;
  bool hasUserData = true;

  Widget toolButton({
    required String iconUrl,
    label,
    required Function() onTap,
  }) {
    return Column(
      children: [
        Bounceable(
          onTap: onTap,
          child: Image.asset(
            iconUrl,
            width: 46.0,
            height: 46.0,
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          label,
          style: Constants.defaultTextStyle.copyWith(fontSize: 10.0),
        )
      ],
    );
  }

  @override
  void initState() {
    FirebaseService.getUserData(userID: widget.userID).then((user) {
      if (user != null) {
        Get.put(MCUserController());
        MCUserController.to.login(userData: user);
      } else {
        setState(() => hasUserData = false);
        debugPrint('require user data');
      }
      setState(() => isFetching = false);
    });

    super.initState();
  }

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
          if (isFetching)
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 32.0,
                    height: 32.0,
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '사용자 정보를 가져오는 중...',
                    style: Constants.defaultTextStyle.copyWith(shadows: [
                      const Shadow(
                        blurRadius: 16.0,
                        color: Colors.black,
                      ),
                    ]),
                  ),
                  const SizedBox(height: 22.0)
                ],
              ),
            )
          else if (!isFetching && !hasUserData)
            AddInformationScreen(uid: widget.userID)
          else
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 26),
                child: MCContainer(
                  width: 640,
                  strokePadding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 28.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 42.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icons/profile_image.png',
                              width: 50.0,
                              height: 50.0,
                            ),
                            const SizedBox(width: 10.0),
                            Obx(
                              () => Text(
                                Get.find<MCUserController>().user!.value.name,
                                style: Constants.defaultTextStyle
                                    .copyWith(fontSize: 20),
                              ),
                            ),
                            const Spacer(),
                            toolButton(
                              iconUrl: 'assets/icons/my_page.png',
                              label: '마이페이지',
                              onTap: () {
                                //TODO: 마이페이지 이동
                              },
                            ),
                            const SizedBox(width: 22.0),
                            toolButton(
                              iconUrl: 'assets/icons/setting.png',
                              label: '환경설정',
                              onTap: () {
                                //TODO: 환경설정 이동
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 27.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Bounceable(
                              onTap: () {
                                //TODO: 방만들기 이동
                              },
                              child: Image.asset(
                                'assets/components/create_room_button.png',
                                width: 270,
                                height: 180,
                              ),
                            ),
                            Bounceable(
                              onTap: () {
                                //TODO: 방 참가하기 이동
                              },
                              child: Image.asset(
                                'assets/components/participate_room_button.png',
                                width: 270,
                                height: 180,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
