import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:money_cycle/app_pages.dart';
import 'package:money_cycle/firebase_options.dart';
import 'package:money_cycle/screen/game_play_screen.dart';
import 'package:money_cycle/screen/lobby_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  KakaoSdk.init(nativeAppKey: 'e9dee5f46be050bdeb181932b2a38718');

  //MARK: Set Screen Orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
      home: Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            final userID = snapshot.data?.uid;

            if (snapshot.hasData) {
              return LobbyScreen(userID: userID!);
            } else {
              return const GamePlayScreen();
            }
          }),
        ),
      ),
    );
  }
}
