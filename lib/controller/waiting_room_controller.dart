import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_cycle/screen/lobby/model/mc_room.dart';
import 'package:money_cycle/services/firebase_real_time_service.dart';

class WaitingRoomController extends GetxController {
  WaitingRoomController({required this.roomId});
  final String roomId;

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
    debugPrint("게임 이벤트 핸들러 바인딩 완료");
  }

  _roomDataHandler(RoomData? room) {
    debugPrint("_waitingRoomDataHandler 트리거 -");
  }
}