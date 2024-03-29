import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:money_cycle/app_pages.dart';
import 'package:money_cycle/firebase_options.dart';
import 'package:money_cycle/screen/main_screen.dart';
import 'package:wakelock/wakelock.dart';

FirebaseApp? firebaseApp;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  firebaseApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Wakelock.enable();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

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
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },
      home: const MainScreen(),
    );
  }
}
