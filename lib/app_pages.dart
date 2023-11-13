import 'package:get/get.dart';
import 'package:money_cycle/screen/lobby/game_play_screen.dart';
import 'package:money_cycle/screen/lobby/participate_room_screen.dart';

class AppPages {
  static final routes = [
    GetPage(name: "/play", page: () => const GamePlayScreen()),
    GetPage(
      name: "/participate_room",
      page: () => const ParticipateRoomScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
