import 'package:get/get.dart';
import 'package:money_cycle/screen/lobby/screens/create_room_screen.dart';
import 'package:money_cycle/screen/lobby/screens/game_play_screen.dart';
import 'package:money_cycle/screen/lobby/screens/participate_room_screen.dart';
import 'package:money_cycle/screen/lobby/screens/waiting_room_screen.dart';

class AppPages {
  static final routes = [
    GetPage(name: "/play", page: () => const GamePlayScreen()),
    GetPage(
      name: "/create_room",
      page: () => const CreateRoomScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: "/participate_room",
      page: () => const ParticipateRoomScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: "/waiting_room",
      page: () => const WaitingRoomScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
