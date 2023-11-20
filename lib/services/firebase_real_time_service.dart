import 'dart:html';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:money_cycle/main.dart';
import 'package:money_cycle/models/game/game_data_detail.dart';

class FirebaseRealTimeService {
  static final FirebaseDatabase _rdb = FirebaseDatabase.instanceFor(
      app: firebaseApp!,
      databaseURL:
          "https://moneycycle-5f900-default-rtdb.asia-southeast1.firebasedatabase.app/");

  static Future<GameDataDetails?> getRoomData({required String roomId}) async {
    final DatabaseReference roomRef = _rdb.ref('Room/$roomId');
     try {
      DataSnapshot snapshot = await databaseReference.once();
      print('Data: ${snapshot.value}');
      // 여기에서 데이터를 처리하거나 상태를 업데이트할 수 있습니다.
    } catch (e) {
      print('Error: $e');
      // 오류 처리 로직을 추가할 수 있습니다.
    }
     return null;
  }
  
  }

  // MARK: - GET STREAM (리스너)
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
