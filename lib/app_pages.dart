import 'package:get/get.dart';
import 'package:money_cycle/screen/game_play_screen.dart';
import 'package:money_cycle/screen/lobby_screen.dart';
import 'package:money_cycle/start/start_screen.dart';

class AppPages {
  static const initial = "/play";

  static final routes = [
    GetPage(name: "/start", page: () => const StartScreen()),
    GetPage(name: "/lobby", page: () => const LobbyScreen()),
    GetPage(name: "/play", page: () => const GamePlayScreen()),
  ];
}
