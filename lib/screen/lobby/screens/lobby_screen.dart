import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/controller/user_controller.dart';
import 'package:money_cycle/screen/lobby/components/logout_dialog.dart';
import 'package:money_cycle/screen/lobby/components/my_page_dialog.dart';
import 'package:money_cycle/start/add_information_screen.dart';
import 'package:money_cycle/start/model/profile_image.dart';
import 'package:money_cycle/utils/firebase_service.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({super.key});

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

  void getUserData() {
    FirebaseService.getUserData(userID: FirebaseAuth.instance.currentUser!.uid)
        .then((user) {
      if (user != null) {
        Get.put(MCUserController());
        MCUserController.to.login(userData: user);
        setState(() => hasUserData = true);
      } else {
        setState(() => hasUserData = false);
        debugPrint('require user data');
      }
      setState(() => isFetching = false);
    });
  }

  @override
  void initState() {
    getUserData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/main_illustration.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          if (isFetching)
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 200),
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
                ],
              ),
            )
          else if (!isFetching && !hasUserData)
            AddInformationScreen(
              tapComplete: () => getUserData(),
            )
          else
            Center(
              child: MCContainer(
                width: 640,
                height: 340,
                strokePadding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 28.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 42.0),
                      child: Row(
                        children: [
                          Obx(
                            () => Image.asset(
                              ProfileImage.profileImages[
                                  Get.find<MCUserController>()
                                      .user!
                                      .value
                                      .profileImageIndex],
                              width: 50.0,
                              height: 50.0,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Obx(
                            () => Text(
                              Get.find<MCUserController>().user!.value.nickNm,
                              style: Constants.defaultTextStyle
                                  .copyWith(fontSize: 20),
                            ),
                          ),
                          const Spacer(),
                          toolButton(
                            iconUrl: 'assets/icons/my_page_button.png',
                            label: '마이페이지',
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return MyPageDialog(
                                    onUpdate: getUserData,
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(width: 22.0),
                          toolButton(
                            iconUrl: 'assets/icons/logout_button.png',
                            label: '계정관리',
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const LogoutDialog();
                                },
                              );
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
                              Get.toNamed('/create_room');
                            },
                            child: Image.asset(
                              'assets/components/create_room_button.png',
                              width: 270,
                              height: 180,
                            ),
                          ),
                          Bounceable(
                            onTap: () {
                              Get.toNamed('/participate_room');
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
        ],
      ),
    );
  }
}
