import 'package:flutter/material.dart';
import 'package:money_cycle/components/mc_container.dart';
import 'package:money_cycle/constants.dart';
import 'package:money_cycle/utils/firebase_service.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({super.key, required this.userID});

  final String? userID;

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  bool isFetching = true;

  @override
  void initState() {
    if (widget.userID != null) {
      FirebaseService.getUserData(userID: widget.userID!)
          .then((value) => print(value));
    }

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
            )),
        ],
      ),
    );
  }
}
