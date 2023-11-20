import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/controller/game_controller.dart';
import 'package:money_cycle/controller/user_controller.dart';
import 'package:money_cycle/screen/lobby/components/logout_dialog.dart';
import 'package:money_cycle/screen/lobby/components/my_page_dialog.dart';
import 'package:money_cycle/screen/play/game_play_screen.dart';
import 'package:money_cycle/start/add_information_screen.dart';
import 'package:money_cycle/start/model/profile_image.dart';
import 'package:money_cycle/utils/firebase_service.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/main_illustration.png',
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          Center(
            child: MCContainer(
              width: 640,
              height: 340,
              strokePadding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 28.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 42.0),
                    child: Row(
                      children: [
                        SizedBox(width: 10.0),
                        Spacer(),
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
                            Get.to(const GamePlayScreen(),
                                binding: BindingsBuilder(() {
                              Get.put(GameController(
                                roomId: "794923",
                                myIndex: 0,
                              ));
                            }));
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
