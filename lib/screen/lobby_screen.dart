import 'package:flutter/material.dart';
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
            const Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 26),
                child: MCContainer(
                  width: 544,
                  child: Column(
                    children: [],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
