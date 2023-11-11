import 'package:get/get.dart';
import 'package:money_cycle/screen/game_play_screen.dart';

class AppPages {
  static final routes = [
    GetPage(name: "/play", page: () => const GamePlayScreen()),
  ];
}
