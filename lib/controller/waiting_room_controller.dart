import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_cycle/controller/game_controller.dart';
import 'package:money_cycle/screen/lobby/model/mc_room.dart';
import 'package:money_cycle/screen/play/game_play_screen.dart';
import 'package:money_cycle/services/firebase_real_time_service.dart';

class WaitingRoomController extends GetxController {
  WaitingRoomController({required this.roomId});
  final String roomId;
  bool isRouteToPlayScreen = false;

  final Rx<RoomData?> _currentWaitingRoom = Rx<RoomData?>(null);
  RoomData? get currentWaitingRoomData => _currentWaitingRoom.value;

  @override
  void onInit() async {
    super.onInit();
    final roomData =
        await FirebaseRealTimeService.getWaitingRoomData(roomId: roomId);
    _currentWaitingRoom.value = roomData;
    bindRoomStream(roomId);
  }

  Future<void> bindRoomStream(String roomId) async {
    _currentWaitingRoom.bindStream(
        FirebaseRealTimeService.getWaitingRoomDataStream(roomId: roomId));
    ever(_currentWaitingRoom, _roomDataHandler);
    debugPrint("대기실 이벤트 핸들러 바인딩 완료");
  }

  _roomDataHandler(RoomData? room) {
    if (room != null && room.isPlaying) {
      debugPrint("_waitingRoomDataHandler 트리거 - GamePlayScreen 이동 시작");
      Map<String, bool> participantsState = {};

      for (Player player in room.player ?? []) {
        participantsState[player.uid] = player.isReady;
      }
      final myIndex = participantsState.keys
          .toList()
          .indexOf(FirebaseAuth.instance.currentUser!.uid);
      if (myIndex != 0 && !isRouteToPlayScreen) {
        isRouteToPlayScreen = true;
        Get.offAll(
          () => const GamePlayScreen(),
          binding: BindingsBuilder(() {
            Get.put(
              GameController(
                roomId: roomId,
                myIndex: myIndex,
              ),
            );
          }),
          transition: Transition.fadeIn,
        );
      }
    }
  }
}
