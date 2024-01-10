import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:money_cycle/main.dart';
import 'package:money_cycle/models/game/game_contents_category.dart';
import 'package:money_cycle/models/game/game_contents_data.dart';
import 'package:money_cycle/models/game/game_data_detail.dart';
import 'package:money_cycle/screen/lobby/model/mc_room.dart';

class FirebaseRealTimeService {
  static final FirebaseDatabase _rdb = FirebaseDatabase.instanceFor(
      app: firebaseApp!,
      databaseURL:
          "https://moneycycle-5f900-default-rtdb.asia-southeast1.firebasedatabase.app/");

  static Future<RoomData?> getWaitingRoomData({required String roomId}) async {
    final DatabaseReference roomRef = _rdb.ref('Room/$roomId');
    try {
      final snapShot = await roomRef.get();
      final data = snapShot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        final json = Map<String, dynamic>.from(data);
        return RoomData.fromJson(json);
      } else {
        debugPrint("getRoomData - 데이터 없음");
        return null;
      }

      // 여기에서 데이터를 처리하거나 상태를 업데이트할 수 있습니다.
    } catch (e) {
      debugPrint('Error: $e');
      // 오류 처리 로직을 추가할 수 있습니다.
    }
    return null;
  }

  static Future<GameDataDetails?> getRoomData({required String roomId}) async {
    final DatabaseReference roomRef = _rdb.ref('Room/$roomId');
    try {
      final snapShot = await roomRef.get();
      debugPrint('Data: ${snapShot.value}');
      final data = snapShot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        final json = Map<String, dynamic>.from(data);
        return GameDataDetails.fromJson(json);
      } else {
        debugPrint("getRoomData - 데이터 없음");
        return null;
      }

      // 여기에서 데이터를 처리하거나 상태를 업데이트할 수 있습니다.
    } catch (e) {
      debugPrint('Error: $e');
      // 오류 처리 로직을 추가할 수 있습니다.
    }
    return null;
  }

  static Future<GameContentsDto?> getGameContents() async {
    final DatabaseReference roomRef = _rdb.ref('contentsData');
    try {
      final snapShot = await roomRef.get();
      final dataList = snapShot.value as List<dynamic>?;
      if (dataList != null) {
        List<GameContentAction> contentsData = [];
        for (final data in dataList) {
          final json = data as Map<dynamic, dynamic>;
          GameContentAction action = GameContentAction.fromJson(json);
          contentsData.add(action);
        }
        log(contentsData.length.toString());
        return GameContentsDto(contentsData: contentsData);
      } else {
        log("getRoomData - 데이터 없음");
        return null;
      }

      // 여기에서 데이터를 처리하거나 상태를 업데이트할 수 있습니다.
    } catch (e) {
      debugPrint('Error: $e');
      // 오류 처리 로직을 추가할 수 있습니다.
    }
    return null;
  }

  // MARK: - GET STREAM (리스너)
  static Stream<RoomData?> getWaitingRoomDataStream({
    required String roomId,
  }) {
    final DatabaseReference roomRef = _rdb.ref('Room/$roomId');
    final Stream<RoomData?> customObjectStream = roomRef.onValue.map((event) {
      final Map<dynamic, dynamic>? data =
          event.snapshot.value as Map<dynamic, dynamic>?;
      debugPrint("Data type: ${data?.runtimeType}");

      if (data != null) {
        //데이터 존재
        final Map<String, dynamic> json = Map<String, dynamic>.from(data);
        return RoomData.fromJson(json);
      } else {
        return null;
      }
    });
    return customObjectStream;
  }

  static Stream<GameDataDetails?> getRoomDataStream({
    required String roomId,
  }) {
    // 참조할 데이터의 Path 와 함께 레퍼런스 생성
    final DatabaseReference roomRef = _rdb.ref('Room/$roomId');
    // 커스텀 객체를 담고 있는 Stream 으로 변환
    final Stream<GameDataDetails?> customObjectStream =
        roomRef.onValue.map((event) {
      // 커스텀 객체로 파싱 (Ex. fromJson)
      final Map<dynamic, dynamic>? data =
          event.snapshot.value as Map<dynamic, dynamic>?;
      debugPrint("Data type: ${data?.runtimeType}");

      if (data != null) {
        //데이터 존재
        final Map<String, dynamic> json = Map<String, dynamic>.from(data);
        return GameDataDetails.fromJson(json);
      } else {
        return null;
      }
    });
    return customObjectStream;
  }

  // GET STREAM (리스너)
  static Stream<int?> getTurnIndexStream({
    required String roomId,
  }) {
    // 참조할 데이터의 Path 와 함께 레퍼런스 생성
    final DatabaseReference roomRef = _rdb.ref('Room/$roomId/turnIndex');
    // 커스텀 객체를 담고 있는 Stream 으로 변환
    final Stream<int?> customObjectStream = roomRef.onValue.map((event) {
      // 커스텀 객체로 파싱 (Ex. fromJson)
      final int? turnIndex = event.snapshot.value as int?;
      debugPrint("Data type: ${turnIndex?.runtimeType}");
      return turnIndex;
    });
    return customObjectStream;
  }

  // GET STREAM (리스너)
  static Stream<int?> getRoundIndexStream({
    required String roomId,
  }) {
    // 참조할 데이터의 Path 와 함께 레퍼런스 생성
    final DatabaseReference roomRef = _rdb.ref('Room/$roomId/roundIndex');
    // 커스텀 객체를 담고 있는 Stream 으로 변환
    final Stream<int?> customObjectStream = roomRef.onValue.map((event) {
      // 커스텀 객체로 파싱 (Ex. fromJson)
      final int? turnIndex = event.snapshot.value as int?;
      debugPrint("Data type: ${turnIndex?.runtimeType}");
      return turnIndex;
    });
    return customObjectStream;
  }

  // GET STREAM (리스너)
  static Stream<bool?> getIsGameEndedStream({
    required String roomId,
  }) {
    // 참조할 데이터의 Path 와 함께 레퍼런스 생성
    final DatabaseReference roomRef = _rdb.ref('Room/$roomId/isEnd');
    // 커스텀 객체를 담고 있는 Stream 으로 변환
    final Stream<bool?> customObjectStream = roomRef.onValue.map((event) {
      // 커스텀 객체로 파싱 (Ex. fromJson)
      final bool? isEnd = event.snapshot.value as bool?;
      debugPrint("Data type: ${isEnd?.runtimeType}");
      return isEnd;
    });
    return customObjectStream;
  }
}
