import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:money_cycle/main.dart';
import 'package:money_cycle/models/game/game_data_detail.dart';

class FirebaseRealTimeService {
  static final FirebaseDatabase _rdb = FirebaseDatabase.instanceFor(
      app: firebaseApp!,
      databaseURL:
          "https://moneycycle-5f900-default-rtdb.asia-southeast1.firebasedatabase.app/");

  // GET STREAM (리스너)
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
        debugPrint("스트림 연동 성공 :$json");
        return GameDataDetails.fromJson(json);
      } else {
        return null;
      }
    });
    return customObjectStream;
  }
}
