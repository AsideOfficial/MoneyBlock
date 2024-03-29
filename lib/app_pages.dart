import 'package:get/get.dart';
import 'package:money_cycle/controller/game_controller.dart';
import 'package:money_cycle/screen/lobby/screens/create_room_screen.dart';
import 'package:money_cycle/screen/main_screen.dart';
import 'package:money_cycle/screen/play/game_play_screen.dart';
import 'package:money_cycle/screen/lobby/screens/participate_room_screen.dart';
import 'package:money_cycle/screen/lobby/screens/waiting_room_screen.dart';

class AppPages {
  static final routes = [
    GetPage(name: MainScreen.routeName, page: () => const MainScreen()),
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
    GetPage(
      name: "/game_play",
      page: () => const GamePlayScreen(),
      binding: BindingsBuilder(() {
        Get.put<GameController>(GameController(roomId: "794923", myIndex: 0));
      }),
      transition: Transition.fadeIn,
    ),
  ];
}
