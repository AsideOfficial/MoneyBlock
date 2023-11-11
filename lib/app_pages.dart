import 'package:get/get.dart';
<<<<<<< HEAD
import 'package:money_cycle/screen/game_play_screen.dart';
import 'package:money_cycle/screen/lobby_screen.dart';
import 'package:money_cycle/start/start_screen.dart';

class AppPages {
  static const initial = "/play";

  static final routes = [
    GetPage(name: "/start", page: () => const StartScreen()),
    GetPage(name: "/lobby", page: () => const LobbyScreen()),
    GetPage(name: "/play", page: () => const GamePlayScreen()),
=======
import 'package:money_cycle/start/start_screen.dart';

class AppPages {
  static final routes = [
    GetPage(name: "/start", page: () => const StartScreen()),
>>>>>>> 5c2f19c97d74473c5ee347d99993f0daea4e1a08
  ];
}
