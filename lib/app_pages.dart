import 'package:get/get.dart';
import 'package:money_cycle/screen/lobby_screen.dart';
import 'package:money_cycle/start/start_screen.dart';

class AppPages {
  static const initial = "/start";

  static final routes = [
    GetPage(name: "/start", page: () => const StartScreen()),
    GetPage(
      name: "/lobby",
      page: () => const LobbyScreen(),
      transition: Transition.topLevel,
    ),
  ];
}
