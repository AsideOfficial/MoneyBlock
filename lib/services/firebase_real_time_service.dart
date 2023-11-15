import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:money_cycle/main.dart';

class FirebaseRealTimeService {
  static final FirebaseDatabase _rdb = FirebaseDatabase.instanceFor(
      app: firebaseApp!,
      databaseURL:
          "https://moneycycle-5f900-default-rtdb.asia-southeast1.firebasedatabase.app/");

  //MARK: -

  //MARK: - Room 데이터 CRUD 예제
  // CREATE
  static Future<void> createRoom({
    required String roomId,
    required Room roomData,
  }) async {
    // 지정한 path 에 데이터 저장
    debugPrint("Firebase called");
    try {
      await _rdb.ref('room/$roomId').set(roomData.toJson());
      debugPrint("Firebase called complete");
    } catch (error) {
      debugPrint("Firebase Error - $error");
    }
  }

  //UPDATE
  static Future<void> updateRoom({
    required String roomId,
    required Room roomData,
  }) async {
    await _rdb.ref('room/$roomId').update({
      'title': roomData.title,
    });
  }

  // GET STREAM (리스너)
  static Stream<Room?> getRoomDataStream({
    required String roomId,
  }) {
    // 참조할 데이터의 Path 와 함께 레퍼런스 생성
    final DatabaseReference roomRef = _rdb.ref('room/$roomId');
    // 커스텀 객체를 담고 있는 Stream 으로 변환
    final Stream<Room?> customObjectStream = roomRef.onValue.map((event) {
      // 커스텀 객체로 파싱 (Ex. fromJson)
      final data = event.snapshot.value;
      if (data != null) {
        //데이터 존재
        final json = data as Map<String, dynamic>;
        return Room.fromJson(json);
      } else {
        return null;
      }
    });
    return customObjectStream;
  }

  //DELETE
  static Future<void> deleteRoom({
    required String roomId,
  }) async {
    await _rdb.ref('room/$roomId').remove();
    debugPrint("hi");
  }
}

// 데이터 모델 예시
class Room {
  final String? id;
  final String? title;
  final int? count;

  Room({
    required this.id,
    required this.title,
    required this.count,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      title: json['title'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'count': count,
    };
  }
}
